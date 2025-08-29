Param(
  [string]$DistDir = "dist",
  [string]$ZipName = "canonlock_noelictus_latest.zip"
)
$ErrorActionPreference = "Stop"
$items = @("lore","rules","gameplay","scenes","index.html","style.css","README.md","CHANGELOG.md","HOW_TO_AUTOMATE.md","tools")
if (!(Test-Path $DistDir)) { New-Item -ItemType Directory -Path $DistDir | Out-Null }
$zipPath = Join-Path $DistDir $ZipName
if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
Add-Type -AssemblyName 'System.IO.Compression.FileSystem'
$zipTempDir = Join-Path $env:TEMP ("canonlock_bundle_" + [Guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $zipTempDir | Out-Null
foreach ($i in $items) { if (Test-Path $i) { Copy-Item $i -Destination (Join-Path $zipTempDir (Split-Path $i -Leaf)) -Recurse -Force } }
[System.IO.Compression.ZipFile]::CreateFromDirectory($zipTempDir, $zipPath)
Remove-Item $zipTempDir -Recurse -Force
Write-Host "Bundle created at $zipPath"
