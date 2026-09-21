---
gsd_state_version: 1.0
milestone: v5.0
milestone_name: DB Schema Hardening + Validator Depth
status: completed
last_updated: "2026-05-01T22:26:35.520Z"
last_activity: 2026-05-01
progress:
  total_phases: 5
  completed_phases: 5
  total_plans: 24
  completed_plans: 24
  percent: 100
---

# Project State

## Project Reference

See: .planning/PROJECT.md (updated 2026-05-01 after v5.0)

**Core value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work -- with as much automated validation as possible before manual testing.
**Current focus:** Planning next milestone (v5.0 shipped 2026-05-01)

## Current Position

Phase: —
Plan: —
Status: v5.0 shipped; awaiting `/gsd-new-milestone` to start next cycle
Last activity: 2026-09-21 - Completed quick task 260921-j0h: SF-01 closed — `node.script` + `node.codebox` added to `max/objects.json` (473 keys) with refpage-verified **fixed** 1-in/2-out I/O; the task's `variable_io` "configurable outlets" premise was contradicted by five bundle sources and deliberately not implemented; CLAUDE.md ban retired and count re-synced 471→473; changes proven inert against the suite via temp-worktree isolation (2197 passed / 5 xfailed, identical to baseline)

Previous: 2026-09-21 - Completed quick task 260921-ima: SF-03 closed — `codebox` added to UI_MAXCLASSES on confirmed MAX-saved-form evidence (kicksynth @ 02c9917, terrain-synth @ 55757e0, appversion 9.1.5); fc3aa27 Jitter pair test coverage backfilled; change proven inert against add_gen() output, 26/26 .maxpat round-trip bytes, and all six consumer sites

## Performance Metrics

| Metric | Value |
|--------|-------|
| Milestone | v5.0 DB Schema Hardening + Validator Depth |
| Total phases | 5 (Phases 28, 29, 30, 31, 32) |
| Optional phase | 33 (Critic Tier Hardening — judgment call after Phase 29) |
| Total v5.0 requirements | 28 |
| Coverage | 28/28 mapped ✓ |

## Accumulated Context

### Decisions

Decisions archived in PROJECT.md Key Decisions table.

v5.0-specific roadmap decisions:

- Phase 33 (Critic Tier Hardening) intentionally excluded from `total_phases` — kept as conditional follow-on contingent on Phase 29 evidence.
- Phase 32 (DSP Pre-Flight Simulation) declared independent of Phase 28 — could ship first or last; agent picks ordering at planning time.
- Schema delta scoped to three fields only (`signal_role`, `domain_restricted`, `verified_installed`); broader schema evolution (inlet roles, message taxonomy) deferred to v6.0+.
- `signal: bool` retained as derived back-compat shim through v5.0; removal scheduled for v6.0+.

### Pending Todos

None.

### Blockers/Concerns

None.

### Quick Tasks Completed

(See history in prior STATE.md snapshots; archived at milestone close.)

