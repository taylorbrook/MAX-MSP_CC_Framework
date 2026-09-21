---
phase: 260921-ima
plan: 01
subsystem: maxpat-core
tags: [maxclass, SF-03, provenance, regression-proof]
status: complete
requires: []
provides:
  - "UI_MAXCLASSES contains `codebox`, admitted on committed-patch evidence"
  - "Provenance-bearing test coverage for `codebox` and the fc3aa27 Jitter pair"
  - "Documented precedent: entries may be admitted on committed-patch evidence"
affects:
  - src/maxpat/maxclass_map.py
  - tests/test_maxclass_map.py
tech-stack:
  added: []
  patterns:
    - "appversion.revision != 0 as the MAX-wrote-this-file discriminator"
    - "order-insensitive consumer diffing with a same-code control run"
key-files:
  created: []
  modified:
    - src/maxpat/maxclass_map.py
    - tests/test_maxclass_map.py
decisions:
  - "Admitted `codebox` to UI_MAXCLASSES on committed-patch evidence, and documented that admission route in the module docstring."
  - "Placed `codebox` in its own commented group (embedded code editors), not folded into the Jitter or MSP groups — it is not a visual widget."
  - "Accepted the suggest_subpatchers() suggestion-set delta as correct rather than halting: the function is non-mutating, has no production caller, and the new behavior is the desired one."
metrics:
  duration: ~25m
  completed: 2026-09-21
actuals:
  tokens: 8500
  tasks: 3
  commits: 1
commits: 1
plan_head_before: a83c478d11c21c77f05f1adb046efa207cc96f69
---

# Quick Task 260921-ima: `codebox` is a UI maxclass (SF-03) Summary

Closed SF-03 by adding `codebox` to `UI_MAXCLASSES` on confirmed MAX-saved-form evidence from committed git objects, backfilled the test coverage `fc3aa27` shipped without, and proved the change inert against `add_gen()` output, `.maxpat` round-trip bytes, the full test suite, and every consumer site.

**Commit:** `a5f1202` — `fix(maxclass): codebox is a UI maxclass (MAX-saved form); SF-03`

## Evidence: the MAX-saved form is CONFIRMED

Pinned evidence SHA for all reads (BEFORE and AFTER used the identical pin): `447ac9a62a9af350b160011006d82c946e55dc36`. HEAD moved twice during the run (`447ac9a` → `a83c478`) from the concurrent instance; the pin insulated the comparison.

**Discriminator:** `patcher.appversion.revision`. The generator hardcodes `0` (`src/maxpat/defaults.py:60-63`), so a non-zero revision means MAX itself wrote or re-saved the file. **19 of 26** committed codebox-bearing `.maxpat` files clear it. All 26 agree on the form.

Confirming patches (both signals: non-zero revision AND an independent MAX-re-save commit message):

| Patch | appversion | Commit | Commit message |
|---|---|---|---|
| `patches/kicksynth/generated/kicksynth.maxpat` | 9.1.5 (rev 5) | `02c9917` | "save kicksynth.maxpat — MAX-side envelope + preset edits" |
| `patches/terrain-synth/generated/terrain-synth.maxpat` | 9.1.5 (rev 5) | `55757e0` | "save terrain-synth.maxpat (MAX re-save of v0.9.0…)" |
| `patches/ji-harmonizer/generated/ji-harmonizer.maxpat` | 9.1.5 (rev 5) | `4b82e72` | "save ji-harmonizer.maxpat (MAX re-save)" |
| `patches/spectraldetector/generated/spectraldetector.maxpat` | 9.1.5 (rev 5) | `477dda6` | "hand edits in MAX (removed 6 boxes)" |

**The decisive observation** — the codebox box in `kicksynth.maxpat` @ `02c9917`:

```json
{ "id": "obj-2", "maxclass": "codebox", "numinlets": 1, "numoutlets": 1,
  "code": "Param pitch_start(300, …)", "fontname": "<Monospaced>", … }
```

No `text` field. Its siblings in the *same* gen~ patcher are `{"maxclass": "newobj", "text": "in 1"}` and `{"maxclass": "newobj", "text": "out 1"}`. MAX discriminates between them in exactly the way `UI_MAXCLASSES` encodes.

## Inventory (recomputed at the pinned SHA)

| Measure | Value | vs planning-time baseline |
|---|---|---|
| Committed `.maxpat` with a codebox | 26 | matches |
| Raw `maxclass": "codebox"` occurrences | 47 | matches |
| Committed `.gendsp` with a codebox | 10 | matches |
| Top-level (non-nested) codebox boxes | **0** | matches — every one is inside an embedded patcher |

**Accounting note (47 vs 46):** 46 of the 47 are reachable through `Patcher.from_dict`'s `"patcher"`-key recursion. The 47th (`ji-harmonizer.maxpat`, `boxes[87]/box/data/patcher/boxes[3]`) sits under a **`data`** key rather than a `patcher` key — the embedded-gen-under-`data` form. `from_dict` treats `data` as an opaque `extra_attrs` value and re-emits it verbatim (hence still byte-identical), and no consumer descends into it. It is unaffected either way.

