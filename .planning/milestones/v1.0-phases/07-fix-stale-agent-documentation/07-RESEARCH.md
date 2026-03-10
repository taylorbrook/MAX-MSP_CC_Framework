# Phase 7: Fix Stale Agent Documentation - Research

**Researched:** 2026-03-10
**Domain:** Documentation maintenance (agent skills, commands, dispatch rules)
**Confidence:** HIGH

## Summary

Phase 7 is a documentation-only phase that closes three integration gaps (DOC-01, DOC-02, DOC-03) discovered during the v1.0 milestone audit. All three issues are stale references left over from Phase 5's upgrade of the RNBO and Externals agents from stubs to full implementations. The code and SKILL.md files are already correct -- only supporting documentation files (dispatch-rules.md, max-build.md) still carry outdated "stub" labels, and the RNBO SKILL.md lacks clarity on `validate_rnbo_patch` input scope.

This is a low-risk, low-complexity phase. All changes are text edits to markdown files. No Python code changes are needed. The existing test suite already has tests verifying SKILL.md files are stub-free (`test_rnbo_agent_not_stub`, `test_ext_agent_not_stub`) but does NOT have tests covering dispatch-rules.md or max-build.md for stale stub references -- new tests should be added as part of the TDD approach established in Phase 6.

**Primary recommendation:** Edit 3 files (dispatch-rules.md, max-build.md, RNBO SKILL.md), add regression tests for dispatch-rules.md and max-build.md stub-free assertions, then verify all 621+ tests pass.

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| AGT-01 | Domain-specialized agents for patch generation, DSP/Gen~, RNBO~, js/Node, externals | Closing DOC-01 and DOC-02 ensures documentation accurately reflects that RNBO and external agents are fully implemented, not stubs |
| AGT-02 | UI/layout specialist agent handling both presentation and patching mode | Closing DOC-02 ensures dispatch-rules.md accurately represents all agents including UI alongside the corrected RNBO/ext entries |
| FRM-02 | Slash commands for project lifecycle | Closing DOC-01 ensures max-build.md command documentation correctly lists all agents without stale stub labels |
| CODE-06 | RNBO~ patch generation using only RNBO-compatible object subset | Closing DOC-03 clarifies that validate_rnbo_patch operates on the inner RNBO patcher dict, not the full rnbo~ wrapper |
| CODE-07 | RNBO~ export target awareness (VST3/AU, Web Audio, C++) | Closing DOC-03 clarifies the validate_rnbo_patch scope so target-aware validation is accurately documented |
</phase_requirements>

## Exact Files and Changes Required

### DOC-01: `.claude/commands/max-build.md` (lines 32-33)

**Current (stale):**
```
   - max-rnbo-agent (RNBO export -- stub, Phase 5)
   - max-ext-agent (externals -- stub, Phase 5)
```

**Required fix:** Remove "stub, Phase 5" parenthetical and replace with actual capability descriptions matching the other agent entries in the list:
```
   - max-rnbo-agent (RNBO export, target validation, param mapping)
   - max-ext-agent (C++ externals, Min-DevKit scaffolding, build)
```

### DOC-02: `.claude/skills/max-router/references/dispatch-rules.md` (lines 37, 49, 64, 75, 108)

Five locations need fixing:

1. **Line 37** -- Section header: `### max-rnbo-agent (RNBO Export) -- STUB` -> Remove `-- STUB`
2. **Lines 48-49** -- Note block: Remove entire `**Note:** This agent is a Phase 5 stub...` paragraph
3. **Line 64** -- Section header: `### max-ext-agent (Externals/C++) -- STUB` -> Remove `-- STUB`
4. **Lines 74-75** -- Note block: Remove entire `**Note:** This agent is a Phase 5 stub...` paragraph
5. **Line 108** -- Edge case table: `RNBO (stub)` -> `RNBO` and update reasoning column to remove "stub response"

### DOC-03: `.claude/skills/max-rnbo-agent/SKILL.md` (line 56)

**Current:**
```
- `validate_rnbo_patch(patch_dict, target)`: 3-layer validation (rnbo-objects, rnbo-target, rnbo-contained)
```

**Required fix:** Clarify that `patch_dict` is the inner RNBO patcher (not the full rnbo~ wrapper). The function's actual docstring says: `"Patch dict in .maxpat format (the inner RNBO patcher)."` -- the SKILL.md should match this.

Proposed:
```
- `validate_rnbo_patch(patch_dict, target)`: 3-layer validation on the **inner RNBO patcher** (not the full rnbo~ wrapper). Checks: rnbo-objects, rnbo-target, rnbo-contained
```

## Architecture Patterns

### Pattern 1: TDD for Documentation Fixes

Phase 6 established a TDD pattern: write failing tests first, then fix documentation to make them pass. This same pattern should apply here.

**What:** Write tests that assert dispatch-rules.md and max-build.md do NOT contain "stub" or "STUB" markers for RNBO/ext agents. Also write a test that RNBO SKILL.md clarifies the inner-patcher scope of validate_rnbo_patch.
**When to use:** Every documentation fix in this project.
**Why:** Prevents regression -- if someone re-generates these files from a template, the tests catch stale content.

### Pattern 2: Consistent Agent Description Style

All agent entries in max-build.md follow a pattern: `agentname (brief capability description)`. The RNBO and ext agent entries should match this style rather than referencing implementation status.

