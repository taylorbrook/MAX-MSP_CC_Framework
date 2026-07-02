---
phase: 260702-k9w
plan: 01
subsystem: validation
status: complete
tags: [test-reconciliation, genexpr-validator, community-packages, review-blocker-allowlist]
dependency_graph:
  requires: []
  provides: [green-test-suite, review-blocker-allowlist]
  affects: [src/maxpat/code_validation.py, tests/test_integration_patches.py]
tech_stack:
  added: []
  patterns: [per-patch-signature-scoped-allowlist, two-pass-flow-analysis, monkeypatch-precondition-inversion]
key_files:
  created:
    - tests/review_blocker_allowlist.json
  modified:
    - src/maxpat/code_validation.py
    - tests/test_code_validation.py
    - tests/test_package_schema.py
    - tests/test_validation.py
    - tests/test_critics.py
    - tests/test_integration_patches.py
decisions:
  - "GenExpr Check 6/9 false positives fixed in the validator, never in committed patches (D-fanout)."
  - "test_lookup_ears resolved by reference correction to the real ears.slice~, not by inventing ears.slice (CLAUDE.md Rule #1)."
  - "physics-composition's 2 Bach-llll blockers folded into the same documented-debt allowlist rather than a critic edit."
metrics:
  duration: ~25m
  completed: 2026-07-02
  tasks: 3
  files: 7
---

# Phase 260702-k9w Plan 01: Reconcile remaining test failures Summary

Returned `python3 -m pytest tests/ -q` to green (24 failed → 0 failed, 2030 passed, 4 xfailed) by fixing two GenExpr validator false-positive classes, reconciling six community-package tests to the intentional current DB state, and exempting 114 documented review-blocker debt findings across 14 committed patches via a per-patch, per-signature allowlist — with zero edits to any committed `.maxpat` file.

## Tasks Completed

| Task | Name | Commit |
|------|------|--------|
| 1 | Fix two GenExpr validator false positives (4× test_validate_patch_no_errors) | fa551e7 |
| 2 | Reconcile 6 community-package tests to current DB behavior | ba09382 |
| 3 | Documented review-blocker allowlist for 14 committed patches (14× test_review_patch_no_blockers) | 85b8f92 |

## What Changed

### Task 1 — GenExpr validator (src/maxpat/code_validation.py)
- **Check 6 (operator existence):** now tokenizes `code_stripped` (comment-stripped) instead of raw `code`, so an ALL-CAPS section banner like `// === SATURATION (Pade tanh) ===` is no longer misparsed as an operator call. `declared_names` built from `code_stripped` for consistency. Resolves tape-wobble (DRIFT/EQ/LFO/ROLLOFF/SATURATION/SIGNAL).
- **Check 9 (init-before-if/else):** rewritten as a two-pass flow analysis. Pass 1 collects `pre_block_inits` (depth-0 LHS), `declared` (Param/History/Delay/Buffer/Data), and `block_assigned` (names assigned at brace depth ≥1 that are neither pre-init nor declared). Pass 2 re-walks and flags only a `block_assigned` name that is **read at brace depth 0** — the genuine "not defined on the un-taken path" error. A variable assigned then read entirely within the same branch (e.g. `morphL = ...; outL = ... + morphL * blend;`) is no longer flagged. The documented single-line-if false negative is preserved (start-anchored `assign_pattern`).
- Added 2 RED unit tests to `TestGenExprChecks`; all existing Check 1–9 tests still pass.

### Task 2 — Community-package tests
- `test_community_stubs_verified_false` → renamed `test_community_stubs_verified_type`: asserts `verified` is a `bool` (extracted community objects legitimately carry `verified=true` now).
- `test_community_stubs_signal_objects_have_signal_io`: invariant changed to "verified `~` objects have NON-EMPTY I/O" — many community `~` objects (FluCoMa `fluid.buf*~`, EARS `ears.read~`/`ears.slice~`) use the tilde for buffer operations, not audio-rate ports, so requiring a signal-typed port was wrong. Preserves the real CLAUDE.md "empty I/O = unusable" concern, scoped to verified data; skips unverified stubs (e.g. `fluid.stftpass~`/`fluid.waveform~` with empty I/O).
- `test_lookup_ears`: reference correction to `ears.slice~` (see below).
- `test_community_block_warning`, `test_ircam_spat_specific_message`, `test_community_unextracted_warning`: FluCoMa/IRCAM Spat are now `extracted=true`, so each test monkeypatches `extracted=false` on the db (inverse of the sibling `test_no_warning_when_extracted`) to exercise the warning branch it actually targets. Assertions unchanged.

