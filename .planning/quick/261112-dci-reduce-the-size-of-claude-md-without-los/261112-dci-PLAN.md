---
phase: quick-261112-dci
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
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
autonomous: true
requirements: [SLIM-01, SLIM-02, SLIM-03, SLIM-04, SLIM-05, SLIM-06]

estimate:
  tokens: 90000
  raw_tokens: 90000
  tasks: 3
  confidence: low

must_haves:
  truths:
    - "CLAUDE.md drops from 29,891 bytes to about 27,300 (exact number in SUMMARY) and CLAUDE_BUDGET_BYTES is lowered to that size rounded up to the next 500 (expected 27_500)"
    - "Every non-blank body line of the four moved CLAUDE.md sections (Multislider, M4L, bach, RNBO) at the base sha exists verbatim, in order, under its new heading in the approved home, and none of those lines remains in CLAUDE.md (verbatim_check.py exits 0)"
    - "Every BASE_HEADINGS heading is still in CLAUDE.md verbatim; under each of the four moved headings there is exactly one pointer line naming the full path of the new home; add_labeled_param_bank and add_m4l_gen_synth are still in CLAUDE.md"
    - "Outside the four moved section bodies CLAUDE.md is line-for-line identical to the base sha (Gen~ list, Rules #1-#9, MSP and every other section untouched)"
    - "The Domain Context Loading section of max-patch-agent, max-ui-agent and max-dsp-agent has a numbered Read step for .claude/skills/references/shared-capabilities.md naming their moved sections; max-rnbo-agent step 1 points at its own RNBO Export Rules section; a test in tests/test_agent_skills.py pins all four"
    - "No test assertion is deleted: every base RULE_ANCHORS entry is either still in RULE_ANCHORS or listed in MOVED_DETAIL, and the collected test count of tests/test_claude_md.py + tests/test_agent_skills.py does not drop"
    - "The stale-citation grep over .claude src tools tests drops from 14 hits to 0"
    - "Full suite `python3 -m pytest -n auto -q` is green before every commit (baseline at e0ab4dde: 7570 passed, 1 skipped, 4 xfailed)"
  artifacts:
    - path: CLAUDE.md
      provides: "one-line pointers under the Multislider, RNBO, M4L and bach headings"
      contains: "\"Max for Live Device Rules\""
    - path: .claude/skills/references/shared-capabilities.md
      provides: "verbatim Multislider, M4L and bach rule bodies"
      contains: "## Max for Live Device Rules"
    - path: .claude/skills/max-rnbo-agent/SKILL.md
      provides: "verbatim RNBO export rules and a repointed step 1"
      contains: "## RNBO Export Rules"
    - path: tests/test_claude_md.py
      provides: "MOVED_DETAIL keys multislider/m4l/bach/rnbo, DETAIL_HOMES rnbo, lowered ratchet"
      contains: "\"rnbo\": (\".claude/skills/max-rnbo-agent/SKILL.md\""
    - path: tests/test_agent_skills.py
      provides: "load-chain test for the moved sections"
      contains: "def test_moved_claude_rules_loaded_by_specialist"
    - path: .planning/quick/261112-dci-reduce-the-size-of-claude-md-without-los/verbatim_check.py
      provides: "verbatim / no-residue / nothing-else-changed / anchor-union proof against the base sha"
      contains: "base-sha.txt"
  key_links:
    - from: CLAUDE.md
      to: .claude/skills/references/shared-capabilities.md
      via: "pointer lines under the Multislider, M4L and bach headings"
      pattern: "shared-capabilities\\.md` \"(Multislider as Labeled Parameter Bank|Max for Live Device Rules|bach \\(package\\) Rules)\""
    - from: CLAUDE.md
      to: .claude/skills/max-rnbo-agent/SKILL.md
      via: "pointer line under the RNBO heading"
      pattern: "max-rnbo-agent/SKILL\\.md` \"RNBO Export Rules\""
    - from: .claude/skills/max-{patch,ui,dsp}-agent/SKILL.md
      to: .claude/skills/references/shared-capabilities.md
      via: "numbered Read step in Domain Context Loading"
      pattern: "^[0-9]+\\. Read `\\.claude/skills/references/shared-capabilities\\.md`"
    - from: .claude/skills/max-rnbo-agent/SKILL.md step 1
      to: .claude/skills/max-rnbo-agent/SKILL.md "## RNBO Export Rules"
      via: "step 1 names its own section"
      pattern: "^1\\. Read the \"RNBO Export Rules\" section"
---

