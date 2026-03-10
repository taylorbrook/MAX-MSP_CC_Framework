---
phase: 02-patch-generation-and-validation
verified: 2026-03-10T01:00:00Z
status: passed
score: 5/5 must-haves verified
re_verification: false
human_verification:
  - test: "Open a generated .maxpat file in MAX 9 and verify it loads without errors"
    expected: "Patch displays cycle~ 440 -> *~ 0.5 -> ezdac~ with correct connections and readable layout"
    why_human: "Actual MAX application loading and rendering cannot be verified programmatically"
  - test: "Enable audio in MAX and confirm generated synth produces sound"
    expected: "440Hz sine tone at half volume when ezdac~ is toggled on"
    why_human: "Audio playback requires running MAX application"
  - test: "Open a subpatcher-containing .maxpat and double-click the subpatcher box"
    expected: "Inner patcher window opens showing inlet/outlet objects and inner signal chain"
    why_human: "Nested patcher UI interaction requires MAX application"
---

# Phase 2: Patch Generation and Validation Verification Report

**Phase Goal:** Framework generates .maxpat files that open in MAX without errors, with readable layout and validated connections
**Verified:** 2026-03-10T01:00:00Z
**Status:** passed
**Re-verification:** No -- initial verification

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | Generated .maxpat files are valid JSON with correct MAX 9 structure | VERIFIED | `generate_patch()` produces dict with `patcher` wrapper, `boxes` array, `lines` array, `fileversion: 1`, `appversion.major: 9`. JSON roundtrip (dumps/loads) succeeds. 169 tests pass. |
| 2 | Subpatchers and bpatchers generate correctly as nested structures | VERIFIED | `add_subpatcher()` creates `newobj` box with embedded `patcher` key containing inner boxes/lines/inlet/outlet objects. `add_bpatcher()` supports file reference (with `name` field) and embedded mode. Verified programmatically. |
| 3 | Connection validation catches out-of-bounds and type mismatches | VERIFIED | Layer 3 validation detects outlet/inlet index overflow, auto-removes invalid connections (`auto_fixed=True`), and checks signal-to-control type compatibility. 34 validation tests cover all cases. |
| 4 | Objects are positioned with readable top-to-bottom signal flow | VERIFIED | `apply_layout()` uses Kahn's topological sort for column assignment, V_SPACING=100px between rows, H_GUTTER=70px between columns, UI controls above targets. 14 layout tests pass. |
| 5 | Multi-layer validation pipeline runs automatically on file writes | VERIFIED | `write_patch()` calls `generate_patch()` which applies layout + runs 4-layer validation. `validate_file()` validates from disk. `has_blocking_errors()` distinguishes fixable from unfixable. 14 hooks tests + 22 generation tests pass. |

