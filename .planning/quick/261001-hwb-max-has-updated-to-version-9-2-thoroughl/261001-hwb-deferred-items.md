# 261001-hwb — deferred items and follow-ups

Nothing here blocks the task. Items are grouped by who can close them.

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

## Repo follow-ups (planned as out of scope — plan S10)

| ID | Item |
|---|---|
| DEF-hwb-10 | `.claude/max-objects/extraction-log.json` left as a timestamped artifact; `tools/audit_db.py` reports the DB as 92 days old with `jitter`, `max`, `msp`, `packages` drifted from the log's counts |
| DEF-hwb-11 | `tools/audit_db.py` cannot see package refpages in flat `docs/` layouts (ableton-dsp, Jitter Tools, jit.mo, Jitter Geometry) — it walks 8 roots; `tools/sync_max_bundle.py` walks them all |
| DEF-hwb-12 | Phantom `v8` key in `packages/Jitter Tools/objects.json` (core `v8` wins lookup, harmless) |
| DEF-hwb-13 | Four define aliases older than 9.2 still unresolved: `jit.geom.topoints`, `jit.gl.grab`, `jit.gl.movie~`, `jit.gl.textureinfo` |
| DEF-hwb-14 | Three pre-existing failures: `tests/test_integration_patches.py::test_review_patch_no_blockers` for minitaur, physics-composition, timestretch |

## Repo follow-ups found during execution

| ID | Item |
|---|---|
| DEF-hwb-20 | `overrides.json` message lists that shadow refpage names — expert review needed, the sync tool never writes overrides: `expr` (19 names), `funnel` (`offset`, `set`), `waveform~` (15 names) |
| DEF-hwb-21 | `jit.gl.web` / `jit.gl.web~`: inlet and signal-outlet digests are empty (no refpage); an override could describe them |
| DEF-hwb-22 | `js` vs `v8` naming. The installed refpages call `js` the Legacy Engine (ECMAScript 5) and `v8` the Modern Engine. CLAUDE.md's existing bullet "`js` object runs V8 JavaScript inline in MAX", the section title "js (V8 JavaScript / js object)" and the skill's "js (V8 object)" column were left in place (additive-only constraint) with a clarifying bullet beside them. Decide whether generated scripts should target `v8` and reword |
| DEF-hwb-23 | `thispatcher` `showparameterwindow` is described in the 9.2 refpage but sits in an entry list, not a method element, so the sync did not add it to the DB message list |
| DEF-hwb-24 | `alpha_mode` is listed as an attribute in 23 bundled Jitter refpages and is in no DB entry; the `alpha_blend` name used by the release-notes overview appears nowhere in the bundle |
| DEF-hwb-25 | CLAUDE.md's "~795 phantom gaps" figure was not recomputed — `tools/audit_db.py` does not report it. The two figures it does report were re-synced (1935 files, 7 unresolved) |
| DEF-hwb-26 | README.md and TECHNICAL.md test-count figures ("2,034 tests", "46 test files") are stale; the suite collects 2,282 tests from 55 `tests/test_*.py` files. Out of scope here (object counts only) |
| DEF-hwb-27 | Local `main` is 68 commits ahead of `origin/main` (0 behind); nothing was pushed. Agent worktree isolation bases off `origin/main`, which is why this task ran sequentially on the main tree |
