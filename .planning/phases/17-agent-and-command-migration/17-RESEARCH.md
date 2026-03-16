# Phase 17: Agent and Command Migration - Research

**Researched:** 2026-03-16
**Domain:** Slash command workflows, agent SKILL.md updates, validation adaptation
**Confidence:** HIGH

## Summary

Phase 17 rewires the user-visible layer -- slash commands and agent skill files -- to use the direct .maxpat editing API built in Phases 13-16 instead of the Python generation pipeline (generate.py scripts). No new Python modules need to be created. The work is entirely about updating markdown files (commands, skills) and making minor adjustments to the validation path so it works with the edit workflow.

The API surface is complete: `read_patch()`, `save_patch_roundtrip()`, `find_box()`/`find_boxes()`, `modify_box()`, `insert_into_connection()`, `replace_box()`, `remove_box()`, `analyze()`, `connected_components()`, and `Patcher.from_dict()` all exist and are tested (289 tests across round-trip, hooks, analysis, and patcher modules). The `generate_patch()` + `write_patch()` creation path is unchanged for new patches. The task is to document the dual workflow (create new vs edit existing) in all command and skill files, and ensure validation does not block the edit path with false positives.

**Primary recommendation:** Treat this as a documentation and wiring phase. Update 4 command files, 6 specialist SKILL.md files, 3 orchestration SKILL.md files, and make the validation layer 2 (object existence) produce warnings instead of errors for unknown objects on loaded patches.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- /max-iterate: Always run analyze() first and show summary before asking what to change
- /max-iterate: Agent chooses between surgical edit (find_box/modify_box/replace_box) and section rebuild (remove group + recreate) -- decision is transparent
- /max-iterate: Always run critic loop after edits -- same quality gate as fresh builds
- /max-iterate: Preserve all existing objects unconditionally -- only modify what user explicitly asks
- /max-iterate: Warn before proceeding if requested edit would affect objects the user added manually
- /max-iterate: Auto-detect which .maxpat to edit from context
- /max-build: Always creates new .maxpat files from scratch via Patcher() -> generate_patch() -> write_patch()
- /max-build: If target .maxpat already exists, warn and offer overwrite or redirect to /max-iterate
- /max-build: No generate.py script is ever created
- /max-new: Keep generated/ subdirectory for .maxpat output files
- /max-new: Create an empty .maxpat (valid empty patcher) on project creation
- /max-new: No generate.py created for new projects
- Save paths: New patches use generate_patch() + write_patch(); Edited patches use read_patch() + edits + validate + save_patch_roundtrip()
- Validation: Do not reject unknown objects on load
- Validation: Validate on demand after edits, not during load
- Validation: Critic loop runs after every iterate session
- Validation: save_patch_roundtrip() never triggers auto-layout
- Agent SKILL.md: All 6 specialist agents updated to reference direct editing API
- Agent SKILL.md: Document dual workflow (create new AND edit existing)
- Agent SKILL.md: Carry forward existing Phase 12 format

### Claude's Discretion
- Exact wording and organization of SKILL.md updates
- How section rebuild scope is determined (which objects constitute a "section")
- How auto-detect chooses the right .maxpat file from user description
- Implementation of the "already exists" warning in /max-build
- /max-onboard implementation details (straightforward from Phase 16 analyze())

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| MG-01 | /max-build generates patches by directly creating and writing .maxpat files -- no generate.py | Command file update + SKILL.md updates documenting Patcher() -> generate_patch() -> write_patch() path exclusively |
| MG-02 | /max-iterate reads existing .maxpat, understands structure, makes surgical edits, writes back | Command file rewrite with analyze-first protocol, dual edit strategy (surgical vs section rebuild), read_patch -> edits -> save_patch_roundtrip path |
| MG-03 | /max-new creates project structure with direct .maxpat workflow | Command file update + project.py enhancement to create empty .maxpat in generated/ |
| MG-04 | /max-onboard implemented as new slash command | New command file at .claude/commands/max-onboard.md using read_patch() + analyze() |
| MG-05 | All 6 specialist agent SKILL.md files reference direct editing API | SKILL.md updates adding "Editing Existing Patches" sections with read_patch, find_box, modify_box, etc. |
| MG-06 | Validation hooks adapted for direct editing | Validation layer 2 change: unknown objects become warnings (not errors) when validating loaded patches; save_patch_roundtrip already avoids layout |
</phase_requirements>

