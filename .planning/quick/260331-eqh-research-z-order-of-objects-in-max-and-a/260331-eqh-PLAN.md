---
phase: quick-260331-eqh
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/patcher.py
  - tests/test_aesthetics.py
  - CLAUDE.md
  - .claude/skills/references/shared-capabilities.md
autonomous: true
requirements: [ZORDER-API, ZORDER-DOCS]

must_haves:
  truths:
    - "Patcher has bring_to_front(box) that moves a box to the end of the boxes array (renders on top)"
    - "Patcher has send_to_back(box) that moves a box to index 0 (renders behind everything)"
    - "Patcher has set_z_index(box, index) for explicit positioning in the boxes array"
    - "CLAUDE.md documents z-order semantics and the ignoreclick overlay pattern"
    - "Agent skill docs reference z-order rules for overlay readouts"
  artifacts:
    - path: "src/maxpat/patcher.py"
      provides: "bring_to_front, send_to_back, set_z_index methods on Patcher"
    - path: "tests/test_aesthetics.py"
      provides: "Unit tests for z-order manipulation methods"
    - path: "CLAUDE.md"
      provides: "Rule #6: Z-Order section documenting array-order rendering and overlay pattern"
    - path: ".claude/skills/references/shared-capabilities.md"
      provides: "Z-Order Manipulation section for agent reference"
  key_links:
    - from: "src/maxpat/patcher.py"
      to: "tests/test_aesthetics.py"
      via: "bring_to_front/send_to_back/set_z_index tested"
      pattern: "bring_to_front|send_to_back|set_z_index"
    - from: "CLAUDE.md"
      to: ".claude/skills/references/shared-capabilities.md"
      via: "Rule #6 referenced by shared capabilities"
      pattern: "z.order"
---

<objective>
Add z-order manipulation API to Patcher and document z-order semantics across the framework.

Purpose: The gen-eq patch demonstrates a common pattern -- flonum readouts overlaid on dials with ignoreclick=1 -- but there is no API to control z-order after boxes are added, and no documentation explaining how z-order works in .maxpat files. Agents building overlay UIs currently have to manually manage insertion order or get it wrong.

Output: Three z-order methods on Patcher, tests, CLAUDE.md rule, and agent skill documentation.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@CLAUDE.md
@src/maxpat/patcher.py (lines 432-490 for Patcher class and add_box; lines 614-680 for add_panel z-order pattern)
@src/maxpat/defaults.py
@tests/test_aesthetics.py (lines 371-385 for existing z-order tests)
@.claude/skills/references/shared-capabilities.md

<interfaces>
<!-- Existing z-order patterns in patcher.py -->

