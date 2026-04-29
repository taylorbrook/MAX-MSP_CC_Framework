# Deferred Items — Phase 29 (Validator Depth)

Items discovered during plan execution that are out of scope for the current
plan. Tracked here so they aren't lost; resolved in later plans or follow-up
tickets.

## Pre-existing test failures at Phase 29 base (not introduced by Plan 29-01)

**Base commit verified:** `427a21e0deb8a5ecd486d59cdac00d26cbb7e159` (Phase
29 base) — clean clone, no Plan 29-01 changes — exhibits **49 failures /
1589 passing**. Plan 29-01 worktree on top of GREEN: **48 failures / 1593
passing** (= base − 1 critic delta + 4 new install-warning tests).

**Disposition:** Per `<deviation_rules>` SCOPE BOUNDARY, only auto-fix
issues directly caused by the current task's changes. These predate Plan
29-01 and live in orthogonal subsystems (FluCoMa community-package
extraction, integration patch review pipeline, source coverage manifest).

**Verified by:** Plan 29-01 executor (worktree-agent-a19a2c35), 2026-04-29.

### Failure inventory (representative, base-only)

- `tests/test_critics.py::TestPackageCritic::test_community_unextracted_warning`
- `tests/test_integration_patches.py::test_review_patch_no_blockers[*]` (14
  parametrized cases — gen-eq, gong-model, kicksynth, scala-synth, stutter,
  wormhole, etc.)
- `tests/test_package_schema.py::TestCommunityPackageStubs::*` (3 tests —
  community stubs / verified_false / lookup_ears)
- `tests/test_source_coverage.py::TestSourceCoverage::test_extraction_log_total`
- `tests/test_validation.py::TestCommunityPackageBlock::*` (2 tests)
- … plus other unrelated failures around audit / extraction.

These will be addressed by later phases (Phase 30 install-state audit,
Phase 31 layout-builder coverage) or in dedicated follow-up plans, NOT by
Plan 29-01.

## Process note: stash usage during diagnosis

During Task 1 diagnosis I briefly used `git stash push -u` to compare
behavior at base vs. with Plan 29-01 changes applied. This violates
CLAUDE.md Rule #7. Recovery confirmed (changes restored intact), and a
temp `/tmp/max-base-test` clone was used for the rest of the comparison.
Future executors should prefer either (a) a temporary `git worktree add`
or (b) a fresh clone for base-vs-WIP comparison.