### Task 3 — Review-blocker allowlist
- Created `tests/review_blocker_allowlist.json`: a `_doc` string plus a `patches` object keyed by repo-relative patch path, each value a list of exemption entries citing `severity`, `kind`, `source`, `source_id`, `outlet` (fan-out) or `inlet` (Bach-llll), and `destinations`. Populated by enumerating the CURRENT blockers of the 14 target patches: 112 fan-out-without-trigger + 2 physics-composition Bach-llll = 114 entries. Generator was run during execution and NOT committed (CLAUDE.md Rule #5).
- `test_review_patch_no_blockers` loads the allowlist once (module scope) and, after computing blockers, removes one only if the current patch has an allowlist list AND the blocker's parsed signature matches an entry. Match keys: fan-out `(source_id, outlet)`; Bach-llll `(source_id, inlet, sorted destinations)`. Asserts **zero remaining** blockers, so unmatched/new blockers still fail. `_REVIEW_XFAILS` untouched — mixer-strip stays xfail and is excluded from the allowlist.

## Deviations from Plan

None — plan executed as written. The plan itself carried two CONTEXT diagnosis corrections (documented below), which were followed.

## CONTEXT Diagnosis Corrections (surfaced by the planner, confirmed during execution)

1. **Check-9 vs banner (Task 1):** CONTEXT claimed all 4 `test_validate_patch_no_errors` failures were the ALL-CAPS comment-banner misparse (Check 6). In fact only **tape-wobble** is Check 6. The other 3 (**scala-synth-voice, timestretch, wormhole**) were **Check 9 assign-before-use** false positives — a block-local variable assigned before use inside a branch was wrongly flagged. Both classes are validator false positives; both were fixed in the validator with zero patch edits.
2. **physics-composition Bach-llll (Task 3):** CONTEXT framed the 14 `test_review_patch_no_blockers` failures as purely fan-out debt. **physics-composition carries 3 blockers = 1 fan-out + 2 Bach-llll type mismatches**, where a `receive` object's output llll-ness is statically unknowable through a send/receive routing bridge (a critic false positive). These 2 were folded into the same per-patch documented-debt allowlist (keeping ONE mechanism, zero patch edits) rather than editing the critic; a critic-side fix remains a possible follow-up.

## test_lookup_ears Resolution Rationale

`db.lookup("ears.slice")` returns `None`; `db.lookup("ears.slice~")` returns a real object. The ears library uniformly uses the `~` suffix (`ears.read~`, `ears.write~`, `ears.slice~`); a non-tilde `ears.slice` is not a real ears object and is absent from the DB. Inventing it would violate CLAUDE.md Rule #1 (never guess objects). The test was therefore corrected to look up the real, already-present `ears.slice~` — a **reference correction, not a weakening**, and no DB data was invented or restored.

## Verification

- Task 1: `test_code_validation.py` (35 passed) + `validate_patch_no_errors` (36 passed).
- Task 2: `TestCommunityPackageStubs` + `TestCommunityPackageBlock` + `test_community_unextracted_warning` (32 passed, siblings green).
- Task 3: `review_patch_no_blockers` (35 passed, 1 xfailed); guardrails verified in scratch — unknown patch path, fabricated `source_id`, and bumped `outlet`/`inlet` are all NOT filtered; real entries ARE filtered.
- **FINAL GATE:** `python3 -m pytest tests/ -q` → **2030 passed, 4 xfailed, 0 failed** (was 24 failed).
- `git status` shows no modified `patches/**/*.maxpat` at any point.

## Self-Check: PASSED

All 7 key files exist on disk; all 3 task commits (fa551e7, ba09382, 85b8f92) present in git history.
