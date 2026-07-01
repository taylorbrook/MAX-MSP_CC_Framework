---
phase: quick-260701-jxg-review-repo
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .planning/quick/260701-jxg-review-repo-and-produce-improvement-repo/260701-jxg-REPORT.md
autonomous: true
requirements:
  - QUICK-REVIEW-01
must_haves:
  truths:
    - "A single REPORT.md exists containing prioritized improvement ideas for the repo."
    - "The report covers all six mandated review areas: Python API, object DB health, docs/skills, validation pipeline, test coverage, repo hygiene."
    - "Every improvement idea is grounded in a concrete file/module observation, not generic advice."
    - "No source code, patch, or database file was modified."
  artifacts:
    - ".planning/quick/260701-jxg-review-repo-and-produce-improvement-repo/260701-jxg-REPORT.md"
  key_links:
    - "Report findings trace to actual paths under src/maxpat/, .claude/max-objects/, .claude/skills/, tests/."
---

<objective>
Review the MAX/MSP patch-generation framework (Python Patcher API, object database, validation/critic pipeline, Claude skills/agents, docs, tests, repo hygiene) and produce ONE written report of prioritized improvement ideas for the user.

Purpose: Give the user an evidence-based, actionable improvement backlog grounded in the actual codebase, not generic advice.
Output: `.planning/quick/260701-jxg-review-repo-and-produce-improvement-repo/260701-jxg-REPORT.md`

READ-ONLY: This plan MUST NOT modify any source code, patch, database, override, or skill file. The only file created is the report.
</objective>

<execution_context>
@$HOME/.claude/gsd-core/workflows/execute-plan.md
@$HOME/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@./CLAUDE.md
@./README.md
@./TECHNICAL.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Review the Python API, validation/critic pipeline, and test coverage</name>
  <files>.planning/quick/260701-jxg-review-repo-and-produce-improvement-repo/260701-jxg-REPORT.md</files>
  <action>
    READ-ONLY analysis. Do not edit any file under src/, tests/, .claude/, patches/, or scripts/.

    Survey the Python codebase to assess API quality and pipeline health:
    - Core API: read src/maxpat/patcher.py (2474 LOC — largest module), src/maxpat/__init__.py public surface, src/maxpat/db_lookup.py (ObjectDatabase), src/maxpat/layout.py, src/maxpat/validation.py. Skim, do not exhaustively read every line — sample enough to judge cohesion, module size, duplication, docstring quality, and whether patcher.py should be decomposed.
    - Validation + critics: read src/maxpat/critics/base.py plus 2-3 concrete critics (dsp_critic.py, structure_critic.py, layout_critic.py), src/maxpat/code_validation.py, src/maxpat/rnbo_validation.py, src/maxpat/ext_validation.py. Assess how the generate-review-revise loop enforces the CLAUDE.md rules (gain safety, hot/cold ordering, PD blocklist, empty-I/O objects).
    - DSP pre-flight sim: skim src/maxpat/dsp_sim/ (classifier, runner, measure) to note maturity/coverage.
    - Tests: run `python -m pytest --collect-only -q 2>&1 | tail -30` and `python -m pytest -q 2>&1 | tail -40` to capture the real pass/fail/skip picture. STATE.md notes ~48 pre-existing TestCommunityPackageBlock failures and missing Nyquist VALIDATION.md files — confirm current status rather than trusting the note. Map which src modules have matching test_*.py and which lack coverage.

    Capture concrete findings (file paths, LOC, specific gaps) into a scratch notes file under the scratchpad dir for Task 3 to consolidate. Do NOT write to the report yet — Task 3 owns report authorship. Focus on: largest-module decomposition candidates, API ergonomics/consistency issues, validation coverage gaps vs the CLAUDE.md rule set, and test coverage holes.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest --collect-only -q 2>&1 | tail -5</automated>
  </verify>
  <done>Findings notes captured for API structure (with patcher.py decomposition assessment), validation/critic coverage vs CLAUDE.md rules, DSP sim maturity, and a concrete test pass/fail/skip snapshot with module-to-test coverage mapping. No repo files modified.</done>
</task>

