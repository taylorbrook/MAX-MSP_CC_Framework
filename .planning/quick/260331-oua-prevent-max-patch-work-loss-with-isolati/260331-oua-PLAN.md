---
phase: quick-260331-oua
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/commands/max-build.md
  - .claude/commands/max-iterate.md
  - .claude/skills/references/shared-capabilities.md
  - src/maxpat/project.py
  - src/maxpat/hooks.py
  - CLAUDE.md
autonomous: true
requirements: [WORK-LOSS-01, WORK-LOSS-02, WORK-LOSS-03]

must_haves:
  truths:
    - "Every save_patch_roundtrip call is followed by an auto-commit of the changed .maxpat (and related files) so work is never only on disk"
    - "versions.json entries include a files_changed list and detailed description of what was modified"
    - "max-build and max-iterate commands include explicit git commit steps in their output protocols"
    - "CLAUDE.md documents the stash danger and mandates never using git stash in patch workflows"
    - "Multiple Claude instances can work on different patches simultaneously because each commits only its own project files"
  artifacts:
    - path: "src/maxpat/project.py"
      provides: "auto_commit_patch() function for git add+commit of patch project files"
      contains: "def auto_commit_patch"
    - path: "src/maxpat/hooks.py"
      provides: "save_patch_roundtrip calls auto_commit_patch after write"
      contains: "auto_commit_patch"
    - path: ".claude/commands/max-build.md"
      provides: "Git commit step in build output protocol"
      contains: "git commit"
    - path: ".claude/commands/max-iterate.md"
      provides: "Git commit step in iterate output protocol"
      contains: "git commit"
    - path: ".claude/skills/references/shared-capabilities.md"
      provides: "Patch Safety section documenting auto-commit and stash prohibition"
      contains: "auto_commit_patch"
    - path: "CLAUDE.md"
      provides: "Rule prohibiting git stash during patch work"
      contains: "git stash"
  key_links:
    - from: "src/maxpat/hooks.py"
      to: "src/maxpat/project.py"
      via: "save_patch_roundtrip -> auto_commit_patch import"
      pattern: "from src\\.maxpat\\.project import.*auto_commit_patch"
    - from: ".claude/commands/max-iterate.md"
      to: "src/maxpat/project.py"
      via: "references auto_commit_patch in output protocol"
      pattern: "auto_commit_patch"
    - from: ".claude/commands/max-build.md"
      to: "src/maxpat/project.py"
      via: "references auto_commit_patch in output protocol"
      pattern: "auto_commit_patch"
---

<objective>
Prevent MAX patch work loss by adding automatic git commits after every patch save, enriching version tracking with detailed change logs, and documenting stash prohibition and multi-instance safety rules.

Purpose: Three orphaned git stashes were found containing significant patch work (mixer, rhythmic-sampler, performancepatchtest). The root cause is that patch saves only write to disk -- no git commit happens, so any stash/merge/checkout by another Claude instance silently discards the work. The fix is: every patch write triggers an auto-commit, version entries get richer metadata, and the rules explicitly prohibit git stash in patch workflows.

Output: auto_commit_patch() function in project.py, updated save_patch_roundtrip in hooks.py, updated max-build and max-iterate commands, updated shared-capabilities.md, updated CLAUDE.md with stash prohibition rule.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md
@src/maxpat/project.py
@src/maxpat/hooks.py
@.claude/commands/max-build.md
@.claude/commands/max-iterate.md
@.claude/skills/references/shared-capabilities.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Add auto_commit_patch() and integrate into save_patch_roundtrip</name>
  <files>src/maxpat/project.py, src/maxpat/hooks.py</files>
  <action>
**In src/maxpat/project.py**, add a new function `auto_commit_patch()` after the existing `bump_version()` function:

