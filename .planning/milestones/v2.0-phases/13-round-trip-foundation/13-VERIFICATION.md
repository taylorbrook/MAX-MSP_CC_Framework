---
phase: 13-round-trip-foundation
verified: 2026-03-16T15:10:00Z
status: passed
score: 18/18 must-haves verified
gaps: []
human_verification: []
---

# Phase 13: Round-Trip Foundation Verification Report

**Phase Goal:** Lossless round-trip foundation — parse and re-serialize .maxpat files with zero data loss
**Verified:** 2026-03-16T15:10:00Z
**Status:** passed
**Re-verification:** No — initial verification

## Goal Achievement

### Observable Truths

All truths are derived from the three plan must_haves blocks (Plans 01, 02, 03).

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | Patchline color attribute survives load-save cycle | VERIFIED | `TestPatchlineAttrs::test_patchline_color_preserved` passes; `Patchline.color` field and `_raw` round-trip path confirmed in patcher.py:73-83 |
| 2 | Patchline extra_attrs (unknown keys) survive load-save cycle | VERIFIED | `TestPatchlineAttrs::test_patchline_extra_attrs_preserved` passes; `_handled_line_keys` pattern extracts unknowns into `extra_attrs`; `_raw` round-trip emits them |
| 3 | Round-trip test scaffolding exists with tests for all known bugs | VERIFIED | 42 tests in `tests/test_round_trip.py`, 0 xfail markers, 0 skips — all hard passes |
| 4 | `from_dict` raises on structurally invalid input | VERIFIED | `TestStructuralErrors` passes; `ValueError` on missing patcher key, `TypeError` on non-list boxes confirmed via inline test |
| 5 | Box loaded from JSON preserves ALL original keys through round-trip via `_raw` dict | VERIFIED | `Box._raw` stored in `from_dict` (patcher.py:1198-1200); round-trip path uses `_raw` as base (patcher.py:235-266); `TestEdgeCases` and `TestRoundTripIdentity` confirm identity |
| 6 | UI widgets (textbutton, codebox, attrui) preserve text, fontname, fontsize through round-trip | VERIFIED | `_raw` captures all keys verbatim; `TestRoundTripIdentity` passes for kicksynth (has codebox), scala-synth, performancepatchtest |
| 7 | `parameter_enable` is NOT spuriously added to boxes that didn't have it | VERIFIED | Removed from `_handled_keys` (patcher.py:1186-1191); round-trip path starts from `_raw` which has it only if it was there originally |
| 8 | `outlettype` is NOT spuriously added to boxes (like comments) that didn't have it | VERIFIED | Round-trip path only overlays `outlettype` if present in `_raw` (patcher.py:241-242) |
| 9 | Patcher-level key ordering preserved — boxes and lines at original position | VERIFIED | `None` placeholders for boxes/lines stored in `p.props` during `from_dict` (patcher.py:1135-1138); `to_dict` iterates props, replaces placeholders (patcher.py:1246-1257); `TestKeyOrdering` passes |
| 10 | Bpatcher attrs survive round-trip via extra_attrs | VERIFIED | `TestBpatcherLoading::test_bpatcher_attrs_in_extra` passes; bpatcher-specific keys (offset, name) land in `extra_attrs` and survive via `_raw` |
| 11 | ALL 10 project .maxpat files round-trip identically | VERIFIED | `TestRoundTripIdentity` parametrized over all 10 files — all pass; inline verification of kicksynth and comp-band confirmed |
| 12 | MAX-saved files (4-space indent) load and round-trip correctly | VERIFIED | comp-band.maxpat (4-space) confirmed: `detect_indent` returns `"    "`, `test_max_saved_file_byte_identical` passes |
| 13 | Framework-generated files (2-space indent) load and round-trip correctly | VERIFIED | rhythmic-sampler.maxpat (2-space) confirmed: `detect_indent` returns `"  "`, `test_framework_file_byte_identical` passes |
| 14 | Recursive subpatchers round-trip with correct key ordering at every nesting level | VERIFIED | `test_round_trip_deeply_nested_subpatchers` (3 levels) passes; `TestSubpatcherLoading` confirms kicksynth subpatcher boxes load recursively |
| 15 | A .maxpat with unknown third-party externals loads and round-trips without data loss | VERIFIED | `test_round_trip_with_unknown_external` passes (com.acme.widget~); `TestUnknownObjects` passes (com.foo.external~) |
| 16 | File-level round-trip preserves original indentation | VERIFIED | `detect_indent()` correctly identifies 4-space, 2-space, and tab; `save_patch_roundtrip()` uses detected indent; byte-identical tests pass |
| 17 | Full test suite passes with zero regressions | VERIFIED | 956 tests pass in 5.56s; zero failures, zero xfails |
| 18 | `detect_indent` and `save_patch_roundtrip` exported from public API | VERIFIED | Both appear in `src/maxpat/__init__.py` imports and `__all__` list |

