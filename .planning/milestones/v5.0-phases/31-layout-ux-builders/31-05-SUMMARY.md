---
phase: 31
plan: 05
subsystem: agent-skills, claude-md, tests
tags: [LAYOUT-05, D-02, agent-discoverability, documentation]
requires:
  - 31-01 (LAYOUT-01 add_overlay_readout)
  - 31-02 (LAYOUT-02 add_labeled_param_bank)
  - 31-03 (LAYOUT-03 _ROLE_COMPANION_MAP)
  - 31-04 (LAYOUT-04 add_m4l_gen_synth)
provides:
  - Builder API discovery surface in max-patch-agent and max-ui-agent SKILL.md
  - CLAUDE.md prose-recipe-to-builder pointers (D-02)
  - Static tests guarding LAYOUT-05 invariants
affects:
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-ui-agent/SKILL.md
  - CLAUDE.md
  - tests/test_agent_skills.py
tech-stack:
  added: []
  patterns: [parametrized-pytest-content-tests, blockquote-recipe-annotation]
key-files:
  created: []
  modified:
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-ui-agent/SKILL.md
    - CLAUDE.md
    - tests/test_agent_skills.py
decisions:
  - "Inserted Builder API section after Capabilities, before Package Intelligence — consistent anchor across both SKILL.md files"
  - "Used identical text in both files (D-02 verbatim copy enforced by test_builder_api_sections_byte_identical)"
  - "Used blockquote `> Codified: ...` format for CLAUDE.md pointers — visually prominent, single-line, consistent across all three sections"
  - "Recipes preserved verbatim per D-02 (recipes are useful narrative; pointers add discoverability without losing prose context)"
metrics:
  duration: ~6 minutes
  completed: 2026-04-30
---

# Phase 31 Plan 05: Wire LAYOUT-05 — Agent Discoverability Summary

Wired LAYOUT-05 by adding a verbatim "Builder API (Phase 31)" section to both `max-patch-agent/SKILL.md` and `max-ui-agent/SKILL.md`, annotating CLAUDE.md's Rule #6, Multislider, and M4L recipe sections with one-line blockquote pointers to the new builder names, and extending `tests/test_agent_skills.py` with 12 parametrized tests that verify the section is present, identical between agents, references all four builders + `_ROLE_COMPANION_MAP`, and that CLAUDE.md contains the pointers — closing Phase 31 by making the four shipped builders discoverable from the canonical agent entry points.

## Tasks Completed

### Task 1 — Author "Builder API" section and apply to both SKILL.md files

- Inserted identical Builder API section into both SKILL.md files at the same anchor: after `## Capabilities` (and its `> Shared Capabilities:` callout), before `## Package Intelligence`.
- Section covers all four builders with full signatures, kwarg semantics, and "When to call" guidance:
  - `Patcher.add_overlay_readout(target, *, format='%.2f', type='flonum', editable=False, offset_x=0, offset_y=0)`
  - `Patcher.add_labeled_param_bank(params, x, y, *, label_side='left', extra_attrs=None)`
  - `Patcher.add_m4l_gen_synth(params, *, gen_varname='synth', gen_code=None)`
  - Role-driven companion-pair placement via `_ROLE_COMPANION_MAP` (passive — applied by `apply_layout`)
- Quick-reference table at bottom maps each use case to its builder and the CLAUDE.md recipe it codifies.
- Diff between the two SKILL.md sections is empty (verified manually via `diff <(sed -n ...) <(...)` and via the `test_builder_api_sections_byte_identical` test).
- **Commit:** `d59a602`

### Task 2 — Annotate CLAUDE.md recipes + extend test_agent_skills.py

- Added blockquote pointer immediately after each affected CLAUDE.md heading (consistent format across all three):
  - `### Rule #6: Z-Order Awareness` → `Patcher.add_overlay_readout(target, format='%.2f')` (Phase 31)
  - `#### Multislider as Labeled Parameter Bank` → `Patcher.add_labeled_param_bank(params, x, y)` (Phase 31)
  - `### Max for Live (M4L / .amxd)` → `Patcher.add_m4l_gen_synth(params)` (Phase 31)
- All three recipe bodies preserved unchanged (D-02 explicit — recipes still useful as prose).
- Added 12 new tests in `tests/test_agent_skills.py`:
  - `test_skill_md_has_builder_api_section[skill_path]` — 2 tests (both SKILL.md files have the section)
  - `test_skill_md_references_builder[builder_name][skill_path]` — 6 tests (each builder × each file)
  - `test_skill_md_references_role_companion_map[skill_path]` — 2 tests (both files reference `_ROLE_COMPANION_MAP`)
  - `test_builder_api_sections_byte_identical` — 1 test (D-02 verbatim copy enforcement via regex extraction)
  - `test_claude_md_pointer_to_builders` — 1 test (CLAUDE.md pointers exist for all three builder names)
- All 12 new tests pass; full `tests/test_agent_skills.py` suite (165 tests) green.
- **Commit:** `3dd2467`

## Test Names Added (LAYOUT-05 / D-02 Verification)

