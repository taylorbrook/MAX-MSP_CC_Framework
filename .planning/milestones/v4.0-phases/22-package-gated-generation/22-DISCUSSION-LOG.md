# Phase 22: Package-Gated Generation - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md — this log preserves the alternatives considered.

**Date:** 2026-04-14
**Phase:** 22-package-gated-generation
**Areas discussed:** Package selection UX, Config storage, Gating behavior, Defaults and mid-project changes

---

## Package Selection UX

### How should /max-new present package choices?

| Option | Description | Selected |
|--------|-------------|----------|
| Bundled vs community split | Two groups: bundled (ship with MAX) and community (require install). User picks from each group. | ✓ |
| Flat checklist | All 20 packages in a single alphabetical list. Simple but noisy. | |
| Domain-grouped | Group by domain: Audio, Video, Analysis, Composition, etc. | |

**User's choice:** Bundled vs community split
**Notes:** None

### Should /max-new offer preset bundles?

| Option | Description | Selected |
|--------|-------------|----------|
| No presets — just the two lists | User always picks individual packages. Clean and explicit. | ✓ |
| A few presets + custom | Quick-start presets like 'Core only', 'All bundled', 'Modular synth'. | |
| You decide | Claude's discretion. | |

**User's choice:** No presets — just the two lists
**Notes:** None

### /max-build prompt when packages not configured

| Option | Description | Selected |
|--------|-------------|----------|
| One-time prompt before generation | Asks once before generating, stores the choice. | |
| Inline warning per object | Flags each package object during generation. | |
| Block until configured | Hard stop until packages are set. | ✓ |

**User's choice:** Block until configured
**Notes:** None

---

## Config Storage

### Where should package selection be stored?

| Option | Description | Selected |
|--------|-------------|----------|
| New config.json in project dir | Structured JSON, clean separation from context.md and status.md. | ✓ |
| Add to context.md | Append structured section to existing freeform file. | |
| Add to status.md | New field alongside stage/progress. | |

**User's choice:** New config.json in project dir
**Notes:** None

### Config format — simple list or with metadata?

| Option | Description | Selected |
|--------|-------------|----------|
| Simple list | {"packages": ["BEAP", "Vizzie"]} — just names. Metadata in package_info.json. | ✓ |
| With install status | {"packages": {"BEAP": {"installed": true}}} — tracks install state. | |
| You decide | Claude's discretion. | |

**User's choice:** Simple list
**Notes:** None

---

## Gating Behavior

### What happens when lookup returns None due to package filter?

| Option | Description | Selected |
|--------|-------------|----------|
| Treat as non-existent | lookup() returns None, Rule #1 applies. No special messaging. | ✓ |
| Return None + log reason | Separate was_filtered() method tells agent WHY. | |
| Raise/warn | Active warning or exception forces explicit handling. | |

**User's choice:** Treat as non-existent
**Notes:** None

### Should validation pipeline also enforce package gating?

| Option | Description | Selected |
|--------|-------------|----------|
| Yes — validator warns | Post-generation check against allowed packages. Defense in depth. | ✓ |
| No — lookup gating sufficient | Trust filtered lookups. Skip redundant check. | |
| You decide | Claude's discretion. | |

**User's choice:** Yes — validator warns
**Notes:** None

---

## Defaults and Mid-Project Changes

### Default when new project created?

| Option | Description | Selected |
|--------|-------------|----------|
| Core only until configured | No packages enabled. /max-new prompts as part of creation. | ✓ |
| All bundled packages enabled | Bundled on by default, community requires opt-in. | |
| Everything enabled | All 20 available by default. | |

**User's choice:** Core only until configured
**Notes:** None

### How to add/remove packages after creation?

| Option | Description | Selected |
|--------|-------------|----------|
| Edit config.json or /max-config command | Hand-edit JSON or interactive command. Same bundled/community split. | ✓ |
| /max-new re-prompts only | Can only set during creation. Recreate to change. | |
| You decide | Claude's discretion. | |

**User's choice:** Edit config.json or /max-config command
**Notes:** None

---

## Claude's Discretion

- Implementation details of `/max-config` command
- Exact wording of `/max-build` block message
- Whether bundled/community classification source

## Deferred Ideas

None
