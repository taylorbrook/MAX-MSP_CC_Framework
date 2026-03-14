---
phase: quick-11
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/incremental.py
  - src/maxpat/patcher.py
  - src/maxpat/__init__.py
  - patches/performancepatchtest/generate.py
  - tests/test_incremental.py
autonomous: true
requirements: [QUICK-11]

must_haves:
  truths:
    - "Running generate.py twice produces the same .maxpat output (idempotent)"
    - "User-added objects in the .maxpat are preserved after regeneration"
    - "User-modified positions/attributes on generator-owned objects are overwritten by regeneration"
    - "Objects removed from generate.py are removed from the .maxpat on next run"
    - "A manifest sidecar JSON tracks which box IDs and connections the generator owns"
  artifacts:
    - path: "src/maxpat/incremental.py"
      provides: "Manifest read/write, load_existing_patch, merge_patch logic"
      exports: ["Manifest", "load_existing_patch", "merge_and_write"]
    - path: "src/maxpat/patcher.py"
      provides: "Patcher.from_dict() class method for loading existing patches"
      contains: "def from_dict"
    - path: "tests/test_incremental.py"
      provides: "Tests for incremental patching: idempotency, preservation, removal"
      min_lines: 80
    - path: "patches/performancepatchtest/generate.py"
      provides: "Updated proof-of-concept using incremental patching"
      contains: "merge_and_write"
  key_links:
    - from: "src/maxpat/incremental.py"
      to: "src/maxpat/patcher.py"
      via: "Patcher.from_dict() to reconstruct Patcher from loaded JSON"
      pattern: "Patcher\\.from_dict"
    - from: "patches/performancepatchtest/generate.py"
      to: "src/maxpat/incremental.py"
      via: "merge_and_write() called at end of generate script"
      pattern: "merge_and_write"
    - from: "src/maxpat/incremental.py"
      to: "manifest sidecar .json"
      via: "Manifest class reads/writes JSON sidecar next to .maxpat"
      pattern: "manifest"
---

<objective>
Implement incremental patching so that generate.py scripts merge changes into existing .maxpat files instead of overwriting them.

Purpose: Allow users to manually add objects, reposition things, and tweak attributes in MAX, then re-run the generator without losing those changes. Only generator-owned objects (tracked via a manifest sidecar) are updated/added/removed.

Output: New `src/maxpat/incremental.py` module, updated `Patcher` with `from_dict()`, updated `generate.py` proof of concept, and tests.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@src/maxpat/patcher.py
@src/maxpat/__init__.py
@src/maxpat/hooks.py
@patches/performancepatchtest/generate.py
@tests/test_patcher.py

<interfaces>
<!-- Key types and contracts the executor needs -->

From src/maxpat/patcher.py:
```python
class Patchline:
    def __init__(self, source_id, source_outlet, dest_id, dest_inlet, order=0, hidden=False, midpoints=None)
    def to_dict(self) -> dict[str, Any]  # returns {"patchline": {...}}

class Box:
    def __init__(self, name, args=None, box_id="obj-0", db=None, x=0.0, y=0.0)
    def to_dict(self) -> dict[str, Any]  # returns {"box": {...}}

class Patcher:
    def __init__(self, db=None, is_subpatcher=False)
    boxes: list[Box]
    lines: list[Patchline]
    props: dict  # copy of DEFAULT_PATCHER_PROPS
    _next_id: int
    def _gen_id(self) -> str  # "obj-N"
    def add_box(self, name, args=None, x=0.0, y=0.0) -> Box
    def add_connection(self, src_box, src_outlet, dst_box, dst_inlet, ...) -> Patchline
    def to_dict(self) -> dict[str, Any]  # returns {"patcher": {...}}
```

From src/maxpat/hooks.py:
```python
def write_patch(patcher, path, validate=True, layout_options=None) -> list[ValidationResult]
```

