---
phase: quick-260322-pkm
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/hooks.py
  - src/maxpat/__init__.py
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-dsp-agent/SKILL.md
  - .claude/skills/max-ui-agent/SKILL.md
  - .claude/skills/max-js-agent/SKILL.md
  - .claude/skills/max-ext-agent/SKILL.md
  - .claude/skills/max-rnbo-agent/SKILL.md
  - .claude/skills/max-critic/SKILL.md
  - .claude/skills/references/shared-capabilities.md
  - tests/test_hooks.py
autonomous: true
requirements: [QUICK-PKM]

must_haves:
  truths:
    - "Every /max-build run produces a patch with apply_layout applied to all patchers and subpatchers"
    - "Every /max-iterate run produces a patch with layout cleanup (midpoint regeneration, overlap resolution) applied to all patchers and subpatchers"
    - "All agent SKILL.md files reference finalize_patch instead of manual layout/styling/comment steps"
    - "finalize_patch handles both new-patch and edit-patch flows with a single call"
  artifacts:
    - path: "src/maxpat/hooks.py"
      provides: "finalize_patch() function"
      exports: ["finalize_patch"]
    - path: "src/maxpat/__init__.py"
      provides: "Re-export of finalize_patch"
      contains: "finalize_patch"
  key_links:
    - from: ".claude/skills/max-patch-agent/SKILL.md"
      to: "src/maxpat/hooks.py"
      via: "Output Protocol references finalize_patch()"
      pattern: "finalize_patch"
    - from: ".claude/skills/max-dsp-agent/SKILL.md"
      to: "src/maxpat/hooks.py"
      via: "Output Protocol references finalize_patch()"
      pattern: "finalize_patch"
    - from: "src/maxpat/hooks.py"
      to: "src/maxpat/layout.py"
      via: "finalize_patch calls apply_layout and _generate_midpoints"
      pattern: "apply_layout|_generate_midpoints"
---

<objective>
Add a `finalize_patch()` hook function that all agents call at the end of /max-build and /max-iterate to ensure layout cleanup, midpoint generation, and assistance comment population on every patch and its subpatches.

Purpose: Currently agents manually call `apply_layout()` for new patches and explicitly skip it for edits, leaving edited patches with messy layout and missing cable midpoints. A single hook centralizes this so no agent can skip cleanup.

Output: `finalize_patch(patcher, is_new=True)` function in hooks.py, updated agent SKILL.md Output Protocols, test coverage.
</objective>