| # | Description | Date | Commit | Status | Directory |
|---|-------------|------|--------|--------|-----------|
| 260701-jxg | Repo review + improvement report | 2026-07-01 | (docs commit) | | [260701-jxg-review-repo-and-produce-improvement-repo](./quick/260701-jxg-review-repo-and-produce-improvement-repo/) |
| 260701-k92 | Fix P0 items from 260701-jxg review: patch_dir kwarg, gitignore junk files, extraction-log regen | 2026-07-01 | d85289d | | [260701-k92-fix-p0-items-from-260701-jxg-review-patc](./quick/260701-k92-fix-p0-items-from-260701-jxg-review-patc/) |
| 260701-r9s | Backfill signal_role metadata (WR-01): fix cmd_apply_run synthesis path, backfill empty type/digest in overrides.json | 2026-07-01 | f9b4f05 | Verified | [260701-r9s-backfill-signal-role-metadata](./quick/260701-r9s-backfill-signal-role-metadata/) |
| 260702-gk6 | Extend audit_empty_io() with by_source coverage across all domain files (43 → 164 entries; 121 shadowed package entries surfaced) | 2026-07-02 | 676b638 | | [260702-gk6-extend-objectdatabase-audit-empty-io-to-](./quick/260702-gk6-extend-objectdatabase-audit-empty-io-to-/) |
| 260702-k9w | Reconcile 24 remaining test failures (GenExpr Check 6/9 false positives, 6 community-package tests, per-patch review-blocker allowlist); suite green with zero .maxpat edits | 2026-07-02 | 85b8f92 | Verified | [260702-k9w-reconcile-the-20-remaining-test-failures](./quick/260702-k9w-reconcile-the-20-remaining-test-failures/) |
| 260703-a73 | Refresh README.md and TECHNICAL.md to v5.0 (DB schema hardening, signal_role metadata, Layers 1-5 validation, dsp_sim, Phase 31 builders) | 2026-07-03 | 2f28eb2 | | [260703-a73-refresh-readme-md-and-technical-md-to-re](./quick/260703-a73-refresh-readme-md-and-technical-md-to-re/) |
| 260703-h75 | Extract 18 add_* builders into BuildersMixin, add -> None to 3 __init__s, drop _AUTO_HIGHLIGHT re-export; exact test parity (2030 passed, 4 xfailed) | 2026-07-03 | a16557f | Verified | [260703-h75-extract-the-18-add-builder-methods-from-](./quick/260703-h75-extract-the-18-add-builder-methods-from-/) |
| 260703-hrl | Direct tests for graph.py and maxclass_map.py + smoke tests for 6 untested modules (68 new tests; 2098 passed, 4 xfailed, zero regressions) | 2026-07-03 | 819ccc8 | | [260703-hrl-add-direct-test-files-for-graph-py-and-m](./quick/260703-hrl-add-direct-test-files-for-graph-py-and-m/) |
| 260703-i0t | De-duplicate CLAUDE.md against 30 feedback memory entries: CLAUDE.md canonical, 15 nuances promoted, 30 memories archived + deleted, MEMORY.md pruned to pointer | 2026-07-03 | c888f14 | | [260703-i0t-de-duplicate-claude-md-against-the-30-fe](./quick/260703-i0t-de-duplicate-claude-md-against-the-30-fe/) |
| 260703-knu | Document dsp_sim as bassoon-specific (module docstring + README covering 3 topologies); deferred general-topology broadening recorded as v6.0 in PROJECT.md Future | 2026-07-03 | d2d008f | | [260703-knu-document-src-maxpat-dsp-sim-as-bassoon-p](./quick/260703-knu-document-src-maxpat-dsp-sim-as-bassoon-p/) |
| 260703-lwq | Prune orphaned quick-task dirs (2 removed, 89 keepers with SUMMARY.md); confirmed .claude/worktrees/ gitignored | 2026-07-03 | (docs commit) | | [260703-lwq-prune-orphaned-empty-quick-task-slugs-un](./quick/260703-lwq-prune-orphaned-empty-quick-task-slugs-un/) |
| 260826-kvk | Fix presentation-mode text contrast: resolve background in presentation coords, all panel color encodings, box-own bgcolor; WCAG critic guard + CLAUDE.md rule | 2026-08-26 | 7193b4a | | [260826-kvk-fix-presentation-mode-panel-text-color-c](./quick/260826-kvk-fix-presentation-mode-panel-text-color-c/) |
| 260921-g5d | Repo review vs installed Max 9.1.5: 15 findings (MF-01..03, SF-01..08, NH-01..04). DB drift near-zero (9 unresolved, 5 are doc pages; 0 I/O counts contradict an unambiguous maxref; 0 patch objects unresolved). **2 fixes applied** by the orchestrator after executor verification: `bach.list2llll` verified_installed: false (9ddd8c4), CLAUDE.md object-count table + packages/ layout (540b33a); suite unchanged at 9 pre-existing failures | 2026-09-21 | 9ddd8c4 | | [260921-g5d-review-this-repo-to-see-if-there-are-any](./quick/260921-g5d-review-this-repo-to-see-if-there-are-any/) |
| 260921-gut | Triage the 9 pre-existing MF-02 pytest failures: 6x review-blocker allowlist entries (allowlist unmaintained since 85b8f92), 2x byte-identity via content-derived MAX-compact-array exemption + unconditional semantic round-trip assert (corrects MF-02: committed scala-synth round-trips byte-identical), 1x dsp_critic line-index anchor de-brittled. Suite green: 0 failed; no `patches/` or `src/` changes | 2026-09-21 | 784a54d | Verified | [260921-gut-triage-the-9-pre-existing-pytest-failure](./quick/260921-gut-triage-the-9-pre-existing-pytest-failure/) |
| 260921-hll | MF-03 + NH-02: `_maybe_warn_empty_io()` aligned with `audit_empty_io()` (warn only when BOTH sides empty; 218 -> 9 objects, warned set == audit set); new `audit_half_empty_io()` exposes 109 sinks / 100 sources; 6 tests added. Pytest 2180 -> 2186 passed, 6 xfailed, warnings 487 -> 9; per-test junit diff changed=0. `lookup_strict`/`has_complete_io` unchanged. | 2026-09-21 | cc70854 | Verified | [260921-hll-per-mf-03-and-nh-02-in-planning-quick-26](./quick/260921-hll-per-mf-03-and-nh-02-in-planning-quick-26/) |
| 260921-i71 | Package critic no longer endorses the uninstalled bach list/llll converters: new name-agnostic `_check_install_state()` emits a `blocker` for any object with `get_install_state() is False` (deduped per name; `None`/unaudited stays silent, guarding the ~2,015 unaudited entries against the `is_verified_installed()` trap). Both dead converter special-cases stripped from `_check_bach_llll_types`; llll-mismatch suggestion rewritten to `bach.flat`/`bach.iter`/`bach.pack`/`bach.nth`. Three generation-steering doc sites corrected. Pytest 2186 -> 2191 passed, 6 xfailed; `validate_patch()` untouched (D-12 intact). | 2026-09-21 | d27a6be, 5fd4855, 56e11a0 | | [260921-i71-package-critic-py-340-special-cases-bach](./quick/260921-i71-package-critic-py-340-special-cases-bach/) |
| 260921-j0h | SF-01: `node.script` + `node.codebox` added to `max/objects.json` (471 → 473 keys), generated by running `extract_objects.py::parse_standard_xml` against the bundled Max 9.1.5 refpages plus four named curation deltas (`rnbo_compatible: false`, curated inlet digest replacing the `TEXT_HERE` placeholder, `category: Languages`, `node.codebox.arguments: []`). **Deviation: the task's `variable_io` "configurable outlet count" premise is wrong** — five bundle sources (refpage `<outletlist>`, symbol-only `objarg`, binary string table, 24 shipped instances all `numoutlets: 2`, anatomy vignette) say fixed 1-in/2-out, so `variable_io: false` and no `variable_io_rules` entry. Core placement (no `package` field) so the Rule #1 gate clears for the 11 projects with `packages: []`; `Patcher().add_box('node.script', [...])` now builds. Pure insertion (246 added lines, 0 deletions). CLAUDE.md line-11 count re-synced and the N4M ban + "configurable outlets" claim retired; `add_node_script` docstring corrected (body/signature/`UI_MAXCLASSES`/tests untouched). Also corrected the plan's stale `2194/6` baseline: real baseline at `e116f0d` is 2197 passed / 5 xfailed, and this task's three files applied to a clean temp worktree reproduce it exactly — **proven inert**. The live tree's 2196/6 + 1 extra test both trace to the concurrent instance (`acd59c6` added a test; its uncommitted degraded `scala-synth.maxpat` save flips the byte-identity xfail). Follow-ups: `add_node_script(num_outlets != 2)` mismatch, `{node,v8}.codebox` `UI_MAXCLASSES` admission, omitted bundle-verified `options`/`code` attributes, `extraction-log.json` left as a timestamped artifact. | 2026-09-21 | 65e662e, 4ac6558, 547d32d | | [260921-j0h-per-sf-01-in-planning-quick-260921-g5d-r](./quick/260921-j0h-per-sf-01-in-planning-quick-260921-g5d-r/) |
| 260921-ima | SF-03: `codebox` added to `UI_MAXCLASSES`. MAX-saved form confirmed from committed git objects via the `appversion.revision != 0` discriminator (generator hardcodes 0) cross-checked against MAX-re-save commit messages — kicksynth @ `02c9917` and terrain-synth @ `55757e0`, both appversion 9.1.5, carry `maxclass: "codebox"` with no `text` field while their `in 1`/`out 1` siblings stay newobj; 19/26 committed codebox `.maxpat` clear the discriminator, all 26 agree. Backfilled the test coverage `fc3aa27` shipped without (jit.pwindow/jit.cellblock). Proven inert: `add_gen()` hash identical, 26/26 `.maxpat` round-trip byte-identical, `validate_patch()` 24→24 unchanged, `_classify_domain` unchanged across 3423 boxes, zero box positions moved. Only delta is non-mutating tests-only `suggest_subpatchers` (93→47 candidates, all 46 codebox-bearing, correct). Pytest 2191 → 2194 passed, 6 xfailed; per-test diff = the 3 new tests only. Corrected a plan claim: the Rule #1 gate never raised for `codebox` (it is in the DB as domain RNBO). | 2026-09-21 | a5f1202 | | [260921-ima-per-sf-03-in-planning-quick-260921-g5d-r](./quick/260921-ima-per-sf-03-in-planning-quick-260921-g5d-r/) |