<task type="auto">
  <name>Task 2: Review object database health, skills/agents/docs, and repo hygiene</name>
  <files>.planning/quick/260701-jxg-review-repo-and-produce-improvement-repo/260701-jxg-REPORT.md</files>
  <action>
    READ-ONLY analysis. Do not edit any file under .claude/, src/, tests/, patches/, or scripts/.

    Object database health:
    - Inspect the 8 domain files under .claude/max-objects/*/objects.json plus overrides.json, aliases.json, relationships.json, pd-blocklist.json, verified-objects.json, package_info.json, extraction-log.json.
    - Quantify the known empty-I/O problem STATE.md/CLAUDE.md flag (168 entries with empty inlets/outlets). Use ObjectDatabase.audit_empty_io() if available, else grep. Report counts per domain.
    - Check schema consistency: STATE.md notes signal_role outlets with empty `type`/`digest` (Phase 30 WR-01, ~703/795), the `signal: bool` back-compat shim scheduled for removal, and `is_domain_restricted` orphan. Confirm which are still present.
    - Note verified/verified_installed coverage and any drift between the DB and overrides.

    Skills/agents + documentation:
    - Review .claude/skills/ SKILL.md files (max-router, max-patch-agent, max-dsp-agent, max-critic, etc.) for accuracy vs the actual Python API and for drift from CLAUDE.md rules.
    - Assess CLAUDE.md itself (23KB): is it too large / redundant with MEMORY.md feedback entries? Are codified builders (add_labeled_param_bank, add_overlay_readout, replace_box_safe) documented consistently? Note README.md and TECHNICAL.md staleness vs current milestone (v5.0 shipped).

    Repo hygiene:
    - Run `git status --short` and check .gitignore coverage — note that __pycache__/*.pyc and .DS_Store appear tracked/present; .pytest_cache present. Check for the 80 orphaned quick-task slugs STATE.md flags, tracked build artifacts, and any stray files.
    - Note the 36 substantive deferred items (Nyquist VALIDATION gaps, human-UAT, tech-debt) from STATE.md as a standing-debt signal.

    Capture concrete findings (paths, counts) into the same scratch notes file for Task 3. Do NOT write to the report yet.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -c "from src.maxpat.db_lookup import ObjectDatabase; db=ObjectDatabase(); print('db loaded OK')" 2>&1 | tail -3</automated>
  </verify>
  <done>Findings notes captured for DB health (per-domain empty-I/O counts, schema/metadata gaps), skill/agent-vs-API accuracy, CLAUDE.md/README/TECHNICAL doc quality, and repo hygiene (gitignore gaps, orphaned slugs, deferred-item debt). No repo files modified.</done>
</task>

<task type="auto">
  <name>Task 3: Synthesize findings into the prioritized improvement REPORT.md</name>
  <files>.planning/quick/260701-jxg-review-repo-and-produce-improvement-repo/260701-jxg-REPORT.md</files>
  <action>
    Consolidate the Task 1 + Task 2 scratch notes into a single well-structured markdown report at
    .planning/quick/260701-jxg-review-repo-and-produce-improvement-repo/260701-jxg-REPORT.md.

    Required top-level sections (use these exact H2 headings so verification passes):
    - `## Executive Summary` — 3-6 sentence health assessment + the top 3 highest-leverage improvements.
    - `## Python API Quality` — patcher.py decomposition, module cohesion, API ergonomics/consistency, docstring/type-hint gaps.
    - `## Object Database Health` — empty-I/O counts, signal_role metadata fidelity, schema shims/orphans, verified coverage.
    - `## Validation Pipeline` — critic/validation coverage vs CLAUDE.md rules, DSP pre-flight sim maturity, gaps.
    - `## Test Coverage` — real pass/fail/skip snapshot, module coverage map, the pre-existing failures, Nyquist VALIDATION gaps.
    - `## Documentation & Skills` — CLAUDE.md size/redundancy, skill-vs-API drift, README/TECHNICAL staleness.
    - `## Repo Hygiene` — gitignore/tracked-artifact issues, orphaned quick-task slugs, deferred-item debt.
    - `## Prioritized Recommendations` — a ranked table with columns: Priority (P0/P1/P2), Area, Recommendation, Effort (S/M/L), Rationale. Include at least 8 rows spanning all six areas.

    Every finding MUST cite a concrete path or count (e.g., "src/maxpat/patcher.py at 2474 LOC", "168 empty-I/O entries"). No generic filler. Keep the tone terse and action-oriented per the user's profile. Prefer recommendations over prose.

    This is the ONLY file this plan writes. Do not modify any source, patch, DB, or skill file.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && f=.planning/quick/260701-jxg-review-repo-and-produce-improvement-repo/260701-jxg-REPORT.md && test -f "$f" && for h in "## Executive Summary" "## Python API Quality" "## Object Database Health" "## Validation Pipeline" "## Test Coverage" "## Documentation & Skills" "## Repo Hygiene" "## Prioritized Recommendations"; do grep -qF "$h" "$f" || { echo "MISSING: $h"; exit 1; }; done && echo "all sections present"</automated>
  </verify>
  <done>REPORT.md exists with all eight required H2 sections, every finding cites a concrete path/count, and the Prioritized Recommendations table has >=8 ranked rows spanning all six areas. No source/patch/DB/skill file modified.</done>
</task>

</tasks>

<threat_model>
Not applicable. This is a read-only review task: no code execution beyond running the existing test suite and importing the DB module for inspection, no package installs, no network calls, and no trust boundaries crossed. The only artifact written is a markdown report inside `.planning/`.
</threat_model>

<verification>
- `git status --short` shows only the new REPORT.md (and this PLAN.md/SUMMARY) as changes — no src/, patches/, or .claude/ files modified.
- Report contains all eight required H2 sections and a Prioritized Recommendations table with >=8 rows.
- Spot-check: each section references at least one concrete path or numeric count from the codebase.
</verification>

<success_criteria>
A single, evidence-grounded improvement report exists at the target path covering Python API quality, object database health, validation pipeline, test coverage, documentation/skills, and repo hygiene, with a prioritized recommendation table — and no source, patch, or database file was altered.
</success_criteria>

<output>
Create `.planning/quick/260701-jxg-review-repo-and-produce-improvement-repo/260701-jxg-SUMMARY.md` when done.
</output>