---
phase: quick-3
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/skills/max-lifecycle/SKILL.md
  - .claude/skills/max-lifecycle/references/test-protocol.md
  - .claude/skills/max-critic/SKILL.md
  - .claude/skills/max-critic/references/critic-protocol.md
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-dsp-agent/SKILL.md
  - .claude/skills/max-router/references/dispatch-rules.md
autonomous: true
requirements: [DOC-SYNC]

must_haves:
  truths:
    - "All SKILL.md and reference files show function signatures matching actual Python source code"
    - "Agents loading these docs get correct parameter names and order for all documented functions"
    - "Router dispatch-rules.md disambiguates ambiguous terms (filter, buffer, delay) explicitly"
  artifacts:
    - path: ".claude/skills/max-lifecycle/SKILL.md"
      provides: "Correct save_test_results and generate_test_checklist signatures"
      contains: "save_test_results(project_dir, test_name, results_md)"
    - path: ".claude/skills/max-lifecycle/references/test-protocol.md"
      provides: "Correct save_test_results usage example"
      contains: "save_test_results(project_dir=, test_name=, results_md=)"
    - path: ".claude/skills/max-critic/SKILL.md"
      provides: "Full review_patch signature with ext_code and ext_archetype"
      contains: "ext_code"
    - path: ".claude/skills/max-critic/references/critic-protocol.md"
      provides: "All four critic modules documented"
      contains: "RNBO critic"
    - path: ".claude/skills/max-patch-agent/SKILL.md"
      provides: "add_comment, add_message, add_node_script, add_js in Key Functions"
      contains: "add_comment"
    - path: ".claude/skills/max-dsp-agent/SKILL.md"
      provides: "write_gendsp in Key Functions or Output Protocol"
      contains: "write_gendsp"
    - path: ".claude/skills/max-router/references/dispatch-rules.md"
      provides: "Explicit disambiguation rows for filter, buffer, delay"
      contains: "filter (data)"
  key_links: []
---

<objective>
Fix API signature documentation mismatches and missing function documentation across 7 agent SKILL.md and reference files. Every documented function signature must exactly match the actual Python source code.

Purpose: Agents load these SKILL.md and reference files as their context. Wrong signatures cause agents to generate broken Python calls. Missing function docs mean agents don't know capabilities exist.

Output: 7 updated documentation files with correct signatures, complete function lists, and disambiguation rules.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Fix function signatures in lifecycle and critic docs</name>
  <files>
    .claude/skills/max-lifecycle/SKILL.md
    .claude/skills/max-lifecycle/references/test-protocol.md
    .claude/skills/max-critic/SKILL.md
    .claude/skills/max-critic/references/critic-protocol.md
  </files>
  <action>
Fix 4 files with signature mismatches:

**1. `.claude/skills/max-lifecycle/SKILL.md`:**
- Line 56: Change `generate_test_checklist(patch_dict, name, path)` to `generate_test_checklist(patch_dict, patch_name, patch_path="")` — parameter names must match source (`patch_name` not `name`, `patch_path` not `path`, default value `""` on patch_path).
- Line 57: Change `save_test_results(results, project_dir)` to `save_test_results(project_dir, test_name, results_md)` — parameter order is completely different from source, and `test_name` parameter is missing entirely.

**2. `.claude/skills/max-lifecycle/references/test-protocol.md`:**
- Lines 63-66: The usage example shows wrong signature. Replace:
  ```python
  save_test_results(
      results="[completed checklist markdown with Pass/Fail marked]",
      project_dir=Path("patches/my-synth")
  )
  ```
  With:
  ```python
  save_test_results(
      project_dir=Path("patches/my-synth"),
      test_name="my-synth",
      results_md="[completed checklist markdown with Pass/Fail marked]"
  )
  ```
- Note: The `generate_test_checklist` example on lines 12-16 is already correct -- do NOT change it.

**3. `.claude/skills/max-critic/SKILL.md`:**
- Line 25: Change `review_patch(patch_dict, code_context)` to `review_patch(patch_dict, code_context=None, ext_code=None, ext_archetype="message")` — the full signature includes optional external code review params.
- Add a brief note that the RNBO critic auto-invokes when rnbo~ boxes are detected, and the external critic invokes when ext_code is provided.

