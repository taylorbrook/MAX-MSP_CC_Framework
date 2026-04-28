# Requirements: MaxSystem v5.0

**Defined:** 2026-04-27
**Core Value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work — with as much automated validation as possible before manual testing.

## v5.0 Requirements

DB Schema Hardening + Validator Depth. Each requirement maps to exactly one phase. Requirements are user-centric capabilities that the framework gains; "user" here is Claude (or a developer) generating/validating MAX patches.

### Schema Foundation (Phase 28)

Migrate the object DB from flat extracted facts to a typed, install-aware contract. Foundation for downstream validator depth (Phase 29) and coverage payoff (Phase 30).

- [ ] **SCHEMA-01**: Every outlet entry can declare a `signal_role` of `audio` | `trigger` | `status` | `float` | `data` | `list` (replacing the boolean `signal:true/false` as the precise type)
- [ ] **SCHEMA-02**: Existing `signal: bool` continues to work — derived from `signal_role` so no consumer breaks during migration
- [ ] **SCHEMA-03**: Object entries can declare `domain_restricted: ["rnbo"]` (or other domains) to mark availability constraints
- [ ] **SCHEMA-04**: Object entries carry a `verified_installed: bool` flag indicating whether the object was confirmed against `_pkg-source/`
- [ ] **SCHEMA-05**: `overrides.json` schema extended to accept the three new fields and deep-merge them onto base objects
- [ ] **SCHEMA-06**: `db_lookup.ObjectDatabase` loads, validates, and exposes the new schema fields via getter methods (e.g. `get_signal_role(name, outlet)`, `is_domain_restricted(name)`, `is_verified_installed(name)`)
- [ ] **SCHEMA-07**: `audit_empty_io()` is extended to also surface unverified-installed entries and domain-restricted entries with no domain coverage

### Validator Depth (Phase 29)

Teach validators and critics to read the richer schema. Plus the schema-independent external `.gendsp` validation that pairs naturally with this pipeline-shaped phase.

- [ ] **VALID-01**: Layer-3 connection validator emits role-aware errors (e.g. `"status outlet → signal inlet (use snapshot~)"`, `"trigger outlet → float inlet"`) instead of generic type-mismatch warnings
- [ ] **VALID-02**: A domain-restricted guard fails hard when an `rnbo`-only object (e.g. `floor~`) appears at MSP top level outside an `rnbo~` container
- [ ] **VALID-03**: Lookup-time install-state warnings fire when an object marked `verified_installed: false` is used (e.g. `"bach.llll2list not present in this install"`)
- [ ] **VALID-04**: External `.gendsp` files are validated by the DSP critic with the same rigor as embedded gen~ codeboxes (declaration ordering, `Delay.read/write` vs `delay()`, init-before-if/else, `clip()` rejection)
- [ ] **VALID-05**: Validation outputs distinguish `error` (blocks output) from `warning` (surfaces but allows) consistently across role-aware checks, domain guard, install warnings, and `.gendsp` checks

### MSP Outlet Coverage (Phase 30)

Migrate existing overrides to the new schema and expand coverage so the typed contract is dense enough to be useful.