```python
def auto_commit_patch(
    project_dir: Path,
    base_dir: Path,
    description: str = "",
    files: list[str] | None = None,
) -> str | None:
    """Auto-commit patch project files to git after a save operation.

    Commits only the specific files within the project's directory (and any
    explicitly listed extra files) to avoid interfering with other Claude
    instances working on different patches.

    Args:
        project_dir: Path to the project directory (e.g., patches/gen-eq/).
        base_dir: Root directory of the repo (for running git commands).
        description: Human-readable description of the change.
        files: Optional explicit list of file paths to stage (relative to base_dir).
            If None, stages all changed files under project_dir/.

    Returns:
        The commit hash string, or None if nothing to commit or git fails.
    """
    import subprocess

    try:
        if files:
            # Stage only the specific files listed
            for f in files:
                subprocess.run(
                    ["git", "add", str(f)],
                    cwd=str(base_dir),
                    capture_output=True,
                    timeout=10,
                )
        else:
            # Stage all changed files under the project directory
            rel_project = project_dir.relative_to(base_dir)
            subprocess.run(
                ["git", "add", str(rel_project)],
                cwd=str(base_dir),
                capture_output=True,
                timeout=10,
            )

        # Check if there are staged changes
        result = subprocess.run(
            ["git", "diff", "--cached", "--quiet"],
            cwd=str(base_dir),
            capture_output=True,
            timeout=10,
        )
        if result.returncode == 0:
            return None  # Nothing staged

        # Build commit message
        project_name = project_dir.name
        msg = f"patch({project_name}): {description}" if description else f"patch({project_name}): auto-save"

        result = subprocess.run(
            ["git", "commit", "-m", msg],
            cwd=str(base_dir),
            capture_output=True,
            text=True,
            timeout=30,
        )
        if result.returncode == 0:
            # Extract commit hash
            hash_result = subprocess.run(
                ["git", "rev-parse", "--short", "HEAD"],
                cwd=str(base_dir),
                capture_output=True,
                text=True,
                timeout=10,
            )
            return hash_result.stdout.strip() if hash_result.returncode == 0 else "unknown"
        return None
    except (subprocess.TimeoutExpired, FileNotFoundError, OSError):
        # Git not available or timed out -- silently skip
        return None
```

Also update `bump_version()` to accept an optional `files_changed` parameter and store it in the version entry:

In the `bump_version` function body, change the `data["versions"].append(...)` block to:

```python
def bump_version(
    project_dir: Path, bump: str = "patch", description: str = "",
    files_changed: list[str] | None = None,
) -> str:
```

And the append block becomes:
```python
    entry = {
        "version": new_version,
        "description": description,
        "timestamp": datetime.now(timezone.utc).isoformat(),
    }
    if files_changed:
        entry["files_changed"] = files_changed
    data["versions"].append(entry)
```

**In src/maxpat/hooks.py**, update `save_patch_roundtrip()` to call `auto_commit_patch` after writing:

After the existing `_write_and_sync(path, output)` line, add:

```python
    # Auto-commit to git to prevent work loss
    try:
        from src.maxpat.project import auto_commit_patch
        patch_path = Path(path)
        # Walk up to find the project dir (patches/{name}/)
        # Pattern: patches/{name}/generated/{file}.maxpat
        if "patches" in patch_path.parts:
            patches_idx = list(patch_path.parts).index("patches")
            if len(patch_path.parts) > patches_idx + 1:
                project_dir = Path(*patch_path.parts[:patches_idx + 2])
                base_dir = Path(*patch_path.parts[:patches_idx])
                auto_commit_patch(
                    project_dir,
                    base_dir,
                    description=f"save {patch_path.name}",
                    files=[str(path)],
                )
    except Exception:
        pass  # Never let commit failure block patch save
```

Do the same for `write_gendsp()` and `write_js()` -- add the same auto-commit block after each `_write_and_sync` call, changing the description to match (e.g., "save {path.name}" for gendsp, "save {path.name}" for js).
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -c "from src.maxpat.project import auto_commit_patch; print('auto_commit_patch imported OK')" && python3 -c "import inspect; from src.maxpat.hooks import save_patch_roundtrip; src = inspect.getsource(save_patch_roundtrip); assert 'auto_commit_patch' in src, 'auto_commit_patch not in save_patch_roundtrip'; print('hooks integration OK')" && python3 -c "import inspect; from src.maxpat.project import bump_version; src = inspect.getsource(bump_version); assert 'files_changed' in src, 'files_changed not in bump_version'; print('bump_version updated OK')" && python3 -m pytest tests/ -x -q --timeout=60 2>&1 | tail -5</automated>
  </verify>
  <done>auto_commit_patch() exists and is importable, save_patch_roundtrip/write_gendsp/write_js all call auto_commit_patch after disk write, bump_version accepts files_changed parameter, all existing tests pass</done>
