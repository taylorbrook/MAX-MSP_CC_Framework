---
phase: quick-260322-fee
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/skills/references/shared-capabilities.md
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-dsp-agent/SKILL.md
  - .claude/skills/max-rnbo-agent/SKILL.md
  - .claude/skills/max-js-agent/SKILL.md
  - .claude/skills/max-ext-agent/SKILL.md
  - .claude/skills/max-ui-agent/SKILL.md
  - tests/test_agent_skills.py
autonomous: true
requirements: [DEDUP-01]

must_haves:
  truths:
    - "Shared content blocks exist in one canonical location"
    - "Each SKILL.md references the shared file instead of duplicating content"
    - "No agent loses any capability information after deduplication"
    - "All existing tests pass (updated to account for shared reference)"
  artifacts:
    - path: ".claude/skills/references/shared-capabilities.md"
      provides: "Canonical source for Aesthetic Capabilities, Layout Options, Editing Functions, Edit Workflow, Assistance Comments blocks"
      min_lines: 50
    - path: ".claude/skills/max-patch-agent/SKILL.md"
      provides: "Patch agent with reference directive replacing duplicated blocks"
    - path: "tests/test_agent_skills.py"
      provides: "Updated tests that validate shared content via the reference file"
  key_links:
    - from: "each specialist SKILL.md"
      to: ".claude/skills/references/shared-capabilities.md"
      via: "reference directive comment"
      pattern: "See.*shared-capabilities\\.md"
---

<objective>
Extract ~53 lines of content duplicated across 6 specialist agent SKILL.md files into a single shared reference file, replacing inline duplication with reference directives.

Purpose: Reduce maintenance burden -- currently any change to Aesthetic Capabilities, Layout Options, Editing Functions, Edit Workflow, or Assistance Comments must be replicated across 6 files. Single-source-of-truth eliminates drift risk.

Output: `.claude/skills/references/shared-capabilities.md` + 6 updated SKILL.md files + updated tests.
</objective>

<execution_context>
@~/.claude/get-shit-done/workflows/execute-plan.md
@~/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md
@tests/test_agent_skills.py
@.claude/skills/max-patch-agent/SKILL.md
@.claude/skills/max-dsp-agent/SKILL.md
@.claude/skills/max-rnbo-agent/SKILL.md
@.claude/skills/max-js-agent/SKILL.md
@.claude/skills/max-ext-agent/SKILL.md
@.claude/skills/max-ui-agent/SKILL.md

<interfaces>
<!-- Tests that must still pass after changes -->
From tests/test_agent_skills.py:
- test_specialist_has_aesthetic_capabilities: checks "Aesthetic Capabilities" in SKILL.md content
- test_specialist_references_patcher_styling_methods: checks "add_section_header" and "add_panel"
- test_specialist_references_aesthetics_helpers: checks "set_canvas_background" and "set_object_bgcolor"
- test_specialist_references_layout_options: checks "LayoutOptions"
- test_specialist_has_editing_section: checks "Editing Existing Patches" or "Editing Functions"
- test_specialist_references_read_patch: checks "read_patch"
- test_specialist_references_find_box: checks "find_box"
- test_specialist_references_modify_box: checks "modify_box"
- test_specialist_references_save_roundtrip: checks "save_patch_roundtrip"

CRITICAL: These tests read each SKILL.md directly and assert specific strings are present.
Since SKILL.md files are prompts (not code with includes), the shared file is loaded
separately by Claude at read time. Tests must be updated to check either SKILL.md OR the
shared reference file for the extracted content.
</interfaces>
</context>

<tasks>

<task type="auto">
  <name>Task 1: Create shared-capabilities.md and update SKILL.md files</name>
  <files>
    .claude/skills/references/shared-capabilities.md
    .claude/skills/max-patch-agent/SKILL.md
    .claude/skills/max-dsp-agent/SKILL.md
    .claude/skills/max-rnbo-agent/SKILL.md
    .claude/skills/max-js-agent/SKILL.md
    .claude/skills/max-ext-agent/SKILL.md
    .claude/skills/max-ui-agent/SKILL.md
  </files>
  <action>
1. Create directory `.claude/skills/references/` (mkdir -p).

