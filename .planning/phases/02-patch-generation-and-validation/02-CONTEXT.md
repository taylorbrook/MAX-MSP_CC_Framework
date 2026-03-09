# Phase 2: Patch Generation and Validation - Context

**Gathered:** 2026-03-09
**Status:** Ready for planning

<domain>
## Phase Boundary

End-to-end .maxpat file generation with layout engine and multi-layer validation pipeline. Generates valid patches across all domains (Max, MSP, Jitter, MC) that open in MAX without errors, with readable layout and validated connections. Includes subpatchers, bpatchers, abstractions, and presentation mode. Code generation (Gen~, js, Node for Max) and agent orchestration are separate phases.

</domain>

<decisions>
## Implementation Decisions

### Layout algorithm
- Column-based layout: objects arranged in vertical columns by signal flow stage (source -> processing -> output)
- Column width is dynamic — determined by the widest object in that column, not a fixed pixel value
- Fixed gutter of ~60-80px between columns (right edge of widest object to left edge of next column)
- Objects within a column are left-aligned
- Top-to-bottom signal flow within columns (per CLAUDE.md conventions)
- ~80-120px vertical spacing between objects in a column (per CLAUDE.md)

### Box sizing
- Content-aware: box width calculated from the content/arguments (e.g., [message hello world] wider than [42])
- Matches how MAX auto-sizes boxes when the user types in them

### UI control placement
- UI control objects (sliders, dials, number boxes) positioned above the objects they control
- Maintains top-to-bottom flow — control parameters flow down into the signal chain

### Presentation mode
- When UI objects exist, auto-generate a basic presentation mode layout grouping controls together
- Both patching mode and presentation mode layouts included in generated patches

### Comments
- Section header comments label major groupings (e.g., "// OSCILLATOR", "// FILTER CHAIN")
- Inline comments on non-obvious connections explaining WHY a connection exists
- Both styles used together

### Send~/Receive~ naming
- Descriptive naming convention only (e.g., send~ lfo_to_filter) — self-documenting, no extra comment annotations needed

### Subpatcher strategy
- Subpatchers ([p name]) created for logical groupings of objects that work together, with descriptive names
- Abstractions (separate .maxpat files with #1 #2 argument substitution) used when the same object pattern repeats with different parameters
- Rule: inline subpatcher when one-off, abstraction when reused with varying arguments

### Validation pipeline
- Auto-fix + report: validation auto-fixes what it can (out-of-bounds connections removed, signal/control mismatches corrected) and reports what changed
- Blocks output only on unfixable structural errors
- Auto hook on .maxpat file write (FRM-05) — triggers validation immediately with zero user effort
- Multi-layer validation: JSON structure validity, object existence against database, connection bounds and type checks, domain-specific rules

### Domain-specific validation rules
- Unterminated signal chains: warn when MSP signal chains don't end at dac~, *~ 0., or send~
- Missing gain staging: warn when oscillators connect directly to dac~ without attenuation
- Hot/cold inlet ordering: warn when cold inlets receive data after the hot inlet
- Feedback loop detection: detect signal feedback loops lacking single-sample delay (tapin~/tapout~ or gen~ History)

### File conventions
- Output directory: patches/<project_name>/ under project root
- Flat structure within each project folder — no subdirectories by default
- Numeric prefixes for ordering: 00_main_patch.maxpat, 01_abstraction.maxpat, 02_gen_code.gendsp, etc.
- Main patch gets 00_ prefix like everything else
- Match MAX 9 defaults for metadata (fileversion, appversion, rect, editing_bgcolor, etc.)

### Generation scope
- Full single-patch complexity: any number of objects, subpatchers, abstractions, UI controls
- All domains supported: Max (control/MIDI/data), MSP (audio/signal), Jitter (video/matrix/GL), MC (multichannel)
- bpatcher generation included (patches that render UI inline in parent patch)
- Limit is "one main patch + its dependencies" — multi-patch project orchestration is Phase 4

### Claude's Discretion
- Generation engine implementation approach (Python library, direct JSON construction, or hybrid)
- Layout algorithm implementation details (topological sort internals, overlap resolution)
- Validation auto-fix strategies (which fixes are safe to apply automatically)
- bpatcher sizing and embedded UI mapping

</decisions>

<specifics>
## Specific Ideas

- Subpatchers should be created logically — if a group of objects work together, they get a subpatcher with a logical name
- Abstractions model: repeated sets of objects with different parameters saved as patches with #1 #2 argument substitution, called from the main patch as objects (MAX calls this an abstraction)
- User is an expert MAX/MSP user — patches should look like an experienced patcher made them

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- Object database: 2,012 objects across 8 domain JSON files (.claude/max-objects/) with full inlet/outlet metadata, signal/control types, hot/cold flags
- validate_db.py: 25-check validation script with quick/full/report modes — architectural model for patch validation
- aliases.json: common object shortcuts (t -> trigger, b -> bangbang, sel -> select)
- relationships.json: common object pairings (tapin~/tapout~, notein/stripnote)
- pd-blocklist.json: PD objects with MAX equivalents — useful for generation guard

### Established Patterns
- Python scripting: extraction, merge, and validation scripts all in Python (pytest for tests)
- JSON domain files: per-domain organization (max/, msp/, jitter/, mc/, gen/, m4l/, rnbo/, packages/)
- CLAUDE.md conventions: top-to-bottom flow, trigger for fan-out, spacing rules, PD confusion guard

### Integration Points
- Object database lookup: generation must verify every object exists before including it
- CLAUDE.md rules: generation must follow all rules (never guess objects, verify before connect, hot/cold ordering)
- validate_db.py pattern: patch validation script can follow same architecture (quick/full/report modes)
- File write hook: .maxpat writes trigger validation automatically (new hook infrastructure)

</code_context>

<deferred>
## Deferred Ideas

None — discussion stayed within phase scope

</deferred>

---

*Phase: 02-patch-generation-and-validation*
*Context gathered: 2026-03-09*
