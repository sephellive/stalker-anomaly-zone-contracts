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
$archive = Join-Path $dist "Zone.Contracts.v$Version.FOMOD.zip"
if (Test-Path -LiteralPath $archive) {
    Remove-Item -LiteralPath $archive -Force
}

$releasePaths = @(Get-ChildItem -LiteralPath $repoRoot -Directory | Where-Object {
    $_.Name -match '^(00|01|02|10|20|30|40|50) '
} | Sort-Object Name | Select-Object -ExpandProperty FullName)
$releasePaths += Join-Path $repoRoot 'fomod'

if ($releasePaths.Count -ne 9) {
    throw "Expected 9 FOMOD source directories, found $($releasePaths.Count)"
}

Compress-Archive -LiteralPath $releasePaths -DestinationPath $archive -CompressionLevel Optimal
Write-Host "Built $archive"
