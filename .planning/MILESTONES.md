# Milestones

## v5.0 DB Schema Hardening + Validator Depth (Shipped: 2026-05-01)

**Phases completed:** 5 phases (28-32), 24 plans, 37 tasks
**Timeline:** 5 days (2026-04-27 to 2026-05-01)
**Stats:** 204 commits, 344 files modified, +52,496/-13,921 lines, ~45,300 LOC Python
**Requirements:** 28/28 satisfied (SCHEMA-01..07, VALID-01..05, MSPCOV-01..05, LAYOUT-01..05, DSPSIM-01..05)
**Audit:** tech_debt — 28/28 reqs satisfied, 3/3 E2E flows pass; 32 tracked tech-debt items + 4 Phase 31 human-UAT runtime checks deferred (see `.planning/milestones/v5.0-MILESTONE-AUDIT.md`)

**Delivered:** Promoted the object database from flat extracted facts to a typed, install-aware contract; taught validators and critics to read the richer schema with role-aware errors and a domain-restriction hard guard; codified four layout/UX recipes as builder APIs; added a numpy-based DSP pre-flight simulator that catches waveguide stability bugs before patches ship.

**Key accomplishments:**

1. **Schema foundation (Phase 28)** — Typed `signal_role` (audio / trigger / status / float / data / list), `domain_restricted`, and `verified_installed` fields land as first-class with a fail-fast validator and a `signal_role → signal:bool` write-through projection that keeps every existing consumer working. Five new getter methods + three sibling audit functions (`audit_empty_io`, `audit_install_coverage`, `audit_domain_coverage` per D-12) surface coverage gaps as focused entry points.
2. **Validator depth (Phase 29)** — Layer-3 emits role-aware ERROR with mechanical-fix suggestions ("use snapshot~", "use sig~ or click~") for status/trigger/data/list→signal mismatches; Layer-4b hard-blocks RNBO-only objects (`floor~`) at MSP top level with an explicit domain-restriction error; lookup-time install-state warnings fire on `verified_installed: false`; Layer-5 walker pulls embedded gen~ codeboxes into `validate_genexpr` so `.maxpat` patches and standalone `.gendsp` files get the same DSP rigor (delay/clip rejection, init-before-if/else flow analysis).
3. **MSP outlet coverage sweep (Phase 30)** — All 16 existing MSP outlet-type overrides migrated from `signal: bool` to `signal_role`; ~80 previously unverified MSP objects (`saw~`, `*~`, `noise~`, `sig~`, `gen~`, `selector~`, etc.) populated; sibling-auto-mirror code path drove MC `gap_count` from 215 → 0 via inlet+outlet parity gate; bulk audit script committed alongside migration.
4. **Layout & UX builders (Phase 31)** — Four builders codify CLAUDE.md prose recipes into APIs: `add_overlay_readout` (Rule #6 bring_to_front + ignoreclick=1, flonum/comment/number variants with `numdecimalplaces`), `add_labeled_param_bank` (multislider size×24 formula with pixel-aligned comment labels), `add_m4l_gen_synth` (gen~ varname + live.dial `param_connect` bindings, no `gain~` before `plugout~`), and a role-driven companion auto-place dispatch consuming Phase 30's curated `signal_role` data with overlay placement and a single-parent guard. `max-patch-agent` and `max-ui-agent` SKILL.md files updated with byte-identical Builder API sections.
5. **DSP pre-flight simulation (Phase 32)** — New `src/maxpat/dsp_sim/` module exposes a sample-accurate waveguide loop simulator with autocorrelation pitch tracker and a D-09 verdict cascade (`runaway > no_oscillation > mode_competition > phase_drift`). Three curated topologies (bore_only, reed_bore, reed_bore_post_radiation) cover the bassoon shape with the v0.4.2+ post-loop placement invariant verified by FFT stability sweeps. Bassoon v0.4.0 / v0.4.1 regression mirrors lock the high-Q-in-loop and group-vs-phase-delay failure modes; live-patch gate via `tests/dsp_sim/test_<stem>.py` filename convention; `python -m src.maxpat.dsp_sim` CLI with verdict-priority exit codes; `max-dsp-agent` SKILL.md mandates simulation pre-flight before commits.

**Git range:** quick-260427-l2t-* through docs(phase-32) — 2026-04-27 to 2026-05-01

---

## v4.0 Package Integration (Shipped: 2026-04-15)

**Phases completed:** 6 phases (20-25), 17 plans
**Timeline:** 10 days (2026-04-05 to 2026-04-15)
**Stats:** 98 code files modified, +54,702/-936 lines
**Requirements:** 26/26 satisfied (PKG-01 through PKG-26)

**Delivered:** Full package integration — bundled and community MAX packages are now first-class citizens in the framework with DB entries, validation gating, agent intelligence, critics, and workflow templates.

**Key accomplishments:**

1. Package-aware object database — all objects tagged with source package, 16-package registry, allowed_packages filtering in ObjectDatabase
2. Bundled package extraction — BEAP (~192 modules), Vizzie (~110), Jitter Geometry (26), Jitter Tools (99) extracted via abstraction parser and XML pipeline
3. Generation gating — package selection in project config, `/max-new` and `/max-build` prompt for packages, validation blocks unavailable packages
4. Agent package intelligence — DB-driven bpatcher sizing, adaptive layout spacing, PACKAGES.md shared reference, 5 specialist SKILL.md files updated with package domain guidance
5. Community package support — stub DB entries for 10 community packages (FluCoMa, CNMAT, Bach, Odot, ml.*, IRCAM Spat, Cage, Dada, EARS, RTK), `--package` CLI extraction flag
6. Package-aware critics — BEAP signal convention checker, Bach llll type checker, community extraction validator, workflow templates for FluCoMa/BEAP/Bach

---

## v3.0.0 Direct .maxpat Editing (Shipped: 2026-04-09)

**Phases completed:** 7 phases (13-19), 15 plans
**Timeline:** 23 days (2026-03-16 to 2026-04-08)
**Stats:** 77 commits, 81 files modified, +11,778/-1,694 lines, 33,430 LOC Python
**Requirements:** 26/26 satisfied
**Audit:** passed (26/26 requirements, 7/7 phases, 26/26 integration, 5/5 E2E flows)

**Delivered:** Replaced the Python generation pipeline with direct .maxpat reading and editing — the .maxpat file is now the single source of truth, enabling true back-and-forth between Claude and manual MAX editing.

**Key accomplishments:**

1. Lossless .maxpat round-trip — Box._raw preservation, detect_indent, save_patch_roundtrip; all 10 project patches round-trip byte-identically
2. Full editing API — find_box/find_boxes with alias resolution, modify_box with I/O recompute, insert_into_connection, replace_box, auto-positioning with collision detection
3. Graph query engine — BFS upstream/downstream traversal, signal_path tracing, connected_components with subpatcher boundary crossing
4. Patch analysis — Patcher.analyze() produces 7-facet structured summaries (complexity, inventory, sections, signal chains, control flow, hierarchy, parameters)
5. All slash commands and 9 agent SKILL.md files migrated to direct .maxpat editing workflow
6. Old pipeline removed — incremental.py, 8 generate.py scripts, 6 manifests, 7 versions.json deleted (4,254 lines); 60+ tests rewritten for v2.0 API

**Git range:** test(13-01) → docs(phase-19)

---

## v1.0 MVP (Shipped: 2026-03-10)

**Phases completed:** 7 phases, 21 plans
**Timeline:** 3 days (2026-03-08 to 2026-03-10)
**Stats:** 126 commits, 183 files, 16,557 LOC Python, 624 tests passing
**Requirements:** 40/40 satisfied
**Audit:** passed (40/40 requirements, 7/7 phases, 6/6 integration, 6/6 E2E flows)

**Delivered:** A complete Claude Code development framework for MAX/MSP — from object knowledge base through patch/code generation to agent orchestration and RNBO/external support.

**Key accomplishments:**

1. Comprehensive MAX object knowledge base — 2,015 objects across 8 domains extracted from XML refpages with RNBO flags, version tags, aliases, and overrides
2. .maxpat patch generation with Patcher/Box data model, column-based layout engine, and 4-layer validation pipeline (JSON structure, object existence, connection bounds/types, domain rules)
3. Gen~ GenExpr, Node for Max, and js V8 code generation with syntax validation and .gendsp standalone generation
4. Agent system — 6 specialist agents (Patch, DSP, RNBO, js, Ext, UI), critic validation loops, persistent memory with deduplication, multi-project isolation, 10 slash commands
5. RNBO-compatible patch generation with export target awareness (VST3/AU, Web Audio, C++) and C/C++ external scaffolding via Min-DevKit with build system support
6. Full documentation accuracy — 9 API signature mismatches fixed, 3 stale stub labels removed, all with regression tests

**Git range:** initial commit → 0245247

---
