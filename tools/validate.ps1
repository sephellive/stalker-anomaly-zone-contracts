[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$expectedCredits = 'Sephellive, Igigog, folk, Lasse Scheyde'

function Fail([string]$Message) {
    throw "Validation failed: $Message"
}

$taskFiles = Get-ChildItem -LiteralPath $repoRoot -Recurse -Filter '*.json' -File |
    Where-Object {
        $_.FullName -notmatch '[\\/]dist[\\/]' -and
        $_.FullName -match '[\\/]gamedata[\\/]configs[\\/]igi_tasks[\\/]tasks[\\/]'
    }

if ($taskFiles.Count -ne 24) {
    Fail "expected 24 task files, found $($taskFiles.Count)"
}

$taskNames = @{}
foreach ($file in $taskFiles) {
    $task = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
    if ($taskNames.ContainsKey($file.BaseName)) {
        Fail "duplicate task id '$($file.BaseName)'"
    }
    $taskNames[$file.BaseName] = $true

    if ($task.CREDITS -ne $expectedCredits) {
        Fail "unexpected credits in $($file.FullName)"
    }
}

$defenseFiles = @($taskFiles | Where-Object { $_.Directory.Name -eq 'cb_defense' })
if ($defenseFiles.Count -ne 3) {
    Fail "expected 3 defense tasks, found $($defenseFiles.Count)"
}

foreach ($file in $defenseFiles) {
    $task = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
    $defense = @($task.entities | Where-Object { $_.CONTROLLER -eq '@$ cb_wtf_combat.HeavyDefense' })
    if ($defense.Count -ne 1) {
        Fail "defense task '$($file.BaseName)' must use exactly one HeavyDefense controller"
    }
    $controller = $defense[0]
    if (@($controller.sections).Count -ne 6) {
        Fail "defense task '$($file.BaseName)' must contain exactly 6 assault groups"
    }
    if ([int]$controller.max_active -gt 3 -or [int]$controller.max_active -lt 1) {
        Fail "defense task '$($file.BaseName)' has unsafe max_active value"
    }
    if ([int]$controller.trigger_radius -gt 60) {
        Fail "defense task '$($file.BaseName)' must start only near the defense position"
    }
}

$monolithPath = ($defenseFiles | Where-Object BaseName -eq 'bar_monolith_breakthrough').FullName
$monolithTask = Get-Content -LiteralPath $monolithPath -Raw -Encoding UTF8 | ConvertFrom-Json
$monolithDefense = @($monolithTask.entities | Where-Object { $_.CONTROLLER -eq '@$ cb_wtf_combat.HeavyDefense' })[0]
$rpgGroupCount = @($monolithDefense.sections | Where-Object { $monolithDefense.rpg_sections -contains $_ }).Count
if ($rpgGroupCount -lt 2) {
    Fail 'Monolith defense must contain at least two RPG assault groups'
}

$squadDescriptionPath = Join-Path $repoRoot '00 Core/gamedata/configs/misc/squad_descr/squad_descr_cb_zone_contracts.ltx'
if (-not (Test-Path -LiteralPath $squadDescriptionPath)) {
    Fail 'fixed defense squad descriptions are missing'
}
$squadDescription = [IO.File]::ReadAllText($squadDescriptionPath, [Text.Encoding]::UTF8)
$fixedSections = [regex]::Matches($squadDescription, '(?m)^\[(cb_defense_[^\]]+)\]')
if ($fixedSections.Count -lt 11 -or [regex]::Matches($squadDescription, '(?m)^common\s*=\s*false\s*$').Count -lt $fixedSections.Count) {
    Fail 'every fixed defense squad must use common=false'
}

$xmlFiles = Get-ChildItem -LiteralPath $repoRoot -Recurse -Filter '*.xml' -File |
    Where-Object { $_.FullName -notmatch '[\\/]dist[\\/]' }
foreach ($file in $xmlFiles) {
    $document = New-Object System.Xml.XmlDocument
    $document.PreserveWhitespace = $true
    $document.Load($file.FullName)
}

$languageIds = @{}
foreach ($language in @('rus', 'eng')) {
    $ids = @()
    $files = $xmlFiles | Where-Object {
        $_.FullName -match "[\\/]gamedata[\\/]configs[\\/]text[\\/]$language[\\/]"
    }

    foreach ($file in $files) {
        $document = New-Object System.Xml.XmlDocument
        $document.Load($file.FullName)
        $ids += @($document.SelectNodes('/string_table/string') | ForEach-Object { $_.GetAttribute('id') })
    }

    $duplicates = $ids | Group-Object | Where-Object Count -gt 1
    if ($duplicates) {
        Fail "duplicate localization ids in '$language': $($duplicates.Name -join ', ')"
    }
    $languageIds[$language] = @($ids | Sort-Object)
}

$rusDiff = Compare-Object $languageIds.rus $languageIds.eng
if ($rusDiff) {
    Fail 'Russian and English localization id sets differ'
}

$moduleConfigs = @(
    (Join-Path $repoRoot 'fomod/ModuleConfig.ru.xml'),
    (Join-Path $repoRoot 'fomod/ModuleConfig.en.xml')
)
foreach ($moduleConfig in $moduleConfigs) {
    $moduleDocument = New-Object System.Xml.XmlDocument
    $moduleDocument.Load($moduleConfig)
    foreach ($attribute in $moduleDocument.SelectNodes('//@source')) {
        $sourcePath = Join-Path $repoRoot $attribute.Value
        if (-not (Test-Path -LiteralPath $sourcePath)) {
            Fail "FOMOD source path does not exist: $($attribute.Value)"
        }
    }
}

$ruModuleText = [IO.File]::ReadAllText($moduleConfigs[0], [Text.Encoding]::UTF8)
$enModuleText = [IO.File]::ReadAllText($moduleConfigs[1], [Text.Encoding]::UTF8)
if ($ruModuleText -notmatch '[^\x00-\x7F]' -or $enModuleText -notmatch 'Quest Economy') {
    Fail 'localized FOMOD descriptions are missing'
}

$markdownFiles = @(
    (Join-Path $repoRoot 'README.md'),
    (Join-Path $repoRoot 'CHANGELOG.md'),
    (Join-Path $repoRoot 'CONTRIBUTING.md'),
    (Join-Path $repoRoot 'docs/MODDB.md')
)
foreach ($file in $markdownFiles) {
    $text = [IO.File]::ReadAllText($file, [Text.Encoding]::UTF8)
    if ($text -notmatch '[^\x00-\x7F]' -or $text -notmatch '## English') {
        Fail "bilingual sections are missing in $file"
    }
}

$htmlPath = Join-Path $repoRoot '00 Core/docs/index.html'
$htmlText = [IO.File]::ReadAllText($htmlPath, [Text.Encoding]::UTF8)
$catalogQuestRows = [regex]::Matches($htmlText, "\['(?:patrol|assault|defense|science|fieldwork)'").Count
if ($catalogQuestRows -ne 48 -or $htmlText -notmatch 'data-lang="ru"' -or $htmlText -notmatch 'data-lang="en"') {
    Fail 'the HTML catalog must contain 24 RU and 24 EN quest rows and both language controls'
}

$textExtensions = @('.json', '.xml', '.html', '.md', '.txt', '.script', '.ps1', '.yml', '.yaml', '.ini')
$forbiddenPattern = 'co' + 'dex'
$forbiddenHits = Get-ChildItem -LiteralPath $repoRoot -Recurse -File |
    Where-Object {
        $_.FullName -notmatch '[\\/]dist[\\/]' -and
        $textExtensions -contains $_.Extension.ToLowerInvariant()
    } |
    Select-String -Pattern $forbiddenPattern -CaseSensitive:$false

if ($forbiddenHits) {
    Fail "forbidden service reference found in $($forbiddenHits[0].Path)"
}

Write-Host "Validation passed: $($taskFiles.Count) tasks, $($xmlFiles.Count) XML files, $($languageIds.rus.Count) localization ids per language."
