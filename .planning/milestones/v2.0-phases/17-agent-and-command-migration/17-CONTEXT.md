# Phase 17: Agent and Command Migration - Context

**Gathered:** 2026-03-16
**Status:** Ready for planning

<domain>
## Phase Boundary

Rewire all slash commands (/max-build, /max-iterate, /max-new, /max-onboard) and all 6 specialist agent SKILL.md files to use the direct .maxpat editing API (read_patch, find_box, modify_box, insert_into_connection, replace_box, analyze, save_patch_roundtrip) instead of the Python generation pipeline. Adapt validation hooks for the edit workflow. Covers requirements MG-01 through MG-06.

NOT: migrating existing project patches (Phase 18), removing generate.py scripts (Phase 18), removing incremental.py or manifests (Phase 18).

</domain>

<decisions>
## Implementation Decisions

### Iteration workflow (/max-iterate)
- Always run analyze() first and show the summary before asking what to change -- gives agent and user shared context of the patch
- Agent chooses between surgical edit (find_box/modify_box/replace_box) for small changes and section rebuild (remove group + recreate) for larger changes -- decision is transparent, agent explains approach before executing
- Always run critic loop after edits -- same quality gate as fresh builds (validate + critic review on modified patch)
- Preserve all existing objects unconditionally -- only modify what user explicitly asks to change
- Warn before proceeding if requested edit would affect objects the user added manually (e.g., removing an object that user-added objects connect to)
- Auto-detect which .maxpat to edit from context: single file = use it, multiple files = infer from user's description, only ask when ambiguous

### Build workflow (/max-build)
- /max-build always creates new .maxpat files from scratch via Patcher() -> generate_patch() -> write_patch()
- If target .maxpat already exists, warn and offer overwrite or redirect to /max-iterate
- Can create multiple .maxpat files in same project (main patch, voice subpatcher, effects chain, etc.) -- each /max-build creates a new file
- No generate.py script is ever created by /max-build

### Project scaffolding (/max-new)
- Keep generated/ subdirectory for .maxpat output files -- existing projects don't need reorganization
- Create an empty .maxpat (valid empty patcher with canvas background color) on project creation -- user can open it in MAX immediately
- Clean break: no generate.py created for new projects
- Existing projects (kicksynth, scala-synth, etc.) stay as-is until Phase 18 cleanup

### Save paths
- New patches: Patcher() -> build -> generate_patch() -> write_patch() (includes layout + validation)
- Edited patches: read_patch() -> surgical edits -> validate -> save_patch_roundtrip() (no layout, preserves positions and indentation)
- generate_patch() is only for initial creation -- never runs on edited patches

### Validation for edits (MG-06)
- Do not reject unknown objects on load -- third-party externals and packages must be accepted gracefully
- Validate on demand after edits, not during load
- Critic loop runs after every iterate session (same as build)
- save_patch_roundtrip() never triggers auto-layout

### Agent SKILL.md updates (MG-05)
- All 6 specialist agents (patch, dsp, rnbo, js, ext, ui) updated to reference direct editing API
- Document dual workflow: create new (Patcher + generate_patch + write_patch) AND edit existing (read_patch + find/modify/insert/replace + save_patch_roundtrip)
- Carry forward existing Phase 12 format: "Key Functions" sections, aesthetic capability documentation

### Claude's Discretion
- Exact wording and organization of SKILL.md updates
- How section rebuild scope is determined (which objects constitute a "section")
- How auto-detect chooses the right .maxpat file from user description
- Implementation of the "already exists" warning in /max-build
- /max-onboard implementation details (straightforward from Phase 16 analyze())

</decisions>

<specifics>
## Specific Ideas

- /max-iterate showing analysis first mirrors the "visionary/builder" model -- user sees what exists, then describes what they want changed, agent figures out how
- The surgical-vs-rebuild choice by the agent should be explained: "This is a small change, I'll modify the filter in place" vs "This changes the whole oscillator section, I'll rebuild it and reconnect to your effects chain"
- Warning on conflict with user-added objects prevents the frustrating case where iterate silently breaks something the user carefully wired up in MAX

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- `read_patch()` (hooks.py): loads .maxpat into Patcher + returns original_text for roundtrip save
- `save_patch_roundtrip()` (hooks.py): saves preserving indentation, no layout
- `analyze()` (patcher.py): 7-facet patch analysis with section detection, signal chains, inventory
- `find_box()`/`find_boxes()` (patcher.py): search by name/maxclass/text with recursive subpatcher search
- `modify_box()` (patcher.py): in-place attribute editing with I/O recomputation
- `insert_into_connection()` (patcher.py): insert object between connected objects
- `replace_box()` (patcher.py): swap object type, returns orphaned connections
- `remove_box()` (patcher.py): remove with automatic patchline cleanup
- `connected_components()` (patcher.py): identify groups for section rebuild scope
- `generate_patch()` (__init__.py): layout + serialize + validate for new patches
- `write_patch()` (hooks.py): write .maxpat with validation for new patches
- `validate_patch()` (validation.py): 4-layer validation pipeline
- `review_patch()` (critics.py): deterministic critic review (DSP, structure, RNBO, external)

### Established Patterns
- Dual-path serialization: _raw round-trip path vs creation path in Box.to_dict()
- EditResult dataclass returns orphaned connections from modify/replace operations
- Critic loop protocol: generate -> review -> classify -> handle blockers -> approve
- Agent SKILL.md "Key Functions" format from Phase 12

### Integration Points
- 6 specialist SKILL.md files: .claude/skills/max-{patch,dsp,rnbo,js,ext,ui}-agent/SKILL.md
- 3 orchestration SKILL.md files: .claude/skills/max-{lifecycle,router,critic}/SKILL.md
- Lifecycle references: project-structure.md, status-tracking.md, test-protocol.md
- hooks.py: may need thin wrapper for edit-validate-save path
- __init__.py: export read_patch, save_patch_roundtrip, EditResult if not already exported

</code_context>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope

</deferred>

---

*Phase: 17-agent-and-command-migration*
*Context gathered: 2026-03-16*
