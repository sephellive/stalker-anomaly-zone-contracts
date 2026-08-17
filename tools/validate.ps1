[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$expectedCredits = 'Sephellive, Igigog, folk, Lasse Scheyde'

function Fail([string]$Message) {
    throw "Validation failed: $Message"
}

$taskFiles = Get-ChildItem -LiteralPath $repoRoot -Recurse -Filter '*.json' -File |
    Where-Object { $_.FullName -match '[\\/]gamedata[\\/]configs[\\/]igi_tasks[\\/]tasks[\\/]' }

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

$xmlFiles = Get-ChildItem -LiteralPath $repoRoot -Recurse -Filter '*.xml' -File
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

$moduleConfig = Join-Path $repoRoot 'fomod/ModuleConfig.xml'
$moduleDocument = New-Object System.Xml.XmlDocument
$moduleDocument.Load($moduleConfig)
foreach ($attribute in $moduleDocument.SelectNodes('//@source')) {
    $sourcePath = Join-Path $repoRoot $attribute.Value
    if (-not (Test-Path -LiteralPath $sourcePath)) {
        Fail "FOMOD source path does not exist: $($attribute.Value)"
    }
}

$textExtensions = @('.json', '.xml', '.html', '.md', '.txt', '.script', '.ps1', '.yml', '.yaml', '.ini')
$forbiddenPattern = 'co' + 'dex'
$forbiddenHits = Get-ChildItem -LiteralPath $repoRoot -Recurse -File |
    Where-Object { $textExtensions -contains $_.Extension.ToLowerInvariant() } |
    Select-String -Pattern $forbiddenPattern -CaseSensitive:$false

if ($forbiddenHits) {
    Fail "forbidden service reference found in $($forbiddenHits[0].Path)"
}

Write-Host "Validation passed: $($taskFiles.Count) tasks, $($xmlFiles.Count) XML files, $($languageIds.rus.Count) localization ids per language."
