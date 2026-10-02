# 261001-hwb — deferred items and follow-ups

Nothing here blocks the task. Items are grouped by who can close them. Repo-side items closed on 2026-10-02 are at the bottom with their commits.

## Needs a session in MAX 9.2 (user)

The same list is in `.claude/skills/references/max-9.2-changes.md` → "Check in MAX before relying on it".

| ID | Check | Why it is open |
|---|---|---|
| DEF-hwb-01 | Instantiate each of the 12 new objects; confirm inlet / outlet counts | Shapes come from refpages and help-patch boxes, not from a running Max |
| DEF-hwb-02 | `jit.web~` / `jit.gl.web~` outlet order (audio L, audio R, matrix or texture, dumpout) | Refpage types all four outlets `signal`; the help box decided |
| DEF-hwb-03 | `jit.gl.web`: is the message / attribute list inherited from `jit.web` right for the texture variant | No refpage exists for the alias |
| DEF-hwb-04 | A gen~ codebox that needs the `History one(1)` de-hoist workaround, compiled without it on 9.2 and on an older 9.x build | 9.2's compiler fixes are release-notes-only; no gen~ rule was relaxed |
| DEF-hwb-05 | `buffer~` `trim`, `replacechannel`; whether `setsize` / `sizeinsamps` take a retain argument and where | The retain argument is in the release notes but not in the 9.2 refpage |
| DEF-hwb-06 | `v8`: `setTimeout` / `setInterval`, `toJSON()` on a Dict, one bundled network example | Release notes say timers exist; the user guide inside the 9.2 bundle still says they do not |
| DEF-hwb-07 | `udpsend` / `udpreceive` with `@port`, `@host`, `@active` | Documented by the refpages, not run |
| DEF-hwb-08 | Save a patch with one background-layer patch cord and commit it | The JSON key is not observable: none of the 48 bundle patches saved by 9.2 carries a new patchline key |
| DEF-hwb-09 | Instantiate `jit.geom.topoints` (1 / 2) and `jit.gl.textureinfo` (1 / 1) | Added 2026-10-02 from the mapping line, alias refpage and help-patch box (DEF-hwb-13), not from a running Max |

## Still open in the repo

