# 261112-dci — Locked decisions (user-approved 2026-11-12)

## Baseline
CLAUDE.md = 29,891 bytes (tests/test_claude_md.py CLAUDE_BUDGET_BYTES = 30_000).

## Moves (APPROVED — do exactly these, nothing else)

| CLAUDE.md section | Body moves to (verbatim, no rewording) | Loader that must read it |
|---|---|---|
| `#### Multislider as Labeled Parameter Bank` (body: Codified note, Manual banks, Reading values by index) | `.claude/skills/references/shared-capabilities.md`, merged into/next to the existing `add_labeled_param_bank` entry (~line 155) | max-patch-agent, max-ui-agent |
| `### Max for Live (M4L / .amxd)` (Experimental line, Codified note, 4 bullets) | `.claude/skills/references/shared-capabilities.md`, new section "Max for Live Device Rules" | max-dsp-agent, max-patch-agent |
| `### bach (package)` (2 bullets) | `.claude/skills/references/shared-capabilities.md`, new section "bach (package) Rules" | max-patch-agent, max-dsp-agent |
| `### RNBO (Export-Ready Patches)` (Experimental line, 3 bullets) | `.claude/skills/max-rnbo-agent/SKILL.md`, new section "RNBO Export Rules" | max-rnbo-agent (its Domain Context Loading step 1 currently says "Read `CLAUDE.md` RNBO section" — repoint to its own section) |

## Explicitly NOT moved
- Gen~ bullet list stays in CLAUDE.md in full (user decision: non-specialist sessions editing codeboxes must see it).
- Rules #1-#9 (other than the Multislider sub-section), Object Database, MSP/gain safety, PD guard, Jitter, Subpatcher I/O, N4M, js/v8, Version, #N args, Variable I/O, File Conventions: untouched.

## Form of what remains in CLAUDE.md
- Every heading stays verbatim (BASE_HEADINGS test pins them).
- Under each moved heading: ONE line, imperative, in the file's existing pointer style, naming the full path of the new home, e.g.
  `Use the builder \`Patcher.add_labeled_param_bank(params, x, y)\`; manual-bank attributes and reading values by index (\`fetch $1\`, right outlet): \`.claude/skills/references/shared-capabilities.md\` "…".`
- Keep the builder names `add_labeled_param_bank` and `add_m4l_gen_synth` in CLAUDE.md (test_agent_skills.py::test_claude_md_pointer_to_builders).

## Load-chain requirement
Specialist SKILL.md files currently only say "See shared-capabilities.md". Add an explicit numbered "Read `.claude/skills/references/shared-capabilities.md` …" step in `## Domain Context Loading` of each loader listed above, naming the moved section(s). Add a test in tests/test_agent_skills.py asserting each loader's Domain Context Loading section names the destination file (pattern: test_dsp_agent_loads_genexpr_rules).

## Test updates (allowed only for moved sections; never delete an assertion)
- tests/test_claude_md.py: anchors of moved text move from RULE_ANCHORS into MOVED_DETAIL under new keys (e.g. "m4l", "bach", "multislider" -> shared-capabilities.md; "rnbo" -> max-rnbo-agent/SKILL.md). Anchors that still appear in the one-line pointers may stay in RULE_ANCHORS. Lower CLAUDE_BUDGET_BYTES ratchet to the new size rounded up to the next 500 bytes. Add DETAIL_HOMES entry for max-rnbo-agent/SKILL.md if CLAUDE.md now names it.
- Fix stale citations "CLAUDE.md M4L / bach / Multislider / RNBO section" in: .claude/skills/references/troubleshooting.md (bach rows), .claude/skills/references/max-9.2-changes.md (M4L rows), .claude/skills/references/shared-capabilities.md (lines ~156, ~182), .claude/skills/max-router/references/dispatch-rules.md (~line 120), .claude/skills/max-dsp-agent/SKILL.md (~line 110), src/maxpat/builders.py (~549, ~1230 docstrings — comment text only), src/maxpat/critics/package_critic.py (~487 docstring). Check tests that pin those strings first.

## Constraints
- No rule deleted or reworded in meaning; moved text is verbatim.
- Full pytest suite green (pytest-xdist available: `pytest -n auto`) before commit.
- Commit only touched files (never `git add -A`).
