# Phase 28 — Deferred Items

Out-of-scope discoveries logged during plan execution. Do NOT fix in Phase 28.

## Pre-Existing Test Failures (unrelated to Phase 28 schema work)

Three failures in `tests/test_package_schema.py::TestCommunityPackageStubs` exist BEFORE any Phase 28 changes were applied. They are about community-package stub data (FluCoMa `verified` flag, FluCoMa signal-object I/O coverage, missing `ears.slice` lookup) — completely orthogonal to `signal_role` / `domain_restricted` / `verified_installed`.

| Test | Reason |
|------|--------|
| `TestCommunityPackageStubs::test_community_stubs_verified_false` | `fluid.bufonsetslice~` has `verified: true` in stub data; test expects all community stubs to be `verified: false`. |
| `TestCommunityPackageStubs::test_community_stubs_signal_objects_have_signal_io` | Signal-suffix object in FluCoMa stubs lacks signal I/O. |
| `TestCommunityPackageStubs::test_lookup_ears` | `db.lookup("ears.slice")` returns `None` — community-package extraction gap. |

These should be addressed by a later community-package-extraction phase, not Phase 28. Plan 28-01 verification commands deselect them.

## Wider Suite Pre-Existing Failures (also unrelated)

Running the full suite (`pytest tests/ -q --ignore=tests/test_integration_patches.py`) surfaces 5 additional failures not caused by Phase 28 schema work. Confirmed by spot-checking each: the failures are about (a) MC tilde objects lacking `signal: true` flags in the DB (`mc.capture~`, `mc.send~`, `mcs.loudness~`, `info~`), (b) community-package warning text drift, and (c) extraction-log totals — all orthogonal to `_validate_schema_extensions` / `_apply_signal_role_writethrough`. Since Phase 28 Plan 01 added zero `signal_role` keys to overrides.json (population is Phase 30 work), the write-through projection is a no-op against current data and cannot regress these tests.

| Test | Reason |
|------|--------|
| `tests/test_critics.py::TestPackageCritic::test_community_unextracted_warning` | Community-package critic warning text drift. |
| ~~`tests/test_inlet_types.py::TestMSPSignalInlets::test_tilde_objects_have_signal_io`~~ | ~~MC tilde objects lack signal I/O in DB (data gap).~~ **RESOLVED in Phase 30 Plan 04 (see `.planning/phases/30-msp-outlet-coverage-sweep/30-04-SUMMARY.md`): `mc.capture~`/`mc.send~`/`mcs.loudness~` got inlet `signal:true` overrides in `overrides.json` (with `_role_source: "phase-30-04-deferred-fix"` annotation); `info~` added to `TILDE_UI_EXCEPTIONS` (control-only despite ~ suffix — buffer-info reporter). Because `tests/conftest.py::all_objects` reads raw domain JSON and does NOT apply overrides, the three override-resolved objects also landed in `TILDE_UI_EXCEPTIONS` as documented carve-outs alongside `info~` so the test fixture sees them as known control-only-at-raw-JSON; ObjectDatabase consumers correctly see the signal-rate inlets via the override deep-merge.** |
| `tests/test_source_coverage.py::TestSourceCoverage::test_extraction_log_total` | Extraction-log totals. |
| `tests/test_validation.py::TestCommunityPackageBlock::test_community_block_warning` | Community-block validation message drift. |
| `tests/test_validation.py::TestCommunityPackageBlock::test_ircam_spat_specific_message` | IRCAM Spat block-message text drift. |

