---
phase: quick-261112-dci
plan: 01
subsystem: docs / agent context
tags: [claude-md, skills, context-budget, tests]
status: complete
requires: []
provides:
  - "CLAUDE.md slimmed by 2,598 bytes with every heading and rule kept"
  - "shared-capabilities.md sections: Multislider as Labeled Parameter Bank, Max for Live Device Rules, bach (package) Rules"
  - "max-rnbo-agent SKILL.md section: RNBO Export Rules"
affects: [max-patch-agent, max-ui-agent, max-dsp-agent, max-rnbo-agent, max-router]
tech-stack:
  added: []
  patterns: ["verbatim section move with one-line pointer + numbered loader Read step + MOVED_DETAIL anchors"]
key-files:
  created: []
  modified:
    - CLAUDE.md
    - .claude/skills/references/shared-capabilities.md
    - .claude/skills/max-rnbo-agent/SKILL.md
    - .claude/skills/max-patch-agent/SKILL.md
    - .claude/skills/max-ui-agent/SKILL.md
    - .claude/skills/max-dsp-agent/SKILL.md
    - .claude/skills/references/troubleshooting.md
    - .claude/skills/references/max-9.2-changes.md
    - .claude/skills/max-router/references/dispatch-rules.md
    - src/maxpat/builders.py
    - src/maxpat/critics/package_critic.py
    - tests/test_claude_md.py
    - tests/test_agent_skills.py
    - tests/test_m4l_gen_synth.py
decisions:
  - "Moved bodies are line-exact copies; verbatim_check.py (checks A-E against base fab1dce7) proves it"
metrics:
  duration: "~5 min"
  completed: 2026-11-12
actuals:
  tokens: 11400
  tasks: 3
  commits: 3
plan_head_before: fab1dce780d4111018c4e69532b3ca700b1c4086
plan_head_after: 8991da7ff7763c128e233d35d630241fbf052436
---

# Quick 261112-dci: Reduce the size of CLAUDE.md without losing any rule — Summary

Moved the Multislider, M4L, bach and RNBO section bodies verbatim out of CLAUDE.md into skill-loaded homes, left each heading with a one-line pointer, added explicit numbered Read steps in the four specialist loaders (test-pinned), repointed 14 stale citations, and lowered the size ratchet.

## Size

| | Bytes |
|---|---|
| CLAUDE.md before (base fab1dce7, same content as e0ab4dde) | 29,891 |
| CLAUDE.md after | 27,293 |
| Delta | -2,598 (-8.7%) |
| `CLAUDE_BUDGET_BYTES` | 30_000 -> 27_500 |

## What moved where

| CLAUDE.md section | New home (full path) | New heading | Loaders that read it | Pointer line kept in CLAUDE.md |
|---|---|---|---|---|
| `#### Multislider as Labeled Parameter Bank` (Codified note, Manual banks, Reading values by index) | `.claude/skills/references/shared-capabilities.md` (inside the `add_labeled_param_bank` Builder API entry) | `#### Multislider as Labeled Parameter Bank` | max-patch-agent (step 2), max-ui-agent (step 2) | Use the builder `Patcher.add_labeled_param_bank(params, x, y)`; manual-bank attributes and reading values by index (`fetch $1`, right outlet): `.claude/skills/references/shared-capabilities.md` "Multislider as Labeled Parameter Bank". |
| `### RNBO (Export-Ready Patches)` (Experimental line, 3 bullets) | `.claude/skills/max-rnbo-agent/SKILL.md` (after Domain Context Loading) | `## RNBO Export Rules` | max-rnbo-agent (step 1 repointed to its own section) | Experimental. Use only `rnbo_compatible: true` objects; export rules (the `rnbo~` container, self-contained export targets, `param` mapping): `.claude/skills/max-rnbo-agent/SKILL.md` "RNBO Export Rules". |
| `### Max for Live (M4L / .amxd)` (Experimental line, Codified note, 4 bullets) | `.claude/skills/references/shared-capabilities.md` (after Builder API) | `## Max for Live Device Rules` | max-patch-agent (step 2), max-dsp-agent (step 3) | Experimental. Build devices with `Patcher.add_m4l_device(kind, params)` or `Patcher.add_m4l_gen_synth(params)`, then `export_amxd(maxpat_path)`; read the device rules (`plugout~` output path, `param_connect` binding, Live automation) first: `.claude/skills/references/shared-capabilities.md` "Max for Live Device Rules". |
| `### bach (package)` (2 bullets) | `.claude/skills/references/shared-capabilities.md` (before Editing Functions) | `## bach (package) Rules` | max-patch-agent (step 2), max-dsp-agent (step 3) | Before using any bach object, read `.claude/skills/references/shared-capabilities.md` "bach (package) Rules" (missing `bach.llll2list` / `bach.list2llll`, `bach.nth` extraction, `@out t` toward plain MAX objects). |

