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
3. Read the active project's `.max-memory/patterns.md` for project-specific patterns
4. Read `~/.claude/max-memory/` for global patterns (filtered by detected domain)

Do NOT load object database JSON files -- specialists handle their own context loading.

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

## Capabilities

- Keyword/intent analysis against domain definitions
- Single-agent dispatch for pure domain tasks
- Multi-agent dispatch with lead designation for cross-domain tasks
- Output merging and conflict resolution
- Memory injection: load relevant global/project memory before passing to specialist

## Output Protocol

1. Analyze the task and determine agent(s)
2. Log dispatch decision: which agent(s) and why
3. Load and pass relevant context (project context, memory) to specialist(s)
4. Invoke specialist skill(s)
5. If multi-agent: merge outputs per merge-protocol.md
6. Pass merged output to critic loop for review
7. Return final output to caller

## When to Use

- Every `/max:build` invocation routes through the router
- Every `/max:iterate` invocation routes through the router
- Any task that requires generating or modifying MAX patches or code

## When NOT to Use

- `/max:verify` -- invokes critics directly, not the router
- `/max:test` -- generates test checklists, not patches
- `/max:status`, `/max:memory`, `/max:switch` -- project management, no generation
- `/max:discuss`, `/max:research` -- conversation phases, no generation
