# Project Research Summary

**Project:** MaxSystem v1.1 — Object DB Audit, Patch Aesthetics, Refined Positioning
**Domain:** MAX/MSP development framework tooling
**Researched:** 2026-03-13
**Confidence:** HIGH

## Executive Summary

v1.1 is a quality milestone for an existing, working MAX patch generation framework. The v1.0 system produces functionally valid patches using a custom Python stack (`patcher.py`, `layout.py`, `db_lookup.py`, `validation.py`) with 624 passing tests. The v1.1 work divides cleanly into two independent tracks: (1) correctness — audit ~973 MAX help patches to extract ground truth object metadata and fix outlet type errors in the database; and (2) aesthetics — add visual polish (panels, styled comments, background layering, color system) so generated patches look professionally authored rather than machine-generated. Both tracks operate within the existing Python stdlib-only architecture with no new dependencies.

The recommended approach is to treat the audit track as the higher-priority foundation. Outlet type errors are not cosmetic — they break connection validation for mixed signal/control objects like `line~`, `sfplay~`, and `curve~`. The help patch format is identical JSON to `.maxpat`, parses in 0.17s for all 973 files, and provides authoritative `outlettype` arrays. The audit produces corrections into the existing `overrides.json` mechanism, which `db_lookup.py` already deep-merges with no code changes. The aesthetics track is then a clean post-audit addition: a new `aesthetics.py` module runs after layout and before serialization, adding panels and comment styling through the existing `Box.extra_attrs` mechanism.

The key risks are concentrated in the audit track. Help patches use a tab-based structure where all object examples are buried in subpatcher tabs — a shallow parser finds nothing. Multiple instances of the same object appear with different argument configurations, making naive extraction produce wrong outlet types. And bulk writes to domain JSON files would silently corrupt 16 manually verified overrides. The aesthetics track has lower overall risk, with the main gotchas being panel z-order (panels must appear first in the `boxes` array AND carry `background: 1`) and the undocumented `bgfillcolor` dict format, which requires capping `proportion` below 1.0 and visual validation in MAX.

## Key Findings

### Recommended Stack

The project's custom Python-only stack continues unchanged. Every v1.1 capability is achievable with Python stdlib (`json`, `pathlib`, `collections`, `csv`) and the existing codebase. The stack originally proposed in v1.0 (py2max, Zod, SQLite, fast-xml-parser) was never adopted and should not be introduced now. The custom Patcher/Box/Patchline model is well-tested and already supports aesthetic properties via `Box.extra_attrs`.

**Core technologies:**
- `Python 3.14` (stdlib only) — all parsing, analysis, generation; no new dependencies warranted
- `src/maxpat/patcher.py` — extended with `add_panel()` convenience method and aesthetic property support
- `src/maxpat/defaults.py` — new aesthetic constants derived from empirical analysis of 973 help patches
- `src/maxpat/layout.py` — refined with `LayoutOptions` dataclass, inlet-aligned positioning, grid snapping
- `src/maxpat/aesthetics.py` (new) — post-layout, pre-serialization visual styling pass
- `src/maxpat/help_audit.py` (new) — standalone offline audit tool; does not touch the generation pipeline
- `.claude/max-objects/overrides.json` — correction target for audit results; `db_lookup.py` already loads it automatically

See [STACK.md](./STACK.md) for complete stack analysis.

### Expected Features

**Must have (table stakes — audit):**
- Help patch parser with recursive subpatcher descent — without this, zero objects are audited
- Outlet type audit and `overrides.json` correction generation — fixes the #1 source of broken connections
- Override-aware mode — never overwrite the 16 manually corrected entries already in overrides.json

**Must have (table stakes — aesthetics):**
- Section header comments (fontsize, fontface, textcolor) — removes "wall of plain text" appearance
- Panel objects with background layer — primary visual grouping tool in every professional MAX patch
- Bubble comment annotations — standard MAX annotation idiom for explaining non-obvious objects
- Background layer attribute (`background: 1` + array-first placement) — without this, panels cover objects