## Deferred Items

Items acknowledged and deferred at v5.0 milestone close on 2026-05-01:

| Category | Item | Status |
|----------|------|--------|
| human_uat | 31: overlay readout drag + ignoreclick pass-through (LAYOUT-01) | pending — MAX 9 runtime check |
| human_uat | 31: M4L gen synth parameter binding in Ableton Live (LAYOUT-04) | pending — Live runtime check |
| human_uat | 31: auto-companion-placement visual layout (LAYOUT-03) | pending — MAX 9 runtime check |
| human_uat | 31: labeled param bank pixel alignment (LAYOUT-02) | pending — MAX 9 runtime check |
| nyquist | 28-schema-foundation: 28-VALIDATION.md missing | gap — run /gsd-validate-phase 28 |
| nyquist | 29-validator-depth: 29-VALIDATION.md draft, nyquist_compliant=false | partial |
| nyquist | 30-msp-outlet-coverage-sweep: 30-VALIDATION.md missing | gap |
| nyquist | 31-layout-ux-builders: 31-VALIDATION.md draft, nyquist_compliant=false | partial |
| nyquist | 32-dsp-pre-flight-simulation: 32-VALIDATION.md missing | gap |
| tech_debt | Phase 28: IN-02/IN-03/IN-04 + missing 28-VALIDATION.md (4 items) | tracked in v5.0-MILESTONE-AUDIT.md |
| tech_debt | Phase 29: VALIDATION draft + pre-existing test failures (3 items) | tracked |
| tech_debt | Phase 30: WR-01 metadata fidelity (signal_role outlet `type`/`digest` empty), missing VALIDATION, frontmatter hygiene (3 items) | tracked |
| tech_debt | Phase 31: 11 items — MN-01/02, IN-01/02/04, WR-03/04/05, VALIDATION draft, frontmatter, 4 human-UAT | tracked |
| tech_debt | Phase 32: WR-01/02/03 + IN-01..09 + missing VALIDATION + frontmatter (6 items) | tracked |
| tech_debt | Cross-cutting: VALID-03 surfaces via warnings.warn (D-09/D-10 by design), DSPSIM-03 SKILL.md-only gate (D-04 by design), `is_domain_restricted` orphan, audit functions tooling-only, ~48 pre-existing TestCommunityPackageBlock failures (5 items) | tracked |
| quick_tasks | 80 historical orphaned slugs (all status=missing, empty descriptions) | cleanup needed — likely stale from prior milestones |

