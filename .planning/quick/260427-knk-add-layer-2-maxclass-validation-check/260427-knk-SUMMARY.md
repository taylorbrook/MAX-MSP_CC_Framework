---
quick_id: 260427-knk
mode: quick-full
description: Add Layer-2 maxclass validation check (FINDINGS P1-5)
date: 2026-04-27
status: complete
key_files:
  modified:
    - src/maxpat/maxclass_map.py        # +5 lines (4 UI widget names)
    - src/maxpat/validation.py          # +21/-9 (error level + patcher-key skip + better message)
    - tests/test_validation.py          # +119/-26 (4 renamed + 4 new tests)
commits:
  - 764307e: feat(quick-260427-knk-01): expand UI_MAXCLASSES with 4 package UI widgets
  - b490d11: feat(quick-260427-knk-02): promote maxclass-usage check to error + patcher-key skip
  - 9241012: test(quick-260427-knk-03): update TestMaxclassUsage for error level + 4 new cases
metrics:
  tasks: 4
  duration_minutes: ~10
  completed_date: 2026-04-27
---

# Quick 260427-knk: Layer-2 maxclass validation check — Summary

**One-liner:** Promoted `_validate_maxclass_usage` from warning to hard error, added a `patcher`-key escape for legitimate subpatcher containers, broadened `UI_MAXCLASSES` with four package widgets, and rewrote the error message to show both the wrong pair (`maxclass='cycle~'`) and the correct pair (`maxclass='newobj'` + `text='cycle~ ...'`) in a single line, fully closing FINDINGS P1-5.

## What changed

### Task 1 — `UI_MAXCLASSES` expansion (commit `764307e`)
Added four legitimate non-`newobj` UI widget names so existing real patches continue to pass the now-strict check:
- `playlist~` — Max-bundled clip-player UI widget (used in `patches/tape-wobble`)
- `dict.view` — Max-bundled dict viewer UI widget (used in `patches/intelligent-corpus-remixer`)
- `dada.bounce` — dada package physics-balls UI widget (used in `patches/physics-composition`)
- `bach.roll` — bach package notation-roll UI widget (used in `patches/physics-composition`)

Grouped under a new `# Specialty / package UI widgets` section to keep the existing groupings tidy. `resolve_maxclass` and `is_ui_object` flow through the additions automatically — no other module changes needed.

### Task 2 — `_validate_maxclass_usage` promotion (commit `b490d11`)
1. **Level promoted** from `"warning"` to `"error"`. A box with `maxclass='cycle~'` instead of `maxclass='newobj'` + `text='cycle~ ...'` raises `"invalid attribute maxclass"` at MAX load time — that is a hard correctness bug, not a stylistic warning.
2. **`patcher`-key skip added** right after the structural-maxclass skip. Subpatcher containers (`gen~`, `poly~`, `rnbo~`, `codebox` in embedded mode) legitimately carry their own maxclass when paired with an inline `patcher` JSON object (canonical example: `tests/fixtures/expected/gen_codebox.maxpat`). Without this skip, every embedded gen~ patch would falsely trigger the error.
3. **Message rewritten** to show both pairs on a single line and point to the authoritative source (`UI_MAXCLASSES`):
   ```
   Wrong maxclass: object 'cycle~' uses maxclass='cycle~' but should use
   maxclass='newobj' with text='cycle~ ...' (only UI widgets use their own
   name as maxclass; see UI_MAXCLASSES in src/maxpat/maxclass_map.py)
   ```
4. **Docstring updated** to reflect error-level + patcher-key skip semantics.

The function's external call site at `validate_patch` (line 131) is unchanged.

### Task 3 — Tests (commit `9241012`)
Renamed and flipped four existing tests to assert `level == "error"`:
- `test_non_ui_object_wrong_maxclass_triggers_error`
- `test_ui_object_own_maxclass_no_error`
- `test_structural_maxclass_no_error`
- `test_standard_newobj_no_error`

