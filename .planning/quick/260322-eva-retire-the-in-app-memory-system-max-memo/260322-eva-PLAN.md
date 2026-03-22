---
phase: quick-260322-eva
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  # Deletions
  - .claude/skills/max-memory-agent/SKILL.md
  - .claude/skills/max-memory-agent/BOUNDARIES.md
  - .claude/commands/max-memory.md
  - patches/FDNVerb/.max-memory/patterns.md
  - patches/granularsynthtest/.max-memory/patterns.md
  - patches/kicksynth/.max-memory/patterns.md
  - patches/minitaur/.max-memory/patterns.md
  - patches/mixer/.max-memory/patterns.md
  - patches/performancepatchtest/.max-memory/patterns.md
  - patches/rhythmic-sampler/.max-memory/patterns.md
  - patches/scala-synth/.max-memory/patterns.md
  - patches/stutter/.max-memory/patterns.md
  - patches/wormhole/.max-memory/patterns.md
  # Edits - commands
  - .claude/commands/max-build.md
  - .claude/commands/max-iterate.md
  # Edits - skills
  - .claude/skills/max-router/SKILL.md
  - .claude/skills/max-dsp-agent/SKILL.md
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-ui-agent/SKILL.md
  - .claude/skills/max-js-agent/SKILL.md
  - .claude/skills/max-critic/SKILL.md
  - .claude/skills/max-lifecycle/SKILL.md
  - .claude/skills/max-lifecycle/references/project-structure.md
  # Edits - code and tests
  - src/maxpat/project.py
  - tests/test_commands.py
  - tests/test_agent_skills.py
  - tests/test_project.py
autonomous: true
requirements: []

must_haves:
  truths:
    - "No memory write-back step exists in max-build or max-iterate commands"
    - "No max-memory-agent skill directory exists"
    - "No /max-memory command file exists"
    - "No .max-memory/ directories exist under patches/"
    - "No SKILL.md references max-memory-agent for loading or injection"
    - "src/maxpat/memory.py module is untouched (kept intact)"
    - "All tests pass after removal"
  artifacts:
    - path: ".claude/commands/max-build.md"
      provides: "Build command without memory steps"
      contains: "save_patch_roundtrip"
    - path: ".claude/commands/max-iterate.md"
      provides: "Iterate command without memory steps"
      contains: "save_patch_roundtrip"
  key_links:
    - from: "tests/test_commands.py"
      to: ".claude/commands/"
      via: "ALL_COMMANDS list"
      pattern: "ALL_COMMANDS"
    - from: "tests/test_agent_skills.py"
      to: ".claude/skills/"
      via: "ALL_SKILL_DIRS list"
      pattern: "ALL_SKILL_DIRS"
---

<objective>
Retire the in-app memory system (max-memory-agent, .max-memory/ directories, memory write-back steps). The system has never been used -- all 10 project patterns.md files are empty (0 entries written). Claude's built-in project memory at ~/.claude/projects/ handles all pattern recall.

Purpose: Remove dead code/config that adds context loading overhead and confuses the agent dispatch.
Output: Clean skill/command files with no memory references; deleted empty .max-memory dirs; passing tests.
</objective>