## Standard Stack

### Core (no new dependencies)
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| src.maxpat.patcher | existing | Patcher, Box, Patchline, EditResult | Core data model with all edit methods |
| src.maxpat.hooks | existing | read_patch, save_patch_roundtrip, write_patch | File I/O with dual save paths |
| src.maxpat.__init__ | existing | generate_patch, validate_patch | Creation pipeline + validation |
| src.maxpat.critics | existing | review_patch, CriticResult | Semantic review for critic loop |
| src.maxpat.validation | existing | validate_patch, ValidationResult | 4-layer validation pipeline |
| src.maxpat.project | existing | create_project, set_active_project | Project lifecycle management |

### No New Libraries Needed
This phase is entirely documentation and minor code adjustment. Zero external dependencies.

## Architecture Patterns

### Recommended File Structure (changes only)
```
.claude/commands/
  max-build.md         # UPDATE: remove generate.py references, add direct .maxpat workflow
  max-iterate.md       # REWRITE: analyze-first, surgical/rebuild, read_patch + save_patch_roundtrip
  max-new.md           # UPDATE: add empty .maxpat creation step
  max-onboard.md       # NEW: /max-onboard command using analyze()

.claude/skills/
  max-patch-agent/SKILL.md    # UPDATE: add editing section
  max-dsp-agent/SKILL.md      # UPDATE: add editing section
  max-rnbo-agent/SKILL.md     # UPDATE: add editing section
  max-js-agent/SKILL.md       # UPDATE: add editing section
  max-ext-agent/SKILL.md      # UPDATE: add editing section
  max-ui-agent/SKILL.md       # UPDATE: add editing section
  max-lifecycle/SKILL.md      # UPDATE: add empty .maxpat in create_project
  max-router/SKILL.md         # UPDATE: /max-iterate routing includes analyze context
  max-critic/SKILL.md         # UPDATE: critic loop for edit workflow

src/maxpat/
  validation.py        # MINOR: unknown objects -> warning instead of error
  project.py           # MINOR: create empty .maxpat on project creation
```

### Pattern 1: Dual Workflow in SKILL.md Files
**What:** Each specialist agent documents two workflows: create-new and edit-existing.
**When to use:** Every specialist agent SKILL.md.
**Structure:**
```markdown
## Creating New Patches (via /max-build)
1. Create Patcher and build patch structure
2. Apply layout via generate_patch()
3. Return (patch_dict, results) for critic review
4. Write via write_patch() to generated/

## Editing Existing Patches (via /max-iterate)
1. Load patch: patcher, original_text = read_patch(path)
2. Analyze: summary = patcher.analyze()
3. Find targets: box = patcher.find_box(name="cycle~")
4. Make changes: result = patcher.modify_box(box, args=["440"])
5. Validate: results = validate_patch(patcher)
6. Save: save_patch_roundtrip(patcher.to_dict(), path, original_text)
```

### Pattern 2: /max-iterate Analyze-First Protocol
**What:** Always run analyze() before any edits to give agent and user shared context.
**When to use:** Every /max-iterate invocation.
**Flow:**
1. Auto-detect which .maxpat to edit (single file = use it, multiple = infer, ambiguous = ask)
2. Load via read_patch()
3. Run patcher.analyze() and display summary to user
4. Parse user's change request against the analysis context
5. Choose strategy: surgical edit OR section rebuild
6. Execute edits
7. Run validate_patch() + review_patch() (critic loop)
8. Save via save_patch_roundtrip()