## Before/After proof

| Check | Before | After | Result |
|---|---|---|---|
| `add_gen()` serialized hash | `56deded1399b27ce57b3b678e7a9529585b09b655155070832a743ab03cdbba3` | identical | **MATCH** |
| `.maxpat` round-trip, per-file hash | 26 files | **26/26 identical**, 0 errors | **MATCH** |
| Full suite | 2191 passed / 6 xfailed | 2194 passed / 6 xfailed | +3, as expected |
| Per-test pass/fail identity | 2197 testcases | 2200 | delta is **exactly** the 3 new tests, all `pass`; **zero** existing tests changed state |

`add_gen()` equality holds for the predicted structural reason: it builds its codebox via `Box.__new__` (`builders.py:884-908`), bypassing `Box.__init__` and therefore `resolve_maxclass`. Round-trip equality holds for the same reason — `Patcher.from_dict` assigns `box.maxclass = box_data.get("maxclass")` directly (`patcher.py:1253`), never calling the resolver.

## The six consumer sites — answered

| # | Site | What the entry changes | Verdict |
|---|---|---|---|
| 1 | `patcher.py:177` `resolve_maxclass(canonical)` in `Box.__init__` | `add_box("codebox")` goes from `maxclass='newobj', text='codebox'` → `maxclass='codebox'`, no text | **Real change, zero call sites.** `grep` across `src/` and `tests/` finds no direct `codebox` construction. The new form is the correct MAX form; the old one (a top-level `newobj` reading `codebox`) would not instantiate in MAX. |
| 2 | `patcher.py:188` Rule #1 gate | **Nothing.** | **Plan claim corrected.** The plan (and T-ima-04) asserted the gate currently makes `Box("codebox")` raise. It does not: `codebox` **is** in the object DB (domain `RNBO`, 1 inlet / 1 outlet), so `obj_data is not None` and the gate never fired. Verified empirically — `add_box("codebox")` succeeded before the edit. |
| 3 | `validation.py:283` `_validate_objects_exist` | **Nothing.** | Iterates `patch_dict["patcher"]["boxes"]` only — **no recursion into embedded patchers.** With 0 top-level codeboxes it is never reached. Empirically: `validate_patch()` over all 26 patches → **24 results before, 24 after, zero changed files.** |
| 4 | `validation.py:330` `_validate_maxclass_usage` | **Nothing.** | Same top-level-only loop. The membership skip is **inert**. Covered by the same empirical 24/24 result. |
| 5 | `analysis.py:139` `_classify_domain` | **Nothing.** | The DB lookup runs *first* and returns domain `RNBO`, so the `box.maxclass in UI_MAXCLASSES` branch is never reached for a codebox. Empirically: **3423 boxes across 105 patchers, zero domain changes.** All 46 reachable codeboxes classify as `RNBO` before and after. |
| 6 | `layout.py:1283` `suggest_subpatchers` | **The only real behavior delta.** | Round-tripped codeboxes carry `box.name == "codebox"`, so `is_ui_object` now excludes them from clustering. Candidates **93 → 47 (−46)**. |

### Consumer site 6, in detail

A first-pass diff showed 55 changed patchers, 9 of them codebox-free — which would have been unattributable. A **control run** (identical code, two processes) reproduced the same noise: 7 patchers differed under order-sensitive comparison, **0** under order-insensitive. Cause: `suggest_subpatchers` BFSes over a Python `set` of box IDs, so candidate `boxes` list ordering varies with `PYTHONHASHSEED`. Same membership, same `external_ins`/`external_outs`, same `name`.

Re-diffed order-insensitively, the delta is exact:

- **46 patchers changed — all 46 contain a codebox. Zero codebox-free patchers changed.**
- Change shape is uniform: `1 candidate → 0`, in every case.
- Cause: a gen~ inner patcher holds exactly 3 boxes (`in 1`, codebox, `out 1`). Excluding the codebox drops the eligible group to 2, below `min_group_size=3`, so the candidate disappears.

Accepted rather than halted, because it is covered and correct:
1. **Non-mutating** — the plan's stated check was box positions, and **zero boxes moved** across 105 patchers / 3423 boxes.
2. **No production caller** — `suggest_subpatchers` is referenced only by `tests/test_layout.py`. It returns suggestions and cannot touch `.maxpat` bytes.
3. **Semantically right** — you cannot put a subpatcher inside a gen patcher. Proposing a gen~ inner patcher's 3 structural boxes for encapsulation was always wrong output; suppressing it is the desired outcome.
4. **Breaks nothing** — the per-test identity diff shows `tests/test_layout.py` entirely unchanged.

## Changes

