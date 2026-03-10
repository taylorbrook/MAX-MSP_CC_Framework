---
phase: 06-fix-skill-documentation-signatures
verified: 2026-03-10T21:00:00Z
status: passed
score: 8/8 must-haves verified
re_verification: false
---

# Phase 6: Fix Skill Documentation Signatures Verification Report

**Phase Goal:** Correct all API signature mismatches in skill/command documentation so Claude agents reference accurate function signatures during generation
**Verified:** 2026-03-10T21:00:00Z
**Status:** passed
**Re-verification:** No -- initial verification

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | max-patch-agent SKILL.md references add_connection (not connect) with correct parameter names | VERIFIED | `add_connection` found at lines 38, 44; `.connect(src` and `connect(src,` absent |
| 2 | max-patch-agent SKILL.md references write_patch(patcher, path) (not patch_dict) | VERIFIED | `write_patch(patcher, path, validate=True)` at line 47; `write_patch(patch_dict` absent |
| 3 | max-dsp-agent SKILL.md references build_genexpr(params, code_body) with correct parameter order | VERIFIED | `build_genexpr(params, code_body, num_inputs=1, num_outputs=1)` at line 36; `build_genexpr(code, params` absent |
| 4 | max-dsp-agent SKILL.md references add_gen(code, ...) without a name parameter | VERIFIED | `add_gen(code, num_inputs=None, num_outputs=None)` at line 42; `add_gen(name` absent |
| 5 | max-dsp-agent SKILL.md references generate_gendsp(code, num_inputs, num_outputs) | VERIFIED | `generate_gendsp(code, num_inputs=None, num_outputs=None)` at line 38; `generate_gendsp(code, params` absent |
| 6 | max-js-agent SKILL.md references generate_n4m_script(handlers, dict_access) not options | VERIFIED | `generate_n4m_script(handlers, dict_access=None)` at line 31; `generate_n4m_script(handlers, options` absent |
| 7 | max-js-agent SKILL.md references generate_js_script(num_inlets, num_outlets, handlers) not (handlers, options) | VERIFIED | `generate_js_script(num_inlets=1, num_outlets=1, handlers=None)` at line 40; `generate_js_script(handlers` absent |
| 8 | max-verify.md import paths use src.maxpat (public API) not src.maxpat.validation or src.maxpat.code_validation | VERIFIED | `from src.maxpat import validate_file, validate_code_file` at line 39; `from src.maxpat.validation` and `from src.maxpat.code_validation` absent |

**Score:** 8/8 truths verified

### Cross-Verification Against Python Source

All documentation signatures were cross-checked against actual Python definitions:

