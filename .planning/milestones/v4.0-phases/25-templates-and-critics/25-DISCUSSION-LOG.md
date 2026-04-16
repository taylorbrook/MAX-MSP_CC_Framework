# Phase 25: Templates + Critics - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md — this log preserves the alternatives considered.

**Date:** 2026-04-15
**Phase:** 25-templates-and-critics
**Areas discussed:** Template scope, Critic targets, Template integration, Critic wiring
**Mode:** --auto (all decisions auto-selected)

---

## Template Scope

| Option | Description | Selected |
|--------|-------------|----------|
| All packages | Templates for every bundled + community package | |
| High-value only | FluCoMa, BEAP, Bach — most complex workflows | ✓ |
| Community only | Only community packages that need guidance | |

**User's choice:** [auto] High-value packages only (recommended default)
**Notes:** These three packages have the most complex workflows where agents are most likely to make mistakes without structured guidance.

| Option | Description | Selected |
|--------|-------------|----------|
| Pre-built .maxpat files | Actual patch templates users can open | |
| Agent prompt guidance | Structured descriptions in SKILL.md | ✓ |
| Both | .maxpat files + agent guidance | |

**User's choice:** [auto] Agent prompt guidance (recommended default)
**Notes:** Agents already load SKILL.md context. Adding template sections there integrates naturally without maintaining separate template files.

---

## Critic Targets

| Option | Description | Selected |
|--------|-------------|----------|
| BEAP + Bach | Signal conventions + llll type checking (per PKG-26) | ✓ |
| All packages | Critics for every package | |
| Community only | Focus on unextracted package detection | |

**User's choice:** [auto] BEAP + Bach (recommended default — matches PKG-26)
**Notes:** BEAP and Bach are explicitly called out in requirements. Other packages can be added later.

| Option | Description | Selected |
|--------|-------------|----------|
| All warnings | Convention violations as warnings | |
| Mixed severity | Blockers for type mismatches, warnings for conventions | ✓ |
| All blockers | Strict enforcement | |

**User's choice:** [auto] Mixed severity (recommended default)
**Notes:** llll/list type mismatch always produces silent failures (blocker). BEAP gain range is a convention (warning).

---

## Template Integration

| Option | Description | Selected |
|--------|-------------|----------|
| SKILL.md sections | Templates in agent skill files | ✓ |
| Standalone doc | Separate templates directory | |
| PACKAGES.md only | Add to shared reference | |

**User's choice:** [auto] SKILL.md sections (recommended default)

---

## Critic Wiring

| Option | Description | Selected |
|--------|-------------|----------|
| New package_critic.py | Follows existing critic pattern | ✓ |
| Extend dsp_critic.py | Add to existing DSP checks | |
| Inline in validation.py | Add to validation pipeline | |

**User's choice:** [auto] New package_critic.py (recommended default)
**Notes:** Follows the established pattern of one module per domain critic.

---

## Claude's Discretion

- Exact template chain compositions
- Critic test fixture design
- Specific BEAP convention checks beyond core four
- Bach llll detection mechanism

## Deferred Ideas

None