From src/maxpat/__init__.py:
```python
# Public API re-exports Patcher, Box, Patchline, write_patch, generate_patch, etc.
```
</interfaces>
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Implement incremental patching infrastructure</name>
  <files>src/maxpat/incremental.py, src/maxpat/patcher.py, src/maxpat/__init__.py, tests/test_incremental.py</files>
  <behavior>
    - Test: Manifest.save() writes JSON with box_ids list and connections list to sidecar path
    - Test: Manifest.load() reads sidecar JSON back; returns empty manifest if file missing
    - Test: Manifest sidecar path is derived from .maxpat path (same dir, same stem + ".manifest.json")
    - Test: load_existing_patch() reads a .maxpat JSON file and returns the raw dict (or None if file missing)
    - Test: merge_patch() with no existing file produces identical output to write_patch (fresh generation)
    - Test: merge_patch() preserves non-manifest boxes from existing patch (user-added objects)
    - Test: merge_patch() removes boxes that were in old manifest but not in new patcher (deleted from generator)
    - Test: merge_patch() overwrites boxes that share IDs between old manifest and new patcher (updated objects)
    - Test: merge_patch() preserves non-manifest connections from existing patch
    - Test: merge_patch() is idempotent (running twice produces same output)
  </behavior>
  <action>
    1. Add `Patcher.from_dict(cls, data, db=None)` classmethod to `src/maxpat/patcher.py`:
       - Takes a raw .maxpat dict (the full `{"patcher": {...}}` structure)
       - Reconstructs `Patcher` with `boxes` and `lines` populated from the JSON
       - For boxes: create Box instances using `Box.__new__(Box)` bypass (since we are loading, not creating -- no DB validation needed for loaded objects). Set all fields from the JSON dict: `id`, `maxclass`, `name` (derive from text field or maxclass), `text`, `numinlets`, `numoutlets`, `outlettype`, `patching_rect`, `fontname`, `fontsize`, `presentation`, `presentation_rect`, `extra_attrs` (all remaining keys)
       - For lines: create Patchline instances from the line dicts
       - Set `_next_id` to max existing ID number + 1 to avoid collisions
       - Return the reconstructed Patcher

    2. Create `src/maxpat/incremental.py` with:

       ```python
       class Manifest:
           """Tracks generator-owned box IDs and connections."""
           box_ids: list[str]           # e.g., ["obj-1", "obj-2", ...]
           connections: list[tuple]     # e.g., [("obj-1", 0, "obj-2", 0), ...]

           @classmethod
           def sidecar_path(cls, maxpat_path: Path) -> Path:
               """Return manifest path: same dir, stem + '.manifest.json'"""

           def save(self, path: Path) -> None:
               """Write manifest JSON to disk."""

           @classmethod
           def load(cls, path: Path) -> Manifest:
               """Load manifest from disk. Returns empty manifest if file missing."""

           @classmethod
           def from_patcher(cls, patcher: Patcher) -> Manifest:
               """Extract box IDs and connection tuples from a Patcher."""

       def load_existing_patch(path: Path) -> dict | None:
           """Load a .maxpat JSON file. Returns None if file does not exist."""

       def merge_and_write(
           patcher: Patcher,
           path: Path,
           validate: bool = True,
           layout_options = None,
       ) -> list:
           """Incremental write: merge patcher into existing .maxpat, preserving user changes.

           Algorithm:
           1. Load old manifest (from sidecar). If no sidecar, this is a fresh write.
           2. Load existing .maxpat (if exists).
           3. If no existing patch: do a normal write_patch, save manifest, return.
           4. If existing patch exists:
              a. Build set of old-manifest box IDs and new-patcher box IDs.
              b. From existing patch boxes:
                 - KEEP boxes whose ID is NOT in old manifest (user-added)
                 - DROP boxes whose ID is in old manifest but NOT in new patcher (removed from generator)
                 - (Boxes in old manifest AND new patcher will be replaced by new patcher version)
              c. Build merged boxes list: user-kept boxes + all new patcher boxes
              d. Same logic for connections: keep user connections, drop stale manifest connections, add new connections
              e. Merge patcher-level props: use new patcher's props but preserve user-modified props that aren't generator-controlled (like rect, openinpresentation)
           5. Build a merged Patcher, run write_patch on it.
           6. Save new manifest (from the new patcher's boxes/connections).
           ```

    3. Update `src/maxpat/__init__.py`: add `merge_and_write` and `Manifest` to imports and `__all__`.

    4. Write tests in `tests/test_incremental.py` covering all behaviors listed above. Tests should:
       - Create small patchers (2-3 boxes), write them, then merge updated versions
       - Use `tmp_path` pytest fixture for file I/O
       - Verify manifest JSON structure
       - Verify user-added boxes are preserved after merge
       - Verify removed generator boxes are cleaned up
       - Verify idempotency (merge same patcher twice = same output)

    IMPORTANT DESIGN DECISIONS:
    - Box IDs are the stable identity key. The generator assigns deterministic IDs (obj-1, obj-2, etc.) via `_gen_id()`. On reload, user-added boxes in MAX will have different IDs (MAX assigns its own IDs when users create objects). This natural ID separation is what makes manifest tracking work.
    - The manifest is a simple JSON file, not embedded in the .maxpat (to avoid polluting the MAX file format).
    - Connection identity is the 4-tuple (source_id, source_outlet, dest_id, dest_inlet).
    - `merge_and_write` calls the existing `write_patch` (with layout + validation) on the merged result, so all existing pipeline hooks still apply.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -m pytest tests/test_incremental.py -x -v</automated>
  </verify>
  <done>
    - Manifest class can save/load sidecar JSON files
    - Patcher.from_dict() reconstructs a Patcher from .maxpat JSON
    - merge_and_write() correctly merges generator changes while preserving user objects
    - All tests pass covering: fresh write, idempotency, user preservation, stale removal
  </done>
