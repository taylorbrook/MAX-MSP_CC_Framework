# Phase 6: Fix Skill Documentation Signatures - Research

**Researched:** 2026-03-10
**Domain:** Documentation accuracy -- SKILL.md API signatures vs actual Python source
**Confidence:** HIGH

## Summary

This phase is a documentation-only correction phase. All three specialist agent SKILL.md files (max-patch-agent, max-dsp-agent, max-js-agent) contain function signatures that do not match the actual Python API defined in `src/maxpat/patcher.py`, `src/maxpat/codegen.py`, and `src/maxpat/hooks.py`. Additionally, the `max-verify.md` command file references incorrect import paths for two functions.

The mismatches are not subtle -- they include wrong method names (`connect` vs `add_connection`), wrong parameter types (`patch_dict` vs `patcher`), reversed parameter order, and invented parameter names. These mismatches mean that when Claude agents reference these SKILL.md files during generation, they will produce incorrect function calls that would fail at runtime.

**Primary recommendation:** Fix all 8 identified mismatches by updating the SKILL.md and command files to match the exact signatures found in the Python source code. No Python code changes needed.

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| AGT-01 | Domain-specialized agents for patch generation, DSP/Gen~, RNBO~, js/Node, externals | Already satisfied. This phase closes integration gap DOC-SIG-01 where the agent documentation references inaccurate function signatures. All 8 mismatches catalogued below. |
| FRM-02 | Slash commands for project lifecycle: ideation, research, planning, execution, verification | Already satisfied. This phase fixes the `max-verify.md` command's import paths to reference the correct Python module locations. 2 import path errors identified. |
</phase_requirements>

## Mismatch Catalog

This is the core deliverable of this research: an exhaustive, verified catalog of every signature mismatch between documentation and source code.

### 1. max-patch-agent/SKILL.md

#### Mismatch 1A: `connect` vs `add_connection`

**SKILL.md says:**
```
- `Patcher.connect(src, src_out, dst, dst_in)` -- connect boxes
```

**Actual API (src/maxpat/patcher.py:332-363):**
```python
def add_connection(
    self,
    src_box: Box,
    src_outlet: int,
    dst_box: Box,
    dst_inlet: int,
    order: int = 0,
    hidden: bool = False,
) -> Patchline:
```

**What's wrong:** Method name is `add_connection`, not `connect`. Also has two optional parameters (`order`, `hidden`) not documented.

**Correct documentation:**
```
- `Patcher.add_connection(src_box, src_outlet, dst_box, dst_inlet, order=0, hidden=False)` -- connect boxes
```

#### Mismatch 1B: `write_patch(patch_dict, path)` signature

**SKILL.md says:**
```
- `write_patch(patch_dict, path)` -- write .maxpat with validation hooks
```

**Actual API (src/maxpat/hooks.py:35-92):**
```python
def write_patch(
    patcher: Patcher,
    path: str | Path,
    validate: bool = True,
) -> list[ValidationResult]:
```

**What's wrong:** First parameter is a `Patcher` instance, not a `patch_dict`. Also has an optional `validate` parameter.

**Correct documentation:**
```
- `write_patch(patcher, path, validate=True)` -- write .maxpat with validation hooks
```

### 2. max-dsp-agent/SKILL.md

#### Mismatch 2A: `build_genexpr(code, params)` signature

**SKILL.md says:**
```
- `build_genexpr(code, params)` -- build validated GenExpr code string
```

**Actual API (src/maxpat/codegen.py:46-87):**
```python
def build_genexpr(
    params: list[dict],
    code_body: str,
    num_inputs: int = 1,
    num_outputs: int = 1,
) -> str:
```

**What's wrong:** Parameter order is reversed (`params` is first, not second). Second parameter is named `code_body`, not `code`. Also has two optional parameters.

**Correct documentation:**
```
- `build_genexpr(params, code_body, num_inputs=1, num_outputs=1)` -- build validated GenExpr code string
```

