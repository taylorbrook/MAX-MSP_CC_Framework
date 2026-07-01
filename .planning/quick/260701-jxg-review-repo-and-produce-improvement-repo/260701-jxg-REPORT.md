---
task: 260701-jxg
title: Repo Review — Prioritized Improvement Report
status: complete
date: 2026-07-01
scope: read-only review (Python API, object DB, validation pipeline, tests, docs/skills, repo hygiene)
---

# MAX Framework — Improvement Report

## Executive Summary

The framework is healthy at its core: 1961 tests pass, the `Patcher` API round-trips losslessly, and the critic/validation pipeline enforces the CLAUDE.md rule set (gain staging, fan-out/trigger, PD blocklist). But the test suite is misleadingly red — **57 failing tests** are almost entirely drift and stale-fixture noise, not core regressions, which erodes the signal a green suite is supposed to give. The object DB carries known metadata debt (703/795 `signal_role` outlets missing `type`), and repo hygiene has degraded (124 tracked `.DS_Store`/`.pyc` files, a near-empty `.gitignore`, 82 quick-task slugs). Docs (`README.md`, `TECHNICAL.md`) are stale to the v3.0/v2.2 era while the codebase shipped v5.0.

**Top 3 highest-leverage fixes:**
1. **Fix the integration-test drift** (`tests/test_integration_patches.py:66` passes a removed `patch_dir=` kwarg) — 36 failures collapse to green and restore real coverage over every committed patch.
2. **Fix `.gitignore` + untrack junk** — add `__pycache__/`, `*.pyc`, `.DS_Store`, `.pytest_cache/`; untrack the 124 committed artifacts. One-time, high signal-to-noise win.
3. **Regenerate `extraction-log.json`** — it reports `total_objects: 4` (all domain counts 0); this is a corrupted/reset fixture failing `test_source_coverage` and misrepresenting the DB.

## Python API Quality

- **`src/maxpat/patcher.py` at 2474 LOC is the largest module** and a decomposition candidate, but it already delegates via `GraphMixin`/`AnalysisMixin` (`graph.py` 345 LOC, `analysis.py` 612 LOC). The remaining bulk is the `Box` class (lines 129–360, ~230 LOC) and 47 `Patcher` methods (18 of them `add_*` builders). Recommended split: extract the 18 builder methods (`add_labeled_param_bank`, `add_overlay_readout`, `add_m4l_gen_synth`, etc.) into a `BuildersMixin` to drop patcher.py under ~1800 LOC without touching core edit logic.
- **Return-type-hint coverage is thin in the core class**: only 19/47 `Patcher` methods (~40%) carry a `->` return annotation. Docstring density is good (96 `"""` markers).
- **Private symbols leak into the public API**: `src/maxpat/__init__.py` re-exports `_AUTO_HIGHLIGHT` (underscore-prefixed) alongside 91 public names. Either promote it to a public name or drop it from the re-export list.
- **Module cohesion is otherwise reasonable** — validation (1410), layout (1337), db_lookup (1027) are large but single-responsibility. No egregious duplication surfaced in sampling.

## Object Database Health

- **Empty-I/O entries persist**: raw scan finds **164 objects with empty `inlets` AND `outlets`** across domain files (matches the ~168 STATE.md flag), concentrated in packages — `abclib` alone has 65, then `max` 15, `rnbo` 11, `jit.mo` 8, `grainflow` 7. `ObjectDatabase.audit_empty_io()` only classifies 43 (9 critical: `bp.Global Transport`, `dsp`, `jbox`, `jit_kernel`, `onecopy`, `opensoundcontrol`, `project`, `snorm`, `bp.serialosc`; 34 variable_io_ok) — meaning **the audit tool does not see ~120 package empty-I/O entries**, so the safety net CLAUDE.md relies on ("check I/O lengths, not just exists()") is under-covering the package domains.
- **`signal_role` metadata fidelity is still broken (WR-01)**: of 795 loaded outlets carrying `signal_role`, **703 have an empty `type` field and 588 have an empty `digest`**. Confirmed against the loaded DB (post-override), not just the note. The `cmd_apply_run` synthesis path needs to carry full metadata onto curated outlets.
- **Back-compat shim still live**: `db_lookup.py:168` projects `signal_role` onto the legacy `outlet['signal']` bool at load; removal is deferred to v6.0 (D-15). `domain_restricted` is wired and validated (`db_lookup.py:250-261`), so the `is_domain_restricted` "orphan" flagged in STATE.md is effectively the validation-only surface, not dead code.
- **Domain counts**: max 471, rnbo 560, msp 246, mc 222, jitter 218, gen 189, m4l 35, plus 29 package sub-folders. `overrides.json` is 336 KB — the DB's real source of truth for I/O; on-disk domain files store 0 explicit `signal_role` outlets (all applied at runtime from overrides).