### Pattern 3: /max-build Direct Creation
**What:** Build creates .maxpat files directly without generate.py intermediary.
**When to use:** Every /max-build invocation.
**Flow:**
1. Check if target .maxpat already exists -> warn + offer overwrite or redirect to /max-iterate
2. Create Patcher() instance
3. Build patch structure via specialist agent(s)
4. generate_patch() applies layout + validation
5. Critic loop via review_patch()
6. write_patch() to generated/ directory
7. No generate.py script created at any point

### Pattern 4: /max-onboard Command
**What:** Analyze an existing patch from any source to build understanding.
**When to use:** When user invokes /max-onboard with a .maxpat file path.
**Flow:**
1. Accept path to .maxpat file (any file, not just project patches)
2. Load via read_patch()
3. Run patcher.analyze()
4. Display the structured Markdown analysis
5. Optionally offer to create a project from the analyzed patch

### Pattern 5: Validation for Edit Path
**What:** Validation runs on demand after edits, not on load. Unknown objects are warnings, not errors.
**When to use:** After any edit operation in /max-iterate.
**Key rules:**
- from_dict() already bypasses DB validation (loads via Box.__new__)
- validate_patch() runs AFTER edits, not during load
- Unknown objects in loaded patches are third-party externals or packages -- warn, don't error
- save_patch_roundtrip() never calls apply_layout() (already implemented)
- Critic loop runs after validation (same as /max-build)

### Anti-Patterns to Avoid
- **Creating generate.py scripts:** The entire point of this migration is eliminating the Python script intermediary. No command should ever create a generate.py.
- **Running validate_patch during from_dict/read_patch:** Validation on load rejects third-party objects. Validation must be explicitly invoked after edits.
- **Calling apply_layout on loaded patches:** Destroys user positioning. Only generate_patch() (new patches) runs layout.
- **Mixing save paths:** New patches use write_patch(); edited patches use save_patch_roundtrip(). Never cross them.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Patch loading | Custom JSON parser | read_patch() -> (Patcher, original_text) | Handles from_dict, indent detection, round-trip state |
| Patch analysis | Manual object counting | patcher.analyze() | 7-facet analysis with sections, chains, hierarchy |
| Object search | Iterating patcher.boxes | find_box() / find_boxes() | Handles alias resolution, recursive subpatcher search |
| In-place editing | Remove + re-add | modify_box() | I/O recomputation, orphaned connection tracking |
| Object replacement | Remove + add + reconnect | replace_box() | Position preservation, connection remapping, orphan reporting |
| Indent-preserving save | Custom JSON writer | save_patch_roundtrip() | Detects original indent, preserves trailing newline |
| Section identification | Manual grouping | connected_components() | Graph-based connected component detection |
| Empty patcher creation | Manual JSON construction | Patcher().to_dict() | Produces valid empty patcher with correct structure |

## Common Pitfalls

### Pitfall 1: Tests Assert Old Workflow References
**What goes wrong:** Existing tests in test_commands.py and test_agent_skills.py assert that specific strings exist in command/skill files (e.g., "max-router" in max-build.md, "add_connection" in max-patch-agent). Updating files could break these assertions.
**Why it happens:** Tests were written for the v1.x workflow and check for specific content patterns.
**How to avoid:** Read each test assertion before modifying the file it tests. Ensure updated content still satisfies all existing test assertions while adding new ones for v2.0 API references.
**Warning signs:** test_commands.py and test_agent_skills.py failures after file updates.

### Pitfall 2: Missing Key Functions Section in Updated SKILL.md
**What goes wrong:** The "Key Functions" section format from Phase 12 must be preserved. If editing APIs are added in a different format, tests checking for specific patterns break.
**Why it happens:** Each specialist SKILL.md has existing tests that check for function name patterns (e.g., "add_connection", "build_genexpr(params, code_body").
**How to avoid:** Add editing API functions alongside existing Key Functions, or in a clearly separate "Editing Functions" subsection. Never remove existing function references.
**Warning signs:** test_agent_skills.py API signature tests failing.

