# Requirements: MaxSystem v1.1

**Defined:** 2026-03-13
**Core Value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work — with as much automated validation as possible before manual testing.

## v1.1 Requirements

Requirements for v1.1 Patch Quality & Aesthetics milestone. Each maps to roadmap phases.

### Audit Pipeline

- [x] **AUDIT-01**: Help patch parser recursively descends into subpatcher tabs to find all object instances across 973 .maxhelp files
- [x] **AUDIT-02**: Parser filters degenerate instances (objects with numoutlets: 0 used as labels) and extracts outlet types only from connected instances
- [x] **AUDIT-03**: Outlet type audit compares DB outlet signal/control types against help patch outlettype arrays and generates corrections
- [x] **AUDIT-04**: Inlet/outlet count validation cross-references DB counts against help patch instances, accounting for variable_io argument configurations
- [x] **AUDIT-05**: Per-object box width extraction captures actual patching_rect widths from help patches for accurate sizing
- [x] **AUDIT-06**: Argument format extraction captures canonical argument patterns from help patch newobj text fields
- [x] **AUDIT-07**: Connection pattern extraction parses all help patch connections to build per-object outlet-to-inlet frequency tables
- [x] **AUDIT-08**: Audit produces human-readable diff report (audit-report.json) showing DB vs help patch discrepancies with confidence scores
- [x] **AUDIT-09**: Batch override generation writes proposed overrides.json entries, never overwriting the existing 16+ manually corrected entries
- [x] **AUDIT-10**: Coverage tracker identifies and prioritizes the 292 objects with empty inlet/outlet data in the current DB

### DB Corrections

- [x] **DBCX-01**: High-confidence outlet type corrections merged into overrides.json and picked up automatically by db_lookup.py
- [x] **DBCX-02**: Empty-I/O objects populated with help-patch-verified inlet/outlet data
- [x] **DBCX-03**: All 624 existing tests continue to pass after DB corrections (regression gate)
- [x] **DBCX-04**: Corrections organized by domain (max, msp, jitter, mc, gen, m4l, rnbo, packages) for reviewability

### Comment Styling

- [x] **CMNT-01**: Section header comments rendered with configurable fontsize (14-18pt), fontface (bold), and textcolor
- [x] **CMNT-02**: Bubble comment annotations with bubble outline, configurable bubbleside, and arrow pointing toward target object
- [x] **CMNT-03**: Hierarchical comment system with three tiers: section header (16-18pt bold colored), subsection label (12pt bold), inline annotation (12pt italic/light)
- [x] **CMNT-04**: Semantic color palette defines consistent colors for headers, annotations, and warnings across all generated patches

### Panels

- [x] **PANL-01**: Panel objects created with bgfillcolor (solid color mode), rounded corners, border, and correct background layer placement
- [x] **PANL-02**: Panels inserted at index 0 in boxes array AND carry background: 1 and ignoreclick: 1 for correct z-order
- [x] **PANL-03**: Panel auto-sizing computes bounding box around positioned object groups with configurable padding
- [x] **PANL-04**: Gradient panel support via bgfillcolor dict with type: "gradient", color1, color2, angle, proportion (capped below 1.0)
- [x] **PANL-05**: Step marker numbering using textbutton circles with amber background, rounded=60, in background layer

### Patcher Styling

- [x] **PTCH-01**: Patcher-level editing_bgcolor and locked_bgcolor set via patcher props for canvas background color
- [x] **PTCH-02**: Object background color (bgcolor) applied to key architectural objects (loadbang, dac~, key processors) via extra_attrs

### Layout Refinements