Not moved (per CONTEXT): Gen~ list and every other section; verbatim_check check C confirms CLAUDE.md is line-identical to base outside the four bodies.

## Test bookkeeping

Anchors moved from `RULE_ANCHORS` to `MOVED_DETAIL` (16; none deleted — verbatim_check check E):

| Key | Anchors moved |
|---|---|
| multislider | "Reading values by index", "fetchindex", "outlet 1", "orientation: 0", "size * 24", "contdata: 1", "setstyle: 1", "named subpatchers" |
| m4l | "parameter_enable: 1", "saved_attribute_attributes.valueof", "not Live-automatable", "signal-rate exception" |
| bach | "@unwrap 1" |
| rnbo | "VST3/AU", "RNBO-specific definitions", "`param` objects in RNBO" |

Pointer-kept anchors stay in `RULE_ANCHORS` and are also pinned at the destination via `MOVED_DETAIL`. `DETAIL_HOMES` gains `rnbo`. New tests: `test_moved_claude_rules_loaded_by_specialist` (4 agents) and `test_moved_claude_rule_homes_have_headings` (4 headings) in tests/test_agent_skills.py.

Collect count of tests/test_claude_md.py + tests/test_agent_skills.py: 525 -> 553.

## Stale citations

Gate (`grep -rnE ... .claude src tools tests`): 14 -> 0. Files touched: max-rnbo-agent/SKILL.md (C1), shared-capabilities.md (C2-C4), max-dsp-agent/SKILL.md (C5), troubleshooting.md (C6-C8; C8 was on line 6, not 8), max-9.2-changes.md (C9-C10), max-router/references/dispatch-rules.md (C11), src/maxpat/builders.py (C12-C13, C13 paragraph rewrapped), src/maxpat/critics/package_critic.py (C14, paragraph rewrapped), tests/test_m4l_gen_synth.py (C15, comment only). `builders.py` line 549 ("CLAUDE.md Rule #4 'Multislider as Labeled Parameter Bank' points here") left as is — still true.

Final full suite (Q/full-suite.txt): `7598 passed, 1 skipped, 4 xfailed, 37 warnings in 25.78s`

## Commits

| Task | Hash | Message |
|---|---|---|
| 1 (tracer) | 7a68f3a4 | docs(261112-dci): move bach rules out of CLAUDE.md (tracer) |
| 2 | a1f17cec | docs(261112-dci): move multislider, M4L and RNBO rules out of CLAUDE.md |
| 3 | 8991da7f | docs(261112-dci): repoint citations to moved rules, lower CLAUDE.md ratchet |

## TDD Gate Compliance

Task 1 and Task 2 RED confirmed before GREEN (9 and 26 failing cases respectively), then green. Tests and implementation were committed together per task, as the plan's single-commit-per-task contract specified.

## Deviations from Plan

- Base sha recorded as fab1dce7 (HEAD at start) rather than e0ab4dde; the only difference is the pre-dispatch PLAN/CONTEXT docs, so CLAUDE.md and tests are identical.
- `tests/test_agent_skills.py` needed `import re` for the new numbered-step regex (Rule 3, trivial).

Otherwise the plan ran as written.

## Self-Check: PASSED

- All 14 modified files exist; commits 7a68f3a4, a1f17cec, 8991da7f are ancestors of HEAD.
- `verbatim_check.py bach multislider m4l rnbo` -> OK.
