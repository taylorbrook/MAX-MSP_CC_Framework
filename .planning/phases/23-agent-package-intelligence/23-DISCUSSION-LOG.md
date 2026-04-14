# Phase 23: Agent Package Intelligence - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md — this log preserves the alternatives considered.

**Date:** 2026-04-14
**Phase:** 23-agent-package-intelligence
**Areas discussed:** SKILL.md guidance depth, BEAP modular patterns, Relationship entries, Layout overrides

---

## SKILL.md Guidance Depth

| Option | Description | Selected |
|--------|-------------|----------|
| Per-agent specialization | Each agent gets only domain-relevant package knowledge. Less duplication, more focused. | |
| Shared reference doc | One file all agents import. Centralized updates but agents may get unneeded knowledge. | |
| Hybrid | Shared reference doc for common facts, plus per-agent sections for domain-specific patterns. | ✓ |

**User's choice:** Hybrid
**Notes:** None

---

| Option | Description | Selected |
|--------|-------------|----------|
| Bundled only | BEAP, Vizzie, jit.mo, Jitter Geometry, Jitter Tools, ableton-dsp, Mira, maxforlive-elements. Full guidance for BEAP/Vizzie, lighter for rest. | ✓ |
| BEAP + Vizzie only | Deep guidance for two bpatcher packages. Others get brief mention. | |
| All packages with DB entries | Every package in packages/ (20 dirs). Comprehensive but includes incomplete community stubs. | |

**User's choice:** Bundled only
**Notes:** User asked for reasoning on recommendation. Explained: DB readiness (community packages are stubs), Phase 24 is explicitly for community support, bundled packages are what every MAX user has.

---

| Option | Description | Selected |
|--------|-------------|----------|
| .claude/max-objects/PACKAGES.md | Next to the DB files it documents. All agents already reference this directory. | ✓ |
| .claude/skills/shared/packages.md | New shared/ directory under skills. Groups with agent instructions. | |
| CLAUDE.md section | Add to project CLAUDE.md. Auto-read by every agent but CLAUDE.md is already long. | |

**User's choice:** .claude/max-objects/PACKAGES.md
**Notes:** None

---

## BEAP Modular Patterns

| Option | Description | Selected |
|--------|-------------|----------|
| Signal chain templates | 3-5 canonical chains with module lists and connection order. Rely on DB descriptions for conventions. | |
| Rule-based conventions | Document conventions, let agents compose freely. Most flexible. | |
| Both templates + rules | Short rules section plus 3-5 example chains. Rules are compact, templates are actionable. | ✓ |

**User's choice:** Both templates + rules
**Notes:** User asked for deeper reasoning. Analysis showed: BEAP has clear functional roles (Sources, Processors, Modulators, Output, Utility). Templates answer "what do I connect to what" while rules (already partially in DB inlet descriptions) provide the underlying conventions. Including both costs little and maximizes robustness.

---

| Option | Description | Selected |
|--------|-------------|----------|
| Same depth as BEAP | Templates for common video chains plus Jitter matrix conventions. | ✓ |
| Lighter — rules only | Vizzie is simpler, document matrix conventions only. | |
| Minimal — just a mention | Note Vizzie exists and uses Jitter matrices. | |

**User's choice:** Same depth as BEAP
**Notes:** None

---

## Relationship Entries

| Option | Description | Selected |
|--------|-------------|----------|
| Essential pairs only | 15-25 key pairs covering main signal chain connections. | ✓ |
| Category-level pairs | One pair per category combination. ~30-40 entries. | |
| Comprehensive coverage | Map all meaningful connections. 100+ entries. | |

**User's choice:** Essential pairs only
**Notes:** None

---

| Option | Description | Selected |
|--------|-------------|----------|
| Same file | Add to existing relationships.json with "package" field for filtering. | ✓ |
| Per-package files | packages/BEAP/relationships.json, etc. Self-contained but split lookup. | |
| Separate packages section | New packages-relationships.json file. | |

**User's choice:** Same file
**Notes:** None

---

## Layout Overrides

| Option | Description | Selected |
|--------|-------------|----------|
| DB-driven sizing | Look up bpatcher_dimensions from DB for actual size. Data already exists. | ✓ |
| Category-based presets | Size presets per BEAP category. Less precise. | |
| Fixed bpatcher override | Bump default to 250x140. Loses per-object accuracy. | |

**User's choice:** DB-driven sizing
**Notes:** None

---

| Option | Description | Selected |
|--------|-------------|----------|
| Adapt spacing too | Increase vertical spacing proportionally for large bpatcher rows. | ✓ |
| Box size only | Use actual dimensions but keep standard 20px spacing. | |
| You decide | Claude's discretion. | |

**User's choice:** Adapt spacing too
**Notes:** None

---

## Claude's Discretion

- Exact wording and formatting of PACKAGES.md sections
- Which specific modules appear in each template chain
- How SKILL.md sections reference the shared PACKAGES.md
- Specific spacing formula for bpatcher rows
- How calculate_box_size() accesses DB dimensions

## Deferred Ideas

None — discussion stayed within phase scope