- [x] **LYOT-01**: Box width calculation improved using per-object width override table extracted from help patch measurements
- [x] **LYOT-02**: Inlet-aligned cable routing positions child objects so inlets align under parent outlet X positions, reducing diagonal cables
- [x] **LYOT-03**: 15px grid snapping rounds all object positions to MAX's native grid
- [x] **LYOT-04**: Comment association placement positions comments near their target objects with consistent offset
- [x] **LYOT-05**: LayoutOptions dataclass replaces module-level constants for configurable spacing, grid, and alignment parameters
- [x] **LYOT-06**: Layout tests refactored to relative assertions before any spacing constant changes

### Agent Updates

- [x] **AGNT-01**: Agent SKILL.md files updated with corrected outlet types and connection patterns from audit findings
- [x] **AGNT-02**: Agent docs updated with aesthetic capabilities (comment styling, panels, layout options)

## Future Requirements

### Deferred from v1.1

- **TMPL-01**: Template library for common MAX patterns (synthesis, sequencing, effects, control, Jitter)
- **M4L-01**: MAX for Live integration (Live API, device types, parameter mapping)
- **JITR-01**: Deep Jitter support (specialized agents, validation, templates for video/GL)
- **INTL-01**: Intelligent object selection — context-aware recommendations based on task
- **NLNG-01**: Patch-from-description natural language interface

## Out of Scope

Explicitly excluded. Documented to prevent scope creep.

| Feature | Reason |
|---------|--------|
| Patchline color/thickness changes | User preference — no patch cord visual changes in v1.1 |
| Custom MAX style definitions | Fragile external dependency, pollutes user's style library |
| Custom fonts beyond Arial | Cross-platform inconsistency — vary weight and size instead |
| Hidden connections for aesthetics | Debugging nightmare, violates visual programming paradigm |
| Aggressive color theming | Conflicts with user preferences, impairs readability |
| Help patch layout copying | Pedagogical layouts are not general-purpose — extract patterns, not positions |
| Presentation mode integration | Separate concern from patching mode aesthetics |

## Traceability

Which phases cover which requirements. Updated during roadmap creation.

| Requirement | Phase | Status |
|-------------|-------|--------|
| AUDIT-01 | Phase 8 | Complete |
| AUDIT-02 | Phase 8 | Complete |
| AUDIT-03 | Phase 8 | Complete |
| AUDIT-04 | Phase 8 | Complete |
| AUDIT-05 | Phase 8 | Complete |
| AUDIT-06 | Phase 8 | Complete |
| AUDIT-07 | Phase 8 | Complete |
| AUDIT-08 | Phase 8 | Complete |
| AUDIT-09 | Phase 8 | Complete |
| AUDIT-10 | Phase 8 | Complete |
| DBCX-01 | Phase 9 | Complete |
| DBCX-02 | Phase 9 | Complete |
| DBCX-03 | Phase 9 | Complete |
| DBCX-04 | Phase 9 | Complete |
| CMNT-01 | Phase 10 | Complete |
| CMNT-02 | Phase 10 | Complete |
| CMNT-03 | Phase 10 | Complete |
| CMNT-04 | Phase 10 | Complete |
| PANL-01 | Phase 10 | Complete |
| PANL-02 | Phase 10 | Complete |
| PANL-03 | Phase 10 | Complete |
| PANL-04 | Phase 10 | Complete |
| PANL-05 | Phase 10 | Complete |
| PTCH-01 | Phase 10 | Complete |
| PTCH-02 | Phase 10 | Complete |
| LYOT-01 | Phase 11 | Complete |
| LYOT-02 | Phase 11 | Complete |
| LYOT-03 | Phase 11 | Complete |
| LYOT-04 | Phase 11 | Complete |
| LYOT-05 | Phase 11 | Complete |
| LYOT-06 | Phase 11 | Complete |
| AGNT-01 | Phase 12 | Complete |
| AGNT-02 | Phase 12 | Complete |

**Coverage:**
- v1.1 requirements: 33 total
- Mapped to phases: 33
- Unmapped: 0

---
*Requirements defined: 2026-03-13*
*Last updated: 2026-03-13 -- traceability updated with phase mappings*
