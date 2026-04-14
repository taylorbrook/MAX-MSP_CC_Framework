---
name: max-router
description: Analyzes user task descriptions and dispatches to the correct specialist agent(s) for MAX/MSP generation
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
preconditions:
  - Active project must exist (patches/.active-project.json)
---

# Router Agent

The router is the entry point for all MAX generation tasks. It analyzes the user's description, determines which domain(s) are involved, dispatches to the appropriate specialist agent(s), and merges multi-agent outputs when needed.

## Domain Context Loading

Before dispatching:
1. Read `patches/.active-project.json` to identify the active project
2. Read the active project's `context.md` for project vision
3. Read the active project's `config.json` via `load_project_config()` from `src.maxpat.project`
   - If `config.json` does not exist (returns None): **STOP and tell the user** "Run `/max-new` or `/max-config` to set packages before building." Do NOT dispatch to any agent.
   - If `config.json` exists: extract `packages` list and pass to specialist agents as `allowed_packages`
4. Do NOT load object database JSON files -- specialists handle their own context loading.

## Dispatch Rules

Analyze the user's task description for domain keywords and intent. See `references/dispatch-rules.md` for the full keyword-to-agent mapping.

**Quick reference:**

| Domain | Agent | Trigger Keywords |
|--------|-------|-----------------|
| Patch/Control | max-patch-agent | patch, object, route, trigger, message, subpatcher, send, receive, metro, counter, gate |
| DSP/Gen~ | max-dsp-agent | signal, audio, synth, gen~, oscillator, filter, delay, reverb, feedback, GenExpr, gain, mix |
| RNBO Export | max-rnbo-agent | rnbo, export, vst, au, plugin, web audio, c++ target |
| JavaScript | max-js-agent | javascript, node, n4m, script, node.script, js object, max-api, handler |
| Externals | max-ext-agent | external, sdk, c++, compile, mxo, min-devkit |
| UI/Layout | max-ui-agent | layout, presentation, ui, controls, dial, slider, panel, display, visual |

## Multi-Domain Dispatch

Many tasks span multiple domains. When this happens:

1. Identify the **lead agent** -- the domain that dominates the task
2. Dispatch to all relevant agents
3. Merge outputs using the protocol in `references/merge-protocol.md`

**Common multi-domain patterns:**
- "synth with controls" -> DSP (lead) + UI
- "gen~ waveshaper with knobs" -> DSP (lead) + UI
- "step sequencer with MIDI" -> Patch (lead) + js
- "audio effect with preset system" -> DSP (lead) + Patch + js

## Context Budget

When dispatching to multiple agents, minimize total SKILL.md context loaded.

**Loading tiers:**

| Agents | Strategy |
|--------|----------|
| 1 | Full SKILL.md |
| 2 | Both full |
| 3+ | Lead: full SKILL.md. Secondaries: load ONLY "Domain Context Loading" + "Capabilities" sections |

**Per-agent section map:**

| Section | Classification | Present In |
|---------|---------------|------------|
| Domain Context Loading | domain-specific (always load) | all agents |
| Capabilities (+ subsections) | domain-specific (always load) | all agents |
| Python API References | domain-specific (always load) | rnbo |
| Editing Existing Patches | shared -- skip for secondaries | all agents |
| Output Protocol (New Patches) | shared -- skip for secondaries | all agents |
| Output Protocol (Edited Patches) | shared -- skip for secondaries | all agents |
| When to Use / When NOT to Use | shared -- skip for secondaries | all agents |
| Bpatcher Argument Substitution | shared -- skip for secondaries | patch, dsp |
| Shared Capabilities reference | shared -- skip for secondaries | all agents |

**Example -- "MIDI-controlled FM synth with presets":**
- Lead: DSP (full ~107 lines)
- Secondary: Patch (DCL + Capabilities ~59 lines)
- Secondary: UI (DCL + Capabilities ~62 lines)
- Secondary: js (DCL + Capabilities ~46 lines)
- **Total: ~274 lines** vs ~443 lines loading all fully

**Target:** Keep total loaded SKILL.md context under ~250 lines per generation task.

## Capabilities

- Keyword/intent analysis against domain definitions
- Single-agent dispatch for pure domain tasks
- Multi-agent dispatch with lead designation for cross-domain tasks
- Output merging and conflict resolution
- **/max-iterate analysis context:** When routing edit requests, the router receives the patch analysis summary (from `patcher.analyze()`) alongside the modification request. This analysis informs dispatch decisions by revealing which domains are present in the existing patch (e.g., signal chains -> DSP agent, presentation mode -> UI agent).

## Output Protocol

1. Analyze the task and determine agent(s)
2. Log dispatch decision: which agent(s) and why
3. Load and pass relevant context (project context) to specialist(s)
3b. Pass `allowed_packages` from project config to specialist agent(s) -- they use it when constructing Patcher instances
4. Invoke specialist skill(s)
5. If multi-agent: merge outputs per merge-protocol.md
6. Pass merged output to critic loop for review
7. Return final output to caller

## When to Use

- Every `/max-build` invocation routes through the router
- Every `/max-iterate` invocation routes through the router
- Any task that requires generating or modifying MAX patches or code

## When NOT to Use

- `/max-verify` -- invokes critics directly, not the router
- `/max-test` -- generates test checklists, not patches
- `/max-status`, `/max-switch` -- project management, no generation
- `/max-discuss`, `/max-research` -- conversation phases, no generation