<objective>
Shrink CLAUDE.md (loaded every session) without losing a rule: move the bodies of four sections verbatim to skill-loaded homes, leave each heading with a one-line pointer, make every specialist that needs a moved rule load it explicitly, and fix every citation that still sends readers to CLAUDE.md for the moved text.

Requirement IDs (quick task):
- SLIM-01: move the Multislider, M4L and bach bodies verbatim into `.claude/skills/references/shared-capabilities.md` and the RNBO body verbatim into `.claude/skills/max-rnbo-agent/SKILL.md` (CONTEXT Moves table). Gen~ stays in CLAUDE.md in full.
- SLIM-02: every heading stays; one imperative pointer line per moved heading naming the full path; builder names `add_labeled_param_bank` and `add_m4l_gen_synth` stay in CLAUDE.md.
- SLIM-03: explicit numbered Read step in each loader's `## Domain Context Loading` (patch, ui, dsp: shared-capabilities.md; rnbo: its own section) plus a test modelled on `test_dsp_agent_loads_genexpr_rules`.
- SLIM-04: test updates only for moved sections, no assertion deleted: anchors that leave CLAUDE.md move from RULE_ANCHORS into MOVED_DETAIL; DETAIL_HOMES gains rnbo; CLAUDE_BUDGET_BYTES ratchets down.
- SLIM-05: stale citations fixed in the CONTEXT-listed files (and one test comment).
- SLIM-06: full suite green; SUMMARY reports before/after CLAUDE.md bytes and a moved-where table.

Purpose: CLAUDE.md is the per-session context cost; these four sections are only needed by specialist agents, which load their own references.
Output: slimmer CLAUDE.md, three new sections in shared-capabilities.md, one in max-rnbo-agent/SKILL.md, loader steps, updated tests, fixed citations, verbatim_check.py and the SUMMARY.

Hard constraints (user, locked in CONTEXT.md): moved text is verbatim, no rewording; do exactly the four moves, nothing else; Gen~ is NOT moved; never delete a test assertion; full suite green before each commit; commit only touched files (never `git add -A` / `git add .`).
</objective>

<execution_context>
@~/.claude/gsd-core/workflows/execute-plan.md
@~/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@.planning/quick/261112-dci-reduce-the-size-of-claude-md-without-los/261112-dci-CONTEXT.md
@CLAUDE.md
@tests/test_claude_md.py