#### Mismatch 2B: `Patcher.add_gen(name, code)` signature

**SKILL.md says:**
```
- `Patcher.add_gen(name, code)` -- embed gen~ codebox in a .maxpat
```

**Actual API (src/maxpat/patcher.py:518-663):**
```python
def add_gen(
    self,
    code: str,
    num_inputs: int | None = None,
    num_outputs: int | None = None,
    x: float = 0.0,
    y: float = 0.0,
) -> tuple[Box, "Patcher"]:
```

**What's wrong:** There is no `name` parameter. First parameter is `code`, not `name`. Has optional I/O and position parameters.

**Correct documentation:**
```
- `Patcher.add_gen(code, num_inputs=None, num_outputs=None)` -- embed gen~ codebox in a .maxpat
```

#### Mismatch 2C: `generate_gendsp` missing from Key Functions

**SKILL.md says:**
```
- `generate_gendsp(code, params)` -- generate standalone .gendsp file
```

**Actual API (src/maxpat/codegen.py:90-207):**
```python
def generate_gendsp(
    code: str,
    num_inputs: int | None = None,
    num_outputs: int | None = None,
) -> dict:
```

**What's wrong:** Second parameter is `num_inputs` not `params`. Has `num_outputs` as third parameter.

**Correct documentation:**
```
- `generate_gendsp(code, num_inputs=None, num_outputs=None)` -- generate standalone .gendsp JSON dict
```

### 3. max-js-agent/SKILL.md

#### Mismatch 3A: `generate_n4m_script(handlers, options)` signature

**SKILL.md says:**
```
- `generate_n4m_script(handlers, options)` -- generate a complete N4M script
```

**Actual API (src/maxpat/codegen.py:210-276):**
```python
def generate_n4m_script(
    handlers: list[dict],
    dict_access: list[str] | None = None,
) -> str:
```

**What's wrong:** Second parameter is named `dict_access`, not `options`. Type is `list[str] | None`, not a generic options parameter.

**Correct documentation:**
```
- `generate_n4m_script(handlers, dict_access=None)` -- generate a complete N4M script
```

#### Mismatch 3B: `generate_js_script(handlers, options)` signature

**SKILL.md says:**
```
- `generate_js_script(handlers, options)` -- generate a complete js V8 script
```

**Actual API (src/maxpat/codegen.py:279-339):**
```python
def generate_js_script(
    num_inlets: int = 1,
    num_outlets: int = 1,
    handlers: list[dict] | None = None,
) -> str:
```

**What's wrong:** Completely wrong parameter list. Actual signature has `num_inlets` and `num_outlets` as first two params (with defaults), and `handlers` is optional third param (not first). No `options` param exists.

**Correct documentation:**
```
- `generate_js_script(num_inlets=1, num_outlets=1, handlers=None)` -- generate a complete js V8 script
```

### 4. max-verify.md Import Paths

#### Mismatch 4A: `validate_file` import path

**max-verify.md says:**
```python
from src.maxpat.validation import validate_file
```

**Actual location:** `src/maxpat/hooks.py:129` (re-exported via `src.maxpat.__init__`)

**Correct import:**
```python
from src.maxpat.hooks import validate_file
# or equivalently:
from src.maxpat import validate_file
```

#### Mismatch 4B: `validate_code_file` import path

**max-verify.md says:**
```python
from src.maxpat.code_validation import validate_code_file
```

**Actual location:** `src/maxpat/hooks.py:159` (re-exported via `src.maxpat.__init__`)

**Correct import:**
```python
from src.maxpat.hooks import validate_code_file
# or equivalently:
from src.maxpat import validate_code_file
```

**Note on import style:** The `src.maxpat.__init__.py` re-exports both functions, so `from src.maxpat import validate_file, validate_code_file` is the cleanest import path and matches the public API design pattern used throughout the codebase (see `__init__.py` line 6: `from src.maxpat import Patcher, generate_patch, write_patch, validate_file`).

