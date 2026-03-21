---
name: max-iterate
description: Modify existing patches or code in the active project
argument-hint: "[--full|--discuss|--research] [changes]"
---

# /max-iterate

Apply modifications to existing .maxpat patches using the analyze-first protocol. Reads the patch, shows a structural analysis, then makes surgical or section-level edits while preserving all existing objects and user positioning.

## Behavior

1. **Parse arguments for inline project switch** -- before loading the active project, check if the first word of the argument string matches an existing project:
   ```python
   from src.maxpat.project import get_active_project, set_active_project, list_projects, update_status, bump_version

   projects = list_projects(base_dir)
   args = user_input.strip()
   first_word = args.split()[0] if args else ""

   # Case-insensitive match against known project directories
   matched_project = None
   for p in projects:
       if p.lower() == first_word.lower():
           matched_project = p
           break

   if matched_project:
       set_active_project(matched_project, base_dir)
       change_description = " ".join(args.split()[1:])  # remaining text
   else:
       change_description = args  # entire string is the description
   ```

2. **Parse flags** -- extract workflow flags from the argument string before interpreting the change description:
   - Scan `change_description` (the text remaining after inline project switch parsing) for `--full`, `--discuss`, `--research`, and `--plan`
   - `--full` expands to all three: discuss + research + plan
   - `--discuss`, `--research`, `--plan` can be used individually or combined
   - Strip all recognized flags from `change_description` so downstream steps see only the modification text
   - Store flags as booleans: `do_discuss`, `do_research`, `do_plan`

3. **Load active project** -- read `patches/.active-project.json` for the current project (which may have just been set by the step above). If no active project, prompt the user.

4. **Auto-detect target .maxpat** -- determine which patch file to edit:
   - Single .maxpat in `generated/`: use it automatically
   - Multiple .maxpat files: infer from the user's change description (match keywords to filenames)
   - Ambiguous: ask the user which file to edit

5. **Load patch** -- load the target file using read_patch:
   ```python
   patcher, original_text = read_patch(path)
   ```
   This returns a Patcher instance for editing and the original text for round-trip saving.

6. **Analyze patch** (mandatory before any edits) -- run structural analysis and display it to the user:
   ```python
   summary = patcher.analyze()
   ```
   The analysis shows: complexity metrics, object inventory by domain, functional sections, signal chain trees, control flow origins, subpatcher hierarchy, and parameters. This gives agent and user shared context before discussing changes.

7. **Discuss phase** (only if `do_discuss` is true) -- engage in a structured discussion about the requested changes, following the same protocol as `/max-discuss`:
   - Present the patch analysis alongside the change request
   - Ask clarifying questions about implementation approach: which objects to use, signal flow strategy, how the change integrates with existing patch structure
   - Capture decisions and rationale
   - Append decisions to the project's `context.md` under a "Decisions" section
   - This phase is interactive -- wait for user responses before proceeding

8. **Research phase** (only if `do_research` is true) -- investigate MAX-specific approaches for the requested changes, following the same protocol as `/max-research`:
   - Read relevant object database domains from `.claude/max-objects/`
   - Check `relationships.json` for common object pairings relevant to the change
   - Identify candidate objects, signal flow patterns, and alternative approaches
   - Present findings with tradeoffs
   - Append research results to the project's `context.md` under a "Research" section

9. **Plan phase** (only if `do_plan` is true) -- create an explicit plan for the modifications before executing:
   - Based on the analysis, discussion decisions, and research findings, outline the specific edit steps
   - List which objects will be added, modified, or removed
   - Specify the edit strategy (surgical vs section rebuild) with rationale
   - Identify connection changes and signal flow impacts
   - Present the plan to the user and wait for approval before proceeding to execution

After all flagged phases complete, proceed to the standard edit flow (steps 10+). The edit flow now benefits from decisions captured in context.md and any research/plan context.

10. **Parse change request** -- interpret the user's desired modifications against the analysis context. Identify which objects, sections, or signal chains are affected.

