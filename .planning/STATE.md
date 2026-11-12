---
gsd_state_version: "1.0"
milestone: v5.0
status: completed
last_updated: "2026-11-12T15:53:39.284Z"
last_activity: 2026-11-11
last_activity_desc: "Completed quick task 261001-hwb: Max 9.2.0 update — object DB re-synced from the installed bundle, 9.2 guidance added"
state_head: 317975d67f434ec88c2e5fd490b9e4c59cf04593
progress:
  total_phases: 5
  completed_phases: 5
  total_plans: 24
  completed_plans: 24
  percent: 100
milestone_name: DB Schema Hardening + Validator Depth
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
Last activity: 2026-11-12 - Completed quick task 261112-bve: Cut wall time of MAX bridge tests without weakening them

Previous: 2026-10-22 - Completed quick task 261022-pqu: Implement Q40 in .planning/reviews/2026-10-11-fix-plan.md — M4L device builder and .amxd export

Previous: 2026-09-21 - Completed quick task 260921-kfd: SF-04/SF-06/SF-07 closed — CLAUDE.md `live.*` extraction note revised (all 30 resolve); added refpage `<c74object name>`-is-authoritative rule and refpage-placeholder (54.5%) counts-not-types / never-overwrite-overrides rule

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

- ~~v6.0.0 release~~ DONE 2026-10-23: tag v6.0.0, GitHub release + npm create-max-framework@6.0.0 via trusted publishing (OIDC). NPM_TOKEN secret can now be deleted.
- MAX / Live confirmation items listed in the 261022-ud6 wp*-SUMMARY.md files (theme fills, legacy-layout writer on a Max 8 file, gen~ -> mc.gen~ replace, M4L Q15/Q40 Live check, RNBO builder shape).

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
| 260921-knq | NH-01 closed: the DB-vs-installed-Max audit is reproducible from committed `tools/audit_db.py` instead of a lost scratchpad script. Seven sections on a `{available, ...}` envelope (install, db_age, missing_from_db, absent_from_bundle, empty_io, patch_objects, ui_maxclasses_gap) + JSON/text output, ~1.3s. Read-only contract is structural (named `guard_output_path()` is the sole write site) and proven (sha256 snapshot of both protected trees); Max binary never executed (plistlib); `_git()` is the only subprocess. Real run: Max 9.1.5, DB 82.0d old (`max` drifted 471→473), **7** unresolved refpage names (5 doc pages + kbm/scl.data), 22 absent-from-bundle, 9 critical / 109 sinks / 100 sources empty-I/O, 71 .maxpat with **0 unresolved**, maxclass gap **1** (`gen~`). SF-07 keying cross-checks CLAUDE.md exactly (808 name≠filename). **2 deviations:** build hash lives in `CFBundleShortVersionString` not `CFBundleVersion` (plan premise inverted — normalized + pinned by test); project-local abstractions (3 terrain-*) now classified apart from unresolved objects. 33 hermetic tests, green with no Max installed; SF-07 guard mutation-checked (4 fail on regression). Pytest 2201 → 2234 passed, 6 xfailed unchanged. Deferred: DEF-knq-01 (`tests/fixtures/expected/gen_codebox.maxpat` uses invalid `maxclass: "gen~"`; `add_gen()` itself correct) | 2026-09-21 | 673722f, 3c1b47d, 96518af | | [260921-knq-per-nh-01-in-planning-quick-260921-g5d-r](./quick/260921-knq-per-nh-01-in-planning-quick-260921-g5d-r/) |
| 260921-kfd | SF-04/SF-06/SF-07: docs-only CLAUDE.md corrections in `### How to Use the Database` — retired the stale "`live.*` incompletely extracted" clause (all 30 bundled `live.*` objects resolve); added rule that the authoritative object name is the refpage's `<c74object name>` attribute, never the filename (808/1932 differ); added rule that refpages are authoritative for I/O counts far more than types and must never overwrite expert overrides (640/1175 core refpages, 54.5%, carry unfilled C74 placeholders). +5/−1, no other rules changed. | 2026-09-21 | 2edfb31 | | [260921-kfd-docs-only-update-to-claude-md-per-sf-04-](./quick/260921-kfd-docs-only-update-to-claude-md-per-sf-04-/) |
| 260924-8a6 | Add looper-style `p about` documentation subpatch to 33 user-facing main patches | 2026-09-24 | 2be69eb | | [260924-8a6-for-all-the-patches-add-an-about-subpatc](./quick/260924-8a6-for-all-the-patches-add-an-about-subpatc/) |
| 261001-hwb | Max 9.2.0 update: new additive `tools/sync_max_bundle.py` (dry-run / apply / I/O snapshot guard, 64 tests); 12 new 9.2 objects added from the installed bundle (`dspstress~`, `jit.web`, `jit.web~`, `jit.gl.web`, `jit.gl.web~`, `abl.device.reverb2~`, `abl.device.stereocompressor~`, `abl.dsp.djfilter~`, `jit.message`, `jit.path.ui`, `jit.unpack.geomat`, `jit.gl.tex2mat`); 57 messages + 110 attributes appended on 44 existing objects with no I/O change; `version_map["9.2"]` and 9.x-tolerant guards; `.claude/skills/references/max-9.2-changes.md`, CLAUDE.md / max-js-agent / README / TECHNICAL updates; unknown-key round-trip tolerance test. Nothing tested inside MAX 9.2; all gen~ workarounds kept. `git.allow_default_branch_commits` enabled (user-approved) | 2026-10-01 | f53c921 | | [261001-hwb-max-has-updated-to-version-9-2-thoroughl](./quick/261001-hwb-max-has-updated-to-version-9-2-thoroughl/) |
| 261012-bii | Implement Q1 in .planning/reviews/2026-10-11-fix-plan.md — non-destructive validate_patch | 2026-10-12 | 294f90c | Verified | [261012-bii-implement-q1-in-planning-reviews-2026-10](./quick/261012-bii-implement-q1-in-planning-reviews-2026-10/) |
| 261012-c5i | Implement Q2 in .planning/reviews/2026-10-11-fix-plan.md — fix DB entries that strip valid cords | 2026-10-12 | d0885b8 | Verified | [261012-c5i-implement-q2-in-planning-reviews-2026-10](./quick/261012-c5i-implement-q2-in-planning-reviews-2026-10/) |
| 261012-di7 | Implement Q3 in .planning/reviews/2026-10-11-fix-plan.md — critic precision, suite green | 2026-10-12 | 3008d22 | Verified | [261012-di7-implement-q3-in-planning-reviews-2026-10](./quick/261012-di7-implement-q3-in-planning-reviews-2026-10/) |
| 261012-egf | Implement Q4 in .planning/reviews/2026-10-11-fix-plan.md — revive dead critic detectors and review_m4l | 2026-10-12 | d423bf4 | Verified | [261012-egf-implement-q4-in-planning-reviews-2026-10](./quick/261012-egf-implement-q4-in-planning-reviews-2026-10/) |
| 261012-m87 | Implement Q5 in .planning/reviews/2026-10-11-fix-plan.md — path-scoped auto-commit and stale-file check | 2026-10-12 | 1fdcf8a | Verified | [261012-m87-implement-q5-in-planning-reviews-2026-10](./quick/261012-m87-implement-q5-in-planning-reviews-2026-10/) |
| 261012-pkh | Implement Q6 in .planning/reviews/2026-10-11-fix-plan.md — edit path keeps cord routing and cords | 2026-10-12 | 9c4885f | Verified | [261012-pkh-implement-q6-in-planning-reviews-2026-10](./quick/261012-pkh-implement-q6-in-planning-reviews-2026-10/) |
| 261012-qsr | Implement Q7 in .planning/reviews/2026-10-11-fix-plan.md — automatic save gate | 2026-10-13 | 4dd8424 | Verified | [261012-qsr-implement-q7-in-planning-reviews-2026-10](./quick/261012-qsr-implement-q7-in-planning-reviews-2026-10/) |
| 261012-sam | Implement Q8 in .planning/reviews/2026-10-11-fix-plan.md — CI tests, release tarball, installer | 2026-10-13 | 18b6f3b | Verified | [261012-sam-implement-q8-in-planning-reviews-2026-10](./quick/261012-sam-implement-q8-in-planning-reviews-2026-10/) |
| 261012-ubw | Implement Q9 in .planning/reviews/2026-10-11-fix-plan.md — help-box I/O oracle | 2026-10-13 | a8bce3a | Verified | [261012-ubw-implement-q9-in-planning-reviews-2026-10](./quick/261012-ubw-implement-q9-in-planning-reviews-2026-10/) |
| 261013-cyg | Implement Q10 in .planning/reviews/2026-10-11-fix-plan.md — correct argument-dependent I/O counts | 2026-10-13 | 46465a7 | Verified | [261013-cyg-implement-q10-in-planning-reviews-2026-1](./quick/261013-cyg-implement-q10-in-planning-reviews-2026-1/) |
| 261013-e43 | Implement Q11 in .planning/reviews/2026-10-11-fix-plan.md — per-port override merge and corrected overrides | 2026-10-13 | 67108d1 | Verified | [261013-e43-implement-q11-in-planning-reviews-2026-1](./quick/261013-e43-implement-q11-in-planning-reviews-2026-1/) |
| 261013-mv6 | Implement Q12 in .planning/reviews/2026-10-11-fix-plan.md — restrict RNBO/Gen-only names, fix GenExpr namespace | 2026-10-14 | 3261b39d | Verified | [261013-mv6-implement-q12-in-planning-reviews-2026-1](./quick/261013-mv6-implement-q12-in-planning-reviews-2026-1/) |
| 261013-q58 | Implement Q13 in .planning/reviews/2026-10-11-fix-plan.md — fix UI maxclass set | 2026-10-14 | c306849c | Verified (user-confirmed in MAX 2026-10-13) | [261013-q58-implement-q13-in-planning-reviews-2026-1](./quick/261013-q58-implement-q13-in-planning-reviews-2026-1/) |
| 261013-v4k | Implement Q14 in .planning/reviews/2026-10-11-fix-plan.md — import MC/Jitter/OB3D group messages | 2026-10-14 | 49d9db81 | — | [261013-v4k-implement-q14-in-planning-reviews-2026-1](./quick/261013-v4k-implement-q14-in-planning-reviews-2026-1/) |
| 261014-d13 | Implement Q15 in .planning/reviews/2026-10-11-fix-plan.md — M4L enums, prefixes, gen~ inlet, stereo out | 2026-10-14 | 350d50b7 | Needs Review | [261014-d13-implement-q15-in-planning-reviews-2026-1](./quick/261014-d13-implement-q15-in-planning-reviews-2026-1/) |
| 261014-fbx | Implement Q16 in .planning/reviews/2026-10-11-fix-plan.md — fix docs that cause broken output | 2026-10-14 | f361aeae | Needs Review | [261014-fbx-implement-q16-in-planning-reviews-2026-1](./quick/261014-fbx-implement-q16-in-planning-reviews-2026-1/) |
| 261014-gf2 | Implement Q17 in .planning/reviews/2026-10-11-fix-plan.md — write missing references | 2026-10-14 | 3e3742e6 | — | [261014-gf2-implement-q17-in-planning-reviews-2026-1](./quick/261014-gf2-implement-q17-in-planning-reviews-2026-1/) |
| 261014-i3b | Implement Q18 in .planning/reviews/2026-10-11-fix-plan.md — slim CLAUDE.md | 2026-10-15 | d30c199b | Verified | [261014-i3b-implement-q18-in-planning-reviews-2026-1](./quick/261014-i3b-implement-q18-in-planning-reviews-2026-1/) |
| 261014-t1y | Implement Q19 in .planning/reviews/2026-10-11-fix-plan.md — shared walker and recursive validation | 2026-10-15 | 7eaa71fa | Verified | [261014-t1y-implement-q19-in-planning-reviews-2026-1](./quick/261014-t1y-implement-q19-in-planning-reviews-2026-1/) |
| 261014-uzq | Implement Q20 in .planning/reviews/2026-10-11-fix-plan.md — recursive critics, analyze, checklist, graph | 2026-10-15 | f3bfdce3 | Verified | [261014-uzq-implement-q20-in-planning-reviews-2026-1](./quick/261014-uzq-implement-q20-in-planning-reviews-2026-1/) |
| 261015-bt8 | Implement Q21 in .planning/reviews/2026-10-11-fix-plan.md — trigger type, $N arity, trigger order checks | 2026-10-15 | e9c73020 | Verified | [261015-bt8-implement-q21-in-planning-reviews-2026-1](./quick/261015-bt8-implement-q21-in-planning-reviews-2026-1/) |
| 261015-du0 | Implement Q22 in .planning/reviews/2026-10-11-fix-plan.md — GenExpr parser, codebox lint, js ES5 lint | 2026-10-15 | 78ada853 | Verified | [261015-du0-implement-q22-in-planning-reviews-2026-1](./quick/261015-du0-implement-q22-in-planning-reviews-2026-1/) |
| 261015-f1o | Fix Q22 review findings CR-01 (js _js_mask regex literals) and CR-02 (tanh check History one(1) false error) | 2026-10-15 | fcffcb36 | Verified | [261015-f1o-fix-q22-review-findings-cr-01-js-js-mask](./quick/261015-f1o-fix-q22-review-findings-cr-01-js-js-mask/) |
| 261022-ud6 WP7b (Q23) | Implement Q23 in .planning/reviews/2026-10-11-fix-plan.md — vocabulary checks and cheap wins (planned as 261015-fm1, never run; executed 2026-10-22 as 261022-ud6 WP7b) | 2026-10-22 | 620fa6be (merge 2a2c24a5) | Needs Review | [wp7b-Q23-SUMMARY.md](./quick/261022-ud6-review-q1-q40-improvements-for-regressio/wp7b-Q23-SUMMARY.md) |
| 261015-j0n | Implement Q24 in .planning/reviews/2026-10-11-fix-plan.md — uninitialized UI→DSP state check | 2026-10-15 | 0028553f | Verified | [261015-j0n-implement-q24-in-planning-reviews-2026-1](./quick/261015-j0n-implement-q24-in-planning-reviews-2026-1/) |
| 261015-m9b | Implement Q25 in .planning/reviews/2026-10-11-fix-plan.md — dsp_sim pitch detector and false PASS paths | 2026-10-15 | 8c4774ad | Verified | [261015-m9b-implement-q25-in-planning-reviews-2026-1](./quick/261015-m9b-implement-q25-in-planning-reviews-2026-1/) |
| 261015-nkm | Implement Q26 in .planning/reviews/2026-10-11-fix-plan.md — hot/cold, gain safety, theme-aware contrast, RNBO critic | 2026-10-16 | a841a2e1 | Verified | [261015-nkm-implement-q26-in-planning-reviews-2026-1](./quick/261015-nkm-implement-q26-in-planning-reviews-2026-1/) |
| 261015-qm7 | Implement Q27 in .planning/reviews/2026-10-11-fix-plan.md — layout overlay, stacking, contrast order, bpatcher faces, width cap | 2026-10-16 | 40428815 | Needs Review | [261015-qm7-implement-q27-in-planning-reviews-2026-1](./quick/261015-qm7-implement-q27-in-planning-reviews-2026-1/) |
| 261015-u3j | Implement Q28 in .planning/reviews/2026-10-11-fix-plan.md — change tracking for loaded patches | 2026-10-16 | 8c040b0a | Needs Review | [261015-u3j-implement-q28-in-planning-reviews-2026-1](./quick/261015-u3j-implement-q28-in-planning-reviews-2026-1/) |
| 261016-d3y | Implement Q29 in .planning/reviews/2026-10-11-fix-plan.md — replace_box identity, gendsp round-trip, MAX-style JSON writer | 2026-10-16 | a5787ae8 | Verified | [261016-d3y-implement-q29-in-planning-reviews-2026-1](./quick/261016-d3y-implement-q29-in-planning-reviews-2026-1/) |
| 261016-jbx | Implement Q30 in .planning/reviews/2026-10-11-fix-plan.md — safe DB tooling | 2026-10-16 | 39f6c99b | Verified | [261016-jbx-implement-q30-in-planning-reviews-2026-1](./quick/261016-jbx-implement-q30-in-planning-reviews-2026-1/) |
| 261016-mpq | Implement Q31 in .planning/reviews/2026-10-11-fix-plan.md — codegen and Min-DevKit template fixes | 2026-10-17 | a04b94a4 | Needs Review | [261016-mpq-implement-q31-in-planning-reviews-2026-1](./quick/261016-mpq-implement-q31-in-planning-reviews-2026-1/) |
| 261016-pz8 | Implement Q32 in .planning/reviews/2026-10-11-fix-plan.md — remove dead code | 2026-10-17 | 71a19149 | Verified | [261016-pz8-implement-q32-in-planning-reviews-2026-1](./quick/261016-pz8-implement-q32-in-planning-reviews-2026-1/) |
| 261016-tal | Implement Q33 in .planning/reviews/2026-10-11-fix-plan.md — Box factory and shared helpers refactor | 2026-10-17 | 2e85ff34 | Verified | [261016-tal-implement-q33-in-planning-reviews-2026-1](./quick/261016-tal-implement-q33-in-planning-reviews-2026-1/) |
| 261016-uy1 | Implement Q34 in .planning/reviews/2026-10-11-fix-plan.md — MAX bridge spike | 2026-10-18 | 176a344c | — | [261016-uy1-implement-q34-in-planning-reviews-2026-1](./quick/261016-uy1-implement-q34-in-planning-reviews-2026-1/) |
| 261021-l26 | max-bridge v0.2.0 follow-ups from the Q34 checklist run | 2026-10-21 | 16e0b272 | — | [261021-l26-max-bridge-v0-2-0-follow-ups-from-the-q3](./quick/261021-l26-max-bridge-v0-2-0-follow-ups-from-the-q3/) |
| 261021-olv | max-verify --live mode via max-bridge | 2026-10-22 | 04712b14 | — | [261021-olv-max-verify-live-mode-via-max-bridge](./quick/261021-olv-max-verify-live-mode-via-max-bridge/) |
| 261021-urs | Implement Q35 in .planning/reviews/2026-10-11-fix-plan.md — GenExpr interpreter and codebox smoke test | 2026-10-22 | 0accfea9 | Verified | [261021-urs-implement-q35-in-planning-reviews-2026-1](./quick/261021-urs-implement-q35-in-planning-reviews-2026-1/) |
| 261022-cmr | Fix Q35 review findings CR-01, CR-02, WR-01..WR-06 in .planning/quick/261021-urs-implement-q35-in-planning-reviews-2026-1/261021-urs-REVIEW.md | 2026-10-22 | fa5bccf2 | Verified | [261022-cmr-fix-q35-review-findings-cr-01-cr-02-wr-0](./quick/261022-cmr-fix-q35-review-findings-cr-01-cr-02-wr-0/) |
| 261022-i07 | Implement Q36 in .planning/reviews/2026-10-11-fix-plan.md — edit_patch session API and semantic patch diff | 2026-10-22 | b8249985 | Verified | [261022-i07-implement-q36-in-planning-reviews-2026-1](./quick/261022-i07-implement-q36-in-planning-reviews-2026-1/) |
| 261022-ksz | Implement Q37 in .planning/reviews/2026-10-11-fix-plan.md — /max-diagnose, confirmation lifecycle, router domains | 2026-10-22 | cee6c3ac | Needs Review | [261022-ksz-implement-q37-in-planning-reviews-2026-1](./quick/261022-ksz-implement-q37-in-planning-reviews-2026-1/) |
| 261022-mis | Implement Q38 in .planning/reviews/2026-10-11-fix-plan.md — idiom allowlist, objectfile aliases, version-aware I/O | 2026-10-23 | 549400aa | Verified | [261022-mis-implement-q38-in-planning-reviews-2026-1](./quick/261022-mis-implement-q38-in-planning-reviews-2026-1/) |
| 261022-o2q | Implement Q39 in .planning/reviews/2026-10-11-fix-plan.md — critic quick-fix payloads and /max-iterate --fix | 2026-10-23 | a38c65db | Needs Review | [261022-o2q-implement-q39-in-planning-reviews-2026-1](./quick/261022-o2q-implement-q39-in-planning-reviews-2026-1/) |
| 261022-pqu | Implement Q40 in .planning/reviews/2026-10-11-fix-plan.md — M4L device builder and .amxd export | 2026-10-23 | c0396f5f | Needs Review | [261022-pqu-implement-q40-in-planning-reviews-2026-1](./quick/261022-pqu-implement-q40-in-planning-reviews-2026-1/) |
| 261022-ud6 | Review Q1-Q40 for regressions and fix every finding (WP1-WP6 parallel, WP7a handoffs, WP7b Q23, WP8 docs + v6.0.0 CHANGELOG) | 2026-10-23 | 2a2c24a5 (code) + WP8 docs | Released v6.0.0 | [261022-ud6-review-q1-q40-improvements-for-regressio](./quick/261022-ud6-review-q1-q40-improvements-for-regressio/) |
| 261023-mma | Add Cycling 74 Vision package (22 jit.vis.* entries) to the object DB | 2026-10-23 | 837acc8f | — | [261023-mma-add-cycling-74-vision-package-to-the-obj](./quick/261023-mma-add-cycling-74-vision-package-to-the-obj/) |
| 261103-gah | review the readme to see if it needs updating | 2026-11-03 | 3f66cb64 | — | [261103-gah-review-the-readme-to-see-if-it-needs-upd](./quick/261103-gah-review-the-readme-to-see-if-it-needs-upd/) |
| 261111-u3n | Add pytest-xdist and make parallel test runs safe | 2026-11-11 | fff24628 | — | [261111-u3n-add-pytest-xdist-and-make-parallel-test-](./quick/261111-u3n-add-pytest-xdist-and-make-parallel-test-/) |
| 261112-bve | Cut wall time of MAX bridge tests without weakening them | 2026-11-12 | 317975d6 | — | [261112-bve-cut-wall-time-of-max-bridge-tests-withou](./quick/261112-bve-cut-wall-time-of-max-bridge-tests-withou/) |

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
