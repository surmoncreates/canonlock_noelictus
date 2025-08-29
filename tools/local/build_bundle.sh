#!/usr/bin/env bash
set -euo pipefail
DIST="dist"
ZIP="$DIST/canonlock_noelictus_latest.zip"
ITEMS=(lore rules gameplay scenes index.html style.css README.md CHANGELOG.md HOW_TO_AUTOMATE.md tools)
mkdir -p "$DIST"
rm -f "$ZIP"
TMP="$(mktemp -d)"
for i in "${ITEMS[@]}"; do [ -e "$i" ] && cp -r "$i" "$TMP/"; done
(cd "$TMP" && zip -r "$ZIP" . >/dev/null)
rm -rf "$TMP"
echo "Bundle created at $ZIP"