**4. `.claude/skills/max-critic/references/critic-protocol.md`:**
- Line 19: Currently says "This invokes both the DSP critic (`review_dsp`) and the structure critic (`review_structure`)." — Update to: "This invokes the DSP critic (`review_dsp`), structure critic (`review_structure`), and conditionally the RNBO critic (`review_rnbo`, when rnbo~ boxes detected) and external critic (`review_external`, when `ext_code` provided)."
- Update the Step 2 code example to show the full signature:
  ```python
  results = review_patch(patch_dict, code_context=code_context, ext_code=ext_code, ext_archetype=ext_archetype)
  ```
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -c "
# Verify signatures in docs match source
import re

# Check lifecycle SKILL.md
with open('.claude/skills/max-lifecycle/SKILL.md') as f:
    content = f.read()
assert 'save_test_results(project_dir, test_name, results_md)' in content, 'lifecycle SKILL: save_test_results wrong'
assert 'patch_name' in content and 'patch_path' in content, 'lifecycle SKILL: generate_test_checklist params wrong'

# Check test-protocol.md
with open('.claude/skills/max-lifecycle/references/test-protocol.md') as f:
    content = f.read()
assert 'test_name=' in content, 'test-protocol: missing test_name param'
assert 'results_md=' in content, 'test-protocol: missing results_md param'

# Check critic SKILL.md
with open('.claude/skills/max-critic/SKILL.md') as f:
    content = f.read()
assert 'ext_code' in content, 'critic SKILL: missing ext_code param'
assert 'ext_archetype' in content, 'critic SKILL: missing ext_archetype param'

# Check critic-protocol.md
with open('.claude/skills/max-critic/references/critic-protocol.md') as f:
    content = f.read()
assert 'review_rnbo' in content, 'critic-protocol: missing RNBO critic'
assert 'review_external' in content, 'critic-protocol: missing external critic'

print('All signature checks passed')
"</automated>
  </verify>
  <done>
All 4 files have function signatures exactly matching their Python source definitions. save_test_results shows (project_dir, test_name, results_md). generate_test_checklist shows (patch_dict, patch_name, patch_path=""). review_patch shows full signature with ext_code and ext_archetype. Critic protocol documents all 4 critic modules.
  </done>
</task>

<task type="auto">
  <name>Task 2: Add missing functions to patch-agent and dsp-agent SKILL.md</name>
  <files>
    .claude/skills/max-patch-agent/SKILL.md
    .claude/skills/max-dsp-agent/SKILL.md
  </files>
  <action>
Add undocumented functions that agents need to know about:

**1. `.claude/skills/max-patch-agent/SKILL.md`:**
In the "### Key Functions" section (after line 47, the `write_patch` entry), add these 4 functions that exist in `src/maxpat/patcher.py`:
```
- `Patcher.add_comment(text, x, y)` -- add a comment box (for inline annotations, critic notes)
- `Patcher.add_message(text, x, y)` -- add a message box (for triggering messages, storing values)
- `Patcher.add_node_script(filename, code, num_outlets, x, y)` -- add a node.script box for Node for Max (returns tuple of Box and code string)
- `Patcher.add_js(filename, code, num_inlets, num_outlets, x, y)` -- add a js object box for V8 JavaScript (returns tuple of Box and code string)
```
Note: `code` param is optional (`str | None = None`) for both add_node_script and add_js. `num_outlets` defaults to 2 for add_node_script. `num_inlets` defaults to 1 and `num_outlets` defaults to 1 for add_js. Include the defaults in the docs.

**2. `.claude/skills/max-dsp-agent/SKILL.md`:**
In the "## Output Protocol" section, step 7 (line 78) already references `write_gendsp()` but it is NOT listed in the Capabilities section. Add it to the "### GenExpr Code Generation" capabilities subsection (after line 38, the `generate_gendsp` entry):
```
- `write_gendsp(code, path, num_inputs=None, num_outputs=None)` -- generate and write a .gendsp file to disk (from `src.maxpat.hooks`)
```
Also add `write_gendsp` to the import hint. Currently `generate_gendsp` is listed but its import source is implicit. Add a note that `write_gendsp` is imported from `src.maxpat.hooks` (not from `src.maxpat.patcher`).
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -c "
# Verify new functions documented
with open('.claude/skills/max-patch-agent/SKILL.md') as f:
    content = f.read()
