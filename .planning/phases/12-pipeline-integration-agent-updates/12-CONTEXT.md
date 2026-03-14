# Phase 12: Pipeline Integration & Agent Updates - Context

**Gathered:** 2026-03-13
**Status:** Ready for planning

<domain>
## Phase Boundary

Wire aesthetic styling (Phase 10) and layout improvements (Phase 11) into the main `generate_patch()` pipeline so users get polished patches by default. Update all 6 agent SKILL.md files with new aesthetic capabilities and cross-reference audit corrections against curated object lists. Agent docs do NOT need explicit outlet type corrections or validation notes -- the ObjectDatabase and validate_patch() pipeline handle that transparently.

</domain>

<decisions>
## Implementation Decisions

### Auto-styling in generate_patch()
- Always apply canvas background color (AESTHETIC_PALETTE["canvas_bg"]) -- agents don't need to remember to call set_canvas_background()
- No auto-panels -- panels are a project-level decision, surfaced during project discuss phase, not applied by default
- Always highlight dac~ and loadbang with subtle background color via set_object_bgcolor()
- Add optional `layout_options: LayoutOptions | None = None` parameter to generate_patch() -- passes through to apply_layout()

### Agent aesthetic documentation
- All 6 agents (patch, dsp, rnbo, js, ext, ui) get aesthetic capability documentation
- Format: method list with one-line "when to use" descriptions, matching existing "Key Functions" section style
- Document Patcher methods: add_section_header, add_subsection, add_annotation, add_bubble, add_panel, add_step_marker
- Document aesthetics.py helpers: set_canvas_background, set_object_bgcolor, auto_size_panel, is_complex_patch
- Document LayoutOptions in all agents: note generate_patch() accepts it, list key fields (v_spacing, h_gutter, grid_snap, inlet_align, comment_gap)

### Audit data in agent docs
- DB layer is enough for outlet type corrections -- ObjectDatabase merges overrides.json automatically, no duplication in SKILL.md
- Validation pipeline catches connection errors -- no need for agents to know about specific corrections
- Cross-reference DSP agent's curated object lists (oscillators, filters, etc.) against audit corrections and update descriptions where significant corrections were found

### Claude's Discretion
- LayoutOptions exported from public API (src.maxpat.__init__) alongside other public types
- Import path organization for new exports
- Exact wording and ordering of new SKILL.md sections
- Which audit corrections are "significant" enough to update in DSP agent's curated object lists

</decisions>

<specifics>
## Specific Ideas

- Panels should be a question in the discussion phase of new MAX projects (max-discuss skill), not a pipeline default
- Auto-styling should be invisible -- users just get better-looking patches without doing anything different

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- `aesthetics.py`: set_canvas_background(), set_object_bgcolor(), auto_size_panel(), is_complex_patch()
- `patcher.py`: add_section_header(), add_subsection(), add_annotation(), add_bubble(), add_panel(), add_step_marker()
- `defaults.py`: LayoutOptions dataclass, AESTHETIC_PALETTE dict
- `layout.py`: apply_layout() already accepts LayoutOptions parameter

### Established Patterns
- generate_patch() pipeline: apply_layout() -> to_dict() -> validate_patch() -> raise on errors
- Box.__new__(Box) bypass for structural/decorative objects (panels, step markers)
- SKILL.md "Key Functions" section format for method documentation
- TYPE_CHECKING imports in aesthetics.py to avoid circular dependencies

### Integration Points
- `src/maxpat/__init__.py`: generate_patch() signature change, LayoutOptions export
- 6 SKILL.md files: .claude/skills/max-{patch,dsp,rnbo,js,ext,ui}-agent/SKILL.md
- `defaults.py`: AESTHETIC_PALETTE keys for dac~/loadbang highlighting

</code_context>

<deferred>
## Deferred Ideas

- Panel auto-addition as a project-level preference in max-discuss flow -- future enhancement to project kickoff

</deferred>

---

*Phase: 12-pipeline-integration-agent-updates*
*Context gathered: 2026-03-13*
