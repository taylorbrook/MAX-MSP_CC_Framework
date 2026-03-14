---
phase: quick-6
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/__init__.py
  - tests/test_hooks.py
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-dsp-agent/SKILL.md
  - .claude/skills/max-js-agent/SKILL.md
  - .claude/skills/max-ui-agent/SKILL.md
  - .claude/skills/max-ext-agent/SKILL.md
  - .claude/skills/max-rnbo-agent/SKILL.md
autonomous: true
requirements: [QUICK-6]

must_haves:
  truths:
    - "auto_size_panel and is_complex_patch are importable from src.maxpat"
    - "All 7 LayoutOptions fields are documented in every agent SKILL.md that has an Aesthetic Capabilities section"
    - "LayoutOptions import path and defaults are clear in SKILL.md documentation"
  artifacts:
    - path: "src/maxpat/__init__.py"
      provides: "Re-exports of auto_size_panel and is_complex_patch"
      contains: "auto_size_panel"
    - path: "tests/test_hooks.py"
      provides: "Import test covering new re-exports"
      contains: "auto_size_panel"
    - path: ".claude/skills/max-patch-agent/SKILL.md"
      provides: "Complete LayoutOptions field documentation"
      contains: "patcher_padding"
  key_links:
    - from: "src/maxpat/__init__.py"
      to: "src/maxpat/aesthetics.py"
      via: "import re-export"
      pattern: "from src\\.maxpat\\.aesthetics import.*auto_size_panel"
---

<objective>
Add `auto_size_panel` and `is_complex_patch` to the `src.maxpat` public API (`__init__.py` + `__all__`), expand the LayoutOptions documentation in all 6 agent SKILL.md files to cover all 7 fields with defaults, and update the public API import test.

Purpose: Agent SKILL.md files reference `auto_size_panel` and `is_complex_patch` from `src.maxpat.aesthetics` but these are not re-exported from the top-level `src.maxpat` package, creating an inconsistency. The LayoutOptions docs also omit `patcher_padding` and `grid_size` fields.
Output: Updated __init__.py, test, and 6 SKILL.md files.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@src/maxpat/__init__.py
@src/maxpat/aesthetics.py
@src/maxpat/defaults.py
@tests/test_hooks.py
@.claude/skills/max-patch-agent/SKILL.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Re-export auto_size_panel and is_complex_patch in __init__.py</name>
  <files>src/maxpat/__init__.py, tests/test_hooks.py</files>
  <action>
1. In `src/maxpat/__init__.py`, update the aesthetics import line (line 20) from:
   `from src.maxpat.aesthetics import set_canvas_background, set_object_bgcolor`
   to:
   `from src.maxpat.aesthetics import set_canvas_background, set_object_bgcolor, auto_size_panel, is_complex_patch`

2. In the `__all__` list, add `"auto_size_panel"` and `"is_complex_patch"` in the Aesthetics/Layout section. Place them after `"LayoutOptions"` with an `# Aesthetics` comment:
   ```python
   # Aesthetics
   "set_canvas_background",
   "set_object_bgcolor",
   "auto_size_panel",
   "is_complex_patch",
   ```
   Also move `"set_canvas_background"` and `"set_object_bgcolor"` from wherever they currently are NOT in __all__ (they are imported but not in __all__) -- actually check first: they are imported on line 20 but NOT listed in __all__. Add all 4 aesthetics exports to __all__.

3. In `tests/test_hooks.py`, update `test_public_api_importable()` to also import `auto_size_panel` and `is_complex_patch` from `src.maxpat` and add assertions:
   ```python
   from src.maxpat import (
       ...existing imports...,
       auto_size_panel,
       is_complex_patch,
   )
   assert callable(auto_size_panel)
   assert callable(is_complex_patch)
   ```
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_hooks.py::test_public_api_importable -xvs</automated>
  </verify>
  <done>auto_size_panel, is_complex_patch, set_canvas_background, and set_object_bgcolor all importable from src.maxpat and listed in __all__. Test passes.</done>
</task>

<task type="auto">
  <name>Task 2: Expand LayoutOptions documentation in all 6 agent SKILL.md files</name>
  <files>.claude/skills/max-patch-agent/SKILL.md, .claude/skills/max-dsp-agent/SKILL.md, .claude/skills/max-js-agent/SKILL.md, .claude/skills/max-ui-agent/SKILL.md, .claude/skills/max-ext-agent/SKILL.md, .claude/skills/max-rnbo-agent/SKILL.md</files>
  <action>
In each of the 6 SKILL.md files that have an "Aesthetic Capabilities" section, replace the existing 2-line layout_options block:
```
**Layout options:**
- `generate_patch(patcher, layout_options=LayoutOptions(...))` -- customize layout
- Key fields: `v_spacing` (vertical gap), `h_gutter` (horizontal gap), `grid_snap` (15px grid), `inlet_align` (cable straightening), `comment_gap` (annotation offset)
```

With this expanded block that covers ALL 7 fields with defaults:
```
**Layout options (`from src.maxpat import LayoutOptions`):**
- `generate_patch(patcher, layout_options=LayoutOptions(...))` -- customize layout
- `v_spacing` (default 20.0) -- vertical gap between rows in pixels
- `h_gutter` (default 15.0) -- horizontal gap between sibling objects
- `patcher_padding` (default 40.0) -- padding around content for auto-sized patcher rect
- `grid_size` (default 15.0) -- grid cell size in pixels (when grid_snap enabled)
- `grid_snap` (default True) -- snap box positions to grid_size grid
- `inlet_align` (default True) -- adjust child x-position to straighten cables to parent inlets
- `comment_gap` (default 10.0) -- horizontal offset for associated comment placement
```

For max-patch-agent/SKILL.md specifically, also update line 46 from:
`- \`generate_patch(patcher, layout_options=None)\` -- layout + serialize + validate`
to:
`- \`generate_patch(patcher, layout_options=None)\` -- layout + serialize + validate (accepts LayoutOptions)`
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && grep -c "patcher_padding" .claude/skills/*/SKILL.md | grep -v ":0$" | wc -l | xargs test 6 -eq</automated>
  </verify>
  <done>All 6 agent SKILL.md files document all 7 LayoutOptions fields with defaults and import path. No fields omitted.</done>
</task>

</tasks>

<verification>
- `python -m pytest tests/test_hooks.py::test_public_api_importable -xvs` passes
- `python -c "from src.maxpat import auto_size_panel, is_complex_patch; print('OK')"` prints OK
- All 6 SKILL.md files contain `patcher_padding` and `grid_size` in their layout options section
- `python -m pytest tests/ -x --timeout=60` full test suite still passes
</verification>

<success_criteria>
- auto_size_panel and is_complex_patch importable from src.maxpat (top-level package)
- Both functions listed in __all__
- set_canvas_background and set_object_bgcolor also listed in __all__ (currently missing)
- test_public_api_importable updated and passing
- All 6 agent SKILL.md files document all 7 LayoutOptions fields with default values
- LayoutOptions import path documented in SKILL.md
</success_criteria>

<output>
After completion, create `.planning/quick/6-document-layout-options-in-skill-md-file/6-SUMMARY.md`
</output>