### Pitfall 3: Validation Layer 2 Change Scope
**What goes wrong:** Changing unknown object validation from error to warning globally could mask genuine errors in newly created patches.
**Why it happens:** The same validate_patch() runs on both new and loaded patches.
**How to avoid:** The change should make "Unknown object" findings a warning (not error) uniformly. For newly created patches, the critic loop (review_patch) and agent DB lookups already prevent unknown objects from being generated. The validation layer 2 is a safety net, not the primary guard.
**Warning signs:** If you try to scope the change only to "loaded" patches, you need to thread a flag through validate_patch, which adds complexity for no practical benefit.

### Pitfall 4: /max-onboard Command Test Coverage
**What goes wrong:** The test_commands.py file has ALL_COMMANDS = 10 commands and test_total_command_count asserts >= 10. Adding max-onboard (11th command) is fine, but the new command needs its own test assertions.
**Why it happens:** New command file without corresponding test coverage.
**How to avoid:** Add max-onboard to ALL_COMMANDS list and add cross-reference tests (e.g., asserting it references read_patch or analyze).
**Warning signs:** New command exists but has no test coverage.

### Pitfall 5: Empty .maxpat in create_project
**What goes wrong:** Creating a .maxpat in create_project() requires knowing the correct minimal structure. A malformed empty patch causes MAX to show errors on open.
**Why it happens:** Temptation to hand-write JSON instead of using the Patcher API.
**How to avoid:** Use `Patcher().to_dict()` to create the empty patcher, then write with `json.dumps(patcher_dict, indent=2)`. The Patcher class already produces valid structure.
**Warning signs:** MAX shows "corrupt file" or "missing patcher key" errors when opening the empty patch.

### Pitfall 6: Router Needs to Know About Analyze-First
**What goes wrong:** The router dispatches to specialist agents without knowing that /max-iterate should run analyze() first. The analyze step happens in the command layer, not the router.
**Why it happens:** Confusion about where the analyze-first step lives in the stack.
**How to avoid:** The analyze-first step belongs in the /max-iterate command definition, not in the router. The router receives the analysis summary as context alongside the modification request.
**Warning signs:** Router trying to call analyze() itself, or analysis not happening.

## Code Examples

### Example 1: /max-iterate Edit Flow
```python
# Source: src/maxpat/hooks.py (read_patch) + src/maxpat/patcher.py (edit methods)
from src.maxpat import read_patch, save_patch_roundtrip, validate_patch
from src.maxpat.critics import review_patch

# Step 1: Load
patcher, original_text = read_patch("patches/my-synth/generated/my-synth.maxpat")

# Step 2: Analyze (show to user)
summary = patcher.analyze()
# display summary...

# Step 3: Surgical edit
osc = patcher.find_box(name="cycle~")
result = patcher.modify_box(osc, args=["880"])
# result.orphaned lists any connections broken by I/O change

# Step 4: Validate
results = validate_patch(patcher)
# Check for blockers (warnings OK for unknown objects)

# Step 5: Critic review
patch_dict = patcher.to_dict()
critic_results = review_patch(patch_dict)
# Handle blockers via critic loop protocol

# Step 6: Save (preserves positions and indentation)
save_patch_roundtrip(patch_dict, "patches/my-synth/generated/my-synth.maxpat", original_text)
```

### Example 2: /max-build Direct Creation
```python
# Source: src/maxpat/__init__.py (generate_patch) + src/maxpat/hooks.py (write_patch)
from src.maxpat import Patcher, Box, ObjectDatabase, write_patch

db = ObjectDatabase()
p = Patcher(db=db)

# Build patch structure
osc = p.add_box("cycle~", ["440"])
gain = p.add_box("*~", ["0.5"])
dac = p.add_box("dac~")
p.add_connection(osc, 0, gain, 0)
p.add_connection(gain, 0, dac, 0)
p.add_connection(gain, 0, dac, 1)

# Write (runs generate_patch internally: layout + validate)
results = write_patch(p, "patches/my-synth/generated/my-synth.maxpat")
# No generate.py created
```

