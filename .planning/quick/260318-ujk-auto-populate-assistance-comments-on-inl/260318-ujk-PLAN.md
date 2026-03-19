---
phase: quick-260318-ujk
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/patcher.py
  - tests/test_patcher.py
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-dsp-agent/SKILL.md
autonomous: true
requirements: [QUICK-UJK]

must_haves:
  truths:
    - "inlet/outlet objects in add_subpatcher accept optional comment descriptions"
    - "populate_assistance_comments() auto-infers comments from downstream/upstream connections for empty comment attributes"
    - "Agent skill files instruct agents to always provide assistance comments on inlets/outlets"
  artifacts:
    - path: "src/maxpat/patcher.py"
      provides: "add_subpatcher with inlet_comments/outlet_comments params, populate_assistance_comments method"
    - path: "tests/test_patcher.py"
      provides: "Tests for assistance comment population"
    - path: ".claude/skills/max-patch-agent/SKILL.md"
      provides: "Updated skill instructions for assistance comments"
    - path: ".claude/skills/max-dsp-agent/SKILL.md"
      provides: "Updated skill instructions for assistance comments"
  key_links:
    - from: "src/maxpat/patcher.py::add_subpatcher"
      to: "Box.extra_attrs['comment']"
      via: "inlet_comments/outlet_comments param mapped to extra_attrs"
      pattern: "extra_attrs\\[.comment.\\]"
    - from: "src/maxpat/patcher.py::populate_assistance_comments"
      to: "inner patcher inlet/outlet boxes"
      via: "walks boxes, checks connections, infers descriptions"
      pattern: "populate_assistance_comments"
---

<objective>
Auto-populate assistance comments on inlet/outlet objects in subpatchers and abstractions.

Purpose: When inlet or outlet objects are used inside subpatchers, their "comment" JSON attribute should contain descriptive text that appears on mouseover in MAX. Currently these are set to empty strings. This change adds two mechanisms: (1) explicit comments via parameters, and (2) auto-inference from connection context.

Output: Updated patcher.py with enhanced add_subpatcher and new populate_assistance_comments method, tests, and updated agent skill files.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@src/maxpat/patcher.py (lines 1315-1389: add_subpatcher, lines 214-316: Box class, lines 424-425: extra_attrs serialization)
@tests/test_patcher.py (lines 378-459: existing subpatcher tests)
@.claude/skills/max-patch-agent/SKILL.md
@.claude/skills/max-dsp-agent/SKILL.md

<interfaces>
<!-- Key types and contracts the executor needs. -->

From src/maxpat/patcher.py:
```python
class Box:
    extra_attrs: dict[str, Any]  # serialized via d.update(self.extra_attrs) in to_dict()
    name: str  # e.g. "inlet", "outlet", "inlet~", "outlet~"
    _inner_patcher: Patcher | None

class Patcher:
    boxes: list[Box]
    lines: list[Patchline]

    def add_subpatcher(self, name, inlets=1, outlets=1, x=0.0, y=0.0) -> tuple[Box, Patcher]
    def add_box(self, name, args=None, x=0.0, y=0.0) -> Box
    def add_connection(self, src_box, src_outlet, dst_box, dst_inlet) -> Patchline

class Patchline:
    source_id: str
    source_outlet: int
    dest_id: str
    dest_inlet: int
```

Current add_subpatcher inlet/outlet creation (lines 1344-1353):
```python
for i in range(inlets):
    inlet_box = inner.add_box("inlet", x=50.0 + i * inlet_spacing, y=30.0)
    inlet_box.extra_attrs["comment"] = ""

for i in range(outlets):
    outlet_box = inner.add_box("outlet", x=50.0 + i * inlet_spacing, y=250.0)
    outlet_box.extra_attrs["comment"] = ""
```

Comment attribute in .maxpat JSON (from mixer-strip.maxpat):
```json
{
    "comment": "Audio Input Left",
    "id": "obj-1",
    "index": 1,
    "maxclass": "inlet",
    ...
}
```
</interfaces>
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Add inlet/outlet comment parameters to add_subpatcher and auto-inference method</name>
  <files>src/maxpat/patcher.py, tests/test_patcher.py</files>
  <behavior>
    - Test: add_subpatcher with inlet_comments=["Audio In", "MIDI In"] sets those comments on inner inlet boxes
    - Test: add_subpatcher with outlet_comments=["Audio Out"] sets that comment on inner outlet box
    - Test: add_subpatcher without comment params still sets empty string (backward compatible)
    - Test: add_subpatcher with fewer comments than inlets -- extra inlets get empty string
    - Test: populate_assistance_comments() infers comment from first downstream object for inlet (e.g., inlet connected to cycle~ gets "signal to cycle~")
    - Test: populate_assistance_comments() infers comment from first upstream object for outlet (e.g., outlet receiving from *~ gets "signal from *~")
    - Test: populate_assistance_comments() skips inlet/outlet objects that already have non-empty comments
    - Test: populate_assistance_comments() handles inlet/outlet with no connections (sets "inlet N" / "outlet N")
    - Test: populate_assistance_comments() recurses into nested subpatchers
  </behavior>
  <action>