**`src/maxpat/maxclass_map.py`** (+10 / −1)
- One entry added to `UI_MAXCLASSES` in its own commented group (`# Embedded code editors`), naming `kicksynth.maxpat @ 02c9917` and `terrain-synth.maxpat @ 55757e0` and citing SF-03.
- Module docstring extended to document the committed-patch admission route and the `appversion.revision` discriminator — so the next entry has a stated standard to meet.

**`tests/test_maxclass_map.py`** (+69), 10 → 13 tests
- `UI_OBJECTS` gains `codebox`, `jit.pwindow`, `jit.cellblock`, so the existing `TestResolveMaxclass` / `TestIsUiObject` classes cover them.
- New `TestCommittedPatchProvenance` with three tests: the SF-03 claim (docstring naming the confirming patches, appversions, and SHAs), the `fc3aa27` Jitter pair (crediting `fc3aa27` and `174840c`), and a guard that `gen~`/`rnbo~` still resolve to `newobj` so a future overreaching edit fails here too.

TDD: tests were written first and failed RED for the right reason — `AssertionError: assert 'newobj' == 'codebox'` (membership absent), not an import or name error. 3 failed / 10 passed before the edit; 13 passed after.

## Deviations from Plan

**1. [Rule 1 — factual correction] The plan's Rule #1 gate claim was wrong**
- **Found during:** Task 1, consumer enumeration.
- **Issue:** The plan and threat `T-ima-04` both stated that `patcher.py:188` currently makes a direct `Box("codebox")` construction raise, and that the entry "stops that raise."
- **Reality:** `codebox` is present in the object DB (`domain: RNBO`), so `obj_data` is never `None` and the gate never fired. `add_box("codebox")` succeeded before the edit, returning `maxclass='newobj', text='codebox'`.
- **Fix:** No code change — the correction is recorded here and in the consumer table. The real site-1 impact (maxclass form of a directly-constructed codebox) is documented in its place.

**2. [Rule 3 — blocking issue] Consumer diff contaminated by set-iteration nondeterminism**
- **Found during:** Task 3, layout re-check.
- **Issue:** 9 codebox-free patchers appeared to change, which would have tripped the STOP GATE as an unattributable delta.
- **Fix:** Added a same-code control run to isolate the cause (`PYTHONHASHSEED`-driven `set` ordering in the BFS), then re-diffed order-insensitively. Residual delta is exactly 46 codebox-bearing patchers, 0 others.

**3. [Scope] Working-tree drift under `patches/`**
- The plan expected 4 modified files under `patches/`; at execution start there were 3, and 5 by commit time (the concurrent instance saved `gen-eq` patches mid-run). Per orchestrator override, no fixed count was asserted. **Nothing under `patches/` was read as evidence, written, staged, reverted, or checked out.** All evidence came from `git show <pinned-SHA>:`. Final `git status --porcelain -- patches/` shows 5 modified, none staged.

## Threat Mitigations

| Threat | Status |
|---|---|
| T-ima-01 (concurrent instance's `patches/` edits) | **Mitigated.** All reads via `git show 447ac9a:`. Staged diff verified codebox-free before commit; explicit two-path `git add`. No `git add .`/`-A`, no `git stash`. |
| T-ima-02 (serialization drift) | **Mitigated.** `add_gen()` hash identical; 26/26 round-trip hashes identical. |
| T-ima-03 (generator output masquerading as MAX-saved) | **Mitigated.** Dual-signal confirmation — `appversion.revision != 0` cross-checked against four independent MAX-re-save commit messages. |
| T-ima-04 (Rule #1 gate) | **Mitigated, and the premise corrected** — the gate never fired for `codebox`. See Deviation 1. |
| T-ima-05 (silent `analysis.py` / `layout.py` change) | **Mitigated.** `analysis.py` empirically identical (3423 boxes). `layout.py` delta measured, fully attributed, and justified. Zero box positions moved. |
| T-ima-06 (undocumented membership — the `fc3aa27` failure mode) | **Mitigated.** Source comment and both test docstrings name the confirming patches and SHAs; the module docstring states the admission standard. |

## Known Stubs

None.

## Threat Flags

None — no new network, auth, file-access, or schema surface.

## Verification

- [x] MAX-saved form confirmed with paths, appversions, and SHAs
- [x] `pytest -q` green; 2191 → 2194 passed, 6 xfailed unchanged
- [x] `add_gen()` hash identical before/after
- [x] 26/26 committed codebox `.maxpat` round-trip byte-identical
- [x] All six consumer sites enumerated with observed impact; the two byte-identity cannot cover re-checked empirically
- [x] `git status --porcelain -- patches/` lists only pre-existing modifications, none staged
- [x] Commit touches exactly `src/maxpat/maxclass_map.py` and `tests/test_maxclass_map.py`

## Self-Check: PASSED

- `src/maxpat/maxclass_map.py` — FOUND
- `tests/test_maxclass_map.py` — FOUND
- Commit `a5f1202` — FOUND
- No deletions in the commit; no untracked files left under `src/` or `tests/`