## Architecture Patterns

### Documentation-Source Verification Pattern

Each SKILL.md file serves as an instruction prompt for Claude agents. The pattern is:

```
SKILL.md "Key Functions" section
  -> Claude reads this before generating code
  -> Claude uses these signatures in generated code
  -> Generated code must match actual Python API
```

The fix pattern for each mismatch is:
1. Read actual function signature from Python source
2. Update the SKILL.md to match exactly
3. Preserve surrounding context/descriptions
4. Verify no other references to the old signature exist in the same file

### File Locations

| File | Path |
|------|------|
| max-patch-agent SKILL.md | `.claude/skills/max-patch-agent/SKILL.md` |
| max-dsp-agent SKILL.md | `.claude/skills/max-dsp-agent/SKILL.md` |
| max-js-agent SKILL.md | `.claude/skills/max-js-agent/SKILL.md` |
| max-verify.md | `.claude/commands/max-verify.md` |
| Patcher source | `src/maxpat/patcher.py` |
| Codegen source | `src/maxpat/codegen.py` |
| Hooks source | `src/maxpat/hooks.py` |
| Public API | `src/maxpat/__init__.py` |

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Signature extraction | Script to parse Python AST | Manual reading of source | Only 8 mismatches -- manual is faster and more accurate |
| Cross-reference validation | Custom checker | `tests/test_agent_skills.py` + new signature tests | Test infrastructure already exists |

## Common Pitfalls

### Pitfall 1: Fixing Signatures but Missing Context References

**What goes wrong:** A SKILL.md may reference the same function in multiple places (e.g., Key Functions section AND Output Protocol section). Fixing one but not the other creates an internal inconsistency.

**How to avoid:** After fixing each function signature, search the entire file for all occurrences of the function name and verify consistency.

### Pitfall 2: Over-Documenting Optional Parameters

**What goes wrong:** Including every optional parameter (like `x`, `y` position params) clutters the SKILL.md and distracts from the essential API shape.

**How to avoid:** Include parameters that affect behavior (like `validate=True` on `write_patch`). Omit pure layout parameters (`x`, `y`) that don't affect the conceptual API.

### Pitfall 3: Confusing Source Module vs Public API Import Path

**What goes wrong:** Using `src.maxpat.hooks` (implementation detail) instead of `src.maxpat` (public API).

**How to avoid:** Use the public API import path (`from src.maxpat import ...`) in documentation since that's the intended import pattern per `__init__.py`.

### Pitfall 4: Not Updating the max-verify.md Python Modules Block

**What goes wrong:** The max-verify.md has a fenced code block showing exact import paths. If these are wrong, agents copy them verbatim.

**How to avoid:** Use `from src.maxpat import validate_file, validate_code_file` which is the canonical public API import.

## Validation Architecture

### Test Framework

| Property | Value |
|----------|-------|
| Framework | pytest (installed) |
| Config file | None explicit (uses default discovery) |
| Quick run command | `python3 -m pytest tests/test_agent_skills.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements -> Test Map

| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| DOC-SIG-01a | max-patch-agent SKILL.md has `add_connection` (not `connect`) | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "patch"` | Partial (exists but needs signature-specific tests) |
| DOC-SIG-01b | max-patch-agent SKILL.md has `write_patch(patcher, path)` (not `patch_dict`) | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "patch"` | Partial |
| DOC-SIG-01c | max-dsp-agent SKILL.md has `build_genexpr(params, code_body)` | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "dsp"` | Partial |
| DOC-SIG-01d | max-dsp-agent SKILL.md has `add_gen(code, ...)` (no `name` param) | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "dsp"` | Partial |
| DOC-SIG-01e | max-dsp-agent SKILL.md has `generate_gendsp(code, num_inputs, num_outputs)` | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "dsp"` | Partial |
| DOC-SIG-01f | max-js-agent SKILL.md has `generate_n4m_script(handlers, dict_access)` | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "js"` | No |
| DOC-SIG-01g | max-js-agent SKILL.md has `generate_js_script(num_inlets, num_outlets, handlers)` | unit | `python3 -m pytest tests/test_agent_skills.py -x -q -k "js"` | No |
| DOC-SIG-01h | max-verify.md import paths match actual module locations | unit | `python3 -m pytest tests/test_commands.py -x -q` | Needs verification |

### Sampling Rate

- **Per task commit:** `python3 -m pytest tests/test_agent_skills.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before `/gsd:verify-work`