From src/maxpat/patcher.py:
```python
class Patcher:
    boxes: list[Box]  # Z-order = array order. Later = on top.

    def add_box(self, name, args, x, y) -> Box:
        self.boxes.append(box)  # Appends to end = renders on top

    def add_panel(self, x, y, width, height, gradient=True) -> Box:
        self.boxes.insert(0, panel)  # Inserts at 0 = renders behind everything

    def add_step_marker(self, number, x, y) -> Box:
        self.boxes.insert(0, marker)  # Same background insertion
```
</interfaces>
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Add z-order manipulation methods to Patcher and tests</name>
  <files>src/maxpat/patcher.py, tests/test_aesthetics.py</files>
  <behavior>
    - bring_to_front(box) moves box to end of self.boxes (last rendered = on top)
    - bring_to_front(box) with box not in self.boxes raises ValueError
    - send_to_back(box) moves box to index 0 (first rendered = behind everything)
    - send_to_back(box) with box not in self.boxes raises ValueError
    - set_z_index(box, 0) is equivalent to send_to_back
    - set_z_index(box, -1) places box at the end (like bring_to_front)
    - set_z_index(box, index) with box not in self.boxes raises ValueError
    - set_z_index(box, index) with index out of range clamps to valid range
    - All three methods preserve box identity (same Box object, just moved)
    - All three methods preserve other boxes' relative order
  </behavior>
  <action>
    Add three methods to the Patcher class in patcher.py, placed after `add_step_marker` (around line 730):

    ```python
    def bring_to_front(self, box: Box) -> None:
        """Move box to end of boxes array (renders on top of all other objects).

        In .maxpat files, z-order is implicit: objects later in the boxes array
        render on top of earlier ones. This moves the box to the last position.

        Args:
            box: Box to bring to front.

        Raises:
            ValueError: If box is not in this patcher.
        """
        try:
            self.boxes.remove(box)
        except ValueError:
            raise ValueError(f"Box {box.id!r} not in this patcher")
        self.boxes.append(box)

    def send_to_back(self, box: Box) -> None:
        """Move box to index 0 in boxes array (renders behind all other objects).

        In .maxpat files, z-order is implicit: objects earlier in the boxes array
        render behind later ones. This moves the box to the first position.

        Args:
            box: Box to send to back.

        Raises:
            ValueError: If box is not in this patcher.
        """
        try:
            self.boxes.remove(box)
        except ValueError:
            raise ValueError(f"Box {box.id!r} not in this patcher")
        self.boxes.insert(0, box)

    def set_z_index(self, box: Box, index: int) -> None:
        """Move box to a specific position in the boxes array for z-order control.

        Index 0 = behind everything (same as send_to_back).
        Index -1 or len(boxes) = on top of everything (same as bring_to_front).
        Out-of-range indices are clamped to valid range.

        Args:
            box: Box to reposition.
            index: Target index in boxes array.

        Raises:
            ValueError: If box is not in this patcher.
        """
        try:
            self.boxes.remove(box)
        except ValueError:
            raise ValueError(f"Box {box.id!r} not in this patcher")
        # Clamp index to valid range after removal
        max_idx = len(self.boxes)
        if index < 0:
            index = max(0, max_idx + 1 + index)
        index = min(index, max_idx)
        self.boxes.insert(index, box)
    ```

    Then add tests in tests/test_aesthetics.py in a new `TestZOrder` class after the existing `TestStepMarkers` class:

    ```python
    class TestZOrder:
        """Tests for z-order manipulation methods."""

        def test_bring_to_front(self):
            p = Patcher()
            a = p.add_box("cycle~", ["440"])
            b = p.add_box("dac~")
            c = p.add_box("*~", ["0.5"])
            p.bring_to_front(a)
            assert p.boxes[-1] is a
            assert p.boxes[0] is b
            assert p.boxes[1] is c

        def test_bring_to_front_not_found(self):
            p = Patcher()
            p2 = Patcher()
            orphan = p2.add_box("cycle~", ["440"])
            with pytest.raises(ValueError):
                p.bring_to_front(orphan)

        def test_send_to_back(self):
            p = Patcher()
            a = p.add_box("cycle~", ["440"])
            b = p.add_box("dac~")
            c = p.add_box("*~", ["0.5"])
            p.send_to_back(c)
            assert p.boxes[0] is c
            assert p.boxes[1] is a
            assert p.boxes[2] is b

        def test_send_to_back_not_found(self):
            p = Patcher()
            p2 = Patcher()
            orphan = p2.add_box("cycle~", ["440"])
            with pytest.raises(ValueError):
                p.send_to_back(orphan)

        def test_set_z_index_zero(self):
            p = Patcher()
            a = p.add_box("cycle~", ["440"])
            b = p.add_box("dac~")
            p.set_z_index(b, 0)
            assert p.boxes[0] is b
            assert p.boxes[1] is a

        def test_set_z_index_negative_one(self):
            p = Patcher()
            a = p.add_box("cycle~", ["440"])
            b = p.add_box("dac~")
            c = p.add_box("*~", ["0.5"])
            p.set_z_index(a, -1)
            assert p.boxes[-1] is a

        def test_set_z_index_clamps_high(self):
            p = Patcher()
            a = p.add_box("cycle~", ["440"])
            b = p.add_box("dac~")
            p.set_z_index(a, 999)
            assert p.boxes[-1] is a

        def test_set_z_index_not_found(self):
            p = Patcher()
            p2 = Patcher()
            orphan = p2.add_box("cycle~", ["440"])
            with pytest.raises(ValueError):
                p.set_z_index(orphan, 0)

        def test_set_z_index_middle(self):
            p = Patcher()
            a = p.add_box("cycle~", ["440"])
            b = p.add_box("dac~")
            c = p.add_box("*~", ["0.5"])
            d = p.add_box("number")
            p.set_z_index(d, 1)
            assert p.boxes[0] is a
            assert p.boxes[1] is d
            assert p.boxes[2] is b
            assert p.boxes[3] is c

        def test_bring_to_front_preserves_identity(self):
            p = Patcher()
            a = p.add_box("cycle~", ["440"])
            original_id = id(a)
            p.bring_to_front(a)
            assert id(p.boxes[-1]) == original_id
    ```
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -m pytest tests/test_aesthetics.py::TestZOrder -x -v</automated>
  </verify>
  <done>All 10 z-order tests pass. bring_to_front, send_to_back, set_z_index methods exist on Patcher with ValueError on missing box and index clamping.</done>