</task>

<task type="auto">
  <name>Task 2: Update commands, shared-capabilities, and CLAUDE.md with safety rules</name>
  <files>.claude/commands/max-build.md, .claude/commands/max-iterate.md, .claude/skills/references/shared-capabilities.md, CLAUDE.md</files>
  <action>
**In .claude/commands/max-build.md:**

After step 6 (Write output), add a new step 7:

```markdown
7. **Commit to git** -- after saving, call `auto_commit_patch(project_dir, base_dir, description)` from `src.maxpat.project` to commit the generated files. This happens automatically inside `save_patch_roundtrip()`, but if additional files were generated (e.g., .gendsp, .js) that were saved separately, run an explicit commit:
   ```python
   from src.maxpat.project import auto_commit_patch
   auto_commit_patch(project_dir, base_dir, description="build: {brief description}", files=[...all generated file paths...])
   ```
   This ensures work is committed to git immediately and cannot be lost to stash operations or other instances.
```

Renumber old step 7 to step 8.

Also update the Python Modules section to include `auto_commit_patch`:
```python
from src.maxpat.project import get_active_project, read_status, update_status, auto_commit_patch
```

**In .claude/commands/max-iterate.md:**

After step 18 (Save patch), add a new step 19:

```markdown
19. **Commit to git** -- `save_patch_roundtrip()` auto-commits the .maxpat file, but also explicitly commit the version bump and any other changed files:
    ```python
    from src.maxpat.project import auto_commit_patch
    auto_commit_patch(project_dir, base_dir, description=f"v{new_version}: {change_description}", files=[str(path), str(project_dir / "versions.json")])
    ```
```

Renumber old step 19 to step 20. Also add `auto_commit_patch` to the Python Modules import section.

When calling `bump_version`, update the call to pass `files_changed`:
```python
bump_version(project_dir, "patch", description, files_changed=[path.name])
```

**In .claude/skills/references/shared-capabilities.md:**

Add a new section **after** the "Version Comment" section (at the end of the file):

```markdown
## Patch Safety -- Auto-Commit and Isolation

Every `save_patch_roundtrip()`, `write_gendsp()`, and `write_js()` call automatically commits the saved file to git via `auto_commit_patch()`. This prevents work loss from stash operations, branch switches, or concurrent Claude instances.

### Rules

1. **Never use `git stash`** during patch work. Stash operations have caused orphaned work in the past (3 stashes with significant patch changes were found abandoned). If you need to switch context, commit first.
2. **Commit scope isolation** -- `auto_commit_patch()` only stages files within the specific project directory. This allows multiple Claude instances to work on different patches simultaneously without conflicts.
3. **Version entries track files** -- `bump_version()` accepts `files_changed` to record which files were modified in each version entry.
4. **Manual commit for multi-file saves** -- if a build/iterate produces multiple files saved via separate calls, run one explicit `auto_commit_patch()` at the end with all file paths to create a single clean commit (the per-file auto-commits are fine too, just noisier).

### Multi-Instance Safety

Multiple Claude instances can work on different patches concurrently because:
- Each instance commits only files under its active project's directory
- `auto_commit_patch()` uses `git add {specific files}`, not `git add .`
- No stash/merge/rebase operations are used during patch work
- If a merge conflict occurs (unlikely with project isolation), the instance should stop and alert the user rather than attempting resolution
```

**In CLAUDE.md:**

Add a new Rule #7 after Rule #6 (Z-Order Awareness):