1. In `add_subpatcher()` (line 1315), add two optional parameters:
   - `inlet_comments: list[str] | None = None`
   - `outlet_comments: list[str] | None = None`

2. In the inlet creation loop (line 1346-1348), change to:
   ```python
   for i in range(inlets):
       inlet_box = inner.add_box("inlet", x=50.0 + i * inlet_spacing, y=30.0)
       comment = ""
       if inlet_comments and i < len(inlet_comments):
           comment = inlet_comments[i]
       inlet_box.extra_attrs["comment"] = comment
   ```

3. Same pattern for outlet creation loop (line 1350-1353).

4. Add a new `Patcher` method `populate_assistance_comments()` that:
   - Walks all boxes in the patcher looking for boxes with `_inner_patcher` set
   - For each inner patcher, finds all inlet/outlet/inlet~/outlet~ boxes
   - For each such box with `extra_attrs.get("comment", "") == ""`:
     - For inlets: looks at the inner patcher's patchlines to find what the inlet connects to downstream. Takes the first connected object's `name` (plus args if short). Generates comment like "signal to cycle~ 440" or "data to route foo bar".
     - For outlets: looks at inner patcher's patchlines to find what connects upstream to the outlet. Generates comment like "signal from *~ 0.5" or "data from pack 0 0".
     - If no connections found, uses positional fallback: "inlet 1", "outlet 2", etc.
   - Recurses into nested subpatchers (inner patchers that themselves contain inner patchers)
   - Returns self for chaining

5. The inference logic should be concise: for an inlet box, find patchlines where source_id == inlet_box.id, resolve the dest_id to a box, use that box's text (truncated to 40 chars). For outlet, find patchlines where dest_id == outlet_box.id, resolve source_id. Use "signal" prefix if the inlet/outlet name ends with ~, otherwise use generic description.

6. Write tests in a new `TestAssistanceComments` class in test_patcher.py, placed after the existing `TestSubpatcher` class (around line 459). Tests should cover all behaviors listed above.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_patcher.py -x -k "assistance" -v</automated>
  </verify>
  <done>
    - add_subpatcher accepts inlet_comments/outlet_comments params
    - populate_assistance_comments() auto-infers from connections
    - All 9+ tests pass
    - Backward compatible (no comments param = empty string, same as before)
  </done>
</task>

<task type="auto">
  <name>Task 2: Update agent skill files with assistance comment instructions</name>
  <files>.claude/skills/max-patch-agent/SKILL.md, .claude/skills/max-dsp-agent/SKILL.md</files>
  <action>
1. In `.claude/skills/max-patch-agent/SKILL.md`, add a new subsection under "### Pattern Application" (after "Comment objects on non-obvious connections", around line 77):

   ```markdown
   ### Assistance Comments on Inlets/Outlets
   - When calling `add_subpatcher()`, ALWAYS provide `inlet_comments` and `outlet_comments` with descriptive labels
   - Example: `p.add_subpatcher("audio_proc", inlets=2, outlets=1, inlet_comments=["Audio Input Left", "Audio Input Right"], outlet_comments=["Processed Output"])`
   - If you forget or cannot determine comments at creation time, call `patcher.populate_assistance_comments()` after building all connections -- it auto-infers from connection context
   - Comments appear as mouseover tooltips in MAX when hovering over the parent object's inlets/outlets
   ```

2. In `.claude/skills/max-dsp-agent/SKILL.md`, add similar instructions in the appropriate capabilities section. Read the file first to find the right location (likely after signal chain construction instructions).

3. Also update the `add_subpatcher` entry in the "### Key Functions" list in max-patch-agent/SKILL.md (line 46) to mention the new parameters:
   - `Patcher.add_subpatcher(name, inlets, outlets, inlet_comments, outlet_comments)` -- add a subpatcher with labeled I/O
   - `Patcher.populate_assistance_comments()` -- auto-fill empty inlet/outlet comments from connection context
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && grep -c "assistance" .claude/skills/max-patch-agent/SKILL.md .claude/skills/max-dsp-agent/SKILL.md</automated>
  </verify>
  <done>
    - max-patch-agent SKILL.md documents inlet_comments/outlet_comments params and populate_assistance_comments()
    - max-dsp-agent SKILL.md includes matching instructions
    - Agents are instructed to always provide descriptive comments
  </done>
</task>

</tasks>

<verification>
1. All existing patcher tests still pass: `python -m pytest tests/test_patcher.py -x -v`
2. New assistance comment tests pass: `python -m pytest tests/test_patcher.py -x -k "assistance" -v`
3. Full test suite clean: `python -m pytest tests/ -x --timeout=60`
</verification>

<success_criteria>
- add_subpatcher() accepts optional inlet_comments/outlet_comments parameters
- populate_assistance_comments() method exists on Patcher and auto-infers from connections
- Existing tests unbroken (backward compatible)
- New tests cover explicit comments, auto-inference, empty connections, recursion
- Agent skill files instruct agents to use the new functionality
</success_criteria>

<output>
After completion, create `.planning/quick/260318-ujk-auto-populate-assistance-comments-on-inl/260318-ujk-SUMMARY.md`
</output>