**Score:** 18/18 truths verified

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `tests/test_round_trip.py` | Round-trip test suite, min 100 lines, covering RW-01/02/06 | VERIFIED | 907 lines, 42 tests across 10 classes, 0 xfail markers |
| `tests/fixtures/colored_patchlines.maxpat` | Synthetic fixture with colored patchline and custom key | VERIFIED | Present; patchline has `"color": [1.0, 0.0, 0.0, 1.0]` and `"custom_line_attr": 42` |
| `src/maxpat/patcher.py` | Fixed Patchline with color/extra_attrs/_raw; Box._raw; key-order preservation | VERIFIED | Contains `class Patchline` with all 3 fields; `Box._raw`; `Patcher.from_dict` with placeholder logic; `Patcher.to_dict` with props iteration |
| `src/maxpat/hooks.py` | `save_patch_roundtrip()` and `detect_indent()` functions | VERIFIED | Both functions present at lines 28-81; `detect_indent` scans first indented line, defaults to 4 spaces; `save_patch_roundtrip` uses `json.dumps` with string indent |
| `src/maxpat/__init__.py` | `detect_indent` and `save_patch_roundtrip` in public API | VERIFIED | Both appear in import block (lines 28-29) and `__all__` (lines 151-152) |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `tests/test_round_trip.py` | `src/maxpat/patcher.py` | `Patcher.from_dict()` and `to_dict()` round-trip assertions | WIRED | All test classes import and call `from_dict` + `to_dict`; `result == original` assertions in `TestRoundTripIdentity` and `TestEdgeCases` |
| `src/maxpat/patcher.py::Patchline` | `Patchline._raw` | Round-trip path starts from `_raw` | WIRED | `to_dict` at line 73: `if self._raw is not None:` followed by `d = dict(self._raw)` |
| `src/maxpat/patcher.py::Box.to_dict` | `Box._raw` | Round-trip path starts from `_raw`, overlays mutations | WIRED | `to_dict` at line 232: `if self._raw is not None:` followed by `d = dict(self._raw)` with targeted overlays |
| `src/maxpat/patcher.py::Patcher.from_dict` | `Patcher.props` | boxes/lines placeholders preserve key position | WIRED | Lines 1135-1138: `p.props["boxes"] = None` and `p.props["lines"] = None` as position markers |
| `src/maxpat/patcher.py::Patcher.to_dict` | `Patcher.props` | Iterates props, replaces boxes/lines placeholders | WIRED | Lines 1246-1257: `for key, val in self.props.items()` with conditional replacement of placeholder entries |
| `src/maxpat/hooks.py::save_patch_roundtrip` | `detect_indent` | Detects original file indentation and uses it for json.dumps | WIRED | Line 69: `indent = detect_indent(original_text)` used in `json.dumps(patch_dict, indent=indent)` at line 74 |
| `tests/test_round_trip.py::TestRoundTripIdentity` | `src/maxpat/patcher.py::Patcher.from_dict` | Golden file comparison: json.load -> from_dict -> to_dict == original | WIRED | `test_round_trip_identity` calls `Patcher.from_dict(original)` and asserts `result == original`; all 10 files pass |

### Requirements Coverage

