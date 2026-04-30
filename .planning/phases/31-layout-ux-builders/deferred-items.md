# Phase 31 Deferred Items

Out-of-scope discoveries logged during plan execution. Per CLAUDE.md scope
boundary: only auto-fix issues directly caused by current task changes.

---

## From 31-01 (Overlay Readout)

### Pre-existing test failures observed in full pytest run (NOT caused by this plan)

Plan 31-01 only adds `Patcher.add_overlay_readout` and one new test file. The
following failures were observed running the full suite but are unrelated to
the new method:

- `tests/test_critics.py::TestPackageCritic::test_community_unextracted_warning`
- `tests/test_integration_patches.py::test_validate_patch_no_errors[...]` (28 patches)
- `tests/test_integration_patches.py::test_review_patch_no_blockers[...]` (13 patches)
- `tests/test_package_schema.py::TestCommunityPackageStubs::*` (3 tests)
- `tests/test_source_coverage.py::TestSourceCoverage::test_extraction_log_total`
- `tests/test_validation.py::TestCommunityPackageBlock::*` (2 tests)

These touch community-package extraction state and integration patches under
`patches/`. None reference `add_overlay_readout` or `bring_to_front`. The
relevant scope (`tests/test_overlay_readout.py`, `tests/test_layout.py`,
`tests/test_m4l_polish.py`) is fully green: 117 passed.