2. Create `.claude/skills/references/shared-capabilities.md` containing ALL of the following blocks extracted from the specialist SKILL.md files. Use max-patch-agent as the canonical source since it has the most complete versions:

   **Block 1: Assistance Comments on Inlets/Outlets** (~6 lines)
   - The 5-line block starting "When calling `add_subpatcher()`..." through the "Direct JSON edits" note
   - Present in: patch, dsp, rnbo, ui (NOT js, NOT ext -- they have shorter or no versions)

   **Block 2: Aesthetic Capabilities** (~20 lines)
   - The full section from "Aesthetic auto-styling" through all Patcher methods, Aesthetics helpers, and ending at the last `is_complex_patch` line
   - Present identically in all 6 specialists

   **Block 3: Layout Options** (~8 lines)
   - From "Layout options (`from src.maxpat import LayoutOptions`)" through `comment_gap`
   - Present identically in all 6 specialists

   **Block 4: Editing Functions** (~10 lines)
   - The bullet list from `read_patch(path)` through `save_patch_roundtrip(patcher.to_dict(), path, original_text)`
   - Present identically in all 6 specialists

   **Block 5: Edit Workflow** (~6 lines)
   - The numbered 6-step list: Load, Analyze, Find, Make changes, Validate, Save
   - Present in all 6 specialists (with different domain-specific example object names in step 3-4)

   For Block 5 (Edit Workflow), use generic placeholders for the domain-specific parts:
   - Step 3: `box = patcher.find_box(name="target_object")`
   - Step 4: `result = patcher.modify_box(box, args=["new_value"])`

   The shared file should have a header explaining its purpose and how agents reference it:
   ```
   # Shared Agent Capabilities

   > Referenced by specialist agent SKILL.md files. Load this file alongside SKILL.md for full capability context.
   > Path: `.claude/skills/references/shared-capabilities.md`
   ```

3. In each of the 6 specialist SKILL.md files, replace each duplicated block with a compact reference directive. The directive format:

   ```
   > **[Section Name]:** See `.claude/skills/references/shared-capabilities.md` for full [section name] reference (Aesthetic Capabilities, Layout Options, Editing Functions, Edit Workflow, Assistance Comments).
   ```

   **Per-agent replacements:**

   **max-patch-agent/SKILL.md:**
   - Replace "### Assistance Comments on Inlets/Outlets" block (lines 78-83) with reference directive
   - Replace "### Aesthetic Capabilities" block (lines 85-113) with reference directive
   - Replace "### Editing Functions" block (lines 117-127) with reference directive
   - Replace "### Edit Workflow" block (lines 129-136) with reference directive
   - KEEP the domain focus line: "**Domain focus:** Edit control flow routing, message handling, subpatcher organization."

   **max-dsp-agent/SKILL.md:**
   - Replace "### Assistance Comments on Inlets/Outlets" block (lines 69-74) with reference directive
   - Replace "### Aesthetic Capabilities" block (lines 76-104) with reference directive
   - Replace "### Editing Functions" block (lines 108-118) with reference directive
   - Replace "### Edit Workflow" block (lines 120-128) with reference directive
   - KEEP domain focus line: "**Domain focus:** Edit signal chains, oscillator parameters, filter settings, gen~ codebox content."

   **max-rnbo-agent/SKILL.md:**
   - Replace "### Assistance Comments on Inlets/Outlets" block (lines 26-31) with reference directive
   - Replace "### Aesthetic Capabilities" block (lines 33-61) with reference directive
   - Replace "### Editing Functions" block (lines 98-108) with reference directive
   - Replace "### Edit Workflow" block (lines 110-118) with reference directive
   - KEEP domain focus line

   **max-js-agent/SKILL.md:**
   - Replace "### Aesthetic Capabilities" block (lines 63-91) with reference directive
   - Replace "### Editing Functions" block (lines 95-105) with reference directive
   - Replace "### Edit Workflow" block (lines 107-115) with reference directive
   - NOTE: js-agent does NOT have Assistance Comments block -- do NOT add one
   - KEEP domain focus line

   **max-ext-agent/SKILL.md:**
   - Replace "### Aesthetic Capabilities" block (lines 29-57) with reference directive
   - Replace "### Editing Functions" block (lines 96-106) with reference directive
   - Replace "### Edit Workflow" block (lines 108-116) with reference directive
   - NOTE: ext-agent does NOT have Assistance Comments block -- do NOT add one
   - KEEP domain focus line

   **max-ui-agent/SKILL.md:**
   - Replace "### Assistance Comments on Inlets/Outlets" block (lines 79-84) with reference directive
   - Replace "### Aesthetic Capabilities" block (lines 86-114) with reference directive
   - Replace "### Editing Functions" block (lines 119-128) with reference directive
   - Replace "### Edit Workflow" block (lines 130-138) with reference directive
   - KEEP domain focus line

