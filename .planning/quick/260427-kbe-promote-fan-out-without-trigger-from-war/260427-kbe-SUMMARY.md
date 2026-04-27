---
phase: quick-260427-kbe
plan: 01
subsystem: critics
tags: [structure-critic, severity-tier, fan-out, tdd, p0]
dependency-graph:
  requires:
    - "src/maxpat/critics/base.py CriticResult (severity field, no API change)"
    - "Existing _check_fan_out_without_trigger detection logic (unchanged)"
  provides:
    - "Fan-out without trigger findings now emit at severity='blocker' instead of 'warning'"
    - "Regression guard: signal-rate (~) fan-out remains exempt at all severities"
    - "Regression guard: trigger-mediated fan-out remains exempt at all severities"
  affects:
    - "Downstream critic-loop logic that filters CriticResult.severity == 'blocker' (e.g., review_patch consumers)"
    - "Agent feedback loop — fan-out is now a hard tier alongside gen~ I/O mismatch / missing in~/out~ / missing MIN_EXTERNAL"
tech-stack:
  added: []
  patterns:
    - "TDD RED -> GREEN gating: failing test commit before source change commit, verified by git log ordering"
    - "Severity-tier alignment across sibling critics (dsp_critic / rnbo_critic / ext_critic / structure_critic) for hard structural failures"
key-files:
  created:
    - ".planning/quick/260427-kbe-promote-fan-out-without-trigger-from-war/260427-kbe-SUMMARY.md"
    - ".planning/quick/260427-kbe-promote-fan-out-without-trigger-from-war/deferred-items.md"
  modified:
    - "src/maxpat/critics/structure_critic.py (severity literal flip + docstring expansion)"
    - "tests/test_critics.py (3 tests updated/added: rename, broadened filter, new signal-rate regression)"
decisions:
  - "Use severity='blocker' rather than wiring fan-out into validation.has_blocking_errors() — the latter operates on ValidationResult.level, not CriticResult, and re-routing it is captured separately as FINDINGS.md §P2-4."
  - "Rename test_fan_out_without_trigger_detected -> test_fan_out_without_trigger_blocks to make the tier rename self-documenting in test reports."
  - "Add explicit signal-rate regression test (test_fan_out_signal_rate_not_blocked) so future refactors of _is_signal_object can't accidentally start emitting blockers on cycle~ -> 2x *~ chains."
metrics:
  duration: "~2m16s"
  completed: "2026-04-27T21:45:46Z"
  commits: 2
  tasks_total: 2
  tasks_completed: 2
  tests_added: 1
  tests_modified: 2
  tests_passing_in_target_class: "8/8 TestStructureCritic + TestReviewPatchCombined"
---

# quick-260427-kbe Plan 01: Promote fan-out severity to blocker — Summary

Promoted `structure_critic._check_fan_out_without_trigger` from `severity="warning"` to `severity="blocker"`, aligning fan-out detection with the existing hard-tier used by sibling critics (gen~ I/O mismatch, missing in~/out~, missing MIN_EXTERNAL). Source change is a single string literal flip plus a docstring expansion; tests cover the RED gate, the GREEN gate, and a new regression guarding the signal-rate exemption.

## Files Changed

| File | Change | Lines |
|------|--------|-------|
| `src/maxpat/critics/structure_critic.py` | `"warning"` -> `"blocker"` at line 143; expanded docstring of `_check_fan_out_without_trigger` (lines 85-104) with tier rationale and skip semantics | +12 / -1 |
| `tests/test_critics.py` | Renamed `test_fan_out_without_trigger_detected` -> `test_fan_out_without_trigger_blocks` and asserted `severity=='blocker'`; broadened `test_fan_out_with_trigger_no_warning` filter to span both warning and blocker tiers; added new `test_fan_out_signal_rate_not_blocked`; updated inline comment in `test_review_patch_combines_both_critics` | +66 / -10 |

## Test Counts (Before / After)

- **Before:** 2 fan-out tests in `TestStructureCritic` (`test_fan_out_without_trigger_detected`, `test_fan_out_with_trigger_no_warning`)
- **After:** 3 fan-out tests in `TestStructureCritic` (`test_fan_out_without_trigger_blocks` [renamed + retiered], `test_fan_out_with_trigger_no_warning` [broadened], `test_fan_out_signal_rate_not_blocked` [new])
- **Net delta:** +1 test
- **Suite results:** all 8 of `TestStructureCritic + TestReviewPatchCombined` pass.

