# Requirements: MaxSystem v1.1

**Defined:** 2026-03-13
**Core Value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work — with as much automated validation as possible before manual testing.

## v1.1 Requirements

Requirements for v1.1 Patch Quality & Aesthetics milestone. Each maps to roadmap phases.

### Audit Pipeline

- [ ] **AUDIT-01**: Help patch parser recursively descends into subpatcher tabs to find all object instances across 973 .maxhelp files
- [ ] **AUDIT-02**: Parser filters degenerate instances (objects with numoutlets: 0 used as labels) and extracts outlet types only from connected instances
- [ ] **AUDIT-03**: Outlet type audit compares DB outlet signal/control types against help patch outlettype arrays and generates corrections
- [ ] **AUDIT-04**: Inlet/outlet count validation cross-references DB counts against help patch instances, accounting for variable_io argument configurations
- [ ] **AUDIT-05**: Per-object box width extraction captures actual patching_rect widths from help patches for accurate sizing
- [ ] **AUDIT-06**: Argument format extraction captures canonical argument patterns from help patch newobj text fields
- [ ] **AUDIT-07**: Connection pattern extraction parses all help patch connections to build per-object outlet-to-inlet frequency tables
- [ ] **AUDIT-08**: Audit produces human-readable diff report (audit-report.json) showing DB vs help patch discrepancies with confidence scores
- [ ] **AUDIT-09**: Batch override generation writes proposed overrides.json entries, never overwriting the existing 16+ manually corrected entries
- [ ] **AUDIT-10**: Coverage tracker identifies and prioritizes the 292 objects with empty inlet/outlet data in the current DB

### DB Corrections

- [ ] **DBCX-01**: High-confidence outlet type corrections merged into overrides.json and picked up automatically by db_lookup.py
- [ ] **DBCX-02**: Empty-I/O objects populated with help-patch-verified inlet/outlet data
- [ ] **DBCX-03**: All 624 existing tests continue to pass after DB corrections (regression gate)
- [ ] **DBCX-04**: Corrections organized by domain (max, msp, jitter, mc, gen, m4l, rnbo, packages) for reviewability

### Comment Styling

- [ ] **CMNT-01**: Section header comments rendered with configurable fontsize (14-18pt), fontface (bold), and textcolor
- [ ] **CMNT-02**: Bubble comment annotations with bubble outline, configurable bubbleside, and arrow pointing toward target object
- [ ] **CMNT-03**: Hierarchical comment system with three tiers: section header (16-18pt bold colored), subsection label (12pt bold), inline annotation (12pt italic/light)
- [ ] **CMNT-04**: Semantic color palette defines consistent colors for headers, annotations, and warnings across all generated patches

### Panels

- [ ] **PANL-01**: Panel objects created with bgfillcolor (solid color mode), rounded corners, border, and correct background layer placement
- [ ] **PANL-02**: Panels inserted at index 0 in boxes array AND carry background: 1 and ignoreclick: 1 for correct z-order
- [ ] **PANL-03**: Panel auto-sizing computes bounding box around positioned object groups with configurable padding
- [ ] **PANL-04**: Gradient panel support via bgfillcolor dict with type: "gradient", color1, color2, angle, proportion (capped below 1.0)
- [ ] **PANL-05**: Step marker numbering using textbutton circles with amber background, rounded=60, in background layer

### Patcher Styling

- [ ] **PTCH-01**: Patcher-level editing_bgcolor and locked_bgcolor set via patcher props for canvas background color
- [ ] **PTCH-02**: Object background color (bgcolor) applied to key architectural objects (loadbang, dac~, key processors) via extra_attrs

### Layout Refinements

- [ ] **LYOT-01**: Box width calculation improved using per-object width override table extracted from help patch measurements
- [ ] **LYOT-02**: Inlet-aligned cable routing positions child objects so inlets align under parent outlet X positions, reducing diagonal cables
- [ ] **LYOT-03**: 15px grid snapping rounds all object positions to MAX's native grid
- [ ] **LYOT-04**: Comment association placement positions comments near their target objects with consistent offset
- [ ] **LYOT-05**: LayoutOptions dataclass replaces module-level constants for configurable spacing, grid, and alignment parameters
- [ ] **LYOT-06**: Layout tests refactored to relative assertions before any spacing constant changes

### Agent Updates

- [ ] **AGNT-01**: Agent SKILL.md files updated with corrected outlet types and connection patterns from audit findings
- [ ] **AGNT-02**: Agent docs updated with aesthetic capabilities (comment styling, panels, layout options)

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
| AUDIT-01 | — | Pending |
| AUDIT-02 | — | Pending |
| AUDIT-03 | — | Pending |
| AUDIT-04 | — | Pending |
| AUDIT-05 | — | Pending |
| AUDIT-06 | — | Pending |
| AUDIT-07 | — | Pending |
| AUDIT-08 | — | Pending |
| AUDIT-09 | — | Pending |
| AUDIT-10 | — | Pending |
| DBCX-01 | — | Pending |
| DBCX-02 | — | Pending |
| DBCX-03 | — | Pending |
| DBCX-04 | — | Pending |
| CMNT-01 | — | Pending |
| CMNT-02 | — | Pending |
| CMNT-03 | — | Pending |
| CMNT-04 | — | Pending |
| PANL-01 | — | Pending |
| PANL-02 | — | Pending |
| PANL-03 | — | Pending |
| PANL-04 | — | Pending |
| PANL-05 | — | Pending |
| PTCH-01 | — | Pending |
| PTCH-02 | — | Pending |
| LYOT-01 | — | Pending |
| LYOT-02 | — | Pending |
| LYOT-03 | — | Pending |
| LYOT-04 | — | Pending |
| LYOT-05 | — | Pending |
| LYOT-06 | — | Pending |
| AGNT-01 | — | Pending |
| AGNT-02 | — | Pending |

**Coverage:**
- v1.1 requirements: 33 total
- Mapped to phases: 0
- Unmapped: 33 ⚠️

---
*Requirements defined: 2026-03-13*
*Last updated: 2026-03-13 after initial definition*
