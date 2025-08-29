Param(
  [string]$Manifest = "assets/assets.index.json",
  [string]$OutHtml  = "gallery.html"
)
$ErrorActionPreference = "Stop"
if (!(Test-Path $Manifest)) { Write-Error "Manifest not found: $Manifest" }
$data = Get-Content $Manifest -Raw | ConvertFrom-Json
$cards = ""
foreach ($it in $data) {
  $img = $it.image
  $thumb = if ($it.thumb) { $it.thumb } else { $img }
  $title = $it.title ?? (Split-Path $img -Leaf)
  $tags = ($it.tags -join ", ")
  $cat  = $it.category ?? ""
  $cards += @"
  <figure class="card">
    <a href="$img"><img src="$thumb" alt="$title" loading="lazy"></a>
    <figcaption><strong>$title</strong><br><small>$cat</small><br><small>$tags</small></figcaption>
  </figure>
"@
}
$html = @"
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Canonlock Gallery</title>
<style>
body{background:#0b0f14;color:#e6ecf2;font:16px/1.6 system-ui}
main{max-width:1100px;margin:0 auto;padding:1rem}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:14px}
.card{background:#0f141b;border:1px solid #16202a;border-radius:12px;padding:8px}
img{width:100%;height:auto;border-radius:8px;display:block}
figcaption{color:#9bb1c9}
a{color:#77c1ff;text-decoration:none}
</style>
</head>
<body>
<main>
  <h1>Canonlock Gallery</h1>
  <p>Images auto-imported and indexed.</p>
  <div class="grid">
    $cards
  </div>
</main>
</body>
</html>
"@
$html | Out-File -Encoding utf8 $OutHtml
Write-Host "Wrote $OutHtml"