## TDD Gate Compliance

- **RED gate:** commit `a57acf4 test(quick-260427-kbe-01): ...` adds the new tier assertion; running `pytest test_fan_out_without_trigger_blocks` against the still-warning source produces `AssertionError: Expected at least one blocker for 1-to-3 control fan-out, got: [('warning', ...)]` as expected. Confirmed RED was reached before GREEN.
- **GREEN gate:** commit `98bbc3a feat(quick-260427-kbe-02): ...` flips the severity literal; the same test now passes, along with the broadened trigger-exempt test and the new signal-rate regression.
- **REFACTOR gate:** not needed — implementation change is a single literal swap; nothing to clean up.

## Scope Guards (Held)

- `_check_hot_cold_ordering` — still emits `"warning"` (out of scope per plan; hot/cold ordering is a softer signal than fan-out and remains advisory).
- `_check_redundant_connections` — still emits `"warning"` (out of scope).
- `_is_signal_object` skip at line 119 — unchanged; signal-rate fan-out remains exempt under Rule #3 (all signal inlets are hot in the audio domain).
- `_is_trigger_object` skip at line 115 — unchanged; trigger-mediated fan-out remains exempt at all severities.
- `validation.has_blocking_errors()` — untouched. Critic blockers do not flow into this helper today (it inspects `ValidationResult.level == "error"`, not `CriticResult.severity`). FINDINGS.md §P2-4 captures the wiring task as separate work.

Verification grep on the source confirms scope: `grep -n '"blocker"\|"warning"' src/maxpat/critics/structure_critic.py` returns exactly 1 `"blocker"` (fan-out emit, line 143) and 2 `"warning"` (hot/cold emit line 238, redundant emit line 273).

## Verification

Final integration script (from `<verification>` block of the plan) confirms a 1-to-3 control fan-out now appears in the standard `severity == "blocker"` filter pattern used by `review_patch` consumers:

```
Blocker count: 1
  severity='blocker' finding="Fan-out without trigger: 'metro' (a) outlet 0
    connected to 3 destinations (...) -- execution order is undefined"
OK -- fan-out blockers are emitted, satisfying has_blocking_errors() spirit
```

## Deviations from Plan

None — plan executed exactly as written. Two atomic TDD commits, scope held, no auto-fix rules triggered.

One pre-existing unrelated test failure (`TestPackageCritic::test_community_unextracted_warning`) was discovered during the full-suite run and logged to `deferred-items.md`. It exercises `package_critic.review_packages` and cannot be influenced by this task's changes; flagged for separate follow-up.

## Authentication Gates

None — pure code change with no external service dependencies.

## Known Stubs

None — no placeholder text, hardcoded empty values, or unwired components introduced.

## Threat Flags

None — change is contained to severity-literal in an existing critic; no new network endpoints, auth paths, file access, or schema surface.

## Downstream Note

The critic system's `"blocker"` tier is **not yet wired into `validation.has_blocking_errors()`**, which only inspects `ValidationResult.level == "error"`. This means the new fan-out blocker is visible to:

- Direct consumers of `review_patch()` / `review_structure()` results who filter by `r.severity == "blocker"` (the pattern used throughout `tests/test_critics.py:255+`).
- The `[r for r in results if r.severity == "blocker"]` idiom that critic-loop integrations should standardize on.

It is **not** visible to legacy consumers of `has_blocking_errors()` until that helper is taught to inspect `CriticResult` results. That re-wiring is captured as FINDINGS.md §P2-4 and is not part of this task.

## Commits

| Hash | Type | Message |
|------|------|---------|
| `a57acf4` | test | `test(quick-260427-kbe-01): assert fan-out blocker tier + signal-rate exemption` |
| `98bbc3a` | feat | `feat(quick-260427-kbe-02): promote fan-out severity from warning to blocker` |

## Self-Check: PASSED

- File `src/maxpat/critics/structure_critic.py` — FOUND
- File `tests/test_critics.py` — FOUND
- File `.planning/quick/260427-kbe-promote-fan-out-without-trigger-from-war/260427-kbe-SUMMARY.md` — FOUND
- File `.planning/quick/260427-kbe-promote-fan-out-without-trigger-from-war/deferred-items.md` — FOUND
- Commit `a57acf4` (Task 1: RED gate) — FOUND
- Commit `98bbc3a` (Task 2: GREEN gate) — FOUND