for fn in ['add_comment', 'add_message', 'add_node_script', 'add_js']:
    assert fn in content, f'patch-agent SKILL: missing {fn}'

with open('.claude/skills/max-dsp-agent/SKILL.md') as f:
    content = f.read()
assert 'write_gendsp' in content, 'dsp-agent SKILL: missing write_gendsp'
assert 'num_inputs' in content, 'dsp-agent SKILL: write_gendsp missing params'

print('All missing function checks passed')
"</automated>
  </verify>
  <done>
Patch agent SKILL.md lists add_comment, add_message, add_node_script, and add_js with correct signatures and defaults. DSP agent SKILL.md lists write_gendsp with correct signature and import source.
  </done>
</task>

<task type="auto">
  <name>Task 3: Add disambiguation rows to router dispatch-rules.md</name>
  <files>
    .claude/skills/max-router/references/dispatch-rules.md
  </files>
  <action>
In `.claude/skills/max-router/references/dispatch-rules.md`, add 3 explicit disambiguation rows to the "### Edge Cases" table (starting at line 96).

Add these rows to the existing table:

| "filter the data" | js or Patch | js | Data filtering = JavaScript array ops, not audio |
| "audio filter" / "lowpass filter" | DSP | DSP | Audio filtering = signal processing (biquad~, onepole~, svf~) |
| "buffer management" / "load samples into buffer~" | DSP | DSP | buffer~ is MSP domain, sample playback/recording |
| "buffer data" / "buffer array" | js or Patch | js/Patch | Data buffering = storing/queuing values, not audio buffers |
| "gen~ buffer" / "Buffer operator" | DSP | DSP | Gen~ Buffer/Data operators for sample access inside gen~ |
| "delay messages" / "delayed bang" | Patch | Patch | Control-rate delay = delay/pipe objects |
| "delay effect" / "audio delay" | DSP | DSP | Signal delay = tapin~/tapout~ or gen~ Delay operator |

Also add a brief paragraph before the Edge Cases table heading explaining:
"Some terms are ambiguous between data/control operations and audio/signal operations. The table below includes explicit disambiguation for common cases. When the user's description is still ambiguous after checking these rules, prefer the DSP interpretation if the project context includes audio objects, otherwise prefer the data/control interpretation."
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -c "
with open('.claude/skills/max-router/references/dispatch-rules.md') as f:
    content = f.read()
# Check disambiguation rows exist
assert 'filter the data' in content or 'Data filtering' in content, 'missing filter disambiguation'
assert 'buffer management' in content or 'buffer~' in content.split('Edge Cases')[1] if 'Edge Cases' in content else False, 'missing buffer disambiguation'
assert 'delay messages' in content or 'delayed bang' in content, 'missing delay disambiguation'
assert 'audio filter' in content or 'lowpass filter' in content, 'missing audio filter row'
print('All disambiguation checks passed')
"</automated>
  </verify>
  <done>
Router dispatch-rules.md edge case table includes explicit disambiguation rows for filter (data vs audio), buffer (MSP vs Gen vs data), and delay (control vs signal). Ambiguous terms have clear routing guidance.
  </done>
</task>

</tasks>

<verification>
Run all 3 task verification scripts in sequence. Additionally, confirm no accidental content was removed by checking file line counts are >= original:
```bash
cd /Users/taylorbrook/Dev/MAX
wc -l .claude/skills/max-lifecycle/SKILL.md .claude/skills/max-lifecycle/references/test-protocol.md .claude/skills/max-critic/SKILL.md .claude/skills/max-critic/references/critic-protocol.md .claude/skills/max-patch-agent/SKILL.md .claude/skills/max-dsp-agent/SKILL.md .claude/skills/max-router/references/dispatch-rules.md
```
All files should have equal or more lines than before edits.
</verification>

<success_criteria>
1. Every documented function signature exactly matches its Python source definition
2. No function that exists in source code is missing from the relevant SKILL.md Key Functions list
3. All 4 critic modules (DSP, structure, RNBO, external) are documented in critic-protocol.md
4. Router dispatch-rules.md explicitly disambiguates filter, buffer, and delay terms
5. All 3 automated verification scripts pass
</success_criteria>

<output>
After completion, create `.planning/quick/3-fix-api-signature-documentation-mismatch/3-SUMMARY.md`
</output>
