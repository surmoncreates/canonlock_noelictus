Param([int]$Port = 8000)
$ErrorActionPreference = "Stop"
$python = Get-Command python -ErrorAction SilentlyContinue
if ($python) { Write-Host "Serving on http://localhost:$Port (Ctrl+C to stop)"; python -m http.server $Port; exit $LASTEXITCODE }
Write-Host "Python not found. Install Python or serve via any static server."