### Example 3: /max-onboard Analysis
```python
# Source: src/maxpat/hooks.py (read_patch) + src/maxpat/patcher.py (analyze)
from src.maxpat import read_patch

patcher, _ = read_patch("/path/to/any/patch.maxpat")
analysis = patcher.analyze()
print(analysis)
# Outputs structured Markdown: complexity, inventory, sections,
# signal chains, control paths, hierarchy, parameters
```

### Example 4: Empty .maxpat for /max-new
```python
# Source: src/maxpat/patcher.py (Patcher) + src/maxpat/aesthetics.py
from src.maxpat import Patcher
from src.maxpat.aesthetics import set_canvas_background
import json

p = Patcher()
set_canvas_background(p)  # Standard MAX 9 dark grey
patch_dict = p.to_dict()
path = project_dir / "generated" / f"{name}.maxpat"
path.write_text(json.dumps(patch_dict, indent=2))
```

### Example 5: Section Rebuild in /max-iterate
```python
# Source: src/maxpat/patcher.py (connected_components, remove_box, add_box)
from src.maxpat import read_patch, save_patch_roundtrip, validate_patch

patcher, original_text = read_patch("patch.maxpat")

# Find all objects in the oscillator section
components = patcher.connected_components()
osc_section = None
for component in components:
    if any(b.name == "cycle~" for b in component):
        osc_section = component
        break

# Remove the entire section
for box in osc_section:
    patcher.remove_box(box)

# Rebuild with new objects
new_osc = patcher.add_box("saw~", ["440"])
# ... build new section ...

# Validate and save
results = validate_patch(patcher)
save_patch_roundtrip(patcher.to_dict(), "patch.maxpat", original_text)
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| generate.py scripts create patches | Direct Patcher() -> write_patch() | Phase 17 (this phase) | No intermediary scripts; .maxpat is the single source of truth |
| /max-iterate modifies generate.py | /max-iterate reads/edits .maxpat directly | Phase 17 (this phase) | Surgical edits preserve user positioning and wiring |
| Validation rejects unknown objects | Unknown objects produce warnings | Phase 17 (this phase) | Third-party externals and packages accepted gracefully |
| No /max-onboard command | /max-onboard analyzes any .maxpat file | Phase 17 (this phase) | Users can onboard existing patches from any source |
| /max-new creates empty directory | /max-new creates empty .maxpat file | Phase 17 (this phase) | User can open project in MAX immediately |

**Deprecated/outdated after this phase:**
- generate.py scripts: Not created by any command. Existing scripts remain until Phase 18 cleanup.
- merge_and_write(): Not referenced by any command. Removed in Phase 18.
- incremental.py / Manifest: Not referenced by any command. Removed in Phase 18.

## Inventory of Files to Change

### Command Files (4 total)
| File | Change Type | Key Changes |
|------|-------------|-------------|
| `.claude/commands/max-build.md` | UPDATE | Remove generate.py references, document Patcher() -> generate_patch() -> write_patch() flow, add "already exists" warning step |
| `.claude/commands/max-iterate.md` | REWRITE | Analyze-first protocol, surgical/rebuild strategy, read_patch -> edits -> save_patch_roundtrip, auto-detect file |
| `.claude/commands/max-new.md` | UPDATE | Add empty .maxpat creation step after directory scaffolding |
| `.claude/commands/max-onboard.md` | NEW | read_patch() + analyze() command for onboarding existing patches |

### Specialist SKILL.md Files (6 total)
| File | Key Changes |
|------|-------------|
| `.claude/skills/max-patch-agent/SKILL.md` | Add "Editing Existing Patches" section with read_patch, find_box, modify_box, save_patch_roundtrip |
| `.claude/skills/max-dsp-agent/SKILL.md` | Add editing section for signal chain modifications |
| `.claude/skills/max-rnbo-agent/SKILL.md` | Add editing section for RNBO patch modifications |
| `.claude/skills/max-js-agent/SKILL.md` | Add editing section (js agent primarily edits code files, but may modify .maxpat js/node.script boxes) |
| `.claude/skills/max-ext-agent/SKILL.md` | Add editing section (externals agent rarely edits patches, but may update help patches) |
| `.claude/skills/max-ui-agent/SKILL.md` | Add editing section for UI/presentation modifications |

### Orchestration SKILL.md Files (3 total)
| File | Key Changes |
|------|-------------|
| `.claude/skills/max-lifecycle/SKILL.md` | Add empty .maxpat creation in project setup |
| `.claude/skills/max-router/SKILL.md` | Document /max-iterate routing includes analysis context |
| `.claude/skills/max-critic/SKILL.md` | Document critic loop for edit workflow (same protocol, different save path) |

### Source Code Files (2 total)
| File | Change Type | Key Changes |
|------|-------------|-------------|
| `src/maxpat/validation.py` | MINOR | `_validate_objects_exist`: change "Unknown object" from error to warning |
| `src/maxpat/project.py` | MINOR | `create_project()`: add empty .maxpat creation in generated/ directory |

### Test Files (2 total)
| File | Change Type | Key Changes |
|------|-------------|-------------|
| `tests/test_commands.py` | UPDATE | Add max-onboard to ALL_COMMANDS, add cross-reference tests for new/updated commands |
| `tests/test_agent_skills.py` | UPDATE | Add tests for editing API references in specialist SKILL.md files |

## Existing Test Assertions to Preserve

Critical: these existing tests MUST still pass after changes.

### In test_commands.py
- `test_build_references_max_router()` -- max-build.md must contain "max-router"
- `test_build_references_critic()` -- max-build.md must contain "max-critic" or "review_patch"
- `test_build_no_stub_labels()` -- max-build.md must not contain "stub"
- `test_iterate_references_router()` -- max-iterate.md must contain "max-router"
- `test_new_references_create_project()` -- max-new.md must contain "create_project"
- `test_new_references_lifecycle_skill()` -- max-new.md must contain "max-lifecycle"
- `test_total_command_count()` -- at least 10 command files (adding 11th is fine)
- All parametrized tests for frontmatter, description, minimum content (15 lines)

### In test_agent_skills.py
- `test_patch_agent_uses_add_connection()` -- must contain "add_connection", not ".connect(src"
- `test_patch_agent_write_patch_signature()` -- must contain "write_patch(patcher", not "write_patch(patch_dict"
- `test_dsp_agent_build_genexpr_signature()` -- must contain "build_genexpr(params, code_body"
- `test_dsp_agent_add_gen_signature()` -- must contain "add_gen(code"
- `test_dsp_agent_generate_gendsp_signature()` -- must contain "generate_gendsp(code, num_inputs"
- `test_js_agent_n4m_script_signature()` -- must contain "generate_n4m_script(handlers, dict_access"
- `test_js_agent_js_script_signature()` -- must contain "generate_js_script(num_inlets"
- All parametrized aesthetic/LayoutOptions tests for all 6 specialist agents
- All BOUNDARIES.md existence tests
- All frontmatter tests
- `test_total_skill_count()` -- at least 10 skill directories

### In test_validation.py
- Existing tests for _validate_objects_exist likely assert "error" level for unknown objects. These tests need updating when changing to "warning".

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pyproject.toml or pytest.ini (standard) |
| Quick run command | `python3 -m pytest tests/test_commands.py tests/test_agent_skills.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| MG-01 | /max-build references direct .maxpat workflow, no generate.py | unit | `python3 -m pytest tests/test_commands.py -x -q -k "build"` | Existing tests, need update |
| MG-02 | /max-iterate references read_patch, analyze, save_patch_roundtrip | unit | `python3 -m pytest tests/test_commands.py -x -q -k "iterate"` | Existing tests, need update |
| MG-03 | /max-new references empty .maxpat creation + create_project creates it | unit | `python3 -m pytest tests/test_commands.py tests/test_project.py -x -q -k "new or create"` | Existing + new |
| MG-04 | /max-onboard command exists with correct structure and references | unit | `python3 -m pytest tests/test_commands.py -x -q -k "onboard"` | New tests needed |
| MG-05 | All 6 specialist SKILL.md files reference editing API | unit | `python3 -m pytest tests/test_agent_skills.py -x -q` | Existing + new |
| MG-06 | Unknown objects produce warnings not errors | unit | `python3 -m pytest tests/test_validation.py -x -q -k "unknown"` | Existing tests, need update |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_commands.py tests/test_agent_skills.py tests/test_validation.py tests/test_project.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before /gsd:verify-work

