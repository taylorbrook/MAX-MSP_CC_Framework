---
name: max-iterate
description: Modify existing patches or code in the active project
argument-hint: "[changes]"
---

# /max-iterate

Apply modifications to existing .maxpat patches using the analyze-first protocol. Reads the patch, shows a structural analysis, then makes surgical or section-level edits while preserving all existing objects and user positioning.

## Behavior

1. **Load active project** -- read `patches/.active-project.json` for the current project. If no active project, prompt the user.

2. **Auto-detect target .maxpat** -- determine which patch file to edit:
   - Single .maxpat in `generated/`: use it automatically
   - Multiple .maxpat files: infer from the user's change description (match keywords to filenames)
   - Ambiguous: ask the user which file to edit

3. **Load patch** -- load the target file using read_patch:
   ```python
   patcher, original_text = read_patch(path)
   ```
   This returns a Patcher instance for editing and the original text for round-trip saving.

4. **Analyze patch** (mandatory before any edits) -- run structural analysis and display it to the user:
   ```python
   summary = patcher.analyze()
   ```
   The analysis shows: complexity metrics, object inventory by domain, functional sections, signal chain trees, control flow origins, subpatcher hierarchy, and parameters. This gives agent and user shared context before discussing changes.

5. **Parse change request** -- interpret the user's desired modifications against the analysis context. Identify which objects, sections, or signal chains are affected.

6. **Choose edit strategy** (transparent to user) -- the agent selects an approach and explains it before executing:
   - **Surgical edit** -- for small, targeted changes: use `find_box()` to locate targets, then `modify_box()` or `replace_box()` to make changes in place. Preserves all positions and connections.
   - **Section rebuild** -- for larger structural changes: use `connected_components()` to identify the affected group, `remove_box()` each object in the group, then rebuild with new objects and connections. Reconnect to the rest of the patch.

7. **Preserve existing objects** -- unconditionally preserve all objects the user did not ask to change. If the requested edit would affect objects the user added manually in MAX (e.g., removing an object that user-added objects connect to), warn before proceeding.

8. **Route through max-router** -- invoke the max-router skill for specialist dispatch with:
   - The modification description
   - The analysis summary as context
   - Project context and relevant memory

9. **Execute edits** -- the specialist agent applies changes via Patcher API methods:
   - `find_box()` / `find_boxes()` for locating targets
   - `modify_box()` for in-place attribute changes
   - `replace_box()` for swapping object types
   - `insert_into_connection()` for inserting objects into existing signal chains
   - `remove_box()` for removing objects (with automatic patchline cleanup)
   - `add_box()` / `add_connection()` for adding new objects

10. **Critic loop** -- validate and review the modified patch:
    - Run `validate_patch(patcher)` for structural validation
    - Run `review_patch(patcher.to_dict())` via the max-critic skill
    - Same quality gate as `/max-build` -- blockers require revision, warnings are annotated

11. **Save patch** -- write back using round-trip save to preserve positions and indentation:
    ```python
    save_patch_roundtrip(patcher.to_dict(), path, original_text)
    ```
    This preserves the original file's indentation, key ordering, and any metadata that the Patcher model does not explicitly track.

12. **Bump version** -- call `bump_version(project_dir, "patch", description)` where `description` is a short summary of the change. Use `"minor"` or `"major"` for significant reworks.

13. **Write-back memory** -- store any new patterns from the modification.

14. **Update progress** -- increment progress via `update_status()`.

## Skills Referenced

- **max-router** -- domain detection and agent dispatch
- **max-critic** -- post-modification quality review
- **max-memory-agent** -- memory injection and write-back
- **max-lifecycle** -- project context and status updates

## Python Modules

```python
from src.maxpat import read_patch, save_patch_roundtrip, validate_patch, Patcher
from src.maxpat.project import get_active_project, update_status, bump_version
from src.maxpat.critics import review_patch, CriticResult
from src.maxpat.memory import MemoryStore
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| changes | Yes | Description of modifications (e.g., "add LFO to filter cutoff") |

## Examples

```
/max-iterate add LFO to filter cutoff
/max-iterate change metro rate to 200ms
/max-iterate replace cycle~ with saw~ for the main oscillator
/max-iterate add preset save/recall to the UI
```
