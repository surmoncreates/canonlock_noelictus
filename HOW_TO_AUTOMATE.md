# How to Automate

## GitHub (Auto)
1) Commit/push this repo to GitHub.
2) Settings → Pages → Source: GitHub Actions.
3) Push to `main`.
Actions will build a ZIP artifact and publish a Pages site.

## Local (Windows / Mac / Linux)
- Windows PowerShell:
  - `./tools/local/build_bundle.ps1`
  - `./tools/local/serve_local.ps1` → http://localhost:8000
- Mac/Linux:
  - `bash tools/local/build_bundle.sh`
  - `bash tools/local/serve_local.sh` → http://localhost:8000

## Art
- `./tools/art/watch_art.ps1` — auto-import images from your AI folder.
- `./tools/art/generate_assets_manifest.ps1` — build `assets/assets.index.json`.
- `./tools/art/generate_gallery.ps1` — build `gallery.html`.
