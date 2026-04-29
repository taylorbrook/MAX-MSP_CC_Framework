---
phase: 29-validator-depth
plan: 04
subsystem: validation
tags: [validation, domain-restriction, rnbo, top-level-guard, layer-4b]

# Dependency graph
requires:
  - phase: 28-schema-foundation
    provides: "ObjectDatabase.get_domain_restrictions() + curated `domain_restricted: ['rnbo']` annotation on floor~ in overrides.json"
provides:
  - "_validate_domain_restrictions — Layer 4b sibling check that hard-blocks top-level boxes whose domain_restricted whitelist forbids the outer MSP/Max context"
  - "Call site in validate_patch immediately after _validate_domain_rules (Layer 4 -> Layer 4b dispatch)"
  - "TestDomainGuard class with 5 tests: top-level error firing, nested-gen silence (D-07 anchor), unrestricted silence, severity contract, restriction-list literal in message"
affects: [29-05 codebox/duplicate-emission consolidation, future RNBO-export gating phases that extend domain_restricted to additional objects]

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "Top-level-only sibling guard: walks `patch_dict['patcher']['boxes']` once, no recursion into nested `box.patcher.boxes`. Mirrors _validate_domain_rules' shape and lives next to it for discoverability (D-06)."
    - "Explicit-only restriction lookup: db.get_domain_restrictions(name) is the single source of truth — no fallback to obj.domain canonical inference (D-05). Restrictions added via curated overrides.json only."
    - "Always-ERROR + auto_fixed=False: domain restrictions are hard blocks. Auto-removing the box would mangle the patch; the validator emits an error and lets the caller decide (D-08, D-19)."

key-files:
  created: []
  modified:
    - "src/maxpat/validation.py — added _validate_domain_restrictions function (Layer 4b header section) and call site after _validate_domain_rules"
    - "tests/test_validation.py — added TestDomainGuard with 5 tests"

key-decisions:
  - "Top-level scope only — no recursion into `box.patcher.boxes`. Walking nested patchers would require knowing whether the outer box (`gen~`, `rnbo~`, `p`) is itself a domain container, which is out of scope for Phase 29. D-07 explicitly defers nested-subpatcher restriction handling to a future phase."
  - "Layer label is `'domain'` (matches _validate_domain_rules sibling), NOT a new `'domain_restricted'` layer. This keeps the layer enum in ValidationResult docstring at the same four values (json/objects/connections/domain) and lets callers grep by the existing layer."
  - "Message format includes `restrictions[0]` in the wrap-in suggestion ('Wrap in rnbo~ container'). Multi-restriction objects (none exist today, but the schema permits it) get the first restriction in the suggestion; the full list is still cited verbatim for completeness."

patterns-established:
  - "Sibling Layer 4 checks: when the existing _validate_domain_rules grows past its scope, the established pattern is a new sibling function (_validate_domain_restrictions, _validate_X) with its own `# === Layer 4{x}: ... ===` section header and a one-line `results.extend(...)` call site directly under the prior layer's call. Avoids a monolithic Layer 4 function."
  - "Explicit-annotation guards over inferred guards: when a check needs to consult a per-object whitelist or blacklist, expose a typed DB getter (`db.get_X(name) -> list[str]`) rather than letting the validator inspect raw object dicts. This phase consumes Phase 28's `get_domain_restrictions` getter, keeping validation.py free of overrides.json schema knowledge."

requirements-completed: [VALID-02, VALID-05]

# Metrics
duration: ~10 min
completed: 2026-04-28
---

# Phase 29 Plan 04: Domain Restriction Guard Summary

**Layer 4b validator now hard-blocks RNBO-only objects (floor~) at MSP/Max top level with an explicit ERROR pointing at the curated `domain_restricted` annotation, citing the restriction list and a wrap-in suggestion ("Wrap in rnbo~ container or use a non-restricted equivalent"); top-level scope only (D-07), always ERROR + never auto-fixed (D-08).**

## Performance

- **Duration:** ~10 min (retry; first attempt timed out before commit)
- **Started:** 2026-04-28
- **Completed:** 2026-04-28
- **Tasks:** 2 (all completed)
- **Files modified:** 2 (1 source, 1 test)

## Accomplishments