| Test name | Verifies |
|-----------|----------|
| `test_skill_md_has_builder_api_section` | LAYOUT-05: `## Builder API` heading exists in each SKILL.md |
| `test_skill_md_references_builder` | LAYOUT-05: each builder method name appears in each SKILL.md |
| `test_skill_md_references_role_companion_map` | LAYOUT-05: role-driven companion hook documented |
| `test_builder_api_sections_byte_identical` | D-02: verbatim copy across both SKILL.md files |
| `test_claude_md_pointer_to_builders` | D-02: CLAUDE.md recipe sections point to builder names |

## CLAUDE.md Sections Annotated

- `### Rule #6: Z-Order Awareness` (line 114) — codified by `add_overlay_readout`
- `#### Multislider as Labeled Parameter Bank` (line 92) — codified by `add_labeled_param_bank`
- `### Max for Live (M4L / .amxd)` (line 223) — codified by `add_m4l_gen_synth`

## Verbatim-Copy Verification (D-02)

Manual `diff` of the Builder API section between `max-patch-agent/SKILL.md` and `max-ui-agent/SKILL.md` returned empty output (BYTE-IDENTICAL). The `test_builder_api_sections_byte_identical` test enforces this invariant programmatically using regex extraction from `## Builder API` to the next top-level `## ` heading.

## Verification

- `pytest tests/test_agent_skills.py -k "builder_api or builder or skill_md_references_role_companion_map or claude_md_pointer_to_builders" -x` — 12 passed
- `pytest tests/test_agent_skills.py -x` — 165 passed (full agent-skills suite, no regression)
- `grep -c "## Builder API"` — 1 in each SKILL.md file
- `grep -c "_ROLE_COMPANION_MAP"` — 2 (one per SKILL.md file)
- `grep -c "Codified.*add_overlay_readout|Codified.*add_labeled_param_bank|Codified.*add_m4l_gen_synth" CLAUDE.md` — 3
- All three CLAUDE.md recipe sections still present (recipe bodies unchanged)

## Deviations from Plan

### Out-of-scope failures noted (not fixed)

`pytest tests/` (full suite) reports 48 pre-existing failures across `tests/test_integration_patches.py`, `tests/test_package_schema.py::TestCommunityPackageStubs`, `tests/test_source_coverage.py::TestSourceCoverage::test_extraction_log_total`, `tests/test_validation.py::TestCommunityPackageBlock`, and `tests/test_critics.py::TestPackageCritic::test_community_unextracted_warning`. These failures are entirely unrelated to LAYOUT-05's documentation surface — they concern community package extraction, integration patch validation against newer DB state, and source coverage counting. None of the failing tests touch the files modified by this plan (SKILL.md ×2, CLAUDE.md, test_agent_skills.py). They predate this plan's base commit (`8e348c00`) and were not caused by changes here.

**Action:** Logged and continued per scope-boundary rule — these are pre-existing issues outside Phase 31's documentation scope. The plan's actual verification target (`pytest tests/test_agent_skills.py -x`) passes 165/165.

### No other deviations

Plan executed exactly as written: same insertion location heuristic in both files (after Capabilities, before Package Intelligence), identical Builder API text, blockquote pointer format consistent across all three CLAUDE.md sections, all five test functions added with the structure specified.

## Manual Verification Deferred

Per VALIDATION.md, manual verification that `max-patch-agent` and `max-ui-agent` actually invoke the new builders post-update (rather than restating the prose recipe) is deferred to user observation in real generate runs. Static tests guarantee the documentation surface; behavioral verification requires live agent runs.

## Self-Check: PASSED

**Files claimed:**
- `.claude/skills/max-patch-agent/SKILL.md` — modified (Builder API section added) — FOUND in commit `d59a602`
- `.claude/skills/max-ui-agent/SKILL.md` — modified (Builder API section added) — FOUND in commit `d59a602`
- `CLAUDE.md` — modified (3 blockquote pointers added) — FOUND in commit `3dd2467`
- `tests/test_agent_skills.py` — extended (5 new test functions / 12 parametrized cases) — FOUND in commit `3dd2467`

**Commits claimed:**
- `d59a602` (docs(31-05): add Builder API section ...) — FOUND
- `3dd2467` (test(31-05): annotate CLAUDE.md recipes ...) — FOUND

**Acceptance criteria:**
- `## Builder API` section count in both SKILL.md files: 1 each — PASS
- `add_overlay_readout|add_labeled_param_bank|add_m4l_gen_synth` count in both SKILL.md files: 7 each — PASS (>= 1 required)
- `_ROLE_COMPANION_MAP` count in both SKILL.md files: 2 each — PASS (>= 1 required)
- Builder API section byte-identical: PASS (manual `diff` empty + test passes)
- CLAUDE.md `Codified.*add_*` count: 3 — PASS (>= 3 required)
- CLAUDE.md recipe sections preserved: PASS (Multislider, Rule #6, M4L all still present)
- New test names appear in test_agent_skills.py: PASS (>= 3 required, all 5 added)
- `pytest tests/test_agent_skills.py -k builder_api -x` — PASS (12 tests)
- `pytest tests/test_agent_skills.py -x` — PASS (165 tests, no regression)