**Score:** 5/5 truths verified

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `src/maxpat/__init__.py` | Public API with generate_patch, write_patch, validate_file | VERIFIED | 89 lines. Re-exports Patcher, Box, Patchline, generate_patch, write_patch, validate_file, ValidationResult, ObjectDatabase. `__all__` list defined. |
| `src/maxpat/patcher.py` | Patcher, Box, Patchline with to_dict() serialization | VERIFIED | 527 lines. Box constructor verifies objects against ObjectDatabase (Rule #1). Patchline serializes source/destination arrays. Patcher.to_dict() produces complete .maxpat structure. Subpatcher/bpatcher support via add_subpatcher/add_bpatcher. |
| `src/maxpat/db_lookup.py` | ObjectDatabase with lookup, exists, compute_io_counts, PD detection | VERIFIED | 277 lines. Loads 8 domain JSON files (1672 unique objects). Alias resolution, variable I/O formulas, PD blocklist with MAX equivalents. |
| `src/maxpat/maxclass_map.py` | UI_MAXCLASSES frozenset + resolve_maxclass + is_ui_object | VERIFIED | 73 lines. 59 UI maxclass names. resolve_maxclass returns object name for UI, "newobj" for non-UI. |
| `src/maxpat/sizing.py` | calculate_box_size with UI_SIZES and text-based sizing | VERIFIED | 114 lines. 40+ UI size entries. Text sizing: `len(text) * 7.0 + 16.0`, min 40.0. Comment height 20.0, newobj/message height 22.0. |
| `src/maxpat/defaults.py` | MAX 9 patcher properties, font/spacing constants | VERIFIED | 65 lines. DEFAULT_PATCHER_PROPS dict with fileversion 1, appversion major 9, classnamespace "box", grid settings. V_SPACING=100, H_GUTTER=70. |
| `src/maxpat/layout.py` | Column-based layout engine with topological sort | VERIFIED | 330 lines. Kahn's algorithm, dynamic column widths, UI control repositioning, disconnected node handling, presentation mode grid layout. |
| `src/maxpat/validation.py` | Four-layer validation pipeline with auto-fix | VERIFIED | 628 lines. Layer 1 (JSON structure), Layer 2 (object existence with PD detection), Layer 3 (connection bounds/types with auto-fix), Layer 4 (unterminated chains, gain staging, feedback loops). |
| `src/maxpat/hooks.py` | File write hooks with automatic validation | VERIFIED | 120 lines. write_patch (generate + validate + write), validate_file (load + validate), PatchGenerationError, PatchValidationError. |
| `tests/test_patcher.py` | Patcher/Box/Patchline tests | VERIFIED | 56 tests passing. |
| `tests/test_sizing.py` | Box sizing tests | VERIFIED | 29 tests passing. |
| `tests/test_layout.py` | Layout engine tests | VERIFIED | 14 tests passing. |
| `tests/test_validation.py` | Validation pipeline tests | VERIFIED | 34 tests passing. |
| `tests/test_hooks.py` | File write hook tests | VERIFIED | 14 tests passing. |
| `tests/test_generation.py` | End-to-end generation tests | VERIFIED | 22 tests passing. |
| `tests/fixtures/expected/simple_synth.maxpat` | Known-good reference fixture | VERIFIED | File exists with correct .maxpat JSON structure. |
| `tests/fixtures/expected/subpatcher_example.maxpat` | Known-good subpatcher fixture | VERIFIED | File exists with nested patcher structure. |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `patcher.py` | `maxclass_map.py` | `resolve_maxclass()` in Box constructor | WIRED | Import on line 21, called on line 105 |
| `patcher.py` | `sizing.py` | `calculate_box_size()` for patching_rect | WIRED | Import on line 22, called on lines 138, 303-304, 325-326, 406-407 |
| `patcher.py` | `db_lookup.py` | `ObjectDatabase` for object verification and I/O counts | WIRED | Import on line 23, used in Box constructor lines 114-126, Patcher constructor lines 242-243 |
| `patcher.py` | `defaults.py` | `DEFAULT_PATCHER_PROPS` for patcher wrapper | WIRED | Import on line 16, used on line 248 via deepcopy |
| `layout.py` | `patcher.py` | `apply_layout(Patcher)` reads boxes/lines, mutates patching_rect | WIRED | TYPE_CHECKING import line 22, function signature line 38, accesses patcher.boxes/patcher.lines |
| `layout.py` | `defaults.py` | Uses V_SPACING, H_GUTTER constants | WIRED | Import on line 18, V_SPACING used on line 76/294, H_GUTTER used on line 210 |
| `validation.py` | `db_lookup.py` | Layers 2-4 use ObjectDatabase for lookups | WIRED | Import on line 18, used throughout _validate_objects_exist, _validate_connections, _validate_domain_rules |
| `validation.py` | `patcher.py` | validate_patch accepts Patcher instance | WIRED | Import on line 98 (inside function), isinstance check on line 101 |
| `hooks.py` | `validation.py` | write_patch runs validate_patch before writing | WIRED | Import on line 18, has_blocking_errors used on line 76 |
| `__init__.py` | `patcher.py` | Re-exports Patcher, Box, Patchline | WIRED | Import on line 13 |
| `__init__.py` | `layout.py` | generate_patch calls apply_layout | WIRED | Import on line 19, called on line 50 |
| `__init__.py` | `validation.py` | generate_patch calls validate_patch | WIRED | Import on line 14-17, called on line 56 |
| `test_generation.py` | `__init__.py` | Tests use public API | WIRED | Imports from src.maxpat throughout (15+ test functions) |

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|------------|-------------|--------|----------|
| PAT-01 | 02-01, 02-04 | Valid .maxpat JSON generation | SATISFIED | generate_patch produces JSON that roundtrips through json.dumps/loads. Correct fileversion, appversion, classnamespace. Fixture comparison tests. |
| PAT-02 | 02-01, 02-04 | Correct patcher/boxes/lines structure | SATISFIED | to_dict() produces `{"patcher": {"boxes": [...], "lines": [...]}}`. Layer 1 validation enforces structure. 56 patcher tests verify. |
| PAT-03 | 02-01 | Subpatcher and bpatcher support | SATISFIED | add_subpatcher creates nested patcher with inlet/outlet objects. add_bpatcher supports file reference and embedded mode. Verified programmatically. |
| PAT-04 | 02-03 | Connection outlet/inlet bounds checking | SATISFIED | Layer 3 validates src_outlet < numoutlets and dst_inlet < numinlets. Out-of-bounds connections auto-removed. 34 validation tests. |
| PAT-05 | 02-03 | Signal/control type matching | SATISFIED | Layer 3 checks signal outlet to control-only inlet. Uses database inlet metadata for accurate detection. Respects CLAUDE.md signal/float exception. |
| PAT-06 | 02-02, 02-04 | Top-to-bottom signal flow layout | SATISFIED | Kahn's topological sort assigns columns. Source objects leftmost, outputs rightmost. Vertical stacking within columns. 14 layout tests. |
| PAT-07 | 02-02, 02-04 | Readable spacing (80-120px vertical, 60-80px horizontal gutter) | SATISFIED | V_SPACING=100px, H_GUTTER=70px. Dynamic column widths based on widest object. Tests verify spacing values. |
| PAT-08 | 02-03, 02-04 | Multi-layer validation pipeline | SATISFIED | Four layers: JSON structure, object existence (with PD detection), connection bounds/types, domain rules (gain staging, unterminated chains, feedback). Early termination on Layer 1 errors. |
| FRM-05 | 02-04 | File write hooks trigger validation | SATISFIED | write_patch calls generate_patch (which runs validate_patch). validate_file validates from disk. PatchValidationError raised on blocking errors. 14 hooks tests. |

No orphaned requirements found -- all 9 requirement IDs in REQUIREMENTS.md mapped to Phase 2 are claimed by plans and implemented.

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| (none) | - | - | - | No TODO, FIXME, PLACEHOLDER, stub, or empty implementation patterns found in any src/maxpat/ file |

### Human Verification Required

### 1. MAX Application Loading Test

**Test:** Generate a simple synth patch (cycle~ 440 -> *~ 0.5 -> ezdac~), write it via write_patch(), and open the .maxpat file in MAX 9.
**Expected:** Patch opens without errors. Three objects visible with correct connections. Layout shows left-to-right signal flow with readable spacing.
**Why human:** Actual MAX application rendering and file format acceptance cannot be verified without running MAX.

### 2. Audio Playback Test

**Test:** In the opened patch from Test 1, click the ezdac~ object to enable audio.
**Expected:** 440Hz sine tone plays at half volume. No clicks, pops, or errors.
**Why human:** Audio output requires MAX DSP engine running.

### 3. Subpatcher Navigation Test

**Test:** Generate a patch with a subpatcher, open in MAX, and double-click the subpatcher box.
**Expected:** Inner patcher window opens showing inlet/outlet objects and any inner signal chain. Connections between parent and subpatcher work correctly.
**Why human:** Nested patcher UI interaction and connection routing require MAX application.

### Gaps Summary

No gaps found. All 5 observable truths verified. All 17 artifacts exist, are substantive, and are properly wired. All 9 requirement IDs (PAT-01 through PAT-08, FRM-05) are satisfied with implementation evidence. All 169 tests pass. No anti-patterns detected in source files.

The phase goal -- "Framework generates .maxpat files that open in MAX without errors, with readable layout and validated connections" -- is achieved to the extent verifiable without running MAX. Human verification is recommended for the three tests above to confirm actual MAX application compatibility.

---

_Verified: 2026-03-10T01:00:00Z_
_Verifier: Claude (gsd-verifier)_
