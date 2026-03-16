# Phase 16: Patch Analysis - Context

**Gathered:** 2026-03-16
**Status:** Ready for planning

<domain>
## Phase Boundary

Structured patch understanding for any .maxpat file — produce a human-readable summary of what the patch does. Covers requirements AN-01 (structured summary), AN-02 (/max-onboard command), AN-03 (functional section detection).

Scope: analyze() method on Patcher, section detection, signal/control chain tracing, object inventory, parameter listing, complexity metrics, /max-onboard command. NOT agent migration (Phase 17) or pipeline cleanup (Phase 18).

</domain>

<decisions>
## Implementation Decisions

### Summary structure
- Analysis includes ALL of: signal flow chains, control flow paths, object inventory by domain, subpatcher hierarchy map, parameter/UI control list, and complexity metrics
- Both signal and control flow traced — MIDI input chains, loadbang initialization paths, message routing alongside audio chains
- Complexity metrics at the top: total objects, connections, max nesting depth, unique object types, domain breakdown percentages
- Signal chain presentation uses tree structure showing every fork and merge point — not linearized or flat list
- Concise overview by default — metrics summary, section list with 1-line descriptions, signal chain tree (object names), parameter list

### Section detection
- Primary heuristic: connected components (Phase 15's connected_components()) enhanced with send~/receive~ pair matching — objects linked by matching send~/receive~ names are treated as implicitly connected, merging those components
- Also resolve send/receive (control rate) pairs by matching names for section merging
- Auto-name sections from key/signature objects using a keyword-to-label mapping (cycle~ → "Oscillator", svf~ → "Filter", adsr~ → "Envelope", etc.) with fallback to "Section N"
- Name sections only — no inter-section relationship inference (modulation detection, sidechain identification, etc.)
- Section detection at top level only — subpatchers listed in hierarchy map but not further decomposed into sections

### Output format
- Markdown string returned directly from analyze() method
- analyze() is a Patcher method (not standalone module)
- /max-onboard prints analysis to conversation only — no file artifact saved
- Concise overview default — fits in a terminal screen for small-medium patches

### Unknown object handling
- Best-guess classification from naming heuristics: ~ suffix → signal/MSP domain, jit. prefix → Jitter, mc. prefix → multichannel, etc. Fallback to "External/Unknown"
- Silent classification — unknown objects included in normal inventory without flagging, goal is patch understanding not DB coverage
- Unknown ~ objects included in signal chain tracing — chain follows connections, not DB knowledge
- Send~/receive~ pairs resolved by matching name arguments and treated as implicit connections for both section detection and chain tracing

### Claude's Discretion
- Keyword-to-label mapping dictionary contents (which objects map to which section names)
- Signal chain tree rendering format details (indentation, arrow style, etc.)
- Control flow tracing depth and presentation
- Internal implementation of send~/receive~ name matching
- How parameter/UI controls are detected (by maxclass list vs DB metadata)
- Complexity metric calculation details

</decisions>

<specifics>
## Specific Ideas

- Send~/receive~ resolution is critical — many real-world patches use wireless connections heavily, and section detection would be misleading without it
- The same send~/receive~ resolution should work for both signal (send~/receive~) and control (send/receive) rate pairs
- Tree structure for signal chains should handle the common MAX pattern of stereo splits (one source feeding left/right processing chains)

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- `connected_components()` (patcher.py:2069): undirected BFS grouping — primary section detection primitive
- `signal_path()` (patcher.py:2040): traces ~ object chains — used for signal flow analysis
- `downstream()`/`upstream()` (patcher.py:1849/1876): full chain BFS with subpatcher crossing — used for control flow tracing
- `find_boxes()` (patcher.py:1100): recursive search by maxclass/name/text — used to find UI controls, send~/receive~ pairs, etc.
- `read_patch()` (hooks.py:84): load any .maxpat — /max-onboard entry point
- Object DB `domain` field: per-object domain classification for inventory grouping
- `_inner_patcher` on Box: access subpatcher contents for hierarchy mapping

### Established Patterns
- Graph traversal with `_build_adj()` — adjacency list pattern reusable for section detection
- `signal_only=True` flag on traversal methods — separates signal from control graph
- Box.name for object name, Box.maxclass for MAX class — used for domain classification heuristics

### Integration Points
- `patcher.py` Patcher class: new analyze() method
- Agent SKILL.md files: /max-onboard command documentation (Phase 17 will wire it up)
- Object DB domain files: provide authoritative domain classification for known objects
- `aliases.json`: resolve short names to canonical for consistent inventory counting

</code_context>

<deferred>
## Deferred Ideas

None — discussion stayed within phase scope

</deferred>

---

*Phase: 16-patch-analysis*
*Context gathered: 2026-03-16*