</task>

<task type="auto">
  <name>Task 2: Document z-order in CLAUDE.md and shared agent capabilities</name>
  <files>CLAUDE.md, .claude/skills/references/shared-capabilities.md</files>
  <action>
    **CLAUDE.md -- Add Rule #6: Z-Order after Rule #5 (No Generator Scripts), before the Domain-Specific Rules section (before line 92):**

    ```markdown
    ### Rule #6: Z-Order Awareness

    In `.maxpat` files, z-order is implicit: objects render in the order they appear in the `boxes` array. Later objects render on top of earlier ones.

    - Background elements (panels, step markers): use `add_panel()` / `add_step_marker()` which auto-insert at index 0
    - Overlay readouts (flonum on top of dial): add the readout AFTER the dial, or use `bring_to_front(readout)` to move it on top
    - Overlay readouts must set `ignoreclick=1` so mouse events pass through to the interactive control underneath
    - Use `bring_to_front(box)`, `send_to_back(box)`, or `set_z_index(box, index)` for explicit z-order control

    The overlay readout pattern (from gen-eq):
    1. Create the interactive control (e.g., `dial`)
    2. Create the readout display (e.g., `flonum`) -- added later = renders on top
    3. Set `ignoreclick=1` on the readout so the dial remains interactive
    4. Position the readout overlapping the dial (same or overlapping coordinates)
    ```

    **shared-capabilities.md -- Add a "Z-Order Manipulation" section after the "Patch Finalization" section (after the finalize_patch bullet, before Aesthetic Capabilities):**

    ```markdown
    ## Z-Order Manipulation

    In `.maxpat` files, z-order = boxes array order. Later in array = renders on top.

    **Patcher methods:**
    - `patcher.bring_to_front(box)` -- move box to end of array (renders on top)
    - `patcher.send_to_back(box)` -- move box to index 0 (renders behind everything)
    - `patcher.set_z_index(box, index)` -- place box at specific array position

    **Overlay readout pattern** (flonum/number displayed on top of dial/slider):
    1. Create the interactive control (dial, slider, etc.)
    2. Create the readout (flonum, number) -- it naturally renders on top since it was added later
    3. Set `extra_attrs["ignoreclick"] = 1` on the readout so mouse events pass through to the control
    4. Position readout overlapping the control
    5. If readout was created before the control, call `patcher.bring_to_front(readout)` to fix z-order

    **Background elements** (panels, markers) are handled automatically -- `add_panel()` and `add_step_marker()` insert at index 0.
    ```
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && grep -c "Rule #6: Z-Order" CLAUDE.md && grep -c "Z-Order Manipulation" .claude/skills/references/shared-capabilities.md</automated>
  </verify>
  <done>CLAUDE.md has Rule #6 documenting z-order semantics and overlay pattern. shared-capabilities.md has Z-Order Manipulation section with API and overlay readout recipe. Both reference ignoreclick=1 for overlay readouts.</done>
</task>

</tasks>

<verification>
1. `python3 -m pytest tests/test_aesthetics.py -x -v` -- all existing tests still pass plus new TestZOrder tests
2. `grep "bring_to_front\|send_to_back\|set_z_index" src/maxpat/patcher.py` -- all three methods present
3. `grep "Rule #6" CLAUDE.md` -- z-order rule documented
4. `grep "Z-Order Manipulation" .claude/skills/references/shared-capabilities.md` -- agent docs updated
</verification>

<success_criteria>
- Three z-order methods (bring_to_front, send_to_back, set_z_index) on Patcher class with proper error handling
- 10 unit tests covering normal use, error cases, clamping, and identity preservation
- CLAUDE.md Rule #6 explains z-order semantics and the overlay readout pattern with ignoreclick
- Agent shared capabilities reference the z-order API and overlay recipe
- All existing tests continue to pass
</success_criteria>

<output>
After completion, create `.planning/quick/260331-eqh-research-z-order-of-objects-in-max-and-a/260331-eqh-SUMMARY.md`
</output>