11. **Choose edit strategy** (transparent to user) -- the agent selects an approach and explains it before executing:
    - **Surgical edit** -- for small, targeted changes: use `find_box()` to locate targets, then `modify_box()` or `replace_box()` to make changes in place. Preserves all positions and connections.
    - **Section rebuild** -- for larger structural changes: use `connected_components()` to identify the affected group, `remove_box()` each object in the group, then rebuild with new objects and connections. Reconnect to the rest of the patch.

12. **Preserve existing objects** -- unconditionally preserve all objects the user did not ask to change. If the requested edit would affect objects the user added manually in MAX (e.g., removing an object that user-added objects connect to), warn before proceeding.

13. **Route through max-router** -- invoke the max-router skill for specialist dispatch with:
    - The modification description
    - The analysis summary as context
    - Project context and relevant memory

14. **Execute edits** -- the specialist agent applies changes via Patcher API methods:
    - `find_box()` / `find_boxes()` for locating targets
    - `modify_box()` for in-place attribute changes
    - `replace_box()` for swapping object types
    - `insert_into_connection()` for inserting objects into existing signal chains
    - `remove_box()` for removing objects (with automatic patchline cleanup)
    - `add_box()` / `add_connection()` for adding new objects

15. **Critic loop** -- validate and review the modified patch:
    - Run `validate_patch(patcher)` for structural validation
    - Run `review_patch(patcher.to_dict())` via the max-critic skill
    - Same quality gate as `/max-build` -- blockers require revision, warnings are annotated

16. **Save patch** -- write back using round-trip save to preserve positions and indentation:
    ```python
    save_patch_roundtrip(patcher.to_dict(), path, original_text)
    ```
    This preserves the original file's indentation, key ordering, and any metadata that the Patcher model does not explicitly track.

17. **Bump version** -- call `bump_version(project_dir, "patch", description)` where `description` is a short summary of the change. Use `"minor"` or `"major"` for significant reworks.

18. **Write-back memory** -- store any new patterns from the modification.

19. **Update progress** -- increment progress via `update_status()`.

## Skills Referenced

- **max-router** -- domain detection and agent dispatch
- **max-critic** -- post-modification quality review
- **max-memory-agent** -- memory injection and write-back
- **max-lifecycle** -- project context and status updates

## Python Modules

```python
from src.maxpat import read_patch, save_patch_roundtrip, validate_patch, Patcher
from src.maxpat.project import get_active_project, set_active_project, list_projects, update_status, bump_version
from src.maxpat.critics import review_patch, CriticResult
from src.maxpat.memory import MemoryStore
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| changes | Yes | Optional project name prefix followed by description of modifications (e.g., "stutter add LFO to filter cutoff") |

## Flags

| Flag | Description |
|------|-------------|
| --full | Run full pipeline: discuss -> research -> plan -> build |
| --discuss | Run discuss phase only before build |
| --research | Run research phase only before build |
| --plan | Run plan phase only before build |

Flags are composable: `--discuss --research` runs both phases. `--full` is shorthand for `--discuss --research --plan`.

Flags are stripped from the change description before processing.

## Examples

```
/max-iterate add LFO to filter cutoff
/max-iterate change metro rate to 200ms
/max-iterate replace cycle~ with saw~ for the main oscillator
/max-iterate add preset save/recall to the UI

# Inline project switching (first word matches a project name):
/max-iterate stutter add LFO to filter cutoff     # switches to stutter, then iterates
/max-iterate FDNVerb increase diffusion            # switches to FDNVerb, then iterates

# Full pipeline (discuss + research + plan before edit):
/max-iterate --full add granular synthesis engine
/max-iterate stutter --full redesign the delay feedback path

# Individual flags:
/max-iterate --discuss add LFO to filter cutoff
/max-iterate --research replace cycle~ with wavetable oscillator
/max-iterate --discuss --research add sidechain compression
```
