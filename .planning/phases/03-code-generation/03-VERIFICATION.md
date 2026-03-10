---
phase: 03-code-generation
verified: 2026-03-10T03:44:10Z
status: passed
score: 4/4 must-haves verified
---

# Phase 3: Code Generation Verification Report

**Phase Goal:** Claude generates valid Gen~ GenExpr DSP code, js/V8 scripts, and Node for Max JavaScript that integrate correctly with MAX patches
**Verified:** 2026-03-10T03:44:10Z
**Status:** PASSED
**Re-verification:** No -- initial verification

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | Generated Gen~ GenExpr code uses correct syntax (in/out keywords, Param declarations, C-style operators) and passes syntax validation | VERIFIED | `build_genexpr` produces section headers, `Param name(default, min=N, max=N);` format, in/out keywords. `validate_genexpr` checks braces, semicolons, Param syntax, and operators against gen/objects.json (189 operators). 77 codegen/validation tests pass. |
| 2 | Gen~ codebox objects embed correctly in .maxpat patches, and standalone .gendsp files generate for Gen~ patchers | VERIFIED | `Patcher.add_gen()` creates gen~ box with inner patcher containing in objects + codebox + out objects + patchlines. Codebox `code` attribute serialized via `extra_attrs`. `generate_gendsp()` produces complete .gendsp JSON dict. `write_gendsp()` writes to disk. gen~ uses maxclass `"gen~"` (in `UI_MAXCLASSES`). Fixture files exist and comparison tests pass. |
| 3 | Node for Max (node.script) JavaScript generates with correct MAX API integration (handlers, post function, Dict access) | VERIFIED | `generate_n4m_script` produces CommonJS code with `require("max-api")`, `addHandler` registrations, async dict access with try/catch and `maxAPI.post` error reporting. `Patcher.add_node_script` creates box with `maxclass="newobj"`, `text="node.script filename.js"`, 1 inlet, configurable outlets. `validate_n4m` checks require, addHandler names, outlet calls. |
| 4 | js object V8 JavaScript generates with correct patcher API access (inlets, outlets, bang/msg_int/msg_float handlers) | VERIFIED | `generate_js_script` produces code with `inlets = N;` / `outlets = N;` declarations and handler functions (bang, msg_int, msg_float, list). Default handlers generated when none specified. `Patcher.add_js` creates box with `maxclass="newobj"`, `text="js filename.js"`. `validate_js` checks inlets/outlets declarations, handler presence, and outlet index bounds. |