| Function | Source File | Source Line | Doc Signature Matches |
|----------|-------------|-------------|----------------------|
| `add_connection(self, src_box, src_outlet, dst_box, dst_inlet, ...)` | `src/maxpat/patcher.py` | 332 | Yes |
| `write_patch(patcher, path, validate=True)` | `src/maxpat/hooks.py` | 35 | Yes |
| `build_genexpr(params, code_body, num_inputs=1, num_outputs=1)` | `src/maxpat/codegen.py` | 46 | Yes |
| `add_gen(self, code, num_inputs=None, num_outputs=None, ...)` | `src/maxpat/patcher.py` | 518 | Yes |
| `generate_gendsp(code, num_inputs=None, num_outputs=None)` | `src/maxpat/codegen.py` | 90 | Yes |
| `generate_n4m_script(handlers, dict_access=None)` | `src/maxpat/codegen.py` | 210 | Yes |
| `generate_js_script(num_inlets=1, num_outlets=1, handlers=None)` | `src/maxpat/codegen.py` | 279 | Yes |
| `validate_file` / `validate_code_file` re-exported via `src.maxpat` | `src/maxpat/__init__.py` | 24-25 | Yes |

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `tests/test_agent_skills.py` | Signature-accuracy tests for all 3 SKILL.md files | VERIFIED | 8 new tests at lines 377-483; COMMANDS_DIR constant at line 368; _read_command helper at line 371 |
| `.claude/skills/max-patch-agent/SKILL.md` | Correct patch agent API signatures | VERIFIED | `add_connection` (2 occurrences), `write_patch(patcher, path, validate=True)` |
| `.claude/skills/max-dsp-agent/SKILL.md` | Correct DSP agent API signatures | VERIFIED | `build_genexpr(params, code_body, ...)`, `add_gen(code, ...)`, `generate_gendsp(code, num_inputs, ...)` |
| `.claude/skills/max-js-agent/SKILL.md` | Correct js agent API signatures | VERIFIED | `generate_n4m_script(handlers, dict_access=None)`, `generate_js_script(num_inlets=1, ...)` |
| `.claude/commands/max-verify.md` | Correct import paths for validate_file and validate_code_file | VERIFIED | `from src.maxpat import validate_file, validate_code_file` on single line |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `tests/test_agent_skills.py` | `.claude/skills/max-patch-agent/SKILL.md` | File content string matching | WIRED | Tests read SKILL.md via `_read_skill("max-patch-agent")` and assert `add_connection`, `write_patch(patcher` present |
| `tests/test_agent_skills.py` | `.claude/skills/max-dsp-agent/SKILL.md` | File content string matching | WIRED | Tests read SKILL.md via `_read_skill("max-dsp-agent")` and assert `build_genexpr(params, code_body`, `add_gen(code`, `generate_gendsp(code, num_inputs` present |
| `tests/test_agent_skills.py` | `.claude/skills/max-js-agent/SKILL.md` | File content string matching | WIRED | Tests read SKILL.md via `_read_skill("max-js-agent")` and assert `generate_n4m_script(handlers, dict_access`, `generate_js_script(num_inlets` present |
| `tests/test_agent_skills.py` | `.claude/commands/max-verify.md` | File content string matching | WIRED | Test reads command via `_read_command("max-verify")` and asserts `from src.maxpat import` present, wrong paths absent |

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|------------|-------------|--------|----------|
| AGT-01 | 06-01 | Domain-specialized agents for patch generation, DSP/Gen~, RNBO~, js/Node, externals | SATISFIED (gap closure) | Already complete from Phase 4. Phase 6 closes DOC-SIG-01 gap: all 3 specialist agent SKILL.md files now have correct API signatures matching actual Python source |
| FRM-02 | 06-01 | Slash commands for project lifecycle | SATISFIED (gap closure) | Already complete from Phase 4. Phase 6 fixes `max-verify.md` import paths to use public API (`from src.maxpat import`) instead of nonexistent internal modules |

No orphaned requirements found. REQUIREMENTS.md maps AGT-01 and FRM-02 to Phase 4 (original implementation). Phase 6's `gap_closure: true` flag correctly identifies this as closing DOC-SIG-01 rather than original implementation.

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| (none) | - | - | - | No anti-patterns detected in any modified file |

All 5 modified files scanned for TODO, FIXME, PLACEHOLDER, HACK, XXX markers. None found.

### Test Results

| Suite | Result | Details |
|-------|--------|---------|
| Signature-accuracy tests (8 tests) | All pass | `pytest tests/test_agent_skills.py -k "signature or verify_command"` |
| Agent skills tests (80 tests total) | All pass | `pytest tests/test_agent_skills.py -x -q` |
| Full test suite (621 tests) | All pass | `pytest tests/ -x -q` in 2.47s |

### Commit Verification

| Commit | Hash | Verified |
|--------|------|----------|
| TDD RED: 8 failing signature tests | `da6635c` | Exists in git log |
| TDD GREEN: fix all 9 signature mismatches | `cd9b696` | Exists in git log |

### Human Verification Required

None. All verification is automated via string matching against documentation files and cross-referencing against Python source definitions. No visual, real-time, or external service behavior is involved.

### Gaps Summary

No gaps found. All 9 API signature mismatches identified in the DOC-SIG-01 audit have been corrected:

- 2 fixes in max-patch-agent/SKILL.md (add_connection, write_patch)
- 3 fixes in max-dsp-agent/SKILL.md (build_genexpr param order, add_gen no name, generate_gendsp params)
- 2 fixes in max-js-agent/SKILL.md (n4m dict_access, js num_inlets first)
- 2 fixes in max-verify.md (validate_file and validate_code_file import paths)

All documentation signatures now match the actual Python API definitions. Regression tests prevent future signature drift.

---

_Verified: 2026-03-10T21:00:00Z_
_Verifier: Claude (gsd-verifier)_