Added four new tests:
- `test_ui_widgets_button_dial_gain_pass` — three concrete UI widgets pass.
- `test_multiple_non_ui_own_maxclass_each_errors` — three non-UI boxes (`cycle~`, `*~`, `pack`) each using own-name maxclass produce three errors.
- `test_subpatcher_container_with_patcher_key_passes` — `gen~` with embedded `patcher` key is not flagged.
- `test_error_message_includes_correct_pair` — message contains both `maxclass='cycle~'` AND `maxclass='newobj'` AND `text='cycle~`, enforcing the wrong-pair → correct-pair contract.

All 8 tests in `TestMaxclassUsage` pass.

### Task 4 — Regression check (verification only)
Direct invocation of `_validate_maxclass_usage` on every real patch and fixture in the repo:

```
27 real patches scanned (patches/*/generated/*.maxpat) → 0 maxclass errors
 4 fixtures scanned (tests/fixtures/**/*.maxpat)        → 0 maxclass errors
```

The new check breaks no existing patch. The four UI widgets added in Task 1 plus the `patcher`-key skip are exactly sufficient.

## Success criteria (all met)

- [x] `_validate_maxclass_usage` emits `error` not `warning` (Task 2)
- [x] Error message includes wrong-pair AND correct-pair info (Task 2 + `test_error_message_includes_correct_pair`)
- [x] Subpatcher-container skip via `patcher` key (Task 2 + `test_subpatcher_container_with_patcher_key_passes`)
- [x] `UI_MAXCLASSES` expanded by 4 (Task 1)
- [x] Tests cover both directions per spec (Task 3, `test_ui_widgets_button_dial_gain_pass` + `test_multiple_non_ui_own_maxclass_each_errors`)
- [x] No regressions caused by this plan (Task 4)

## Deviations from Plan

None — plan executed exactly as written. No Rule 1/2/3 auto-fixes were required; the plan's verify/done fields all hit on first pass.

## Pre-existing test failures (out of scope, NOT caused by this plan)

The full-suite run surfaced pre-existing failures unrelated to maxclass validation. Each was verified to also fail on the base commit (`980ca1c`) before any of this plan's commits:

| Test | Failure | Root cause |
| --- | --- | --- |
| `test_integration_patches.py::test_validate_patch_no_errors` (×27) | `TypeError: validate_patch() got an unexpected keyword argument 'patch_dir'` | Test calls `validate_patch(patch_dir=...)` but `validate_patch()` has never had a `patch_dir` parameter (verified on base commit). API mismatch unrelated to this plan. |
| `test_integration_patches.py::test_review_patch_no_blockers` (×14) | `Fan-out without trigger: ... -- execution order is undefined` | Real-patch fixtures need updating to the just-landed fan-out severity promotion (commit `98bbc3a`, `quick-260427-kbe`). Unrelated to maxclass. |
| `test_validation.py::TestCommunityPackageBlock::test_community_block_warning` | `assert 0 >= 1` (no warnings emitted) | Package-layer / community-block logic; verified failing on base. Unrelated to maxclass. |
| `test_validation.py::TestCommunityPackageBlock::test_ircam_spat_specific_message` | `assert 0 >= 1` | Same — package-layer concern. Unrelated to maxclass. |
| `test_critics.py::TestPackageCritic::test_community_unextracted_warning` | `Expected community extraction warning, got: []` | FluCoMa community-extraction critic; verified failing on base. Unrelated to maxclass. |

These are tracked here for visibility but are explicitly out of scope per the plan ("If a real patch fails `test_validate_patch_no_errors`, treat it as a true bug surfaced by the new check — report in SUMMARY but do not silently widen UI_MAXCLASSES further"). All `test_validate_patch_no_errors` failures are `TypeError`s in the test wrapper, not maxclass errors — direct invocation of `_validate_maxclass_usage` on every patch/fixture (Task 4) found 0 maxclass errors.

## Self-Check: PASSED

- [x] `src/maxpat/maxclass_map.py` updated (`playlist~`, `dict.view`, `dada.bounce`, `bach.roll` present in `UI_MAXCLASSES`)
- [x] `src/maxpat/validation.py` updated (level=`"error"`, `patcher`-key skip, new message format)
- [x] `tests/test_validation.py::TestMaxclassUsage` 8/8 pass
- [x] All three commits exist: `764307e`, `b490d11`, `9241012`
- [x] No real patch (`patches/*/generated/*.maxpat`) fails the new check
