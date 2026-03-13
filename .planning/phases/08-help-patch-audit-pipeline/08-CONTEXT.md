# Phase 8: Help Patch Audit Pipeline - Context

**Gathered:** 2026-03-13
**Status:** Ready for planning

<domain>
## Phase Boundary

Build an offline audit tool that parses all 2,101 .maxhelp files from the MAX installation, extracts ground truth object metadata (outlet types, inlet/outlet counts, box widths, argument formats, connection patterns), and identifies every discrepancy with the current object database. The tool does NOT merge corrections -- it produces proposed overrides for human review in Phase 9.

</domain>

<decisions>
## Implementation Decisions

### Audit tool design
- Claude decides tool location (src/maxpat/audit/ or tools/audit/ -- based on project conventions)
- Both a Python script (standalone invocation) and a thin slash command wrapper (/max-audit) for conversational access
- Single pass extraction with filtered views -- one traversal extracts all data types, flags/sub-commands filter the output (--outlets-only, --widths-only, etc.)
- Auto-detect MAX help path from /Applications/Max.app/Contents/Resources/C74/help/ (matching extraction-log.json), with --help-dir override flag

### Output format & reporting
- JSON as primary output format (machine-readable, diffable, filterable)
- Discrepancies organized by object -- each object gets one entry with all its discrepancies (outlets, inlets, widths, args)
- Confidence scoring based on instance count: more help patch instances agreeing = higher confidence (e.g., 5/5 instances agree = high, 2/3 = medium)
- Audit output files live at .claude/max-objects/audit/ -- co-located with the database they audit

### Help patch parsing strategy
- Full recursive descent into all subpatcher tabs -- help files use tabs like 'Basic', 'Details', 'Arguments' containing real object instances
- Parse all 2,101 .maxhelp files (not just 973 estimate) -- more data = better corrections
- Degenerate instance filtering: skip instances that have zero connections AND whose numoutlets/numinlets don't match the DB -- catches label objects without discarding legitimate sink objects (print, send, dac~ etc. with 0 outlets are kept)
- Build per-object outlet-to-inlet connection frequency tables -- valuable for validating outlet types (signal outlets should connect to signal inlets)

### Override generation & safety
- Generate proposed-overrides.json as a separate file -- never auto-merge into overrides.json
- Manual merge happens in Phase 9 after human review
- Flag conflicts with existing manual corrections in overrides.json, never overwrite -- manual entries are always authoritative
- Claude's Discretion: proposed overrides format (exact match vs extended with metadata)

### Claude's Discretion
- Tool location within project structure
- Proposed overrides format details (whether to include audit metadata inline or keep it pure)
- Internal architecture (class structure, module organization)
- Test strategy for the audit tool itself

</decisions>

<specifics>
## Specific Ideas

- Objects with 0 outlets (print, send, send~, dac~, thispatcher) are legitimate -- parser must not filter these out just because numoutlets is 0
- The real degenerate case is objects used as labels in help patches: no connections AND I/O counts that don't match the DB (MAX allows manual inspector overrides)
- Existing overrides.json has 16+ manually corrected entries (buffer~, info~, line~, curve~, play~, sfplay~, multislider, etc.) that represent expert knowledge and must be protected

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- `db_lookup.py` (ObjectDatabase class): Full object lookup, alias resolution, variable I/O computation, outlet type computation -- audit tool needs this to compare DB vs help patch data
- `overrides.json`: Current manual corrections with established format (objects dict, variable_io_rules, version_map) -- proposed overrides must match this structure
- `extraction-log.json`: Records original extraction source path and per-domain counts -- audit can reference this for baseline stats

### Established Patterns
- Object database is JSON-per-domain under .claude/max-objects/{domain}/objects.json
- Overrides are deep-merged onto base objects at load time (db_lookup.py _load method)
- Outlet types use string convention: "signal", "", "multichannelsignal"
- Validation pipeline (validation.py) consumes outlet type data for connection checking

### Integration Points
- Help patches at /Applications/Max.app/Contents/Resources/C74/help/ (subdirs: max/, msp/, jitter/, m4l/)
- Help files are .maxpat JSON format -- same structure as generated patches (patcher/boxes/lines)
- Audit output feeds into Phase 9 (Object DB Corrections) for merge review
- Box width data feeds into Phase 11 (Layout Refinements) for LYOT-01

</code_context>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope

</deferred>

---

*Phase: 08-help-patch-audit-pipeline*
*Context gathered: 2026-03-13*
