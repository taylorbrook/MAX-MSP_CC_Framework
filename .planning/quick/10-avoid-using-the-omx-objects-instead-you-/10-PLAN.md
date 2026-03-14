---
phase: quick-10
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/skills/max-dsp-agent/SKILL.md
  - patches/performancepatchtest/generate.py
  - patches/performancepatchtest/generated/build_compressor.py
  - examples/performancepatchtest/performancepatchtest.maxpat
  - .planning/phases/12-pipeline-integration-agent-updates/12-RESEARCH.md
autonomous: true
requirements: [QUICK-10]
must_haves:
  truths:
    - "No omx objects appear anywhere in agent documentation or curated object lists"
    - "No omx objects appear in any generator scripts"
    - "DSP agent SKILL.md documents gen~-based compressor and limi~ as dynamics replacements"
    - "The performancepatchtest generate.py uses gen~ compressor instead of omx.comp~"
  artifacts:
    - path: ".claude/skills/max-dsp-agent/SKILL.md"
      provides: "Dynamics line without omx objects, with gen~ compressor and limi~ alternatives"
      contains: "limi~"
    - path: "patches/performancepatchtest/generate.py"
      provides: "Generator script using gen~ compressor instead of omx.comp~"
    - path: "patches/performancepatchtest/generated/build_compressor.py"
      provides: "Compressor builder with no omx references in comments"
  key_links:
    - from: ".claude/skills/max-dsp-agent/SKILL.md"
      to: "gen~ compressor pattern"
      via: "Dynamics section"
      pattern: "gen~.*compressor|limi~"
---

<objective>
Remove all omx object references from the project and replace with gen~-based equivalents or standard MAX alternatives.

Purpose: The omx objects (omx.comp~, omx.peaklim~, omx.4band~, omx.5band~) are Octimax legacy objects. They should not be used -- gen~ can build equivalent compressors/limiters with full control, and limi~ provides a standard peak limiter. This ensures the project recommends and uses portable, transparent DSP building blocks.

Output: Updated SKILL.md, generate.py, build_compressor.py, regenerated example patch, and updated RESEARCH doc -- all omx-free.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md
@.claude/skills/max-dsp-agent/SKILL.md
@patches/performancepatchtest/generate.py
@patches/performancepatchtest/generated/build_compressor.py
</context>

<tasks>

<task type="auto">
  <name>Task 1: Remove omx references from SKILL.md and RESEARCH.md documentation</name>
  <files>.claude/skills/max-dsp-agent/SKILL.md, .planning/phases/12-pipeline-integration-agent-updates/12-RESEARCH.md</files>
  <action>
1. Edit `.claude/skills/max-dsp-agent/SKILL.md` line 52. Replace:
   `- Dynamics: compressor~, limiter~, gate~, omx.comp~, omx.peaklim~`
   with:
   `- Dynamics: limi~ (peak limiter), gate~, deltaclip~ (slew limiter), gen~ (custom compressor/limiter via GenExpr)`

   Note: `compressor~` and `limiter~` are NOT real MAX objects (they do not exist in the object database). Remove them along with omx objects. The actual dynamics objects available in MAX are `limi~`, `gate~`, and `deltaclip~` -- plus gen~ for building custom compressor/limiter DSP.

2. Edit `.planning/phases/12-pipeline-integration-agent-updates/12-RESEARCH.md` line 277. Replace:
   `Dynamics: compressor~, limiter~, gate~, omx.comp~, omx.peaklim~`
   with:
   `Dynamics: limi~ (peak limiter), gate~, deltaclip~ (slew limiter), gen~ (custom compressor/limiter via GenExpr)`
  </action>
  <verify>
    <automated>grep -rn "omx" .claude/skills/ .planning/phases/12-pipeline-integration-agent-updates/12-RESEARCH.md; echo "exit: $?"</automated>
  </verify>
  <done>No omx references in any SKILL.md file or in 12-RESEARCH.md. Dynamics line accurately lists only objects that exist in the database.</done>
</task>

<task type="auto">
  <name>Task 2: Replace omx.comp~ with gen~ compressor in performancepatchtest generator and regenerate</name>
  <files>patches/performancepatchtest/generate.py, patches/performancepatchtest/generated/build_compressor.py, examples/performancepatchtest/performancepatchtest.maxpat</files>
  <action>
The performancepatchtest/generate.py uses `omx.comp~` on lines 125, 132, 135 for a 3-band multiband compressor. The build_compressor.py already has a gen~-based compressor approach (using `gen~ @gen comp-engine.gendsp`). The generate.py needs to match this approach.