Total: 36 substantive deferred items (4 human-UAT + 5 Nyquist + 27 tech-debt) + 80 orphaned quick-task slugs requiring cleanup.

Full audit detail: `.planning/v5.0-MILESTONE-AUDIT.md` (will be archived to `.planning/milestones/v5.0-MILESTONE-AUDIT.md`).

## Session Continuity

**Next action:** `/gsd-new-milestone` to scope v6.0 (questioning → research → requirements → roadmap). Fresh REQUIREMENTS.md will be created.

**Carryover candidates for next milestone (judgment calls — not auto-promoted):**

1. **Nyquist VALIDATION.md remediation** — 5 phases (28, 29, 30, 31, 32) need `/gsd-validate-phase` runs to reach `nyquist_compliant: true`. Process-level fix: bake into phase-completion gate per RETROSPECTIVE lesson #5.
2. **Phase 31 human-UAT runtime checks** — 4 scenarios (LAYOUT-01 overlay drag, LAYOUT-02 14-param bank pixel alignment, LAYOUT-03 auto-companion visual, LAYOUT-04 M4L parameter binding in Live) require MAX 9 / Ableton Live session.
3. **Phase 30 metadata fidelity (WR-01)** — 703/795 signal_role outlets have empty `type` field; 588 have empty `digest`. Fix the `cmd_apply_run` synthesis path so curated outlets carry full metadata.
4. **`signal: bool` removal** — back-compat shim retained through v5.0 (D-15); removal scheduled for v6.0+ per PROJECT.md Key Decisions.
5. **Quick-task orphan cleanup** — 80 historical entries with empty descriptions/dates surfaced during v5.0 audit-open scan.
6. **Phase 33 (Critic Tier Hardening)** — deferred from v5.0; promote only if empirical case clear post-v5.0 use.

**Open blockers:** None.

**Resolved at v5.0 close:** Phase 32 context session, all 24 v5.0 plans, v5.0 milestone audit (status: tech_debt, accepted at close).