### Wave 0 Gaps

- [ ] Add signature-accuracy tests to `tests/test_agent_skills.py` -- verify that SKILL.md files contain the correct function signatures (not just that functions are mentioned)
- [ ] Verify `tests/test_commands.py` covers import path accuracy for max-verify.md

## Correct Signatures Reference

Complete reference of what each documentation file SHOULD contain after fixes:

### max-patch-agent/SKILL.md Key Functions

```
- `Patcher()` -- create a new patch
- `Box(name, args, db)` -- create a validated box
- `Patcher.add_box(name, args=None)` -- add box to patch
- `Patcher.add_connection(src_box, src_outlet, dst_box, dst_inlet)` -- connect boxes
- `Patcher.add_subpatcher(name, inlets=1, outlets=1)` -- add a subpatcher
- `generate_patch(patcher)` -- layout + serialize + validate
- `write_patch(patcher, path, validate=True)` -- write .maxpat with validation hooks
```

### max-dsp-agent/SKILL.md Key Functions

```
- `build_genexpr(params, code_body, num_inputs=1, num_outputs=1)` -- build validated GenExpr code string
- `parse_genexpr_io(code)` -- detect input/output count from GenExpr code
- `generate_gendsp(code, num_inputs=None, num_outputs=None)` -- generate standalone .gendsp file
- `Patcher.add_gen(code, num_inputs=None, num_outputs=None)` -- embed gen~ codebox in a .maxpat
```

### max-js-agent/SKILL.md Key Functions

```
- `generate_n4m_script(handlers, dict_access=None)` -- generate a complete N4M script
- `generate_js_script(num_inlets=1, num_outlets=1, handlers=None)` -- generate a complete js V8 script
- `validate_js(code)` -- validate js V8 script structure
- `validate_n4m(code)` -- validate N4M script structure
- `detect_js_type(code)` -- determine if code is N4M or js V8
```

### max-verify.md Python Modules

```python
from src.maxpat import validate_file, validate_code_file
from src.maxpat.critics import review_patch, CriticResult
from src.maxpat.project import get_active_project, update_status
```

## Open Questions

None. All mismatches are fully identified and verified against source code. The fixes are deterministic text replacements.

## Sources

### Primary (HIGH confidence)

All findings are based on direct source code inspection:

- `src/maxpat/patcher.py` -- `add_connection` (line 332), `add_gen` (line 518) signatures
- `src/maxpat/codegen.py` -- `build_genexpr` (line 46), `generate_gendsp` (line 90), `generate_n4m_script` (line 210), `generate_js_script` (line 279) signatures
- `src/maxpat/hooks.py` -- `write_patch` (line 35), `validate_file` (line 129), `validate_code_file` (line 159) signatures
- `src/maxpat/__init__.py` -- public API re-exports and canonical import paths

## Metadata

**Confidence breakdown:**
- Mismatch catalog: HIGH -- every mismatch verified by reading both documentation and source code line-by-line
- Correct signatures: HIGH -- copied directly from Python source `def` statements
- Import paths: HIGH -- verified against `__init__.py` re-exports and `hooks.py` definitions

**Research date:** 2026-03-10
**Valid until:** Indefinite (signatures change only if Python API changes)
