---
name: max-iterate
description: Modify existing patches or code in the active project
argument-hint: "[changes]"
---

# /max-iterate

Apply modifications to existing generated patches or code without regenerating from scratch.

## Behavior

1. **Load active project** -- read `patches/.active-project.json` for the current project. If no active project, prompt the user.

2. **Read existing files** -- load the generated files from the project's `generated/` directory that the user wants to modify.

3. **Understand the change** -- parse the user's description of desired modifications.

4. **Route through max-router** -- invoke the max-router skill to determine which specialist agent(s) should handle the modification. The router receives:
   - The modification description
   - The existing file content(s) as context
   - Project context and relevant memory

5. **Apply changes** -- the specialist agent modifies the existing output rather than regenerating from scratch. Modifications respect:
   - Existing object positions and connections (for patches)
   - Existing code structure (for GenExpr/JavaScript)
   - User's prior decisions captured in context.md

6. **Critic loop** -- run the max-critic skill on the modified output to verify the changes are valid.

7. **Write output** -- save modified files back to the project's `generated/` directory.

8. **Write-back memory** -- store any new patterns from the modification.

9. **Update progress** -- increment progress via `update_status()`.

## Skills Referenced

- **max-router** -- domain detection and agent dispatch
- **max-critic** -- post-modification quality review
- **max-memory-agent** -- memory injection and write-back
- **max-lifecycle** -- project context and status updates

## Python Modules

```python
from src.maxpat.project import get_active_project, update_status
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