```markdown
### Rule #7: Commit After Every Save

Every patch save MUST be committed to git. The `save_patch_roundtrip()`, `write_gendsp()`, and `write_js()` functions auto-commit via `auto_commit_patch()`. Do NOT rely on disk-only saves -- uncommitted work is vulnerable to loss from stash operations, branch switches, or concurrent instances.

**Prohibited:** `git stash` during any patch workflow. Three orphaned stashes containing significant patch work were discovered and recovered. Use `git commit` instead. If you need to context-switch, commit your current work first.

**Multi-instance safety:** When multiple Claude instances work on the repo simultaneously, each MUST only commit files within its active project directory. Never use `git add .` or `git add -A` during patch work.
```
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && grep -q "auto_commit_patch" .claude/commands/max-build.md && echo "max-build OK" && grep -q "auto_commit_patch" .claude/commands/max-iterate.md && echo "max-iterate OK" && grep -q "Patch Safety" .claude/skills/references/shared-capabilities.md && echo "shared-capabilities OK" && grep -q "Rule #7" CLAUDE.md && echo "CLAUDE.md OK" && grep -q "git stash" CLAUDE.md && echo "stash prohibition OK"</automated>
  </verify>
  <done>max-build.md has git commit step, max-iterate.md has git commit step, shared-capabilities.md has Patch Safety section, CLAUDE.md has Rule #7 prohibiting git stash and mandating commit-after-save, all references to auto_commit_patch are consistent</done>
</task>

<task type="auto">
  <name>Task 3: Recover orphaned stashes and verify</name>
  <files>patches/mixer/generated/, patches/rhythmic-sampler/generated/, patches/performancepatchtest/generated/</files>
  <action>
Recover the 3 orphaned stashes found in the repo. For each stash, inspect the diff to understand what patch work it contains, then apply it if the work is still relevant (i.e., the current version of those files hasn't already incorporated the changes).

**Recovery process for each stash (starting from stash@{2} -- oldest first to avoid index shifting):**

1. `git stash show -p stash@{N}` -- examine the full diff
2. Identify which .maxpat and .js files have meaningful changes (ignore .pyc files)
3. For each meaningful file, check if the current version already contains the changes:
   - If the current file is OLDER than the stash (stash has newer work): apply with `git checkout stash@{N} -- {file_path}`
   - If the current file is NEWER or same: skip (changes already incorporated or superseded)
4. After extracting any useful files, drop the stash: `git stash drop stash@{N}`

**Important:** Process stashes in reverse order (stash@{2}, then stash@{1}, then stash@{0}) because dropping changes indices.

After recovery, commit recovered files using auto_commit_patch pattern:
```bash
git add patches/{project}/generated/{files}
git commit -m "patch({project}): recover orphaned stash work"
```

If a stash contains no recoverable work (all changes superseded), just drop it with a note.

Finally, verify no stashes remain: `git stash list` should be empty.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && test -z "$(git stash list)" && echo "All stashes cleared" || echo "FAIL: stashes still exist"</automated>
  </verify>
  <done>All 3 orphaned stashes examined, recoverable patch work applied and committed, stash list is empty, no work remains orphaned</done>
</task>

</tasks>

<verification>
1. `python3 -c "from src.maxpat.project import auto_commit_patch; print('OK')"` -- function exists
2. `python3 -m pytest tests/ -x -q` -- all existing tests still pass
3. `grep -c "auto_commit_patch" src/maxpat/hooks.py` -- should be >= 3 (one per write function)
4. `grep "Rule #7" CLAUDE.md` -- stash prohibition rule exists
5. `git stash list` -- empty (all stashes recovered or dropped)
6. `grep "Patch Safety" .claude/skills/references/shared-capabilities.md` -- safety section exists
</verification>

<success_criteria>
- auto_commit_patch() function in project.py commits patch files to git after save
- save_patch_roundtrip, write_gendsp, and write_js all trigger auto-commit
- bump_version records files_changed in version entries
- max-build and max-iterate commands include explicit git commit steps
- CLAUDE.md Rule #7 prohibits git stash and mandates commit-after-save
- shared-capabilities.md documents multi-instance isolation strategy
- All 3 orphaned stashes recovered or dropped, stash list empty
- All existing tests pass
</success_criteria>

<output>
After completion, create `.planning/quick/260331-oua-prevent-max-patch-work-loss-with-isolati/260331-oua-SUMMARY.md`
</output>
