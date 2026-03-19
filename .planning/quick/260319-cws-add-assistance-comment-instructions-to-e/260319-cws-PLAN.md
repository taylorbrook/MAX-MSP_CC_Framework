---
phase: quick-260319-cws
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-dsp-agent/SKILL.md
  - .claude/skills/max-rnbo-agent/SKILL.md
  - .claude/skills/max-ui-agent/SKILL.md
autonomous: true
requirements: [QUICK-CWS]

must_haves:
  truths:
    - "All agent edit protocols call populate_assistance_comments() before save"
    - "All agent SKILL.md files instruct agents to include comment attributes in direct JSON edits"
  artifacts:
    - path: ".claude/skills/max-patch-agent/SKILL.md"
      provides: "Updated edit protocol with populate_assistance_comments step"
      contains: "populate_assistance_comments"
    - path: ".claude/skills/max-dsp-agent/SKILL.md"
      provides: "Updated edit protocol with populate_assistance_comments step"
      contains: "populate_assistance_comments"
    - path: ".claude/skills/max-rnbo-agent/SKILL.md"
      provides: "Updated edit protocol with populate_assistance_comments step"
      contains: "populate_assistance_comments"
    - path: ".claude/skills/max-ui-agent/SKILL.md"
      provides: "Updated edit protocol with populate_assistance_comments step"
      contains: "populate_assistance_comments"
  key_links:
    - from: "Output Protocol (Edited Patches)"
      to: "populate_assistance_comments()"
      via: "Step inserted between validate and save"
      pattern: "populate_assistance_comments.*save_patch_roundtrip"
---

<objective>
Add populate_assistance_comments() to the Edited Patches output protocol in all agent SKILL.md files, and add a direct-JSON-edit instruction about manually including "comment" attributes on inlet/outlet boxes.

Purpose: The previous quick task (260318-ujk) added the populate_assistance_comments() method and documented it for new patch creation, but the Edited Patches protocol in all agents still lacks this step. When agents edit existing patches via /max-iterate, assistance comments are not auto-populated, leaving inlet/outlet tooltips empty.

Output: Four updated SKILL.md files with complete edit protocols.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@.claude/skills/max-patch-agent/SKILL.md
@.claude/skills/max-dsp-agent/SKILL.md
@.claude/skills/max-rnbo-agent/SKILL.md
@.claude/skills/max-ui-agent/SKILL.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Add populate_assistance_comments to edit protocols in max-patch-agent and max-dsp-agent</name>
  <files>.claude/skills/max-patch-agent/SKILL.md, .claude/skills/max-dsp-agent/SKILL.md</files>
  <action>
In both max-patch-agent/SKILL.md and max-dsp-agent/SKILL.md, update the "Output Protocol (Edited Patches)" section to insert a new step between "Validate" and "Return for critic review". The updated protocol should read:

```
## Output Protocol (Edited Patches)

1. Load and analyze existing patch via `read_patch()` and `patcher.analyze()`
2. Make surgical edits or section rebuild using find/modify/replace/insert/remove
3. Run `patcher.populate_assistance_comments()` to auto-fill any empty inlet/outlet comments from connection context
4. Validate via `validate_patch(patcher)`
5. Return for critic review
6. Save via `save_patch_roundtrip()` -- never `apply_layout()` on loaded patches
```

The key change: step 3 is new, calling populate_assistance_comments() AFTER edits are made but BEFORE validation. Steps 3-5 from the old protocol shift to 4-6.

Additionally, add a "Direct JSON Edit Rule" note at the bottom of the "Assistance Comments on Inlets/Outlets" section in BOTH files (this section already exists from 260318-ujk). Append this paragraph:

```
**Direct JSON edits:** When editing .maxpat JSON directly (not via the Python API), you MUST manually include a `"comment"` attribute on any inlet or outlet box dictionary being added or modified. Example: `{"maxclass": "inlet", "comment": "Audio Input Left", ...}`. The auto-populate method only works via the Patcher API, so direct JSON manipulation requires explicit comment attributes.
```

Do NOT modify any other sections of these files.
  </action>
  <verify>
    <automated>grep -n "populate_assistance_comments" .claude/skills/max-patch-agent/SKILL.md .claude/skills/max-dsp-agent/SKILL.md | grep -c "Output Protocol\|Edited Patches\|auto-fill\|Direct JSON"</automated>
  </verify>
  <done>Both max-patch-agent and max-dsp-agent SKILL.md files have populate_assistance_comments() in the Edited Patches protocol (step 3) and a Direct JSON Edit Rule in the Assistance Comments section</done>
</task>

<task type="auto">
  <name>Task 2: Add assistance comment instructions to max-rnbo-agent and max-ui-agent</name>
  <files>.claude/skills/max-rnbo-agent/SKILL.md, .claude/skills/max-ui-agent/SKILL.md</files>
  <action>