<execution_context>
@~/.claude/get-shit-done/workflows/execute-plan.md
@~/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Delete memory agent files and remove all memory references from skill/command docs</name>
  <files>
    .claude/skills/max-memory-agent/SKILL.md
    .claude/skills/max-memory-agent/BOUNDARIES.md
    .claude/commands/max-memory.md
    patches/FDNVerb/.max-memory/patterns.md
    patches/granularsynthtest/.max-memory/patterns.md
    patches/kicksynth/.max-memory/patterns.md
    patches/minitaur/.max-memory/patterns.md
    patches/mixer/.max-memory/patterns.md
    patches/performancepatchtest/.max-memory/patterns.md
    patches/rhythmic-sampler/.max-memory/patterns.md
    patches/scala-synth/.max-memory/patterns.md
    patches/stutter/.max-memory/patterns.md
    patches/wormhole/.max-memory/patterns.md
    .claude/commands/max-build.md
    .claude/commands/max-iterate.md
    .claude/skills/max-router/SKILL.md
    .claude/skills/max-dsp-agent/SKILL.md
    .claude/skills/max-patch-agent/SKILL.md
    .claude/skills/max-ui-agent/SKILL.md
    .claude/skills/max-js-agent/SKILL.md
    .claude/skills/max-critic/SKILL.md
    .claude/skills/max-lifecycle/SKILL.md
    .claude/skills/max-lifecycle/references/project-structure.md
  </files>
  <action>
    **Deletions:**

    1. Delete the entire `.claude/skills/max-memory-agent/` directory (contains SKILL.md and BOUNDARIES.md).
    2. Delete `.claude/commands/max-memory.md`.
    3. Delete all 10 `.max-memory/` directories (each contains only patterns.md) under patches/:
       - patches/FDNVerb/.max-memory/
       - patches/granularsynthtest/.max-memory/
       - patches/kicksynth/.max-memory/
       - patches/minitaur/.max-memory/
       - patches/mixer/.max-memory/
       - patches/performancepatchtest/.max-memory/
       - patches/rhythmic-sampler/.max-memory/
       - patches/scala-synth/.max-memory/
       - patches/stutter/.max-memory/
       - patches/wormhole/.max-memory/

    **Edits to .claude/commands/max-build.md:**

    - Remove step 3 entirely ("Inject memory" -- lines 17-19). Renumber steps 4-9 to 3-7.
    - Remove step 8 entirely ("Write-back memory" -- line 45). Renumber remaining.
    - In "Skills Referenced" section: remove the line `- **max-memory-agent** -- memory injection and write-back`.
    - In "Python Modules" code block: remove the line `from src.maxpat.memory import MemoryStore, MemoryEntry`.
    - In step 4 (now step 3, Route through max-router): remove the bullet `- Relevant memory entries` from the list passed to the router.

    **Edits to .claude/commands/max-iterate.md:**

    - In step 13 (Route through max-router): remove `- Project context and relevant memory` and replace with `- Project context`. (Line 95.)
    - Remove step 18 entirely ("Write-back memory" -- line 118). Renumber step 19 to 18.
    - In "Skills Referenced" section: remove `- **max-memory-agent** -- memory injection and write-back`.
    - In "Python Modules" code block: remove `from src.maxpat.memory import MemoryStore`.

    **Edits to .claude/skills/max-router/SKILL.md:**

    - In "Domain Context Loading" section (lines 20-25): remove steps 3 and 4 (memory loading). Keep steps 1-2 only.
    - In "Capabilities" bullet list: remove `- Memory injection: load relevant global/project memory before passing to specialist` (line 63).
    - In "Output Protocol" step 3: change `Load and pass relevant context (project context, memory) to specialist(s)` to `Load and pass relevant context (project context) to specialist(s)`.
    - In "When NOT to Use" list: change `- /max-status, /max-memory, /max-switch -- project management, no generation` to `- /max-status, /max-switch -- project management, no generation`.

    **Edits to specialist agent SKILL.md files (remove memory context loading steps):**

    - `.claude/skills/max-dsp-agent/SKILL.md`: Remove context loading steps 6-7 (lines 27-28: "Read active project's .max-memory/patterns.md" and "Read ~/.claude/max-memory/dsp/").
    - `.claude/skills/max-patch-agent/SKILL.md`: Remove context loading steps 6-7 (lines 27-28: "Read active project's .max-memory/patterns.md" and "Read ~/.claude/max-memory/patch/").
    - `.claude/skills/max-ui-agent/SKILL.md`: Remove context loading steps 3-4 (lines 24-25: "Read active project's .max-memory/patterns.md" and "Read ~/.claude/max-memory/ui/").
    - `.claude/skills/max-js-agent/SKILL.md`: Remove context loading steps 2-3 (lines 23-24: "Read active project's .max-memory/patterns.md" and "Read ~/.claude/max-memory/js/").

    **Edits to .claude/skills/max-critic/SKILL.md:**

    - In "When NOT to Use" list: remove the line `- For memory operations (use max-memory-agent)` (line 75).

    **Edits to .claude/skills/max-lifecycle/SKILL.md:**

    - In "When NOT to Use" list: remove `- For memory operations (use max-memory-agent)` (line 87).

    **Edits to .claude/skills/max-lifecycle/references/project-structure.md:**

    - Remove `.max-memory/` and `patterns.md` from the directory layout tree (lines 14-15).
    - Remove the `### .max-memory/patterns.md` section (lines 71-72).

    **IMPORTANT: Do NOT touch src/maxpat/memory.py or tests/test_memory.py. The Python module stays intact.**
  </action>
  <verify>
    <automated>bash -c "test ! -d .claude/skills/max-memory-agent && test ! -f .claude/commands/max-memory.md && test ! -d patches/FDNVerb/.max-memory && test ! -d patches/stutter/.max-memory && ! grep -r 'max-memory' .claude/commands/ && ! grep -r 'max-memory-agent' .claude/skills/max-router/SKILL.md .claude/skills/max-dsp-agent/SKILL.md .claude/skills/max-patch-agent/SKILL.md .claude/skills/max-ui-agent/SKILL.md .claude/skills/max-js-agent/SKILL.md .claude/skills/max-critic/SKILL.md .claude/skills/max-lifecycle/SKILL.md && echo PASS"</automated>
  </verify>
  <done>
    - max-memory-agent skill directory deleted
    - /max-memory command file deleted
    - All 10 .max-memory/ directories deleted from patches/
    - No remaining "max-memory" references in any command or skill file
    - src/maxpat/memory.py untouched
  </done>