</task>

<task type="auto">
  <name>Task 2: Update performancepatchtest generate.py to use incremental patching</name>
  <files>patches/performancepatchtest/generate.py</files>
  <action>
    Update `patches/performancepatchtest/generate.py` to use `merge_and_write` instead of `write_patch`:

    1. Add import: `from src.maxpat.incremental import merge_and_write`

    2. At the bottom of the file, replace:
       ```python
       write_patch(main, OUTPUT)
       ```
       with:
       ```python
       merge_and_write(main, OUTPUT)
       ```

    3. Keep all existing patch construction code unchanged -- the Patcher is built the same way, but now the write step merges instead of overwrites.

    4. Verify the script runs successfully and produces:
       - The same `.maxpat` output file
       - A new `.manifest.json` sidecar file next to it

    5. Run the script twice to confirm idempotency (second run produces identical .maxpat).

    NOTE: The `write_patch` import can be kept for other uses but the final write call must use `merge_and_write`.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 patches/performancepatchtest/generate.py && test -f patches/performancepatchtest/generated/performancepatchtest.manifest.json && echo "PASS: manifest created" && python3 patches/performancepatchtest/generate.py && echo "PASS: idempotent run"</automated>
  </verify>
  <done>
    - generate.py uses merge_and_write instead of write_patch
    - Running generate.py produces both .maxpat and .manifest.json
    - Running generate.py twice is idempotent (same output)
  </done>
</task>

</tasks>

<verification>
1. All existing tests still pass: `python3 -m pytest tests/ -x -q`
2. New incremental tests pass: `python3 -m pytest tests/test_incremental.py -x -v`
3. generate.py produces valid output: `python3 patches/performancepatchtest/generate.py`
4. Manifest sidecar exists after generation
5. Second run of generate.py produces identical .maxpat (idempotent)
</verification>

<success_criteria>
- merge_and_write() is the new default write function for generator scripts
- Generator-owned objects are tracked in a .manifest.json sidecar file
- User-added objects in .maxpat are preserved across regeneration
- Objects removed from the generator script are cleaned up on next run
- Existing test suite passes unchanged
- performancepatchtest/generate.py serves as working proof of concept
</success_criteria>

<output>
After completion, create `.planning/quick/11-implement-incremental-patching-in-the-pa/11-SUMMARY.md`
</output>
