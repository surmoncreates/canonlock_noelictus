Param(
  [string]$ImagesDir = "assets/images",
  [string]$ThumbsDir = "assets/thumbs",
  [string]$MetaDir   = "assets/meta",
  [string]$OutFile   = "assets/assets.index.json"
)
$ErrorActionPreference = "Stop"
if (!(Test-Path $ImagesDir)) { New-Item -ItemType Directory -Path $ImagesDir | Out-Null }
$items = @()
Get-ChildItem -Path $ImagesDir -File -Include *.png,*.jpg,*.jpeg,*.webp | ForEach-Object {
  $name = $_.BaseName; $ext = $_.Extension
  $thumbPath = Join-Path $ThumbsDir ($name + $ext)
  $metaPath  = Join-Path $MetaDir   ($name + ".json")
  $obj = [ordered]@{ image = "assets/images/" + $_.Name }
  if (Test-Path $thumbPath) { $obj.thumb = "assets/thumbs/" + $_.Name }
  if (Test-Path $metaPath) {
    try { $meta = Get-Content $metaPath -Raw | ConvertFrom-Json; foreach ($k in $meta.PSObject.Properties.Name) { $obj[$k] = $meta.$k } }
    catch { Write-Warning "Bad meta JSON: $metaPath" }
  }
  if (-not $obj.date) { $obj.date = (Get-Date).ToString('yyyy-MM-dd') }
  if (-not $obj.source) { $obj.source = "local-ai" }
  $items += [pscustomobject]$obj
}
$items | ConvertTo-Json -Depth 6 | Out-File -Encoding utf8 $OutFile
Write-Host "Wrote manifest: $OutFile"