### Wave 0 Gaps
- [ ] `tests/test_commands.py` -- add max-onboard to ALL_COMMANDS, add onboard cross-reference tests
- [ ] `tests/test_commands.py` -- add tests for updated max-build (no generate.py reference), max-iterate (read_patch, analyze, save_patch_roundtrip references)
- [ ] `tests/test_agent_skills.py` -- add tests for editing API references (read_patch, find_box, modify_box, save_patch_roundtrip) in specialist SKILL.md files
- [ ] `tests/test_validation.py` -- update unknown object tests to expect "warning" instead of "error"
- [ ] `tests/test_project.py` -- add test for empty .maxpat creation in create_project

## Open Questions

1. **Section rebuild scope determination**
   - What we know: connected_components() gives graph-based groups; analyze() shows named sections
   - What's unclear: When the user says "replace the oscillator section," how to map that to specific connected components
   - Recommendation: Use section names from analyze() + connected_components() grouping. The agent matches the user's description against section names, then identifies the component. This is agent discretion per CONTEXT.md.

2. **Auto-detect .maxpat file selection**
   - What we know: Single file case is trivial. Multiple files need heuristics.
   - What's unclear: Best heuristic for multi-file projects
   - Recommendation: Use filename matching against user description keywords. If user says "change the voice," look for files containing "voice" in name. If ambiguous, ask. This is agent discretion per CONTEXT.md.