4. Content coverage verification: After all replacements, confirm that every line removed from a SKILL.md exists in shared-capabilities.md. Do a manual line-by-line check. The only content that should differ are:
   - Edit Workflow step 3/4 example object names (now generic in shared file, domain-specific line removed from SKILL.md)
   - Assistance Comments examples use different subpatcher names per agent (use the patch-agent version as canonical)
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -c "
import pathlib
shared = pathlib.Path('.claude/skills/references/shared-capabilities.md')
assert shared.exists(), 'shared-capabilities.md missing'
content = shared.read_text()
# Verify all key content present in shared file
for term in ['Aesthetic Capabilities', 'add_section_header', 'add_panel', 'set_canvas_background', 'set_object_bgcolor', 'LayoutOptions', 'read_patch', 'find_box', 'modify_box', 'save_patch_roundtrip', 'Assistance Comments', 'populate_assistance_comments']:
    assert term in content, f'{term} missing from shared-capabilities.md'
# Verify each SKILL.md has reference directive
for agent in ['max-patch-agent', 'max-dsp-agent', 'max-rnbo-agent', 'max-js-agent', 'max-ext-agent', 'max-ui-agent']:
    skill = pathlib.Path(f'.claude/skills/{agent}/SKILL.md').read_text()
    assert 'shared-capabilities.md' in skill, f'{agent} missing reference to shared file'
print('All content checks passed')
"
    </automated>
  </verify>
  <done>
    - shared-capabilities.md exists at .claude/skills/references/ with all 5 extracted blocks
    - All 6 specialist SKILL.md files reference the shared file instead of duplicating content
    - Domain-specific content (focus lines, unique sections) preserved in each SKILL.md
    - No capability information lost -- every line from the original blocks exists in the shared file
  </done>
</task>

<task type="auto">
  <name>Task 2: Update tests to validate shared reference pattern</name>
  <files>tests/test_agent_skills.py</files>
  <action>
Update `tests/test_agent_skills.py` to account for the shared reference pattern. The key issue: tests currently check SKILL.md content for strings like `"add_section_header"`, `"LayoutOptions"`, `"read_patch"`, etc. After deduplication, these strings live in the shared reference file, not in individual SKILL.md files.

**Changes needed:**

1. Add a helper function `_read_skill_with_shared(name)` that reads both the agent's SKILL.md AND `.claude/skills/references/shared-capabilities.md`, concatenating them. This represents the full capability context an agent receives.

2. Add a constant for the shared file path:
   ```python
   SHARED_CAPABILITIES = SKILLS_DIR / "references" / "shared-capabilities.md"
   ```

3. Add a new test `test_shared_capabilities_exists()` that verifies the shared file exists.

4. Update these parametrized test functions to use `_read_skill_with_shared()` instead of `_read_skill()`:
   - `test_specialist_has_aesthetic_capabilities` -- check combined content
   - `test_specialist_references_patcher_styling_methods` -- check combined content
   - `test_specialist_references_aesthetics_helpers` -- check combined content
   - `test_specialist_references_layout_options` -- check combined content
   - `test_specialist_has_editing_section` -- check combined content
   - `test_specialist_references_read_patch` -- check combined content
   - `test_specialist_references_find_box` -- check combined content
   - `test_specialist_references_modify_box` -- check combined content
   - `test_specialist_references_save_roundtrip` -- check combined content

5. Add a new test `test_specialist_references_shared_capabilities()` parametrized on SPECIALIST_AGENTS that verifies each SKILL.md contains a reference to `shared-capabilities.md`.

6. Do NOT change any other tests. The frontmatter, domain-specific, critic, lifecycle, router, and boundary tests stay exactly as they are.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_agent_skills.py -x -q 2>&1 | tail -5</automated>
  </verify>
  <done>
    - All existing tests pass (no regressions)
    - New test validates shared-capabilities.md exists
    - New test validates each specialist SKILL.md references the shared file
    - Content-checking tests read combined SKILL.md + shared file for full coverage
  </done>
</task>

</tasks>

<verification>
1. `python -m pytest tests/test_agent_skills.py -x -q` -- all tests pass
2. Manual diff: compare line counts before/after. Each SKILL.md should be shorter. Shared file should be ~55-65 lines.
3. Content coverage: `grep -c 'add_section_header' .claude/skills/*/SKILL.md` should show 0 hits (moved to shared file). `grep -c 'add_section_header' .claude/skills/references/shared-capabilities.md` should show 1 hit.
</verification>

<success_criteria>
- shared-capabilities.md contains all 5 shared blocks with ~55-65 lines of content
- 6 SKILL.md files each reduced by ~30-50 lines
- All 40+ tests in test_agent_skills.py pass
- No agent capability lost (diff coverage verified)
</success_criteria>

<output>
After completion, create `.planning/quick/260322-fee-extract-duplicated-content-blocks-from-a/260322-fee-SUMMARY.md`
</output>