**Should have (differentiators):**
- Semantic color system (palette constants for headers, annotations, warnings)
- Hierarchical comment styling (three tiers: section header / subsection label / inline annotation)
- Panel auto-sizing around object groups (computes bounding box, saves manual measurement)
- Patchline color coding by signal type (audio vs. control)
- Step marker numbering (numbered textbutton circles, amber background, `rounded=60`)
- Grid snapping to 15px (aligns generated patches to MAX's native grid)
- Inlet-aligned cable routing (reduces diagonal cables by aligning child inlets under parent outlets)

**Defer (v2+):**
- Custom MAX style definitions (fragile external dependency, pollutes user's style library)
- Custom fonts beyond Arial (cross-platform inconsistency)
- Hidden connections for aesthetics (debugging nightmare)
- Aggressive color theming (conflicts with user preferences)
- Help patch layout copying (pedagogical layouts are not general-purpose)

See [FEATURES.md](./FEATURES.md) for complete feature analysis including effort estimates (~30-50h total aesthetics).

### Architecture Approach

The architecture follows the existing pipeline model with two new modules inserted at the correct points. `help_audit.py` is a standalone offline tool that touches only `overrides.json` (data, not code). `aesthetics.py` is a new pipeline step between `apply_layout()` and `to_dict()`. All other files receive only additive changes: new methods, new constants, one new optional parameter. `db_lookup.py` and `hooks.py` remain entirely unchanged.

**Major components:**
1. `help_audit.py` (new) — `HelpPatchAuditor` class parses 973 `.maxhelp` files via recursive subpatcher descent, extracts outlet types from connected instances only, compares against `ObjectDatabase`, writes proposed entries to `overrides.json` and a human-readable `audit-report.json`
2. `aesthetics.py` (new) — `PatchStyle` dataclass with predefined styles (DEFAULT, MSP, CONTROL, INIT); `add_section_panel()` runs post-layout to size panels around positioned boxes; `style_comment()` sets font/color via `Box.extra_attrs`
3. `layout.py` (modified) — `LayoutOptions` dataclass replaces module-level constants; `_parent_alignment_x()` uses outlet/inlet indices instead of parent center; `_snap_to_grid()` rounds positions to 15px; layout tests refactored to relative assertions before constants change
4. `patcher.py` (modified, minor) — `add_panel()` convenience method; panels inserted at index 0 in `boxes` array for correct render order
5. `defaults.py` (modified, minor) — aesthetic constants derived from help patch analysis (HELPFILE_COMMENT_FONTSIZE=13.0, PANEL_DEFAULT_BGCOLOR=[0.87, 0.84, 0.82, 1.0], STEP_MARKER_BGCOLOR, etc.)

See [ARCHITECTURE.md](./ARCHITECTURE.md) for complete component design with code sketches and the parallelization map.

### Critical Pitfalls

1. **Recursive subpatcher descent required** — Help patches store ALL example content in `showontab: 1` subpatchers. A shallow parser finds zero instances of the target object. Must recursively descend into all nested patchers. After parsing, verify found instance count > 0 or flag the file as failed.

2. **Filter degenerate instances before extracting outlet types** — Help patches contain multiple instances with different argument configs AND degenerate instances (e.g., `buffer~` with `numoutlets: 0` used as a label). Extract only from instances that have connections FROM them. Track outlet types per argument configuration for variable-I/O objects.

3. **Never overwrite manual overrides during bulk update** — `overrides.json` contains 16 manually corrected MSP outlet types plus the `multislider fetch` correction. These are hard-won ground truth. The audit pipeline must load `overrides.json` first and skip any object already manually corrected. All audit results go to `overrides.json` additions only; never modify domain JSON files.

4. **Fix box width calculation before fixing cable routing** — The current formula (`len(text) * 7.0 + 16.0`) has up to 59px error. This compounds into inlet/outlet X position errors in midpoint generation. Fix sizing first (per-object override table from help patch measurements), then recalibrate routing.

5. **Panel z-order requires both `background: 1` AND array-first placement** — Use `patcher.boxes.insert(0, panel_box)` not `add_box()`. Also set `"ignoreclick": 1`. Either property alone is insufficient.

6. **Refactor layout tests before changing spacing** — `test_layout.py` has pixel range assertions calibrated for `V_SPACING=20`. Refactor to relative assertions (`gap >= V_SPACING * 0.8`) first, then change constants. Reversing this order turns one improvement into a mass test failure event.

See [PITFALLS.md](./PITFALLS.md) for all 16 pitfalls with evidence, consequences, and detection strategies.

## Implications for Roadmap

Based on combined research, the natural phase structure is driven by three constraints: (a) correctness before aesthetics, (b) sizing accuracy before cable routing, and (c) test stability before spacing changes.

### Phase 1: Help Patch Audit Pipeline

**Rationale:** Correctness work first. Outlet type errors produce broken patches — aesthetics do not. The audit is a standalone tool with zero risk to the existing generation pipeline. Building it also produces the per-object width measurements needed in Phase 4 as a byproduct.
**Delivers:** `src/maxpat/help_audit.py`, `audit-report.json`, proposed `overrides.json` entries for human review, per-object actual box width data extracted from help patches
**Addresses:** Outlet type audit, inlet/outlet count validation, argument format extraction, coverage mapping for 292 empty-I/O objects
**Avoids:** Pitfalls 1 (degenerate instances), 2 (override merge order), 3 (tab structure), 9 (maxclass mapping), 11 (stale version data), 14 (priority targeting), 15 (operator coverage gaps)

### Phase 2: Object DB Corrections

**Rationale:** Data task, not code task. Run the Phase 1 pipeline, review the diff report, merge approved high-confidence corrections into `overrides.json`. The 16 manually corrected entries and the existing 624-test suite serve as a regression gate. Prioritize the 292 objects with empty inlets or outlets — these are guaranteed improvements with no conflict risk.
**Delivers:** Expanded `overrides.json` with help-patch-verified outlet types; `db_lookup.py` picks up all corrections automatically (no code changes)
**Avoids:** Pitfall 2 (never modify domain JSON files), Pitfall 14 (prioritize empty-I/O objects first)

### Phase 3: Aesthetic Foundations

**Rationale:** Can run in parallel with Phase 2 since these touch entirely different files. Comment styling and the background layer attribute are low-risk additions via `Box.extra_attrs`. Panel support requires `add_panel()` and correct array ordering but does not affect any existing code paths. Validate `bgfillcolor` dict format by opening test patches in MAX — this cannot be verified offline.
**Delivers:** `src/maxpat/aesthetics.py`, `add_panel()` on Patcher, aesthetic constants in `defaults.py`, styled section header comments, panel objects with correct z-order, patcher background color support, bubble comment annotations
**Addresses:** All FEATURES.md table stakes aesthetics; must-have differentiators (semantic colors, hierarchical comments, step markers)
**Avoids:** Pitfalls 5 (bgfillcolor dict format), 6 (panel z-order), 7 (comment property names differ from other boxes), 12 (presentation mode conflicts), 13 (style system conflicts — do not use patcher `style` property in v1.1)

### Phase 4: Layout Refinements

**Rationale:** Can also run in parallel with Phase 2. But layout tests MUST be refactored to relative assertions before changing any spacing constants — this is a hard prerequisite step within the phase. Fix sizing accuracy (per-object override table using Phase 1 width measurements) before fixing cable routing, since routing errors compound from sizing errors.
**Delivers:** `LayoutOptions` dataclass, inlet-aligned cable positioning, 15px grid snapping, comment association placement, improved box sizing with per-object override table, recalibrated midpoint routing
**Addresses:** FEATURES.md differentiators (grid alignment, inlet alignment, panel auto-sizing integration)
**Avoids:** Pitfalls 4 (width calculation error), 8 (brittle tests — refactor first), 10 (compound routing error from width error)

### Phase 5: Pipeline Integration and Agent Updates

**Rationale:** Integrates Phase 3 and Phase 4 into the main `generate_patch()` pipeline. Aesthetics are opt-in via parameter to prevent regressions for existing callers. Aesthetic validation issues are info-level only — never blocking. Update agent SKILL.md files with corrected object patterns and new aesthetic capabilities after both the DB corrections (Phase 2) and pipeline (this phase) are complete.
**Delivers:** Updated `generate_patch(aesthetics=True)` in `__init__.py`; aesthetic validation as info-level in `validation.py`; updated agent documentation reflecting corrected outlet types and aesthetic capabilities
**Implements:** Full pipeline: Patcher → `apply_layout()` → `apply_aesthetics()` → `to_dict()` → `validate_patch()`

### Phase Ordering Rationale

- Phases 1 and 2 sequence together: audit pipeline must run before corrections can be reviewed.
- Phases 3 and 4 can run in parallel with Phase 2 — they operate on different files with no shared state.
- Phase 5 depends on both Phase 3 and Phase 4 being complete but does not require Phase 2 (DB corrections are data-level, not pipeline-level).
- Overall dependency structure: `1 → 2 → (5 depends on 2 for agent docs)`, `3 → 5`, `4 → 5`.
- Do not let aesthetics work block on DB corrections. The two tracks are independent.

### Research Flags

Phases with well-documented patterns (skip additional research):
- **Phase 2:** Pure data review task. Diff report from Phase 1 provides everything needed for decisions.
- **Phase 3:** All aesthetic properties are fully verified from official docs and real `.maxpat` file analysis. Panel format, comment styling, and bgfillcolor structure are documented in FEATURES.md with validated JSON examples.
- **Phase 5:** Pipeline integration is a straightforward parameter addition and documentation update.

Phases that may benefit from targeted investigation during planning:
- **Phase 1:** The help patch coverage mapping for operators and MC objects (Pitfall 15) needs concrete resolution before building the coverage tracker. Low risk — scoping work, not architectural.
- **Phase 4:** The proportional character width table for sizing accuracy benefits from Phase 1 data. Extract actual widths during Phase 1 as a byproduct to avoid a second pass through help patches.

## Confidence Assessment

| Area | Confidence | Notes |
|------|------------|-------|
| Stack | HIGH | Verified against existing codebase. All recommendations extend what already works. No new dependencies. |
| Features | HIGH (audit) / MEDIUM (aesthetics) | Audit features verified against actual `.maxhelp` JSON. Aesthetic properties verified from official docs and real `.maxpat` files; "what looks professional" retains a subjective component. |
| Architecture | HIGH | All recommendations based on direct codebase analysis. Integration points (`Box.extra_attrs`, `patcher.props`, `overrides.json` merge) are confirmed working patterns. |
| Pitfalls | HIGH (parsing + DB) / MEDIUM (bgfillcolor) | Parsing and DB pitfalls verified against actual help patches and source code. The `bgfillcolor` dict format is reverse-engineered — no official schema exists. |

**Overall confidence:** HIGH

### Gaps to Address

- **Proportional character width table:** Sizing error analysis (Pitfall 4) has measurements for 6 objects. A fuller table requires help patch analysis. Build width extraction into the Phase 1 audit tool as a byproduct. Interim fix: operator override table (short objects like `+`, `-` get minimum ~90px).
- **bgfillcolor rendering validation:** Cannot be verified offline. Visual validation of generated panels must be done by opening test patches in MAX 9. Plan for a "panel gallery" test patch as a Phase 3 deliverable.
- **Help patch coverage for 738 un-covered objects:** Operators, MC wrappers, and Gen internals share help files. Accept ~56% direct coverage (934/1,672 objects) as sufficient for v1.1 and document the remainder as known gaps tracked in `audit-report.json`.
- **bgfillcolor behavior across MAX versions:** Some help patches were saved in older MAX versions. All visual validation should target MAX 9, not inferred from MAX 8 documentation alone.

## Sources

### Primary (HIGH confidence)
- `/Applications/Max.app/Contents/Resources/C74/help/` — 973 .maxhelp files; `trigger.maxhelp`, `buffer~.maxhelp`, `attrui.maxhelp` analyzed directly
- `/Users/taylorbrook/Dev/MAX/src/maxpat/` — entire codebase read; all integration points confirmed
- [Color and the Max User Interface (Max 8)](https://docs.cycling74.com/max8/vignettes/max_colors) — patcher-level color properties
- [Panel Reference (Max 8)](https://docs.cycling74.com/max8/refpages/panel) — panel object attributes
- [Comment Reference (Max 8)](https://docs.cycling74.com/max8/refpages/comment) — comment styling attributes
- [Common Box Attributes (Max 5+)](https://docs.cycling74.com/max5/refpages/max-ref/jbox.html) — universal box properties
- [Foreground and Background Layers (Max 7)](https://docs.cycling74.com/max7/vignettes/background) — layer system

### Secondary (MEDIUM confidence)
- [HfMT-ZM4/WFS-Server](https://github.com/HfMT-ZM4/WFS-Server/blob/master/wfs.gui.cpu.maxpat) — bgfillcolor gradient dict structure verified from real .maxpat
- [Vimeo/vimeo-maxmsp](https://github.com/vimeo/vimeo-maxmsp/blob/master/n4m-vimeo/player.maxpat) — styled comments and gradient messages
- [Scripting Panel Gradients (Forum)](https://cycling74.com/forums/scripting-panel-gradients) — proportion limit gotcha, pt1/pt2 vs angle conflict
- [Tips on structuring/laying out patches (Forum)](https://cycling74.com/forums/tips-on-structuringlaying-out-patches) — layout conventions
- [Panel bgfillcolor attributes (Forum)](https://cycling74.com/forums/panel-bgfillcolor-attributes-how-to-specify-as-3-floats) — proportion capping requirement

### Tertiary (project memory, LOW confidence without fresh verification)
- `feedback_msp_outlet_types.md` — 16 corrected MSP objects; confirms audit priority
- `feedback_layout_spacing.md` — V_SPACING=20, H_GUTTER=15 tight spacing requirements
- `feedback_multislider_fetch.md` — confirms fetch/fetchindex and outlet 1 issue

---
*Research completed: 2026-03-13*
*Ready for roadmap: yes*