| Requirement | Source Plans | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| RW-01 | 13-02, 13-03 | Patcher can load any .maxpat file into fully populated Patcher/Box/Line objects — all maxclass types, recursive subpatchers, bpatcher attrs, unknown objects handled gracefully | SATISFIED | `from_dict` handles all maxclasses via `Box.__new__` bypass; recursive subpatcher loading via `Patcher.from_dict({"patcher": box_data["patcher"]})` at line 1183; unknown objects load without error (`TestUnknownObjects`); `TestSubpatcherLoading` and `TestBpatcherLoading` pass |
| RW-02 | 13-02, 13-03 | Loaded Patcher writes back to .maxpat with minimal diff — unchanged portions byte-for-byte identical, key ordering preserved, numeric precision maintained | SATISFIED | All 10 golden file `TestRoundTripIdentity` tests pass; `TestKeyOrdering` passes; `TestNumericPrecision` (int stays int, float stays float) passes; file-level byte-identical tests pass for 4-space and 2-space files |
| RW-06 | 13-01 | All user state preserved on edit — positions, colors, presentation rects, varnames, scripting names, custom attrs, unknown keys survive load-edit-save cycle | SATISFIED | `TestPatchlineAttrs` (color preserved); `TestUserState` (presentation, presentation_rect, varname, scripting_name); `TestExtraAttrs` (unknown keys); `TestBpatcherLoading` (bpatcher attrs); all pass |

All three requirements for Phase 13 are fully satisfied. No orphaned requirements (REQUIREMENTS.md traceability table maps exactly RW-01, RW-02, RW-06 to Phase 13).

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `src/maxpat/patcher.py` | 1136, 1138 | `p.props["boxes"] = None` — intentional None placeholders for key position | Info | These are architectural: None is a sentinel marking key position in the ordered dict, replaced in `to_dict`. Not a stub. |

No blockers or warnings found. The `placeholder` comments in patcher.py (lines 1136-1138) are architectural sentinels used correctly — they are immediately replaced with real data in `to_dict` and never emitted as None.

### Human Verification Required

None. All phase 13 objectives are fully verifiable programmatically:
- Data model correctness: covered by unit tests
- File identity: covered by byte-identical file-level round-trip tests
- Structural validation: covered by error-type tests
- Numeric precision: covered by type assertion tests

No visual, real-time, or external service behavior is involved.

### Gaps Summary

No gaps. All 18 must-have truths are verified by direct code inspection and passing test suite execution. The full 956-test suite passes with zero failures and zero xfail markers.

---

## Verification Detail

### Test Suite Run

```
tests/test_round_trip.py::TestPatchlineAttrs (5 tests)   PASSED
tests/test_round_trip.py::TestRoundTripIdentity (10 tests) PASSED — all 10 project .maxpat files
tests/test_round_trip.py::TestKeyOrdering (2 tests)       PASSED
tests/test_round_trip.py::TestSubpatcherLoading (2 tests) PASSED
tests/test_round_trip.py::TestBpatcherLoading (1 test)    PASSED
tests/test_round_trip.py::TestUnknownObjects (2 tests)    PASSED
tests/test_round_trip.py::TestNumericPrecision (2 tests)  PASSED
tests/test_round_trip.py::TestUserState (3 tests)         PASSED
tests/test_round_trip.py::TestExtraAttrs (2 tests)        PASSED
tests/test_round_trip.py::TestStructuralErrors (2 tests)  PASSED
tests/test_round_trip.py::TestEdgeCases (4 tests)         PASSED
tests/test_round_trip.py::TestFileLevelRoundTrip (7 tests) PASSED
Total: 42 passed, 0 failed, 0 xfail, 0 skip

Full suite: 956 passed in 5.56s
```

### Commit Verification

All commits referenced in SUMMARY files are confirmed present in git log:

- `6f503f2` — test(13-01): add failing round-trip test suite and colored patchline fixture
- `c8eb1f1` — feat(13-01): fix Patchline model for lossless round-trip and add structural validation
- `aabb281` — feat(13-02): add _raw dict preservation to Box for lossless round-trip
- `a16ad10` — feat(13-02): patcher key-order preservation and _raw init across codebase
- `b44e48a` — test(13-03): remove xfail markers and add edge-case round-trip tests
- `5e7f130` — test(13-03): add failing tests for indentation-preserving file save
- `277fa80` — feat(13-03): implement indentation-preserving file save for zero-diff round-trip

---

_Verified: 2026-03-16T15:10:00Z_
_Verifier: Claude (gsd-verifier)_