**Score:** 4/4 truths verified

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `src/maxpat/codegen.py` | GenExpr code builder + .gendsp + N4M + js generators | VERIFIED | 339 lines. Exports: `parse_genexpr_io`, `build_genexpr`, `generate_gendsp`, `generate_n4m_script`, `generate_js_script`. All substantive implementations. |
| `src/maxpat/patcher.py` | add_gen, add_js, add_node_script methods | VERIFIED | 778 lines. `add_gen` (line 518), `add_node_script` (line 665), `add_js` (line 715). All use `Box.__new__` pattern for structural bypass. |
| `src/maxpat/code_validation.py` | GenExpr, js, N4M validators | VERIFIED | 306 lines. Exports: `validate_genexpr`, `validate_js`, `validate_n4m`, `detect_js_type`. All with substantive check logic (braces, semicolons, operators, inlets/outlets, require). |
| `src/maxpat/hooks.py` | Extended hooks for .gendsp and .js validation | VERIFIED | 265 lines. `write_gendsp` (line 95), `validate_code_file` (line 159), `write_js` (line 238). Dispatches to correct validator based on file type. |
| `src/maxpat/__init__.py` | Public API exports all code generation/validation functions | VERIFIED | 119 lines. `__all__` contains all required exports: `build_genexpr`, `parse_genexpr_io`, `generate_gendsp`, `generate_n4m_script`, `generate_js_script`, `validate_genexpr`, `validate_js`, `validate_n4m`, `detect_js_type`, `validate_code_file`, `write_js`, `write_gendsp`. |
| `src/maxpat/maxclass_map.py` | gen~ in UI_MAXCLASSES | VERIFIED | `"gen~"` at line 40 in the `UI_MAXCLASSES` frozenset. `resolve_maxclass("gen~")` returns `"gen~"`. |
| `src/maxpat/defaults.py` | GEN_PATCHER_BGCOLOR constant | VERIFIED | `GEN_PATCHER_BGCOLOR = [0.9, 0.9, 0.9, 1.0]` at line 22. |
| `src/maxpat/sizing.py` | gen~ default size | VERIFIED | `"gen~": (150.0, 22.0)` at line 65 in `UI_SIZES`. |
| `tests/test_codegen.py` | Tests for all code generation domains | VERIFIED | 764 lines. 8 test classes: TestGenExpr (9 tests), TestGendsp (8 tests), TestMaxclassFix (2 tests), TestGenBox (12 tests), TestGendspFile (6 tests), TestPublicAPI (4 tests), TestN4M (5 tests), TestJsObject (5 tests), TestHookIntegration (3 tests). |
| `tests/test_code_validation.py` | Validation tests for all three code domains | VERIFIED | 267 lines. 5 test classes: TestGenExprValidator (6 tests), TestJsValidator (5 tests), TestN4MValidator (4 tests), TestDetectJsType (3 tests), TestValidateCodeFile (4 tests). |
| `tests/fixtures/expected/gen_codebox.maxpat` | gen~ codebox fixture | VERIFIED | File exists on disk. |
| `tests/fixtures/expected/simple.gendsp` | .gendsp fixture | VERIFIED | File exists on disk. Used in fixture comparison test. |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `patcher.py::add_gen` | `codegen.py::parse_genexpr_io` | Import and call for I/O auto-detection | WIRED | `from src.maxpat.codegen import parse_genexpr_io` at line 542, called at line 546. |
| `patcher.py::add_gen` | `maxclass_map.py` | gen~ resolves to maxclass "gen~" | WIRED | gen~ in `UI_MAXCLASSES` (line 40). `resolve_maxclass("gen~")` returns "gen~". Test at line 253 confirms. |
| `codegen.py::generate_gendsp` | `defaults.py` | Uses DEFAULT_PATCHER_PROPS | WIRED | Import at line 20, used at line 118 via `copy.deepcopy(DEFAULT_PATCHER_PROPS)`. |
| `hooks.py::validate_code_file` | `code_validation.py` | Dispatches to appropriate validator | WIRED | Imports all 4 functions (lines 178-181). Dispatches: `.gendsp` -> `validate_genexpr` (line 215), `.js` -> `detect_js_type` then `validate_n4m` or `validate_js` (lines 218-222). |
| `code_validation.py::validate_genexpr` | `db_lookup.py::ObjectDatabase` | Validates operators against gen/objects.json | WIRED | Creates `ObjectDatabase()` at line 131 when db is None. Calls `db.lookup(func_name)` at line 151 for each extracted operator. |
| `patcher.py::add_node_script` | Box creation | Creates node.script box via Box.__new__ | WIRED | Box.__new__ at line 692, maxclass="newobj", text="node.script {filename}" at line 690-691. |
| `patcher.py::add_js` | Box creation | Creates js box via Box.__new__ | WIRED | Box.__new__ at line 745, maxclass="newobj", text="js {filename}" at line 748-749. |