<execution_context>
@~/.claude/get-shit-done/workflows/execute-plan.md
@~/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@CLAUDE.md
@src/maxpat/hooks.py
@src/maxpat/__init__.py
@src/maxpat/layout.py
@.claude/skills/max-patch-agent/SKILL.md
@.claude/skills/max-dsp-agent/SKILL.md
@.claude/skills/max-ui-agent/SKILL.md
@.claude/skills/max-critic/SKILL.md
@.claude/skills/references/shared-capabilities.md
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Create finalize_patch() hook and export it</name>
  <files>src/maxpat/hooks.py, src/maxpat/__init__.py, tests/test_hooks.py</files>
  <behavior>
    - Test 1: finalize_patch(patcher, is_new=True) calls apply_layout, _apply_auto_styling, and populate_assistance_comments -- boxes get repositioned with top-to-bottom flow
    - Test 2: finalize_patch(patcher, is_new=False) calls _generate_midpoints and populate_assistance_comments but does NOT call _apply_auto_styling or full apply_layout repositioning -- existing box positions are preserved, only midpoints are added/refreshed
    - Test 3: finalize_patch with is_new=False on a patch with offset cables produces midpoints on those cables
    - Test 4: finalize_patch recurses into subpatchers for both new and edit flows
    - Test 5: finalize_patch is importable from src.maxpat (re-exported in __init__.py)
  </behavior>
  <action>
    1. Add `finalize_patch(patcher, is_new=True)` to `src/maxpat/hooks.py`:
       - When `is_new=True`: call `_apply_auto_styling(patcher)` (import from `src.maxpat`), then `apply_layout(patcher)` (which already handles midpoints, subpatcher recursion, and presentation layout). Then call `patcher.populate_assistance_comments()`.
       - When `is_new=False` (edit flow): call `patcher.populate_assistance_comments()`. Then for the patcher and each nested subpatcher recursively, clear existing midpoints and regenerate them by calling `_generate_midpoints(patcher)` from `src.maxpat.layout`. This ensures edited patches get clean cable routing without destroying user-placed object positions.
       - Import `_generate_midpoints` from `src.maxpat.layout` (it's module-private but same package).
       - Import `apply_layout` from `src.maxpat.layout`.
       - Import `_apply_auto_styling` from `src.maxpat` is circular -- instead, inline the auto-styling logic or import `set_canvas_background` and `set_object_bgcolor` from `src.maxpat.aesthetics` directly, with the same `_AUTO_HIGHLIGHT` dict from `__init__.py`. Better: move `_apply_auto_styling` into `hooks.py` or `aesthetics.py` to avoid circular imports, and have `__init__.py` import it from there.

    2. To avoid circular imports, move `_apply_auto_styling` and `_AUTO_HIGHLIGHT` from `src/maxpat/__init__.py` into `src/maxpat/aesthetics.py` as a public function `apply_auto_styling(patcher)`. Update `__init__.py` to import and re-export it (keeping backward compat with the underscore name as an alias). Then `hooks.py` imports from `aesthetics` directly.

    3. Add `finalize_patch` to `src/maxpat/__init__.py` re-exports and `__all__`.

    4. Write tests in `tests/test_hooks.py`:
       - Build a simple 3-box linear chain (cycle~ -> *~ -> ezdac~), call finalize_patch(p, is_new=True), assert boxes have top-to-bottom y positions and midpoints exist where needed.
       - Build same chain, manually set positions, call finalize_patch(p, is_new=False), assert original x/y positions are preserved but midpoints are generated for any offset cables.
       - Build a patch with a subpatcher containing objects, call finalize_patch(p, is_new=True), verify subpatcher boxes also got laid out.
       - Test importability: `from src.maxpat import finalize_patch`.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_hooks.py -x -v 2>&1 | tail -30</automated>
  </verify>
  <done>finalize_patch() exists in hooks.py, is re-exported from src.maxpat, handles both is_new=True and is_new=False flows, tests pass</done>
</task>

<task type="auto">
  <name>Task 2: Update all agent SKILL.md Output Protocols to use finalize_patch()</name>
  <files>.claude/skills/max-patch-agent/SKILL.md, .claude/skills/max-dsp-agent/SKILL.md, .claude/skills/max-ui-agent/SKILL.md, .claude/skills/max-js-agent/SKILL.md, .claude/skills/max-ext-agent/SKILL.md, .claude/skills/max-rnbo-agent/SKILL.md, .claude/skills/max-critic/SKILL.md, .claude/skills/references/shared-capabilities.md</files>
  <action>
    Update Output Protocol sections in all agent SKILL.md files:

    **For "Output Protocol (New Patches)" in max-patch-agent, max-dsp-agent, max-ui-agent:**
    - Replace the manual steps "Apply styling and layout: `_apply_auto_styling(patcher)`, `apply_layout(patcher)`" with a single step: "Finalize patch: `finalize_patch(patcher, is_new=True)` -- applies styling, layout, assistance comments, and midpoint generation for all patchers and subpatchers"
    - Keep the serialize/validate/critic/save steps unchanged

    **For "Output Protocol (Edited Patches)" in ALL agents (max-patch-agent, max-dsp-agent, max-ui-agent, max-js-agent, max-ext-agent, max-rnbo-agent):**
    - Replace the "never `apply_layout()` on loaded patches" instruction with: "Finalize patch: `finalize_patch(patcher, is_new=False)` -- regenerates cable midpoints and populates assistance comments without repositioning existing objects"
    - Remove the separate `patcher.populate_assistance_comments()` step since finalize_patch handles it
    - Keep validate/critic/save steps unchanged

    **In shared-capabilities.md:**
    - Add `finalize_patch` to the documented API: `finalize_patch(patcher, is_new=True)` -- single-call layout cleanup hook. For new patches (`is_new=True`): applies auto-styling, layout, assistance comments, midpoints. For edited patches (`is_new=False`): regenerates midpoints and populates assistance comments without moving objects.

    **In max-patch-agent SKILL.md Key Functions list:**
    - Add `finalize_patch(patcher, is_new=True)` with description: "Single-call layout cleanup -- styling, layout, comments, midpoints (new); midpoints + comments (edit)"

    **In max-dsp-agent and max-ui-agent Capabilities sections:**
    - Add `finalize_patch` reference where `apply_layout` is currently listed
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && grep -l "finalize_patch" .claude/skills/max-patch-agent/SKILL.md .claude/skills/max-dsp-agent/SKILL.md .claude/skills/max-ui-agent/SKILL.md .claude/skills/max-js-agent/SKILL.md .claude/skills/max-ext-agent/SKILL.md .claude/skills/max-rnbo-agent/SKILL.md .claude/skills/references/shared-capabilities.md && echo "---" && grep -c "never.*apply_layout" .claude/skills/*/SKILL.md .claude/skills/references/*.md; echo "Expected: all 0 counts"</automated>
  </verify>
  <done>All 7 agent/reference files mention finalize_patch in their Output Protocols. Zero files contain the "never apply_layout on loaded patches" instruction. The edit protocol for every agent calls finalize_patch(patcher, is_new=False).</done>
</task>

<task type="auto">
  <name>Task 3: Verify existing tests still pass with refactored _apply_auto_styling</name>
  <files></files>
  <action>
    Run the full test suite to ensure:
    1. Moving `_apply_auto_styling` to aesthetics.py and re-exporting from `__init__.py` doesn't break any existing imports
    2. The layout tests still pass (no behavioral change to apply_layout itself)
    3. The agent skill tests still pass (they verify SKILL.md content patterns)

    If any tests fail due to the refactor (e.g., tests that import `_apply_auto_styling` directly from `src.maxpat`), fix the import path in those tests.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/ -x -v 2>&1 | tail -40</automated>
  </verify>
  <done>Full test suite passes with zero failures. _apply_auto_styling is importable from both src.maxpat (backward compat) and src.maxpat.aesthetics (new canonical location).</done>
</task>

</tasks>

<verification>
1. `python -m pytest tests/test_hooks.py -x -v` -- finalize_patch tests pass
2. `python -m pytest tests/ -x -v` -- full suite passes
3. `grep -r "finalize_patch" .claude/skills/` -- present in all agent Output Protocols
4. `grep -r "never.*apply_layout" .claude/skills/` -- returns no matches
5. `python -c "from src.maxpat import finalize_patch; print('OK')"` -- importable
</verification>

<success_criteria>
- finalize_patch(patcher, is_new=True) applies full styling + layout + comments + midpoints
- finalize_patch(patcher, is_new=False) regenerates midpoints + comments without repositioning
- All agent SKILL.md Output Protocols (both New and Edited) reference finalize_patch
- No SKILL.md contains "never apply_layout on loaded patches"
- Full test suite passes
</success_criteria>

<output>
After completion, create `.planning/quick/260322-pkm-add-a-hook-so-that-the-appropriate-agent/260322-pkm-SUMMARY.md`
</output>