</task>

<task type="auto">
  <name>Task 2: Update project.py scaffolding and fix tests</name>
  <files>
    src/maxpat/project.py
    tests/test_commands.py
    tests/test_agent_skills.py
    tests/test_project.py
  </files>
  <action>
    **Edit src/maxpat/project.py:**

    - In `create_project()` docstring: remove `- .max-memory/patterns.md (empty)` from the list (line 30).
    - Remove line 56: `(project_dir / ".max-memory").mkdir()`.
    - Remove lines 65-68: the block that initializes `.max-memory/patterns.md`:
      ```python
      # Initialize .max-memory/patterns.md
      (project_dir / ".max-memory" / "patterns.md").write_text(
          f"# {name} -- Learned Patterns\n\nPatterns discovered during development.\n"
      )
      ```

    **Edit tests/test_commands.py:**

    - Remove `"max-memory"` from the `ALL_COMMANDS` list (line 27). Update the docstring count from "11" to "10" (line 4).
    - Remove the entire `test_memory_references_memory_store` function (lines 143-148).
    - Update `test_total_command_count` assertion from `>= 10` to `>= 9` (line 71). Update its docstring from "10" to "9".

    **Edit tests/test_agent_skills.py:**

    - Remove `"max-memory-agent"` from the `ALL_SKILL_DIRS` list (line 28). Update the docstring count from "10" to "9" (line 4).
    - Remove the entire `test_memory_agent_references_memory_module` function (lines 282-287).
    - Remove the entire `test_memory_agent_has_boundaries` function (lines 290-293).

    **Edit tests/test_project.py:**

    - Remove `assert (project_path / ".max-memory").is_dir()` (line 33).
    - Remove `assert (project_path / ".max-memory" / "patterns.md").is_file()` (line 40).
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_commands.py tests/test_agent_skills.py tests/test_project.py -x -q 2>&1 | tail -5</automated>
  </verify>
  <done>
    - create_project() no longer scaffolds .max-memory/ directories
    - All test files updated: removed memory-related test cases and list entries
    - All tests pass
  </done>
</task>

</tasks>

<verification>
1. `grep -r 'max-memory' .claude/ --include='*.md'` returns zero hits
2. `find patches/ -name '.max-memory' -type d` returns zero results
3. `python -m pytest tests/test_commands.py tests/test_agent_skills.py tests/test_project.py tests/test_memory.py -x -q` -- all pass (test_memory.py unchanged, still passes independently)
4. `test -f src/maxpat/memory.py` -- file still exists (not deleted)
</verification>

<success_criteria>
- Zero references to max-memory-agent, /max-memory, or .max-memory/ in any skill or command file
- src/maxpat/memory.py and tests/test_memory.py unchanged
- All tests pass
- No .max-memory/ directories exist under patches/
</success_criteria>

<output>
After completion, create `.planning/quick/260322-eva-retire-the-in-app-memory-system-max-memo/260322-eva-SUMMARY.md`
</output>
