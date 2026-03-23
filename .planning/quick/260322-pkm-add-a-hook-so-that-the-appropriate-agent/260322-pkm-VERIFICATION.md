---
phase: quick-260322-pkm
verified: 2026-03-22T02:00:00Z
status: passed
score: 4/4 must-haves verified
---

# Quick Task 260322-pkm: finalize_patch() Hook Verification Report

**Task Goal:** Add a hook so that the appropriate agent or agents clean up all patches and subpatches at the end of a max-build and max-iterate slash command. Any time you make an edit to a max patch there should be a check to make sure that the objects are clearly and logically laid out and the patch chords are tidy and segmented around all objects.
**Verified:** 2026-03-22T02:00:00Z
**Status:** passed
**Re-verification:** No -- initial verification

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | Every /max-build run produces a patch with apply_layout applied to all patchers and subpatchers | VERIFIED | `finalize_patch(is_new=True)` calls `apply_layout(patcher)` which handles subpatcher recursion; test `test_new_patch_recurses_into_subpatchers` confirms inner patcher boxes get laid out |
| 2 | Every /max-iterate run produces a patch with layout cleanup (midpoint regeneration, overlap resolution) applied to all patchers and subpatchers | VERIFIED | `finalize_patch(is_new=False)` calls `_finalize_midpoints_recursive` which recurses into all nested subpatchers; test `test_edit_patch_generates_midpoints_for_offset_cables` confirms midpoints generated |
| 3 | All agent SKILL.md files reference finalize_patch instead of manual layout/styling/comment steps | VERIFIED | 6 agent SKILL.md files and shared-capabilities.md all contain `finalize_patch` in Output Protocols; grep confirms zero instances of "never apply_layout on loaded patches" |
| 4 | finalize_patch handles both new-patch and edit-patch flows with a single call | VERIFIED | Dual-mode function at `src/maxpat/hooks.py:27`; all 5 TestFinalizePatch tests pass (new layout, edit position preservation, midpoint generation, subpatcher recursion, importability) |

**Score:** 4/4 truths verified

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `src/maxpat/hooks.py` | finalize_patch() function | VERIFIED | Function at line 27; exports `finalize_patch` and `_finalize_midpoints_recursive`; imports `apply_auto_styling`, `apply_layout`, `_generate_midpoints` correctly |
| `src/maxpat/__init__.py` | Re-export of finalize_patch | VERIFIED | Imported at line 37 from hooks; listed in `__all__` at line 131 |
| `src/maxpat/aesthetics.py` | apply_auto_styling() and _AUTO_HIGHLIGHT (moved here to avoid circular imports) | VERIFIED | `_AUTO_HIGHLIGHT` at line 95, `apply_auto_styling` at line 102; backward compat alias `_apply_auto_styling = apply_auto_styling` kept in `__init__.py` at line 76 |
| `tests/test_hooks.py` | 5 TestFinalizePatch tests covering both flows, subpatcher recursion, midpoints, importability | VERIFIED | 5 tests in TestFinalizePatch class; all 19 tests in file pass |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `.claude/skills/max-patch-agent/SKILL.md` | `src/maxpat/hooks.py` | Output Protocol references finalize_patch() | WIRED | Lines 86 (new) and 96 (edit) in Output Protocols |
| `.claude/skills/max-dsp-agent/SKILL.md` | `src/maxpat/hooks.py` | Output Protocol references finalize_patch() | WIRED | Lines 110 (new) and 120 (edit) in Output Protocols |
| `.claude/skills/max-ui-agent/SKILL.md` | `src/maxpat/hooks.py` | Output Protocol references finalize_patch() | WIRED | Line 100 (edit protocol); new patches use apply_layout via finalize_patch |
| `.claude/skills/max-js-agent/SKILL.md` | `src/maxpat/hooks.py` | Edit Output Protocol references finalize_patch() | WIRED | Line 82 (edit protocol) |
| `.claude/skills/max-ext-agent/SKILL.md` | `src/maxpat/hooks.py` | Edit Output Protocol references finalize_patch() | WIRED | Line 82 (edit protocol) |
| `.claude/skills/max-rnbo-agent/SKILL.md` | `src/maxpat/hooks.py` | Edit Output Protocol references finalize_patch() | WIRED | Line 77 (edit protocol) |
| `.claude/skills/references/shared-capabilities.md` | `src/maxpat/hooks.py` | Patch Finalization section documents finalize_patch | WIRED | Lines 16-17 document API and import path |
| `src/maxpat/hooks.py` | `src/maxpat/layout.py` | finalize_patch calls apply_layout and _generate_midpoints | WIRED | Lines 43-44 import both; line 47 calls apply_layout, line 51 calls _generate_midpoints via recursive helper |

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|------------|-------------|--------|----------|
| QUICK-PKM | 260322-pkm-PLAN.md | Add finalize_patch() hook for end-of-command layout cleanup | SATISFIED | Hook implemented, exported, all agent SKILLs updated, tests pass |

### Anti-Patterns Found

None found. No placeholder returns, no empty implementations, no TODO stubs in modified files.

Note: The pre-existing test failure `test_patch_agent_references_max_objects` in `tests/test_agent_skills.py` was present before this task (acknowledged in SUMMARY) and is unrelated to this work. The test checks for `"max/"` literal in patch agent SKILL.md -- the SKILL.md content is correct but uses `ObjectDatabase` API docs rather than a raw path reference. Not a regression introduced by this task.

### Human Verification Required

None. All observable behaviors are verifiable programmatically. The test suite covers both flows with real Patcher instances.

### Gaps Summary

No gaps. All four must-have truths are fully verified:

1. `finalize_patch()` is substantively implemented in `src/maxpat/hooks.py` with proper dual-mode behavior -- not a stub.
2. Both flows (new/edit) are tested with real Patcher instances and pass.
3. All 6 agent SKILL.md files plus shared-capabilities.md reference `finalize_patch` in their Output Protocols.
4. The circular import issue was correctly resolved by moving `_apply_auto_styling` to `aesthetics.py` with backward-compat alias preserved.

---

_Verified: 2026-03-22T02:00:00Z_
_Verifier: Claude (gsd-verifier)_
