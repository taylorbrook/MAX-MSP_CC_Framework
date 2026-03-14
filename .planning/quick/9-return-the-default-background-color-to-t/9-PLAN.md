---
phase: quick-9
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/defaults.py
  - .claude/skills/max-ui-agent/SKILL.md
  - .claude/skills/max-dsp-agent/SKILL.md
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-ext-agent/SKILL.md
  - .claude/skills/max-rnbo-agent/SKILL.md
  - .claude/skills/max-js-agent/SKILL.md
autonomous: true
requirements: []
must_haves:
  truths:
    - "Generated patches open in MAX 9 with the standard dark grey background, not off-white"
    - "All SKILL.md files accurately describe the canvas background color"
  artifacts:
    - path: "src/maxpat/defaults.py"
      provides: "canvas_bg palette entry with standard MAX 9 dark grey"
      contains: "0.333"
  key_links:
    - from: "src/maxpat/defaults.py"
      to: "src/maxpat/aesthetics.py"
      via: "AESTHETIC_PALETTE[\"canvas_bg\"]"
      pattern: "canvas_bg"
---

<objective>
Change the default patcher background color from the custom off-white blue tint back to the standard MAX 9 dark grey.

Purpose: Generated patches should match MAX's native default background color rather than using a custom off-white tint.
Output: Updated palette value and consistent SKILL.md documentation.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@src/maxpat/defaults.py
@src/maxpat/aesthetics.py
@src/maxpat/__init__.py

The `canvas_bg` value in AESTHETIC_PALETTE (defaults.py line 122) is currently `[0.97, 0.97, 0.98, 1.0]` (off-white with blue tint). The standard MAX 9 background color is `[0.333, 0.333, 0.333, 1.0]` (dark grey), verified from a MAX 9 tour patch in the project's own 10-RESEARCH.md (line 233).

The `set_canvas_background()` function in aesthetics.py reads from `AESTHETIC_PALETTE["canvas_bg"]` and applies it to both `editing_bgcolor` and `locked_bgcolor` patcher props. No changes needed there -- it will pick up the new value automatically.

Existing tests in `tests/test_aesthetics.py` and `tests/test_generation.py` compare against `AESTHETIC_PALETTE["canvas_bg"]` dynamically, so they will pass with the new value without modification.
</context>

<tasks>

<task type="auto">
  <name>Task 1: Change canvas_bg palette value to MAX 9 standard dark grey</name>
  <files>src/maxpat/defaults.py</files>
  <action>
In `src/maxpat/defaults.py`, change the `canvas_bg` entry in AESTHETIC_PALETTE (line 122) from:
```python
"canvas_bg": [0.97, 0.97, 0.98, 1.0],             # off-white with blue tint
```
to:
```python
"canvas_bg": [0.333, 0.333, 0.333, 1.0],           # standard MAX 9 dark grey
```

This is the standard MAX 9 patcher background color, verified from a MAX 9 tour patch (documented in `.planning/phases/10-aesthetic-foundations/10-RESEARCH.md` line 233: `editing_bgcolor: [0.333, 0.333, 0.333, 1.0]`).

No other code changes needed -- `set_canvas_background()` in aesthetics.py reads from this palette entry dynamically, and tests compare against the palette value, not hardcoded colors.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_aesthetics.py tests/test_generation.py -x -q 2>&1 | tail -5</automated>
  </verify>
  <done>AESTHETIC_PALETTE["canvas_bg"] is [0.333, 0.333, 0.333, 1.0] and all tests pass</done>
</task>

<task type="auto">
  <name>Task 2: Update SKILL.md files to reflect new background color description</name>
  <files>
    .claude/skills/max-ui-agent/SKILL.md
    .claude/skills/max-dsp-agent/SKILL.md
    .claude/skills/max-patch-agent/SKILL.md
    .claude/skills/max-ext-agent/SKILL.md
    .claude/skills/max-rnbo-agent/SKILL.md
    .claude/skills/max-js-agent/SKILL.md
  </files>
  <action>
In each of these 6 SKILL.md files, find the line:
```
- Canvas background color (off-white with blue tint) applied automatically
```
and change it to:
```
- Canvas background color (standard MAX 9 dark grey) applied automatically
```

Files and line numbers:
- `.claude/skills/max-ui-agent/SKILL.md` line 84
- `.claude/skills/max-dsp-agent/SKILL.md` line 74
- `.claude/skills/max-patch-agent/SKILL.md` line 80
- `.claude/skills/max-ext-agent/SKILL.md` line 32
- `.claude/skills/max-rnbo-agent/SKILL.md` line 29
- `.claude/skills/max-js-agent/SKILL.md` line 68
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && grep -r "off-white" .claude/skills/ && echo "FAIL: still has off-white" || echo "PASS: no off-white references remain"</automated>
  </verify>
  <done>All 6 SKILL.md files describe the background as "standard MAX 9 dark grey" with zero "off-white" references remaining</done>
</task>

</tasks>

<verification>
1. `python -m pytest tests/test_aesthetics.py tests/test_generation.py -x -q` -- all tests pass
2. `grep "canvas_bg" src/maxpat/defaults.py` -- shows 0.333 values
3. `grep -r "off-white" .claude/skills/` -- returns no matches
</verification>

<success_criteria>
- AESTHETIC_PALETTE["canvas_bg"] is [0.333, 0.333, 0.333, 1.0]
- All existing tests pass without modification
- All 6 SKILL.md files updated to say "standard MAX 9 dark grey"
- No remaining references to "off-white with blue tint" in skills documentation
</success_criteria>

<output>
After completion, create `.planning/quick/9-return-the-default-background-color-to-t/9-SUMMARY.md`
</output>
