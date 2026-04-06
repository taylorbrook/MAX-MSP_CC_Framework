# Phase 20: Foundation - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md -- this log preserves the alternatives considered.

**Date:** 2026-04-05
**Phase:** 20-foundation
**Areas discussed:** Detection heuristics, AMXD constants scope, CLAUDE.md M4L rules, DB entry sourcing

---

## Detection Heuristics

| Option | Description | Selected |
|--------|-------------|----------|
| Instrument (Recommended) | plugin~ + midiin + plugout~ = instrument. audio_effect never has midiin. | |
| Ambiguous -- return both | Return both instrument and audio_effect with confidence scores, let caller decide | |
| Strict pattern matching | Only classify if ALL required objects for a type are present, otherwise return unknown | |
| Other | User chose: if uncertain then ask | ✓ |

**User's choice:** If uncertain, ask the user -- this should be a standard part of the discussion when starting a new patch.
**Notes:** Detection should be part of the new-patch kickoff flow. Definitive classification for clear patterns, prompt user for ambiguous cases.

---

| Option | Description | Selected |
|--------|-------------|----------|
| Both (Recommended) | Works on existing .maxpat during /max-onboard AND new project creation | ✓ |
| New projects only | Only used during /max-new to validate stated device type | |

**User's choice:** Both -- works on existing patches and new projects.

---

| Option | Description | Selected |
|--------|-------------|----------|
| Enum: high/medium/low | Simpler, matches how it'll be used | |
| Numeric 0.0-1.0 | More granular, supports thresholds | ✓ |

**User's choice:** Numeric 0.0-1.0 confidence scoring.

---

## AMXD Constants Scope

| Option | Description | Selected |
|--------|-------------|----------|
| Research it (Recommended) | Researcher investigates .amxd binary format from community docs | ✓ |
| I have references | User provides docs or .amxd files | |
| Skip .amxd for now | Stub constants, defer to Phase 22 | |

**User's choice:** Research it -- let phase researcher investigate.

---

| Option | Description | Selected |
|--------|-------------|----------|
| All known values (Recommended) | Complete enums from Ableton's documentation | ✓ |
| Common subset only | ~10 most used types and styles, extend later | |

**User's choice:** All known values -- comprehensive reference.

---

## CLAUDE.md M4L Rules

| Option | Description | Selected |
|--------|-------------|----------|
| Core device rules (Recommended) | gain~/plugout~ prohibition, --- naming, parameter_enable, device types | |
| Core + Live API patterns | Above plus live.path/live.object, live.banks, parameter metadata | ✓ |
| Minimal -- just constraints | Only hard rules, leave patterns for SKILL.md in Phase 21 | |

**User's choice:** Core + Live API patterns -- comprehensive M4L section.

---

| Option | Description | Selected |
|--------|-------------|----------|
| Include in Phase 20 (Recommended) | Agents need 169px constraint and openinpresentation from the start | ✓ |
| Defer to Phase 24 | Keep Phase 20 focused on audio/MIDI structure | |

**User's choice:** Include presentation mode conventions in Phase 20 rules.

---

## DB Entry Sourcing

| Option | Description | Selected |
|--------|-------------|----------|
| Research + your verification | Researcher finds docs, user verifies in MAX | |
| Research only (Recommended) | Research finds docs, add with verified=false, fix in Phase 25 | ✓ |
| You provide the data | User inspects objects in MAX directly | |

**User's choice:** Research only -- add with verified=false.

---

| Option | Description | Selected |
|--------|-------------|----------|
| Research it (Recommended) | Check community sources for plugin~/plugout~ maxclass ground truth | ✓ |
| Keep DB as-is | Trust current entries, fix later if broken | |

**User's choice:** Research it -- resolve maxclass question via research.

---

## Claude's Discretion

No areas deferred to Claude's discretion.

## Deferred Ideas

None -- discussion stayed within phase scope.
