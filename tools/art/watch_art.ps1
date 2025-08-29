Param(
  [string]$WatchDir = "$env:USERPROFILE\Pictures\AI_Outputs",
  [string]$RepoImages = "assets/images"
)
$ErrorActionPreference = "Stop"
if (!(Test-Path $RepoImages)) { New-Item -ItemType Directory -Path $RepoImages | Out-Null }
$fsw = New-Object System.IO.FileSystemWatcher
$fsw.Path = $WatchDir; $fsw.Filter = "*.*"; $fsw.IncludeSubdirectories = $false; $fsw.EnableRaisingEvents = $true
Write-Host "Watching $WatchDir for new images… (Ctrl+C to stop)"
Register-ObjectEvent $fsw Created -Action {
  Start-Sleep -Milliseconds 500
  $p = $Event.SourceEventArgs.FullPath
  $ext = [IO.Path]::GetExtension($p).ToLower()
  if ($ext -in @('.png','.jpg','.jpeg','.webp')) {
    $name = [IO.Path]::GetFileName($p)
    Copy-Item $p (Join-Path $RepoImages $name) -Force
    Write-Host "Imported $name"
  }
}
while ($true) { Start-Sleep -Seconds 1 }
