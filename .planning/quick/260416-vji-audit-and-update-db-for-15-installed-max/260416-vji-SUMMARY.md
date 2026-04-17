---
quick_id: 260416-vji
description: Audit and update DB for 15 installed Max community packages
status: complete
date: 2026-04-17
commits:
  - c541204
  - c5f6e7e
  - 3d1b7bf
  - f09c29c
---

# Quick Task 260416-vji: Community Package DB Audit

## Goal

Find missing objects and incomplete entries in the community-package portion of `.claude/max-objects/`, and update the DB where info was missing.

## Approach

User copied 15 installed community packages (~7.7G) into `.claude/max-objects/_pkg-source/` (gitignored) so the CLI could read them — `~/Documents/Max 9/Packages/` is TCC-locked from Claude Code. The user explicitly chose deep audit scope across all installed packages, with web research + help patches as truth source.

Two extraction pipelines were used depending on what each package ships:

- **XML refpages** (`docs/*.maxref.xml`): authoritative for inlets, outlets, arguments, messages, attributes, descriptions. Used `.claude/scripts/extract_objects.py` after patching it to discover community-layout refpages.
- **Abstractions / externals** (`patchers/*.maxpat`, `externals/*.mxo`): no refpages exist; I/O parsed from inlet/outlet boxes in the abstraction or the `newobj` instance in the matching help patch.

## Stages and commits

### Stage 1 — `c541204` Patch the extraction script

`extract_objects.py` only knew about C74's `docs/refpages/<lang>-ref/` layout. Community packages put `.maxref.xml` directly under `docs/`. Added `community_root` parameter to `discover_xml_files` / `extract_all` that scans recursively from a passed-in package root.

Two latent bugs surfaced and were fixed:

- `parse_max_xml` set `maxclass = name` for every object, which is wrong for everything except built-in UI widgets and a few special boxes. Default is now `"newobj"` with an explicit `NON_NEWOBJ_MAXCLASSES` allowlist.
- `update_package_registry` refused to add new packages and never refreshed version metadata. Now it creates a default community-tier entry from the package's own `package-info.json` and refreshes version on subsequent runs.

Added `.gitignore` (the repo had none) excluding `.claude/max-objects/_pkg-source/`.

### Stage 2 — `c5f6e7e` Extract 11 XML-based packages, fix maxclass across the DB

Ran the patched script for every installed XML package. Numbers are post-merge totals (curated entries preserved on top of fresh extraction):

| Package | Before | After | Delta |
|---|---:|---:|---:|
| Bach | 78 | 274 | +196 |
| EARS | 28 | 134 | +106 |
| abclib | 0 | 66 | +66 |
| CNMAT | 54 | 59 | +5 |
| Dada | 14 | 40 | +26 |
| FluCoMa | 78 | 80 | +2 |
| grainflow | 0 | 34 | +34 |
| ml.star | 0 | 18 | +18 |
| ease | 0 | 6 | +6 |
| FlowSwing | 0 | 6 | +6 |
| nn_tilde | 0 | 4 | +4 |

Skipped: **RNBO** (563 `.maxref.xml` files overlap with the bundled `rnbo/objects.json` which already has 560 entries; re-extracting would duplicate work).

One-shot fix of the maxclass bug applied across **17 package directories** — 513 entries had `maxclass` set to the object name instead of `"newobj"`. Same bug as the manual FluCoMa fix in `9d42e86`, but the manual pass missed `fluid.bufonsetslice~` (caught here) and never touched the other 16 packages.

### Stage 3 — `3d1b7bf` Add 3 abstraction-only packages

| Package | Objects | I/O coverage | Source |
|---|---:|---:|---|
| ABL Effect Modules | 48 | 48/48 | `patchers/Abl.*.maxpat` inlet/outlet boxes |
| catart-mubu | 71 | 65/71 | `patchers/lib/camu.*.maxpat` inlet/outlet boxes |
| cv.jit | 47 | 46/47 | `externals/cv.jit.*.mxo` + `help/*.maxhelp` newobj instance |

Entries marked `verified: true` when I/O was extractable, `false` for the 7 utility patches with no inlet/outlet objects. `abstraction_file` / `external_file` fields point back to source paths so a future audit pass can refine descriptions, attributes, and arguments.

### Stage 4 — `f09c29c` Reconcile package_info.json

- Synced `object_count` to actual file totals (registry was understating because `update_package_registry` writes the pre-merge fresh-extraction count, not the post-merge total).
- Added `installed: true|false` to every entry. Bundled packages always installed; community packages flagged based on presence in `_pkg-source/`.
- Set `extracted: true` for 5 packages with stale `extracted: false` despite having data (Cage 31, Odot 31, IRCAM Spat 25, RTK 18, ml-lib 14).
- Sorted: bundled first, community alphabetical.

Final state: **29 packages** — 10 bundled, 14 community-installed, 5 community-uninstalled.

## What's now in the DB

| Tier | Installed | Total objects |
|---|---|---:|
| Bundled | 10 packages | 515 |
| Community installed | 14 packages | 887 |
| Community uninstalled | 5 packages | 119 (stub) |

## Known limitations

- **catart-mubu / ABL Effect Modules**: descriptions are blank — the abstractions don't carry a structured description field. A future pass could parse comment boxes near inlet/outlet definitions to derive them.
- **cv.jit**: one external (`cv.jit.*` whose help patch has no matching `newobj`) lacks I/O. Probably uses a different invocation pattern in its help.
- **catart-mubu**: 6 of 71 objects have empty I/O — they're pure utility patches with no inlet/outlet boxes (likely `.js` wrappers or one-off scripts loaded as abstractions).
- **5 uninstalled packages** (Cage, Odot, IRCAM Spat, Rhythmic Time Toolkit, ml-lib): kept their existing curated stubs but cannot be deeply audited until installed locally.

## Files modified

| Path | What changed |
|---|---|
| `.gitignore` | New file. Excludes `.claude/max-objects/_pkg-source/` (7.7G of help patches and externals — never committed). |
| `.claude/scripts/extract_objects.py` | Added community-package XML discovery, fixed maxclass default, extended `update_package_registry` to add new entries. |
| `.claude/max-objects/package_info.json` | Reconciled counts, added `installed` flag, sorted by tier. |
| `.claude/max-objects/packages/{14 dirs}/objects.json` | Fresh extractions + maxclass cleanup across existing curated entries. |
| `.claude/max-objects/packages/{ABL Effect Modules,catart-mubu,cv.jit,abclib,FlowSwing,grainflow,ml.star,nn_tilde}/objects.json` | New package directories. |
| `.claude/max-objects/extraction-log.json` | Auto-updated by extractor on each run. |
