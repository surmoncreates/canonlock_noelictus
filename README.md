# Canonlock — Noëlictus (Post-Cara)

This bundle locks anchors, presence flags, and behind-the-scenes hooks for Nyx's induction arc.

## Quick Start (GitHub Pages)
1. Upload **all files** in this folder to your repo.
2. Enable **Pages** (Settings → Pages → Source: `main` / root).
3. Visit your Pages URL; anchors render via `index.html` and `anchor_toggles.js`.

## Files
- `index.html` — Baseline page with anchors section injected.
- `style.css` — Light theme helpers.
- `anchors_noelictus_book2.json` — Machine-readable anchors, presence flags, offstage & environment.
- `ANCHORS.md` — Human-readable character anchors.
- `SCENE_GATES.md` — Who can appear in which scenes and when.
- `ENVIRONMENT.md` — Setting anchors & signals.
- `CANONLOCK_RULES.md` — Conventions for consistency.
- `anchor_toggles.js` — Tiny helper to load JSON and tag present/BTS actors.
- `CHANGELOG.md` — Version notes.

## Toggle Presence
Edit `anchors_noelictus_book2.json` → `characters[].present` or `offstage` to mark who is on-scene. The UI uses `data-present` attributes and will add a `present--false` class where needed.

## Notes
- Veterans are **not** part of this trip.
- Darran (male conscript) persists as an antagonist.
- Sera (young hunter) acts as a foil and quiet observer.
- Noëlictus environment behaves as an active signal (echo/rot).