## Validation Pipeline

- **Critic coverage maps well to CLAUDE.md rules.** `dsp_critic.py` (524 LOC) enforces gain staging (`_GAIN_NAMES`, `_TERMINAL_NAMES`, `_NORMALIZER_NAMES`, MIDI-range 0-127 detection); `structure_critic.py` enforces fan-out-without-trigger (Rule #3/#4); `validation.py` carries the PD blocklist check. Nine critics total (dsp, package, m4l, layout, structure, rnbo, ext + base + registry).
- **The generate-review-revise loop is real** (`review_patch` in `critics/__init__.py:55`) and flags genuine issues — 14 committed patches currently fail `test_review_patch_no_blockers` with real blockers (e.g. `kicksynth.maxpat`: "8 blocker(s)… Fan-out without trigger: 'number' (obj-129) outlet 0 connected to 2 destinations"). These are true Rule #3 violations in shipped patches, not false positives — either the patches need trigger fan-out or the critic needs a documented allowlist.
- **DSP pre-flight sim is immature/narrow**: `src/maxpat/dsp_sim/` has only **3 topologies** (`bore_only`, `reed_bore`, `reed_bore_post_radiation`) — all bassoon-model waveguide cases. The classifier/runner/measure scaffolding (1003 LOC) is solid but generalizes to almost nothing else. It is effectively a single-project tool today.
- **Validation behavior drifted from its tests**: `TestCommunityPackageBlock` expects ≥1 package warning but gets 0 (`test_validation.py:1802`) — the community-package warning path was changed/removed without updating tests.

## Test Coverage

- **Snapshot: 57 failed, 1961 passed, 4 xfailed (29s).** The failures are NOT the "~48 TestCommunityPackageBlock" STATE.md predicted — that note is stale. Actual breakdown:
  | Cluster | Count | Root cause |
  |---------|-------|------------|
  | `test_validate_patch_no_errors` | 36 | **Test-API drift** — passes removed `patch_dir=` kwarg (`test_integration_patches.py:66`); `validate_patch()` signature is `(patch, db, allowed_packages)`. TypeError before validation even runs → **integration coverage over every real patch is currently a no-op**. |
  | `test_review_patch_no_blockers` | 14 | **Real critic blockers** in committed patches (fan-out without trigger, gen~ I/O, etc.). |
  | Community-package (`test_validation` x2, `test_package_schema` x3, `test_critics` x1) | 6 | **Behavior drift** — validation no longer emits package warnings / stub expectations changed. |
  | `test_source_coverage::test_extraction_log_total` | 1 | **Stale fixture** — `extraction-log.json` reports `total_objects: 4` (expected >1500). |
- **44 `test_*.py` files** covering 24 source modules. **8 modules lack a dedicated test file**: `defaults`, `ext_templates`, `ext_validation`, `graph`, `m4l_constants`, `maxclass_map`, `rnbo_validation`, `utils` (some are covered transitively, e.g. externals tests exercise `ext_validation`; `graph`/`maxclass_map` are load-bearing and deserve direct tests).
- **Nyquist VALIDATION.md gaps** (from STATE.md, unverified in this pass): phases 28, 30, 32 missing entirely; 29, 31 draft with `nyquist_compliant=false`. Standing process debt.

## Documentation & Skills

- **`CLAUDE.md` is 298 lines / 23.6 KB** and overlaps heavily with the **30 `feedback_*.md` MEMORY entries** — e.g. `line~` comma behavior, `floor~`/RNBO, `expr` has no `clip()`, gen~ param messages, multislider `fetch`, umenu items format all appear in BOTH. This duplication risks divergence; consider making CLAUDE.md the canonical rule surface and letting MEMORY hold only the discovery-log provenance, or vice-versa.
- **Codified builders are documented consistently** in CLAUDE.md (`add_labeled_param_bank`, `add_overlay_readout`, `replace_box_safe`, `add_m4l_gen_synth`) with "prefer the builder" pointers — good.
- **Skills are NOT drifted from the API**: all 8 `.claude/skills/*/SKILL.md` reference real methods (`save_patch_roundtrip`, `add_connection`, `ObjectDatabase`, `replace_box`), and none reference the deprecated `generate.py` pattern (Rule #5 respected).
- **`README.md` (16 KB) and `TECHNICAL.md` (28 KB) are stale**: README's architecture note tops out at "Direct .maxpat Editing (v3.0)"; TECHNICAL references a "Retired in v2.2" agent. Neither mentions v5.0 (DB Schema Hardening + Validator Depth) or the dsp_sim / signal_role work. Refresh both to current milestone.

## Repo Hygiene

- **`.gitignore` is nearly empty** — a single line (`.claude/max-objects/_pkg-source/`). It does NOT ignore `__pycache__/`, `*.pyc`, `.DS_Store`, or `.pytest_cache/`.
- **Consequence: 124 junk files are tracked** — `.DS_Store` at repo root and in `.claude/`, `patches/*/generated/`, `src/`, `.planning/`; plus committed `*.pyc` (`scripts/__pycache__/audit_signal_role.cpython-314.pyc`, `.claude/scripts/__pycache__/extract_objects.cpython-314.pyc`). `.pytest_cache/` is present on disk.
- **`.claude/worktrees/` is untracked and not ignored** (shows in `git status`), likely a stray GSD worktree dir.
- **82 quick-task slugs** under `.planning/quick/` (STATE.md flags 80 as orphaned/empty). Cleanup candidate.
- **36 substantive deferred items** (4 human-UAT + 5 Nyquist + 27 tech-debt) tracked in STATE.md / `v5.0-MILESTONE-AUDIT.md` — a standing-debt signal to burn down at v6.0 kickoff.

## Prioritized Recommendations

| Priority | Area | Recommendation | Effort | Rationale |
|----------|------|----------------|--------|-----------|
| P0 | Test Coverage | Fix `test_integration_patches.py:66` — drop the removed `patch_dir=` kwarg from the `validate_patch()` call | S | Collapses 36 failures; restores real validation coverage over every committed `.maxpat` (currently a silent no-op) |
| P0 | Repo Hygiene | Add `__pycache__/`, `*.pyc`, `.DS_Store`, `.pytest_cache/` to `.gitignore` and `git rm --cached` the 124 tracked artifacts | S | Near-empty `.gitignore` is leaking OS/build junk into history; one-time cleanup |
| P0 | Object DB | Regenerate `extraction-log.json` (currently `total_objects: 4`, all domain counts 0) | S | Corrupted fixture fails `test_source_coverage` and misrepresents DB scale (~1900 objects) |
| P1 | Object DB | Backfill `type`/`digest` on the 703/588 `signal_role` outlets via the `cmd_apply_run` synthesis path (WR-01) | M | Metadata fidelity gap flagged since Phase 30; affects outlet-type reasoning for critics |
| P1 | Validation | Extend `audit_empty_io()` to cover package domains — it misses ~120 of 164 empty-I/O entries (abclib 65, etc.) | M | The empty-I/O safety net CLAUDE.md depends on under-covers exactly where most gaps live |
| P1 | Test/Validation | Reconcile the 6 community-package failures and 14 patch-blocker failures — decide per case: update tests to match new behavior, or fix the patches/critics | M | Red suite hides real regressions; each failure is either a stale test or a genuine patch defect |
| P1 | Documentation | Refresh `README.md` (stuck at v3.0) and `TECHNICAL.md` (v2.2 refs) to v5.0; document dsp_sim + signal_role schema | M | Onboarding/reference docs are two milestones stale |
| P2 | Python API | Extract the 18 `add_*` builders from `patcher.py` (2474 LOC) into a `BuildersMixin`; add return-type hints (only ~40% covered) | M | Largest module; mixin pattern already established via Graph/Analysis mixins |
| P2 | Python API | Stop re-exporting private `_AUTO_HIGHLIGHT` from `__init__.py` (promote or drop) | S | Private symbol leaking into the 91-name public surface |
| P2 | Validation | Broaden `dsp_sim` beyond the 3 bassoon-only topologies, or scope/document it as project-specific | L | 1003 LOC of scaffolding currently serves one model; low reuse |
| P2 | Test Coverage | Add direct tests for the 8 untested modules, prioritizing `graph.py` and `maxclass_map.py` (load-bearing) | M | `maxclass_map.py` is the authoritative UI-class source per CLAUDE.md; deserves direct coverage |
| P2 | Documentation | De-duplicate `CLAUDE.md` (23.6 KB) against the 30 `feedback_*.md` MEMORY entries — pick one canonical rule surface | M | Overlap risks divergence between the two rule sources |
| P2 | Repo Hygiene | Prune the 82 quick-task slugs and untrack/ignore `.claude/worktrees/`; burn down the 36 deferred items at v6.0 kickoff | S | Standing clutter and debt flagged at v5.0 close |