3. **Validation test update scope**
   - What we know: _validate_objects_exist produces "error" for unknowns; tests likely assert this
   - What's unclear: Exact test assertions that need changing (need to read test_validation.py)
   - Recommendation: Read test_validation.py during implementation, update assertions from "error" to "warning" for unknown object tests

## Sources

### Primary (HIGH confidence)
- `src/maxpat/patcher.py` -- All edit methods verified: find_box, find_boxes, modify_box, insert_into_connection, replace_box, remove_box, connected_components, analyze (7 facets)
- `src/maxpat/hooks.py` -- read_patch, save_patch_roundtrip, write_patch verified
- `src/maxpat/__init__.py` -- generate_patch pipeline verified, all exports confirmed
- `src/maxpat/validation.py` -- Layer 2 unknown object handling verified (lines 203-238)
- `src/maxpat/project.py` -- create_project directory scaffolding verified (no .maxpat creation currently)
- `src/maxpat/critics/__init__.py` -- review_patch API verified
- `.claude/commands/max-build.md` -- Current workflow verified (routes through max-router)
- `.claude/commands/max-iterate.md` -- Current workflow verified (routes through max-router, reads existing files)
- `.claude/commands/max-new.md` -- Current workflow verified (creates project, no .maxpat)
- All 6 specialist SKILL.md files -- Current content and format verified
- All 3 orchestration SKILL.md files -- Current content verified
- `tests/test_commands.py` -- All test assertions catalogued
- `tests/test_agent_skills.py` -- All test assertions catalogued (including API signature tests)

### Secondary (MEDIUM confidence)
- None needed -- all findings are from direct source code and file inspection

### Tertiary (LOW confidence)
- None

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- all APIs exist, tested, verified by source inspection
- Architecture: HIGH -- dual workflow pattern is explicitly defined in CONTEXT.md locked decisions
- Pitfalls: HIGH -- test assertions catalogued from source, validation behavior traced through code
- File inventory: HIGH -- complete enumeration from directory listing and content analysis

**Research date:** 2026-03-16
**Valid until:** N/A -- this is an internal codebase research, not dependent on external library versions