1. In `patches/performancepatchtest/generate.py`, replace the three `omx.comp~` usages (lines 125, 132, 135) with `gen~` compressor objects. Since the project already has a gen~ compressor pattern in build_compressor.py (which uses `gen~ @gen comp-engine.gendsp`), use the same pattern:

   Replace each:
   ```python
   comp_lo = ip.add_box("omx.comp~")
   ```
   with a gen~ box created via `Patcher.add_gen()` or `Box.__new__(Box)` bypass (since gen~ with @gen attribute needs structural creation):

   For each of the three bands (comp_lo, comp_mid, comp_hi), create a gen~ object. Since the existing `add_gen()` method embeds a codebox, and we want to reference an external .gendsp file instead, use the `Box.__new__()` bypass pattern:

   ```python
   def make_gen_compressor(patcher):
       """Create a gen~ compressor box referencing comp-engine.gendsp."""
       box = Box.__new__(Box)
       box_id = patcher._gen_id()
       box.name = "gen~"
       box.args = []
       box.id = box_id
       box.maxclass = "newobj"
       box.text = "gen~ @gen comp-engine.gendsp"
       box.numinlets = 1
       box.numoutlets = 1
       box.outlettype = ["signal"]
       from src.maxpat.sizing import calculate_box_size
       w, h = calculate_box_size("gen~ @gen comp-engine.gendsp", "newobj")
       box.patching_rect = [0, 0, w, h]
       from src.maxpat.defaults import FONT_NAME, FONT_SIZE
       box.fontname = FONT_NAME
       box.fontsize = FONT_SIZE
       box.presentation = False
       box.presentation_rect = None
       box.extra_attrs = {}
       box._inner_patcher = None
       box._saved_object_attributes = None
       box._bpatcher_attrs = None
       patcher.boxes.append(box)
       return box
   ```

   Add this helper near `make_sfplay_stereo` at the top, then replace:
   - Line 125: `comp_lo = ip.add_box("omx.comp~")` -> `comp_lo = make_gen_compressor(ip)`
   - Line 132: `comp_mid = ip.add_box("omx.comp~")` -> `comp_mid = make_gen_compressor(ip)`
   - Line 135: `comp_hi = ip.add_box("omx.comp~")` -> `comp_hi = make_gen_compressor(ip)`

2. In `patches/performancepatchtest/generated/build_compressor.py`, update the comments on lines 127-129 and 224 that say "omx.comp~":
   - Line 127: change `# inlet -> omx.comp~` to `# inlet -> gen~ compressor`
   - Line 128: change `# omx.comp~ -> outlet` to `# gen~ compressor -> outlet`
   - Line 129: change `# omx.comp~ -> meter~` to `# gen~ compressor -> meter~`
   - Line 224: change `# Connections: dial -> scale -> prepend -> omx.comp~` to `# Connections: dial -> scale -> prepend -> gen~ compressor`

3. Regenerate the example patch by running:
   ```bash
   cd /Users/taylorbrook/Dev/MAX && python3 patches/performancepatchtest/generate.py
   ```
   Then copy the output to examples:
   ```bash
   cp patches/performancepatchtest/generated/performancepatchtest.maxpat examples/performancepatchtest/performancepatchtest.maxpat
   ```

4. Verify no omx references remain anywhere in the repository (excluding the object database files themselves, audit reports, and .pyc files which are expected to contain them):
   ```bash
   grep -rn "omx" --include="*.py" --include="*.md" --include="*.maxpat" . | grep -v ".claude/max-objects/" | grep -v "__pycache__" | grep -v ".planning/quick/10-"
   ```
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 patches/performancepatchtest/generate.py && grep -rn "omx" --include="*.py" --include="*.md" --include="*.maxpat" . | grep -v ".claude/max-objects/" | grep -v "__pycache__" | grep -v ".planning/quick/10-" | grep -v "SUMMARY"; echo "exit: $?"</automated>
  </verify>
  <done>generate.py uses gen~ compressor instead of omx.comp~. build_compressor.py comments updated. Example patch regenerated. No omx references remain in project code, documentation, or patches (only the object database retains them as reference data).</done>
</task>

</tasks>

<verification>
Run a project-wide search for omx outside the object database:
```bash
grep -rn "omx" --include="*.py" --include="*.md" --include="*.maxpat" . | grep -v ".claude/max-objects/" | grep -v "__pycache__" | grep -v ".planning/quick/10-"
```
Expected: zero results (all omx references removed from active code and docs).

The object database files (.claude/max-objects/msp/objects.json, mc/objects.json, audit/) retain omx entries as reference data -- this is correct. The database documents what MAX supports; the rule is just that the project should not USE or RECOMMEND these objects.
</verification>

<success_criteria>
- Zero omx references in SKILL.md files
- Zero omx references in generator scripts (generate.py, build_compressor.py)
- Zero omx references in generated patches and examples
- DSP agent SKILL.md accurately lists limi~, gate~, deltaclip~, and gen~ as dynamics tools
- performancepatchtest generates successfully with gen~ compressor objects
</success_criteria>

<output>
After completion, create `.planning/quick/10-avoid-using-the-omx-objects-instead-you-/10-SUMMARY.md`
</output>