**Note on generate_js_script/generate_n4m_script links:** Plan 03-02 defined key links from `add_js -> generate_js_script` and `add_node_script -> generate_n4m_script`. In practice, these methods accept code as a parameter rather than calling generators internally. The caller composes the steps (generate code, then create box). This is a valid architectural separation -- the link is through the caller, not internal wiring. Tests in TestHookIntegration confirm the full pipeline works end-to-end.

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|------------|-------------|--------|----------|
| CODE-01 | 03-01, 03-02 | Gen~ GenExpr code generation with correct syntax | SATISFIED | `build_genexpr` produces well-formatted GenExpr. `validate_genexpr` validates against gen/objects.json. 15 tests cover parsing, building, and validation. |
| CODE-02 | 03-01 | Gen~ codebox objects embedded correctly in .maxpat patches | SATISFIED | `Patcher.add_gen()` creates gen~ box with inner patcher, codebox, in/out objects, and patchlines. Serialization produces correct nested JSON. 12 tests cover embedding. |
| CODE-03 | 03-01 | Standalone .gendsp file generation for Gen~ patchers | SATISFIED | `generate_gendsp` produces complete .gendsp dict. `write_gendsp` writes to disk. Fixture comparison and roundtrip tests pass. 14 tests cover structure and file I/O. |
| CODE-04 | 03-02 | Node for Max (node.script) JavaScript generation with MAX API integration | SATISFIED | `generate_n4m_script` produces CommonJS with require, addHandler, async dict access. `add_node_script` creates box. `validate_n4m` validates. 12 tests cover generation, box creation, and validation. |
| CODE-05 | 03-02 | js object V8 JavaScript generation with patcher API access | SATISFIED | `generate_js_script` produces code with inlets/outlets and handler functions. `add_js` creates box. `validate_js` validates. 12 tests cover generation, box creation, and validation. |

No orphaned requirements. REQUIREMENTS.md maps CODE-01 through CODE-05 to Phase 3, and all five are covered by Plans 03-01 and 03-02.

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| None | - | - | - | No anti-patterns detected |

Two false positives noted:
- `codegen.py` line 288/308: "placeholder bodies" -- refers to the intentional design of generating default handler code with basic bodies (e.g., `outlet(0, v)`) when no custom handlers are specified. These are functional, not empty stubs.
- `codegen.py` line 246: `return null;` -- inside a generated JavaScript string template for dict access error handling. This is correct JavaScript semantics, not a Python stub.

### Human Verification Required

### 1. Gen~ codebox opens in MAX

**Test:** Generate a .maxpat with a gen~ codebox via `add_gen`, open in MAX 9.
**Expected:** Gen~ object displays in patch, double-click opens the gen~ patcher showing the codebox with GenExpr code.
**Why human:** Cannot verify MAX rendering programmatically. JSON structure is correct per validation, but actual MAX behavior needs visual confirmation.

### 2. .gendsp file opens in MAX

**Test:** Generate a .gendsp file via `write_gendsp`, open in MAX 9 via File > Open.
**Expected:** Gen~ patcher opens with codebox containing the GenExpr code, in/out objects connected.
**Why human:** .gendsp file format validated structurally but MAX's actual parsing may differ.

### 3. node.script box references JavaScript file correctly

**Test:** Create a patch with `add_node_script("myscript.js")`, write it, place a myscript.js file alongside, open in MAX.
**Expected:** node.script box loads the JavaScript file, handlers respond to messages.
**Why human:** File path resolution and Node.js runtime behavior require MAX to test.

### 4. js box references JavaScript file correctly

**Test:** Create a patch with `add_js("myobject.js")`, write it, place a myobject.js file alongside, open in MAX.
**Expected:** js box loads the file, inlets/outlets count matches, handlers work.
**Why human:** V8 runtime behavior and patcher API access require MAX to test.

### Gaps Summary

No gaps found. All four observable truths are verified with complete evidence:

1. GenExpr code generation produces correct syntax and passes validation against the gen domain database (189 operators).
2. Gen~ codebox embedding creates the full nested patcher structure (in -> codebox -> out) with correct serialization.
3. Node for Max JavaScript generates with proper MAX API patterns (CommonJS require, addHandler, async dict access).
4. js V8 JavaScript generates with proper patcher API patterns (inlets/outlets, handler functions).

All 5 requirements (CODE-01 through CODE-05) are satisfied. The full test suite passes at 314 tests with zero failures. All public API functions are importable. No anti-patterns or stub implementations detected.

---

_Verified: 2026-03-10T03:44:10Z_
_Verifier: Claude (gsd-verifier)_