- [ ] **MSPCOV-01**: All ~16 existing MSP outlet-type overrides migrated from `signal: bool` to `signal_role`
- [ ] **MSPCOV-02**: At least 80 previously unverified MSP objects (from 260331-n24's flagged list — `saw~`, `*~`, `noise~`, `sig~`, `gen~`, `selector~`, etc.) get `signal_role` populated per outlet
- [ ] **MSPCOV-03**: A bulk audit script classifies any remaining `signal: true` outlet by digest keyword (bang/done/index/status) and produces a candidate-overrides report
- [ ] **MSPCOV-04**: Audit script's output is committed alongside the migration so future drift is visible
- [ ] **MSPCOV-05**: Post-migration `audit_empty_io()` and a new `audit_signal_role_coverage()` show fewer than 20 remaining gaps in MSP

### Layout & UX Builders (Phase 31)

Move the layout/UX recipes currently sitting in CLAUDE.md into first-class builder functions. Companion-pair patterns get smarter on the new `signal_role` data.

- [ ] **LAYOUT-01**: `add_overlay_readout(target, format=...)` builder creates a flonum/comment readout overlapping a target dial/control with `bring_to_front` + `ignoreclick=1` baked in
- [ ] **LAYOUT-02**: `add_labeled_param_bank(params, ...)` builder codifies the multislider formula (size×24, contdata=1, setstyle=1) currently a CLAUDE.md recipe; produces multislider plus aligned comment labels
- [ ] **LAYOUT-03**: Companion-pair layout patterns auto-place gain~/meter~ side-by-side, dial+flonum overlay, live.dial+text label using `signal_role` to decide placement (e.g. `status` outlets get readout overlays, `audio` outlets get meter companions)
- [ ] **LAYOUT-04**: `m4l_gen_synth(params=[...])` skeleton builder generates a Live-ready M4L device with gen~ + `live.dial`s correctly bound via `param_connect` (per CLAUDE.md M4L rules), no `gain~` before `plugout~`
- [ ] **LAYOUT-05**: All four builders are reachable from `max-patch-agent` and `max-ui-agent` via documented entry points

### DSP Pre-Flight Simulation (Phase 32)

A numpy-based simulation harness that catches DSP stability bugs (the bassoon v0.4–0.5 saga) before they ship.

- [ ] **DSPSIM-01**: New `src/maxpat/dsp_sim/` module exposes a waveguide loop simulator with sample-accurate Param sweeps
- [ ] **DSPSIM-02**: Simulator measures fundamental stability via autocorrelation/FFT and flags Q values where the loop fails to oscillate or drifts
- [ ] **DSPSIM-03**: `max-dsp-agent` invokes the simulator before committing waveguide patches and surfaces the stability report in its summary
- [ ] **DSPSIM-04**: Simulator covers the high-Q-in-loop and group-vs-phase-delay failure modes that motivated the bassoon-model rework
- [ ] **DSPSIM-05**: Simulator output is reproducible from a `(patch_path, param_name, sweep_range)` triple so failures can be regression-tested

### Critic Tier Hardening (Phase 33 — Optional)

After Phase 29's `VALID-05` lands, evaluate whether other structure-critic warnings deserve hard-tier treatment. Judgment call — only if the empirical case is clear.

- [ ] **CRITIC-01**: Audit remaining structure-critic warnings against shipped patches; identify which warnings have a low false-positive rate and high real-fault rate
- [ ] **CRITIC-02**: Promote gain-staging-unsafe-values (raw MIDI feeding `*~`/`gain~`) and unterminated-MSP-chains warnings to blockers if their precision warrants it
- [ ] **CRITIC-03**: Each promotion lands with a regression test that exercises the false-positive boundary

## Future Requirements

Deferred from FINDINGS.md but not in scope for v5.0:

- [ ] **PATCHER-SPLIT**: Finish splitting `patcher.py` (already 2827→2094) into focused modules — to be done opportunistically as quick tasks (FINDINGS § P2-2)
- [ ] **AUDIT-PROCESS**: Standing audit-as-process (periodic FINDINGS regeneration) — meta-process, not a feature (FINDINGS § P2-5)

## Out of Scope

Explicit exclusions and why:

- **Schema changes outside the three new fields** (e.g. inlet roles, message-type taxonomy) — Out of scope. Goal is to land a small, reversible schema delta. Broader schema evolution would balloon Phase 28.
- **Removing `signal: bool` entirely** — Out of scope this milestone. Back-compat shim keeps existing consumers working until v6.0+.
- **Live audio simulation in the DSP pre-flight harness** — Numpy offline sweep is sufficient. Real-time MAX-driven simulation creates a fragile dependency on MAX running (Out of Scope from PROJECT.md).
- **Non-MSP outlet coverage sweep** — Phase 30 is MSP-only. Max/Jitter/MC outlets remain `signal: false` derived; no role enrichment.
- **Auto-rewrite of CLAUDE.md recipes into the new builders** — Phase 31 builds the API; users (and agents) opt in. CLAUDE.md edits land separately if and when builders prove themselves.

## Traceability

| REQ-ID | Phase | Plan | Validation |
|--------|-------|------|------------|
| SCHEMA-01 | Phase 28 | TBD | Pending |
| SCHEMA-02 | Phase 28 | TBD | Pending |
| SCHEMA-03 | Phase 28 | TBD | Pending |
| SCHEMA-04 | Phase 28 | TBD | Pending |
| SCHEMA-05 | Phase 28 | TBD | Pending |
| SCHEMA-06 | Phase 28 | TBD | Pending |
| SCHEMA-07 | Phase 28 | TBD | Pending |
| VALID-01 | Phase 29 | TBD | Pending |
| VALID-02 | Phase 29 | TBD | Pending |
| VALID-03 | Phase 29 | TBD | Pending |
| VALID-04 | Phase 29 | TBD | Pending |
| VALID-05 | Phase 29 | TBD | Pending |
| MSPCOV-01 | Phase 30 | TBD | Pending |
| MSPCOV-02 | Phase 30 | TBD | Pending |
| MSPCOV-03 | Phase 30 | TBD | Pending |
| MSPCOV-04 | Phase 30 | TBD | Pending |
| MSPCOV-05 | Phase 30 | TBD | Pending |
| LAYOUT-01 | Phase 31 | TBD | Pending |
| LAYOUT-02 | Phase 31 | TBD | Pending |
| LAYOUT-03 | Phase 31 | TBD | Pending |
| LAYOUT-04 | Phase 31 | TBD | Pending |
| LAYOUT-05 | Phase 31 | TBD | Pending |
| DSPSIM-01 | Phase 32 | TBD | Pending |
| DSPSIM-02 | Phase 32 | TBD | Pending |
| DSPSIM-03 | Phase 32 | TBD | Pending |
| DSPSIM-04 | Phase 32 | TBD | Pending |
| DSPSIM-05 | Phase 32 | TBD | Pending |
| CRITIC-01 | Phase 33 (optional) | TBD | Pending |
| CRITIC-02 | Phase 33 (optional) | TBD | Pending |
| CRITIC-03 | Phase 33 (optional) | TBD | Pending |

**Coverage:** 28/28 v5.0 requirements mapped (Phases 28-32). Phase 33 (3 CRITIC reqs) tracked separately as optional/conditional follow-on.

---
*Requirements created: 2026-04-27*
*Traceability filled: 2026-04-27 by gsd-roadmapper*
*Source: FINDINGS.md (260427-hox) + user-provided v5.0 scope proposal*
