[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[0-9]+\.[0-9]+\.[0-9]+(?:[-+][0-9A-Za-z.-]+)?$')]
    [string]$Version
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
& (Join-Path $PSScriptRoot 'validate.ps1')

$dist = Join-Path $repoRoot 'dist'
New-Item -ItemType Directory -Path $dist -Force | Out-Null
$releasePaths = @(Get-ChildItem -LiteralPath $repoRoot -Directory | Where-Object {
    $_.Name -match '^(00|01|02|10|20|30|40|50) '
} | Sort-Object Name | Select-Object -ExpandProperty FullName)

if ($releasePaths.Count -ne 8) {
    throw "Expected 8 FOMOD content directories, found $($releasePaths.Count)"
}

foreach ($language in @('RU', 'EN')) {
    $archive = Join-Path $dist "Zone.Contracts.v$Version.FOMOD.$language.zip"
    $stage = Join-Path $dist ".stage-$language"
    if (Test-Path -LiteralPath $archive) {
        Remove-Item -LiteralPath $archive -Force
    }
    if (Test-Path -LiteralPath $stage) {
        Remove-Item -LiteralPath $stage -Recurse -Force
    }

    New-Item -ItemType Directory -Path $stage | Out-Null
    foreach ($path in $releasePaths) {
        Copy-Item -LiteralPath $path -Destination $stage -Recurse
    }

    $stageFomod = Join-Path $stage 'fomod'
    New-Item -ItemType Directory -Path $stageFomod | Out-Null
    Copy-Item -LiteralPath (Join-Path $repoRoot 'fomod/info.xml') -Destination (Join-Path $stageFomod 'info.xml')
    Copy-Item -LiteralPath (Join-Path $repoRoot "fomod/ModuleConfig.$($language.ToLowerInvariant()).xml") -Destination (Join-Path $stageFomod 'ModuleConfig.xml')

    Compress-Archive -LiteralPath (Get-ChildItem -LiteralPath $stage | Select-Object -ExpandProperty FullName) -DestinationPath $archive -CompressionLevel Optimal
    Remove-Item -LiteralPath $stage -Recurse -Force
    Write-Host "Built: $archive"
}