| ID | Item |
|---|---|
| DEF-hwb-13 (rest) | `jit.gl.grab` and `jit.gl.movie~` are still unresolved. The bundle has a `max define` line for each (`jit.grab` / `jit.movie~` with `@output_texture 1`) but no refpage and no help-patch box for either name anywhere in the bundle, so `tools/sync_max_bundle.py --apply define` aborts on both. Nothing was hand-written. They need an instance saved from MAX (or a decision to inherit the target's I/O unverified) |
| DEF-hwb-14 | Three pre-existing failures: `tests/test_integration_patches.py::test_review_patch_no_blockers` for minitaur, physics-composition, timestretch |
| DEF-hwb-22 | `js` vs `v8` naming in CLAUDE.md and the js skill. Being handled by a separate change (`dd079b2`); not verified from this follow-up |
| DEF-hwb-27 | Local `main` is ahead of `origin/main`; nothing was pushed. Agent worktree isolation bases off `origin/main` |
| DEF-hwb-28 | CLAUDE.md figures to re-sync (not edited by the follow-up, another change owns the file): package objects 1496 → **1497**; refpage statistics → **2156** refpage files, **813** disagree filename vs name attribute, **795** phantom gaps when keyed by filename (803 stems unresolved, 8 of them real), **8** names unresolved when keyed by name attribute (6 documentation pages, `kbm.data`, `scl.data`). All four come from one run of `tools/audit_db.py` |
| DEF-hwb-29 | Inherited Jitter group attributes. `tools/sync_max_bundle.py` now reports 53 group-page attributes unrecorded on 186 objects (`blend_enable`, `depth_enable`, `drawto`, ... — everything a refpage lists in `<jitterattributelist>`). Only `alpha_mode` was applied (DEF-hwb-24). Decide whether the DB should carry inherited attributes at all; if yes, `--apply inherited --attributes NAME ...` lands them. 35 referenced names (`dim`, `planecount`, `out_name`, ...) have no group-page definition and cannot be added by the tool; `name` is defined differently by two group pages and is never offered |
| DEF-hwb-30 | `thispatcher`: the 12 other `<misc name="Patcher Messages">` entries (`clean`, `dirty`, `dispose`, `front`, `loadbang`, `lockdown`, `locked`, `path`, `presentation`, `title`, `topmost`, `write`) are documented the same way as `showparameterwindow` and are equally absent from the DB message list. Only the 9.2 name was added (DEF-hwb-23) |
| DEF-hwb-31 | `waveform~` override still lacks the refpage entries `(drag)` and `(mouse)` — skipped on purpose in DEF-hwb-20 as mouse-interaction pseudo entries. The sync report keeps listing them under "shadowed by override". Base DB lists elsewhere do carry `(drag)` / `(mouse)`; decide which convention the overrides follow |
| DEF-hwb-32 | The two aliases added in DEF-hwb-13 carry `min_version: 8`, the value of their package neighbours (and of the phantom entry that held `jit.gl.textureinfo`'s data before 9.2), set with the new `--min-version` flag. The bundle does not say when they were introduced |
| DEF-hwb-33 | `jit.geom.topoints` has `seealso: ["bogus"]` — verbatim from its refpage. The sync tool's template scrub does not treat it as a placeholder |
| DEF-hwb-34 | `.claude/scripts/validate_db.py --quick` reports 2 of 12 checks failed (`packages/objects.json` missing, `packages` domain empty): it still expects the monolithic package file replaced by per-package files in v4.0. Observed while checking the extraction log; not caused by, and not touched in, this follow-up |

## Closed 2026-10-02

Each item is its own commit on `main` (message prefix `fix(max-9.2-followup):` / `chore(max-9.2-followup):`). Nothing was pushed.

| ID | Commit | What closed it |
|---|---|---|
| DEF-hwb-11 | `1fc4ff0` | `tools/audit_db.py` takes its package refpage roots from `sync_max_bundle.package_docs_dirs()` (one shared walk, deferred import). Roots 8 → 14, refpage files 1935 → 2156. Alias documents (filename stem is a `max define` alias) are indexed under the alias. `absent_from_bundle` lists define-mapped aliases apart from its count: 16 names + 4 aliases (`jit.gl.movie`, `jit.gl.polymovie`, `jit.gl.web`, `jit.gl.web~`) instead of 24 |
| DEF-hwb-25 | `01578ee` | `missing_from_db.filename_keyed` (stems checked, stems unresolved, phantom count and list) and `refpage_index.filename_stems`; both figures are on the text summary line. Recomputed values are in DEF-hwb-28 |
| DEF-hwb-13 (part) | `2075cab` | `jit.geom.topoints` (1 / 2) and `jit.gl.textureinfo` (1 / 1) landed through `--apply define`. New `--min-version` flag for objects that predate the installed Max. `package_info.json`: Jitter Tools 102 → 103 |
| DEF-hwb-12 | `5cf473d` | Phantom `v8` key removed from `packages/Jitter Tools/objects.json`. It was the `jit.gl.textureinfo` refpage (not `jit.gl.tex2mat`, as first assumed — both refpages carry `name="v8"`), extracted under its name attribute; identical to the new `jit.gl.textureinfo` entry apart from the name and template placeholders. `package_info.json`: Jitter Tools 103 → 102 |
| DEF-hwb-24 | `b6299fc` | `alpha_mode` added to the 22 `jit.gl.*` entries whose refpages list it. Cause: object refpages reference shared OB3D attributes names-only in `<jitterattributelist>`; the definition is only in the group page `jit.group-gl.maxref.xml`, a documentation page with no DB entry (22 + that page = the "23 refpages"). The sync tool gained the `inherited_attributes` report section and `--apply inherited --attributes` |
| DEF-hwb-23 | `9823dc2` | `showparameterwindow` appended to the `thispatcher` message list, written through `write_db_file`. The tool was not taught the shape: only `thispatcher` keeps messages in `<misc>` entry lists |
| DEF-hwb-20 | `17a6e87` | `overrides.json`: `expr` +19, `funnel` +2, `waveform~` +13 refpage messages appended after the curated names, byte-preserving. Skipped `(drag)` and `(mouse)` (DEF-hwb-31) |
| DEF-hwb-21 | `b66012f` | Digest-only overrides for `jit.gl.web` / `jit.gl.web~`, copied from `jit.web` / `jit.web~`; the texture outlet reads "texture output" per the help-patch box. Counts, types, signal and hot flags equal the base entries |
| DEF-hwb-10 | `8a01e8b` | `sync_max_bundle.py --refresh-log` re-states `extraction-log.json` from the DB on disk (3445 objects, 36 files, Max 9.2.0); extractor fields keep name, order and meaning; the 2026-07-01 state is kept under `history`. Audit: 92.9 days / 4 drifted domains → 0 days / none |
| DEF-hwb-26 | `4b44b89` | README / TECHNICAL: 2,309 tests in 55 files; 3,445 objects (1,948 core + 1,497 package) |

### Guards and totals after the follow-up

- I/O snapshot taken before the first commit (3089 names) against the final tree: 3087 names byte-identical; `jit.gl.web` and `jit.gl.web~` differ in **digest text only** (DEF-hwb-21) — ids, counts, types, signal and hot flags unchanged. No name stopped resolving; two names are new.
- On-disk counts: max 473, msp 247, jitter 222, mc 222, gen 189, m4l 35, rnbo 560 (core 1,948); 29 package dirs, 1,497 objects (Jitter Geometry 26, Jitter Tools 102); total 3,445.
- Tests: 2303 passed, 3 failed (the DEF-hwb-14 set, unchanged), 2 xfailed, 1 xpassed. +27 passes are this follow-up's tests (8 in `tests/test_audit_db.py`, 19 in `tests/test_sync_max_bundle.py`).