- `_validate_domain_restrictions` Layer 4b guard added as a sibling to `_validate_domain_rules` (D-06)
- Wired into `validate_patch` orchestration immediately after Layer 4 (D-06 splice point at line 175)
- `floor~` at MSP top level emits exactly one `ValidationResult('domain', 'error', auto_fixed=False)` with restriction list and wrap-in suggestion
- D-07 anchor test: `floor~` nested inside a `gen~` inner patcher emits NO error (top-level-only contract verified)
- 5 new tests in TestDomainGuard, all green; full test_validation.py file passes (97 passed, 2 deselected pre-existing TestCommunityPackageBlock failures unrelated to this plan)

## Task Commits

Each task was committed atomically:

1. **Task 1: Add _validate_domain_restrictions function + call site** — `f477825` (feat)
2. **Task 2: Add TestDomainGuard class with 5 tests** — `9df246f` (test)

_Note: This plan was a retry. The first attempt timed out before any commit landed. The implementation diff was preserved in the working tree and committed atomically on retry; the retry replayed the plan exactly as written._

## Files Created/Modified

- `src/maxpat/validation.py` — added Layer 4b header section, `_validate_domain_restrictions` function (≈37 lines including docstring), and `results.extend(_validate_domain_restrictions(...))` call site after the existing Layer 4 call
- `tests/test_validation.py` — added `TestDomainGuard` class (≈125 lines) with 5 tests: top-level error, nested-gen silence, unrestricted silence, severity contract, restriction-list literal

## Decisions Made

- **Top-level only — D-07 deferred nested-subpatcher handling.** A future phase will need to track which container types (rnbo~, gen~, p) act as domain scopes. For now, walk only `patch_dict["patcher"]["boxes"]`. The nested-gen test pins this contract.
- **Layer label `"domain"` not a new layer.** Keeps the four-layer enum in ValidationResult stable; downstream callers that grep `r.layer == "domain"` pick up the new findings without modification.
- **Always ERROR + auto_fixed=False.** Auto-removing the offending box would silently mangle the patch. Emit error and let the caller decide. (D-08 / D-19)

## Deviations from Plan

None — plan executed exactly as written. The implementation diff was already present in the working tree from a prior timed-out attempt and matched the plan's `<action>` block verbatim; only commits and test additions were needed on retry.

## Issues Encountered

- **Pre-existing TestCommunityPackageBlock failures (unrelated):** `test_community_block_warning` and `test_ircam_spat_specific_message` fail at the Wave 1 base (commit `dda5add`). Confirmed pre-existing; tracked in `deferred-items.md` per task instructions. Not in scope for this plan.
- **Pre-existing failures across other test files (unrelated):** Broader pytest run shows 47 failures spread across `test_package_schema.py::TestCommunityPackageStubs`, `test_source_coverage.py`, etc. None touched by this plan; all out of scope.

## Verification Evidence

- `python3 -m pytest tests/test_validation.py::TestDomainGuard -x -v` — 5 passed
- `python3 -m pytest tests/test_validation.py -q --deselect "tests/test_validation.py::TestCommunityPackageBlock::test_community_block_warning" --deselect "tests/test_validation.py::TestCommunityPackageBlock::test_ircam_spat_specific_message"` — 97 passed
- Manual probe: floor~ at top level emits exactly one `[domain:error]` finding mentioning floor~ and `['rnbo']` (verified via the inline Python one-liner in plan `<verification>`)

## Self-Check: PASSED

- `src/maxpat/validation.py` exists and contains `_validate_domain_restrictions` — FOUND
- `tests/test_validation.py` exists and contains `class TestDomainGuard` — FOUND
- Commit `f477825` (feat) — FOUND in `git log`
- Commit `9df246f` (test) — FOUND in `git log`
- Acceptance criteria from plan all satisfied:
  - `def _validate_domain_restrictions` present in validation.py — yes
  - `Layer 4b: Domain Restriction Guard` header marker present — yes
  - `results.extend(_validate_domain_restrictions` call site present — yes
  - `is restricted to`, `Wrap in`, `not allowed at MSP/Max top level` literals present — yes
  - 5 named tests present in TestDomainGuard — yes

## Next Plan Readiness

- VALID-02 closed: top-level RNBO-only objects (floor~) hard-block with actionable suggestion
- VALID-05 (severity discipline) reinforced: D-08 ERROR-only contract pinned by `test_severity_contract`
- Plan 05 (codebox/duplicate-emission consolidation) can build on this guard without modification — the call site is already wired and the layer label is consistent with the existing Layer 4 sibling

---
*Phase: 29-validator-depth*
*Completed: 2026-04-28*