Q below = `.planning/quick/261112-dci-reduce-the-size-of-claude-md-without-los` (write every measurement file there; do not add Q files to task commits, the orchestrator's docs commit takes them).

## Baselines captured at planning (HEAD e0ab4dde)

- CLAUDE.md = 29,891 bytes; `CLAUDE_BUDGET_BYTES = 30_000`.
- Full suite `python3 -m pytest -n auto -q`: 7570 passed, 1 skipped, 4 xfailed in ~30 s. Fast enough to run before every commit.
- Stale-citation gate (command in Task 3 verify) = 14 hits at HEAD; target 0. It deliberately does not match `src/maxpat/builders.py:549` ("CLAUDE.md Rule #4 'Multislider as Labeled Parameter Bank' points here"), which stays true because the heading stays and its pointer names the builder. Leave that line and `src/maxpat/sizing.py:96` alone.
- Moved bodies at HEAD (1-based CLAUDE.md lines, heading excluded): Multislider 99-105 (under line 98), RNBO 192-198 (under 191), M4L 212-221 (under 211), bach 223-226 (under 222).

## Exact pointer lines (use verbatim; planning simulation: final CLAUDE.md = 27,293 bytes)

Each replaces the whole body of its section, so the region between the heading and the next heading becomes: blank line, pointer line, blank line.

```text
P-MULTI (under "#### Multislider as Labeled Parameter Bank"):
Use the builder `Patcher.add_labeled_param_bank(params, x, y)`; manual-bank attributes and reading values by index (`fetch $1`, right outlet): `.claude/skills/references/shared-capabilities.md` "Multislider as Labeled Parameter Bank".

P-RNBO (under "### RNBO (Export-Ready Patches)"):
Experimental. Use only `rnbo_compatible: true` objects; export rules (the `rnbo~` container, self-contained export targets, `param` mapping): `.claude/skills/max-rnbo-agent/SKILL.md` "RNBO Export Rules".

P-M4L (under "### Max for Live (M4L / .amxd)"):
Experimental. Build devices with `Patcher.add_m4l_device(kind, params)` or `Patcher.add_m4l_gen_synth(params)`, then `export_amxd(maxpat_path)`; read the device rules (`plugout~` output path, `param_connect` binding, Live automation) first: `.claude/skills/references/shared-capabilities.md` "Max for Live Device Rules".

P-BACH (under "### bach (package)"):
Before using any bach object, read `.claude/skills/references/shared-capabilities.md` "bach (package) Rules" (missing `bach.llll2list` / `bach.list2llll`, `bach.nth` extraction, `@out t` toward plain MAX objects).
```

## Destination placement

| Key | Body moves to | New heading | Exact position |
|---|---|---|---|
| multislider | `.claude/skills/references/shared-capabilities.md` | `#### Multislider as Labeled Parameter Bank` | Inside the `### \`Patcher.add_labeled_param_bank(...)\`` entry, after its "**When to call:**" paragraph, before `### \`Patcher.add_m4l_gen_synth(...)\`` |
| m4l | `.claude/skills/references/shared-capabilities.md` | `## Max for Live Device Rules` | New h2 right after the Builder API section (after the "### Quick reference" table), before `## bach (package) Rules` / `## Editing Functions` |
| bach | `.claude/skills/references/shared-capabilities.md` | `## bach (package) Rules` | New h2 immediately before `## Editing Functions` (after the M4L section once Task 2 adds it) |
| rnbo | `.claude/skills/max-rnbo-agent/SKILL.md` | `## RNBO Export Rules` | New h2 right after the `## Domain Context Loading` section, before `## Python API References` |

Copy the body lines exactly as they are at HEAD, including the `**Experimental:**` lines, the `> Codified ...` blockquotes and blank-line spacing. The M4L blockquote ending "The rules below still apply." stays true in the new home.

Do not touch the `## Builder API` stub in max-patch-agent or max-ui-agent SKILL.md (test_builder_api_sections_byte_identical requires them byte-identical), and leave the shared-capabilities "### Quick reference" table's "Replaces (CLAUDE.md)" column alone (those headings still exist in CLAUDE.md).

## Anchor bookkeeping for tests/test_claude_md.py (from the planning simulation with the exact pointer lines)

Anchors that leave CLAUDE.md (remove from RULE_ANCHORS, add to MOVED_DETAIL), 16 total:
- multislider: "Reading values by index", "fetchindex", "outlet 1", "orientation: 0", "size * 24", "contdata: 1", "setstyle: 1", "named subpatchers"
- m4l: "parameter_enable: 1", "saved_attribute_attributes.valueof", "not Live-automatable", "signal-rate exception"
- bach: "@unwrap 1"
- rnbo: "VST3/AU", "RNBO-specific definitions", "`param` objects in RNBO"

Anchors that stay in RULE_ANCHORS because the pointer lines keep them: add_labeled_param_bank, fetch $1, rnbo_compatible: true, rnbo~, self-contained, plugout~, param_connect, add_m4l_gen_synth, bach.llll2list, bach.nth, @out t. Also list them in the matching MOVED_DETAIL key so the destination is pinned too.

New MOVED_DETAIL entries (each pins the heading plus one long verbatim fragment):
- "multislider": shared-capabilities.md — "#### Multislider as Labeled Parameter Bank", the 8 multislider anchors above, "fetch $1", "add_labeled_param_bank", "Don't insert `split` between multislider and the consumer"
- "m4l": shared-capabilities.md — "## Max for Live Device Rules", the 4 m4l anchors above, "plugout~", "param_connect", "add_m4l_gen_synth", "`gain~` defaults to 0, silence on load", "refuses a `live.thisdevice`-only helper abstraction without `kind=`"
- "bach": shared-capabilities.md — "## bach (package) Rules", "bach.llll2list", "bach.nth", "@unwrap 1", "@out t", "Flat sublists then arrive as regular lists (`unpack f f` works)"
- "rnbo": `.claude/skills/max-rnbo-agent/SKILL.md` — "## RNBO Export Rules", "rnbo_compatible: true", "self-contained", "VST3/AU", "RNBO-specific definitions", "`param` objects in RNBO", "no external file dependencies for export targets (VST3/AU plugin, Web Audio, C++)"

DETAIL_HOMES gains `"rnbo": ".claude/skills/max-rnbo-agent/SKILL.md"` (P-RNBO names it). `"shared"` is already there.

## Loader step text (final form after Task 2)

Insert as a new numbered step and renumber the following steps (+1). No step may mention `load_project_config()` (test_missing_config_is_core_only). The dsp step must contain no `name~` token other than Gen~ (test_dsp_templates_use_db_objects scans that file).

- max-patch-agent, new step 2: `2. Read \`.claude/skills/references/shared-capabilities.md\` for the rules moved out of CLAUDE.md: "Multislider as Labeled Parameter Bank" (manual multislider banks, reading values by index), "Max for Live Device Rules" (any M4L / \`.amxd\` device), "bach (package) Rules" (any bach object)`
- max-ui-agent, new step 2: `2. Read \`.claude/skills/references/shared-capabilities.md\` "Multislider as Labeled Parameter Bank" before building a multislider bank by hand or reading its values by index (moved out of CLAUDE.md)`
- max-dsp-agent, new step 3 (after the genexpr-rules step): `3. Read \`.claude/skills/references/shared-capabilities.md\` "Max for Live Device Rules" before any M4L / \`.amxd\` device work and "bach (package) Rules" before using any bach object (both moved out of CLAUDE.md)`
- max-rnbo-agent, step 1 replaced: `1. Read the "RNBO Export Rules" section below (this file) for export rules and constraints`

Task 1 (bach tracer) writes the patch and dsp steps naming only "bach (package) Rules"; Task 2 extends them to the final text above.

## Stale citations: old -> new (Task 2 owns C1-C5, Task 3 owns C6-C14)

| # | File:line at HEAD | Old text | New text |
|---|---|---|---|
| C1 | .claude/skills/max-rnbo-agent/SKILL.md:38 | step 1 citing the CLAUDE.md RNBO section | the rnbo step 1 above |
| C2 | .claude/skills/references/shared-capabilities.md:155-156 | `Codifies` / `CLAUDE.md §"Multislider as Labeled Parameter Bank" — bakes in` | `Codifies` / `the "Multislider as Labeled Parameter Bank" rules below — bakes in` |
| C3 | .claude/skills/references/shared-capabilities.md:168 | `— see CLAUDE.md Rule #4, "Reading values by index".` | `— see "Reading values by index" below.` |
| C4 | .claude/skills/references/shared-capabilities.md:181-182 | `between —` / `CLAUDE.md M4L rule).` | `between —` / `"Max for Live Device Rules" below).` |
| C5 | .claude/skills/max-dsp-agent/SKILL.md:110 | `device rules: CLAUDE.md "Max for Live (M4L / .amxd)".` | `device rules: "Max for Live Device Rules" in the same file.` |
| C6 | .claude/skills/references/troubleshooting.md:15 | Source cell `CLAUDE.md "bach (package)"` | `shared-capabilities.md "bach (package) Rules"` |
| C7 | .claude/skills/references/troubleshooting.md:31 | same Source cell | same new text |
| C8 | .claude/skills/references/troubleshooting.md:8 | `The Source column names a CLAUDE.md section,` | `The Source column names a CLAUDE.md or shared-capabilities.md section,` |
| C9 | .claude/skills/references/max-9.2-changes.md:146 | `CLAUDE.md M4L \`param_connect\` rule` | `shared-capabilities.md "Max for Live Device Rules" \`param_connect\` rule` |
| C10 | .claude/skills/references/max-9.2-changes.md:154 | `CLAUDE.md M4L "no \`live.gain~\` before \`plugout~\`"` | `shared-capabilities.md "Max for Live Device Rules" (no \`live.gain~\` before \`plugout~\`)` |
| C11 | .claude/skills/max-router/references/dispatch-rules.md:120 | `**Pass to specialists:** CLAUDE.md "Max for Live (M4L / .amxd)" (` | `**Pass to specialists:** "Max for Live Device Rules" in \`.claude/skills/references/shared-capabilities.md\` (` (rest of line unchanged) |
| C12 | src/maxpat/builders.py:556 | `per D-09 and CLAUDE.md Rule #4` | `per D-09 and shared-capabilities.md` (next line `"Reading values by index" (``fetch`` not ``fetchindex``;` unchanged) |
| C13 | src/maxpat/builders.py:1230 | `(CLAUDE.md M4L rule -- Ableton's` | `(shared-capabilities.md "Max for Live Device Rules" -- Ableton's`, rewrapping only that docstring paragraph |
| C14 | src/maxpat/critics/package_critic.py:487 | `(CLAUDE.md bach section)` | `(shared-capabilities.md "bach (package) Rules")`, rewrapping only that docstring paragraph |
| C15 | tests/test_m4l_gen_synth.py:201 | comment `# CLAUDE.md M4L rule: NO gain~/...` | `# M4L device rule (shared-capabilities.md "Max for Live Device Rules"):` then `# NO gain~/live.gain~/ezdac~ in the output path.` (comment only) |

The builders.py add_labeled_param_bank docstring must keep "fetchindex", "outlet 1" and "contdata" (test_builder_docstrings_carry_recipes).

## verbatim_check.py spec (written in Task 1, run by every task)

Path `Q/verbatim_check.py`, run from the repo root: `python3 Q/verbatim_check.py <key> [<key> ...]` with keys from {multislider, m4l, bach, rnbo}. Stdlib only.
- Reads the base sha from `Q/base-sha.txt` (same directory as the script); base files via `git show <sha>:CLAUDE.md` and `git show <sha>:tests/test_claude_md.py`.
- SECTIONS: multislider = ("#### Multislider as Labeled Parameter Bank", shared-capabilities.md, "#### Multislider as Labeled Parameter Bank"); m4l = ("### Max for Live (M4L / .amxd)", shared-capabilities.md, "## Max for Live Device Rules"); bach = ("### bach (package)", shared-capabilities.md, "## bach (package) Rules"); rnbo = ("### RNBO (Export-Ready Patches)", .claude/skills/max-rnbo-agent/SKILL.md, "## RNBO Export Rules").
- CLAUDE.md region of a heading = lines after the exact heading line up to (excluding) the next line starting with "#". Destination region = lines after the destination heading up to the next line starting with "#" whose level (count of leading "#") is <= the destination heading's level.
- Check A verbatim: every non-blank base body line is an exact full line in the destination region, in the same order.
- Check B pointer: the current CLAUDE.md region has exactly one non-blank line; it contains the destination path wrapped in backticks and the destination heading title (without the "#"s) in double quotes.
- Check C nothing else changed: base CLAUDE.md lines with every selected region removed equal current CLAUDE.md lines with every selected region removed.
- Check D no residue: no non-blank base body line of a selected section appears as a line anywhere in current CLAUDE.md.
- Check E anchors kept: parse RULE_ANCHORS and MOVED_DETAIL with `ast` (literal_eval of the assignment values) from base and current tests/test_claude_md.py; every base RULE_ANCHORS entry is in current RULE_ANCHORS or in some current MOVED_DETAIL anchor list; every base MOVED_DETAIL (key, anchor) pair is still present.
- Prints `OK <keys>` and exits 0, or prints every failure and exits 1.

## File-count note

Tasks touch more than 5 files each because every edit is a 1-10 line text move or citation fix; the quick-task cap of 3 tasks rules out a finer split.
</context>

<tasks>

<task type="tracer" tdd="true">
  <name>Task 1: Tracer — move the bach section end-to-end (CLAUDE.md -> shared-capabilities.md -> patch/dsp loaders -> tests)</name>
  <files>CLAUDE.md, .claude/skills/references/shared-capabilities.md, .claude/skills/max-patch-agent/SKILL.md, .claude/skills/max-dsp-agent/SKILL.md, tests/test_claude_md.py, tests/test_agent_skills.py, .planning/quick/261112-dci-reduce-the-size-of-claude-md-without-los/verbatim_check.py</files>
  <read_first>CLAUDE.md lines 205-230; .claude/skills/references/shared-capabilities.md lines 230-250; tests/test_claude_md.py (RULE_ANCHORS, MOVED_DETAIL, DETAIL_HOMES); tests/test_agent_skills.py lines 880-960 (_h2_section, test_dsp_agent_loads_genexpr_rules); the Domain Context Loading sections of .claude/skills/max-patch-agent/SKILL.md and .claude/skills/max-dsp-agent/SKILL.md</read_first>
  <behavior>
    - tests/test_claude_md.py: MOVED_DETAIL["bach"] anchors (context "Anchor bookkeeping") all found in shared-capabilities.md; "@unwrap 1" no longer in RULE_ANCHORS; every other existing assertion unchanged.
    - tests/test_agent_skills.py: new `test_moved_claude_rules_loaded_by_specialist` parametrized over a module-level `_MOVED_RULE_LOADERS` dict (agent -> (home marker, section titles)). For each agent it takes `_h2_section(skill, "## Domain Context Loading")`, finds the numbered line (regex `^\d+\. Read `) that contains the home marker ("shared-capabilities.md" for shared homes, "RNBO Export Rules" for rnbo) and asserts every section title for that agent appears in that same line; for rnbo it also asserts that line does not contain the substring "RNBO section". In Task 1 the dict holds max-patch-agent and max-dsp-agent with ("bach (package) Rules",).
    - tests/test_agent_skills.py: new `test_moved_claude_rule_homes_have_headings` asserting the destination heading lines exist as full lines; in Task 1 only "## bach (package) Rules" in shared-capabilities.md.
    - Both new tests and MOVED_DETAIL bach fail before the move and pass after it.
  </behavior>
  <action>
    Setup: write `git rev-parse HEAD` to Q/base-sha.txt, `wc -c < CLAUDE.md` to Q/size-before.txt, and the last line of `python3 -m pytest tests/test_claude_md.py tests/test_agent_skills.py --collect-only -q -n 0` to Q/collect-before.txt.

    Write Q/verbatim_check.py exactly per the context spec "verbatim_check.py spec" (checks A-E, stdlib only, keys as args).

    RED: in tests/test_claude_md.py add the MOVED_DETAIL "bach" entry and remove "@unwrap 1" from RULE_ANCHORS (only that one: the other bach anchors stay because P-BACH keeps them). In tests/test_agent_skills.py add `_MOVED_RULE_LOADERS` and the two new tests from the behavior block, placed directly after test_dsp_agent_loads_genexpr_rules, reusing the existing `_h2_section` and `_read_skill` helpers and SHARED_CAPABILITIES. Do not put any of the stale-citation gate's literal strings (context "Stale citations" Old text column) into a test, comment or docstring; the rnbo negative check uses only the substring "RNBO section". Run the two test files and confirm the new cases fail.

    GREEN (per CONTEXT Moves row "bach"): insert `## bach (package) Rules` in shared-capabilities.md immediately before `## Editing Functions`, with the two bach bullets copied verbatim from CLAUDE.md lines 224-225 and the same blank-line spacing. Replace the CLAUDE.md bach body (lines 223-226) with blank line, P-BACH, blank line, keeping the `### bach (package)` heading verbatim. In max-patch-agent SKILL.md insert new step 2 and in max-dsp-agent SKILL.md insert new step 3, each a numbered Read line for `.claude/skills/references/shared-capabilities.md` naming "bach (package) Rules" only (Task 2 extends them to the final text in context "Loader step text"); renumber the following steps. Gen~ and every other CLAUDE.md section stay untouched.

    Run the verify block. When green, commit only the six repo files (explicit paths), message `docs(261112-dci): move bach rules out of CLAUDE.md (tracer)`.
  </action>
  <verify>
    <automated>python3 -m pytest tests/test_claude_md.py tests/test_agent_skills.py tests/test_doc_signatures.py -q && python3 .planning/quick/261112-dci-reduce-the-size-of-claude-md-without-los/verbatim_check.py bach && python3 -m pytest -n auto -q</automated>
  </verify>
  <done>bach body lives verbatim under `## bach (package) Rules` in shared-capabilities.md; CLAUDE.md keeps the heading plus P-BACH only; patch and dsp loaders name it in a numbered Read step; verbatim_check.py bach prints OK; full suite green; one commit with the six repo files.</done>
</task>

<task type="auto" tdd="true">
  <name>Task 2: Expand — move Multislider, M4L and RNBO bodies; finish the loader chain; fix citations in touched files</name>
  <files>CLAUDE.md, .claude/skills/references/shared-capabilities.md, .claude/skills/max-rnbo-agent/SKILL.md, .claude/skills/max-patch-agent/SKILL.md, .claude/skills/max-ui-agent/SKILL.md, .claude/skills/max-dsp-agent/SKILL.md, tests/test_claude_md.py, tests/test_agent_skills.py</files>
  <read_first>CLAUDE.md lines 96-106 and 189-222; .claude/skills/references/shared-capabilities.md lines 150-200; .claude/skills/max-rnbo-agent/SKILL.md lines 33-45; Domain Context Loading of .claude/skills/max-ui-agent/SKILL.md; .claude/skills/max-dsp-agent/SKILL.md line 110</read_first>
  <behavior>
    - MOVED_DETAIL gains "multislider", "m4l", "rnbo" (context "Anchor bookkeeping"); the 15 remaining leaving anchors are removed from RULE_ANCHORS; DETAIL_HOMES gains "rnbo".
    - `_MOVED_RULE_LOADERS` final: max-patch-agent -> shared, ("Multislider as Labeled Parameter Bank", "Max for Live Device Rules", "bach (package) Rules"); max-ui-agent -> shared, ("Multislider as Labeled Parameter Bank",); max-dsp-agent -> shared, ("Max for Live Device Rules", "bach (package) Rules"); max-rnbo-agent -> "RNBO Export Rules", ("RNBO Export Rules",).
    - `test_moved_claude_rule_homes_have_headings` final: shared-capabilities.md has "#### Multislider as Labeled Parameter Bank", "## Max for Live Device Rules", "## bach (package) Rules"; max-rnbo-agent SKILL.md has "## RNBO Export Rules".
  </behavior>
  <action>
    RED: extend tests/test_claude_md.py and tests/test_agent_skills.py per the behavior block (move the 15 anchors from RULE_ANCHORS into the new MOVED_DETAIL keys, never dropping one; add DETAIL_HOMES "rnbo"). Confirm the new cases fail.

    GREEN, per CONTEXT Moves table and context "Destination placement":
    - Multislider: insert `#### Multislider as Labeled Parameter Bank` with the three paragraphs from CLAUDE.md lines 100-104 verbatim into the add_labeled_param_bank entry of shared-capabilities.md; replace the CLAUDE.md body (99-105) with blank, P-MULTI, blank.
    - M4L: insert `## Max for Live Device Rules` with CLAUDE.md lines 213-220 verbatim (Experimental line, Codified blockquote, 4 bullets) right after the Builder API section and before `## bach (package) Rules`; replace the CLAUDE.md body with blank, P-M4L, blank.
    - RNBO: insert `## RNBO Export Rules` with CLAUDE.md lines 193-197 verbatim right after `## Domain Context Loading` in max-rnbo-agent SKILL.md; replace the CLAUDE.md body with blank, P-RNBO, blank.
    - Loaders: set the patch and dsp steps to their final text, add the ui step 2 (renumber), and replace rnbo step 1, all per context "Loader step text".
    - Citations in files this task owns: apply C1-C5 from the context table.
    Every heading stays verbatim; Gen~ and all other CLAUDE.md sections stay untouched; Builder API stubs in the patch/ui SKILL.md stay byte-identical.

    Run the verify block. When green, commit only the eight repo files (explicit paths), message `docs(261112-dci): move multislider, M4L and RNBO rules out of CLAUDE.md`.
  </action>
  <verify>
    <automated>python3 -m pytest tests/test_claude_md.py tests/test_agent_skills.py tests/test_doc_signatures.py -q && python3 .planning/quick/261112-dci-reduce-the-size-of-claude-md-without-los/verbatim_check.py bach multislider m4l rnbo && python3 -m pytest -n auto -q</automated>
  </verify>
  <done>All four bodies live verbatim in their approved homes; CLAUDE.md has the four pointer lines and every heading; all four loaders name their moved sections in a numbered Read step; C1-C5 fixed; verbatim_check.py prints OK for all four keys; full suite green; one commit with the eight repo files.</done>
</task>

<task type="auto">
  <name>Task 3: Fix remaining stale citations, lower the ratchet, prove the suite green, record sizes</name>
  <files>.claude/skills/references/troubleshooting.md, .claude/skills/references/max-9.2-changes.md, .claude/skills/max-router/references/dispatch-rules.md, src/maxpat/builders.py, src/maxpat/critics/package_critic.py, tests/test_m4l_gen_synth.py, tests/test_claude_md.py</files>
  <read_first>The exact lines named in context rows C6-C15 (read only those line ranges); tests/test_claude_md.py CLAUDE_BUDGET_BYTES block</read_first>
  <action>
    Apply C6-C15 from the context table (comment, docstring and doc-table text only; no code, no assertion changes; rewrap only the two docstring paragraphs C13/C14 touch). Keep "fetchindex", "outlet 1" and "contdata" in the add_labeled_param_bank docstring. Leave the dispatch-rules M4L overlay's other lines and fragments as they are (test_m4l_overlay_experimental_and_critic_trigger).

    Ratchet: measure `wc -c < CLAUDE.md` into Q/size-after.txt, set CLAUDE_BUDGET_BYTES to that size rounded up to the next multiple of 500 (expected 27_500), and extend the ratchet comment with one line naming 261112-dci and the before/after bytes.

    Proof: run the stale-citation gate (expect 0, baseline 14), verbatim_check.py for all four keys, the collect count of tests/test_claude_md.py + tests/test_agent_skills.py into Q/collect-after.txt (must be >= Q/collect-before.txt), and the full suite with output saved to Q/full-suite.txt.

    When green, commit only the seven repo files (explicit paths), message `docs(261112-dci): repoint citations to moved rules, lower CLAUDE.md ratchet`.
  </action>
  <verify>
    <automated>test "$(grep -rnE 'CLAUDE\.md (M4L|bach section)|CLAUDE\.md` RNBO section|CLAUDE\.md §"Multislider|CLAUDE\.md "(Max for Live|bach)|D-09 and CLAUDE\.md|CLAUDE\.md Rule #4, "Reading' .claude src tools tests | wc -l | tr -d ' ')" = 0 && python3 .planning/quick/261112-dci-reduce-the-size-of-claude-md-without-los/verbatim_check.py bach multislider m4l rnbo && python3 -m pytest tests/test_claude_md.py tests/test_agent_skills.py tests/test_diagnose.py tests/test_m4l_gen_synth.py -q && { python3 -m pytest -n auto -q > .planning/quick/261112-dci-reduce-the-size-of-claude-md-without-los/full-suite.txt 2>&1; rc=$?; tail -1 .planning/quick/261112-dci-reduce-the-size-of-claude-md-without-los/full-suite.txt; test $rc = 0; }</automated>
  </verify>
  <done>Stale-citation gate 0 hits; CLAUDE_BUDGET_BYTES equals the new size rounded up to 500 and test_claude_md_size_budget passes; collected test count not lower than before; full suite green with output in Q/full-suite.txt; one commit with the seven repo files.</done>
</task>

</tasks>

<threat_model>
## Trust Boundaries

| Boundary | Description |
|----------|-------------|
| CLAUDE.md -> every session | rules loaded unconditionally; a rule lost here silently changes generated patches |
| skill references -> specialist agents | moved rules reach agents only if the agent's Domain Context Loading reads them |
| shipped docs -> release archive | CLAUDE.md, .claude/skills/** ship; they must not carry private paths |

## STRIDE Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation Plan |
|-----------|----------|-----------|----------|-------------|-----------------|
| T-261112-dci-01 | Tampering | CLAUDE.md rule text (lost or reworded during the move) | high | mitigate | verbatim_check.py checks A-D against the base sha (line-exact copy, no residue, nothing else changed) plus MOVED_DETAIL anchors; check E proves no RULE_ANCHORS entry vanished |
| T-261112-dci-02 | Repudiation | test suite weakened while editing anchors | medium | mitigate | check E (anchor union against base tests/test_claude_md.py) and collect-count gate (after >= before) in Task 3 |
| T-261112-dci-03 | Denial of service | specialist agent never loads a moved rule (M4L/bach/multislider/RNBO guidance silently gone) | high | mitigate | numbered Read steps in four Domain Context Loading sections pinned by test_moved_claude_rules_loaded_by_specialist and test_moved_claude_rule_homes_have_headings |
| T-261112-dci-04 | Information disclosure | private paths copied into shipped docs | low | mitigate | moved text is copied from CLAUDE.md, which test_claude_md_no_private_paths already keeps free of .planning/ and /Users/ paths; no Q path is written into any shipped file |
| T-261112-dci-SC | Tampering | npm/pip/cargo installs | high | accept | No package is installed by this plan (stdlib + existing pytest/pytest-xdist only); the legitimacy gate is not triggered |
</threat_model>

<verification>
- `python3 .planning/quick/261112-dci-reduce-the-size-of-claude-md-without-los/verbatim_check.py bach multislider m4l rnbo` prints OK.
- Stale-citation gate: 0 hits (baseline 14).
- `wc -c < CLAUDE.md` < 29,891 and <= CLAUDE_BUDGET_BYTES (expected 27,293 / 27_500).
- `python3 -m pytest -n auto -q` green before each of the three commits; final output in Q/full-suite.txt.
- `git show --stat` of each task commit lists only that task's repo files; no untracked .planning/ trees were added.
</verification>

<success_criteria>
- CLAUDE.md about 2.6 KB smaller, every heading and every rule still present (in CLAUDE.md or verbatim in its approved home), Gen~ untouched.
- Patch, ui, dsp and rnbo agents load the moved rules through an explicit numbered step, pinned by tests.
- No stale "CLAUDE.md M4L / bach / Multislider / RNBO section" citation remains in .claude, src, tools or tests.
- Full suite green; no assertion deleted; collected test count not lower.
</success_criteria>

<output>
Create `.planning/quick/261112-dci-reduce-the-size-of-claude-md-without-los/261112-dci-SUMMARY.md` when done. It must contain:
- CLAUDE.md bytes before (Q/size-before.txt) and after (Q/size-after.txt), the delta, and the new CLAUDE_BUDGET_BYTES.
- A moved-where table: CLAUDE.md section | new home (full path) | new heading | loaders that read it | pointer line kept in CLAUDE.md.
- The anchors moved from RULE_ANCHORS to MOVED_DETAIL (per key) and the collect count before/after.
- The stale-citation gate before/after (14 -> 0) with the files touched, and the final full-suite line from Q/full-suite.txt.
- The three commit hashes.
</output>