### Anti-Patterns to Avoid
- **Partial fix:** Do not fix only some of the 5 locations in dispatch-rules.md. All must be addressed in one pass.
- **Over-editing:** Do not restructure the RNBO or ext sections in dispatch-rules.md -- only remove stub markers and notes. The keyword mappings and intent patterns are correct as-is.
- **Changing Python code:** No Python source changes are needed. The code is correct. Only documentation files change.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Finding stale references | Manual file-by-file search | `grep -r "stub\|STUB" .claude/` | Comprehensive catch of any additional stale references |

## Common Pitfalls

### Pitfall 1: Missing a Stale Reference
**What goes wrong:** You fix the obvious locations but miss one occurrence of "stub" buried in prose.
**Why it happens:** The word appears in 5 separate locations across 2 files, some in headers and some in prose blocks.
**How to avoid:** After fixing, run `grep -ri "stub" .claude/commands/ .claude/skills/` and verify zero matches related to RNBO/ext agents being stubs. The word "stub" may legitimately appear in other contexts (e.g., describing what a stub IS) but should not label these agents as stubs.
**Warning signs:** Tests pass but grep still finds "stub" in a location you missed.

### Pitfall 2: Breaking dispatch-rules.md Edge Case Table
**What goes wrong:** Editing the markdown table in line 108 breaks table alignment or removes the wrong column.
**Why it happens:** Markdown tables are fragile -- one missing pipe character breaks rendering.
**How to avoid:** After editing, visually verify the table renders correctly. The fix is small: change `RNBO (stub)` to `RNBO` and change `stub response` to a proper routing explanation.

### Pitfall 3: Ambiguous validate_rnbo_patch Scope Fix
**What goes wrong:** The clarification added to SKILL.md is too verbose or unclear, making the document harder to scan.
**Why it happens:** Over-explaining a simple distinction.
**How to avoid:** Keep it to one line. The key fact is: the function takes the inner RNBO patcher dict, not the full wrapper .maxpat. This matches the function's docstring.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest (standard) |
| Config file | No explicit config -- uses default pytest discovery |
| Quick run command | `python -m pytest tests/test_agent_skills.py tests/test_commands.py -x -q` |
| Full suite command | `python -m pytest tests/ -x -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| DOC-01 | max-build.md has no stub labels for RNBO/ext | unit (text scan) | `pytest tests/test_commands.py::test_build_no_stub_labels -x` | Wave 0 |
| DOC-02 | dispatch-rules.md has no STUB labels for RNBO/ext | unit (text scan) | `pytest tests/test_agent_skills.py::test_dispatch_rules_no_stub_labels -x` | Wave 0 |
| DOC-03 | RNBO SKILL.md clarifies validate_rnbo_patch scope | unit (text scan) | `pytest tests/test_agent_skills.py::test_rnbo_validate_scope_documented -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python -m pytest tests/test_agent_skills.py tests/test_commands.py -x -q`
- **Per wave merge:** `python -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before `/gsd:verify-work`

### Wave 0 Gaps
- [ ] `tests/test_commands.py::test_build_no_stub_labels` -- asserts max-build.md does not contain "stub" for RNBO/ext agents
- [ ] `tests/test_agent_skills.py::test_dispatch_rules_no_stub_labels` -- asserts dispatch-rules.md does not contain "STUB" markers for RNBO/ext agents
- [ ] `tests/test_agent_skills.py::test_rnbo_validate_scope_documented` -- asserts RNBO SKILL.md clarifies inner patcher scope for validate_rnbo_patch

Note: Existing tests `test_rnbo_agent_not_stub` and `test_ext_agent_not_stub` already cover SKILL.md stub-free status. The new tests cover dispatch-rules.md and max-build.md which are currently untested for stale content.

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| RNBO/ext agents as Phase 5 stubs | Fully implemented agents (Phase 5 complete) | Phase 5 execution | Stubs were replaced; documentation lagged |
| No regression tests for doc staleness | TDD pattern for doc fixes (Phase 6 established) | Phase 6 execution | All doc fixes get tests first |

**Deprecated/outdated:**
- Stub agent pattern: RNBO and ext agents are no longer stubs. All "stub" references in documentation are stale.

## Open Questions

None. All three documentation gaps are clearly identified with exact file locations and line numbers from the v1.0 audit. The fixes are straightforward text edits with clear before/after states.

## Sources

### Primary (HIGH confidence)
- `/Users/taylorbrook/Dev/MAX/.planning/v1.0-MILESTONE-AUDIT.md` -- Defines DOC-01, DOC-02, DOC-03 with exact file locations and line numbers
- `/Users/taylorbrook/Dev/MAX/.claude/commands/max-build.md` -- Verified stale content at lines 32-33
- `/Users/taylorbrook/Dev/MAX/.claude/skills/max-router/references/dispatch-rules.md` -- Verified stale content at lines 37, 49, 64, 75, 108
- `/Users/taylorbrook/Dev/MAX/.claude/skills/max-rnbo-agent/SKILL.md` -- Verified line 56 lacks inner-patcher scope clarification
- `/Users/taylorbrook/Dev/MAX/src/maxpat/rnbo_validation.py` -- Verified `validate_rnbo_patch` docstring says "the inner RNBO patcher" (line 73)
- `/Users/taylorbrook/Dev/MAX/tests/test_agent_skills.py` -- Verified existing stub-free tests for SKILL.md, confirmed no tests for dispatch-rules.md/max-build.md stub content
- `/Users/taylorbrook/Dev/MAX/tests/test_commands.py` -- Verified no existing tests for stub labels in max-build.md

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - No new libraries; pure documentation edits
- Architecture: HIGH - TDD pattern established in Phase 6, directly applicable
- Pitfalls: HIGH - All gaps documented in audit with exact line numbers; verified by reading actual files

**Research date:** 2026-03-10
**Valid until:** No expiry -- documentation-only changes with no external dependencies