These two agents have the same "Output Protocol (Edited Patches)" pattern but were NOT updated in the 260318-ujk task, so they lack both the Assistance Comments section AND the populate_assistance_comments() call in the edit protocol.

**For both max-rnbo-agent/SKILL.md and max-ui-agent/SKILL.md:**

1. Update "Output Protocol (Edited Patches)" to insert populate_assistance_comments step between edits and validation:

```
## Output Protocol (Edited Patches)

1. Load and analyze existing patch via `read_patch()` and `patcher.analyze()`
2. Make surgical edits or section rebuild using find/modify/replace/insert/remove
3. Run `patcher.populate_assistance_comments()` to auto-fill any empty inlet/outlet comments from connection context
4. Validate via `validate_patch(patcher)`
5. Return for critic review
6. Save via `save_patch_roundtrip()` -- never `apply_layout()` on loaded patches
```

2. Add a new "Assistance Comments on Inlets/Outlets" section. Place it just before the "Aesthetic Capabilities" section (matching the placement in max-patch-agent and max-dsp-agent). Content:

For max-rnbo-agent:
```
### Assistance Comments on Inlets/Outlets
- When calling `add_subpatcher()`, ALWAYS provide `inlet_comments` and `outlet_comments` with descriptive labels
- Example: `p.add_subpatcher("rnbo_io", inlets=2, outlets=2, inlet_comments=["Audio In L", "Audio In R"], outlet_comments=["Audio Out L", "Audio Out R"])`
- If you forget or cannot determine comments at creation time, call `patcher.populate_assistance_comments()` after building all connections -- it auto-infers from connection context
- Comments appear as mouseover tooltips in MAX when hovering over the parent object's inlets/outlets
- **Direct JSON edits:** When editing .maxpat JSON directly (not via the Python API), you MUST manually include a `"comment"` attribute on any inlet or outlet box dictionary being added or modified. Example: `{"maxclass": "inlet", "comment": "Audio Input Left", ...}`. The auto-populate method only works via the Patcher API, so direct JSON manipulation requires explicit comment attributes.
```

For max-ui-agent:
```
### Assistance Comments on Inlets/Outlets
- When calling `add_subpatcher()`, ALWAYS provide `inlet_comments` and `outlet_comments` with descriptive labels
- Example: `p.add_subpatcher("ui_panel", inlets=3, outlets=1, inlet_comments=["Value", "Min", "Max"], outlet_comments=["Formatted Output"])`
- If you forget or cannot determine comments at creation time, call `patcher.populate_assistance_comments()` after building all connections -- it auto-infers from connection context
- Comments appear as mouseover tooltips in MAX when hovering over the parent object's inlets/outlets
- **Direct JSON edits:** When editing .maxpat JSON directly (not via the Python API), you MUST manually include a `"comment"` attribute on any inlet or outlet box dictionary being added or modified. Example: `{"maxclass": "inlet", "comment": "Control Value", ...}`. The auto-populate method only works via the Patcher API, so direct JSON manipulation requires explicit comment attributes.
```

Do NOT modify any other sections of these files.
  </action>
  <verify>
    <automated>grep -c "populate_assistance_comments" .claude/skills/max-rnbo-agent/SKILL.md .claude/skills/max-ui-agent/SKILL.md && grep -c "Direct JSON edits" .claude/skills/max-rnbo-agent/SKILL.md .claude/skills/max-ui-agent/SKILL.md</automated>
  </verify>
  <done>Both max-rnbo-agent and max-ui-agent SKILL.md files have a new Assistance Comments section, populate_assistance_comments() in the Edited Patches protocol, and Direct JSON Edit Rule</done>
</task>

</tasks>

<verification>
All four agent SKILL.md files should:
1. Have `populate_assistance_comments()` as step 3 in "Output Protocol (Edited Patches)"
2. Have an "Assistance Comments on Inlets/Outlets" section with Direct JSON edit instructions
3. No other sections modified

```bash
for f in .claude/skills/max-{patch,dsp,rnbo,ui}-agent/SKILL.md; do
  echo "=== $f ==="
  grep -c "populate_assistance_comments" "$f"
  grep -c "Direct JSON edits" "$f"
done
```
</verification>

<success_criteria>
- All 4 agent SKILL.md files have populate_assistance_comments() in the Edited Patches protocol
- All 4 agent SKILL.md files have the Direct JSON Edit Rule in the Assistance Comments section
- No unrelated changes to any SKILL.md files
</success_criteria>

<output>
After completion, create `.planning/quick/260319-cws-add-assistance-comment-instructions-to-e/260319-cws-SUMMARY.md`
</output>
