# Phase 22: Validation and Export - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions captured in CONTEXT.md -- this log preserves the alternatives considered.

**Date:** 2026-04-06
**Phase:** 22-validation-and-export
**Areas discussed:** Critic error behavior, AMXD export integration, Device auto-detection, Validation scope

---

## Critic Error Behavior

| Option | Description | Selected |
|--------|-------------|----------|
| Report only (Recommended) | Same as existing critics -- return CriticResult findings with severity levels. Agents and hooks read results and decide. Keeps critic system consistent. | :heavy_check_mark: |
| Block on errors | M4L errors block the file write via hooks.py. Warnings pass through. Stricter but prevents broken devices from being saved. | |
| Tiered: block + warn | Blockers prevent save, warnings report but don't block. Two severity tiers with different enforcement. | |

**User's choice:** Report only
**Notes:** Consistent with existing critic system. No special blocking behavior for M4L.

---

## AMXD Export Integration

| Option | Description | Selected |
|--------|-------------|----------|
| Standalone function | write_amxd() in new m4l_export.py. Called explicitly. Clean separation -- export is a deliberate step. | :heavy_check_mark: |
| Hooks integration | Auto-exports .amxd on every M4L patch save via hooks.py. Seamless but every save produces .amxd. | |
| Both: function + command | Standalone function plus /max-export slash command wrapper. | |

**User's choice:** Standalone function
**Notes:** Export is deliberate, not automatic. Lives in its own module.

---

## Device Auto-Detection

| Option | Description | Selected |
|--------|-------------|----------|
| Simple pattern check (Recommended) | Check for plugin~/plugout~/midiin/midiout presence. Fast, reliable, matches RNBO approach. | |
| Confidence-scored analysis | Score based on multiple signals. Returns device_type + confidence. More accurate but complex. | |
| You decide | Claude picks during implementation. | :heavy_check_mark: |

**User's choice:** You decide
**Notes:** Claude's discretion on detection approach. Must wire into critics/__init__.py for auto-invoke.

---

## Validation Scope

| Option | Description | Selected |
|--------|-------------|----------|
| Required checks only (Recommended) | Just VALID-01/02/03. Keep critic lean. | |
| Add presentation basics | Also check openinpresentation, devicewidth, presentation_rect. | |
| Full device quality | All above plus parameter_enable, ranges, orphaned live.* objects. Comprehensive. | :heavy_check_mark: |

**User's choice:** Full device quality
**Notes:** Comprehensive validation beyond minimum requirements. Catches common M4L setup omissions.

---

## Claude's Discretion

- M4L device auto-detection approach (simple vs confidence-scored)
- Internal m4l_critic.py structure
- Severity assignment for quality checks beyond VALID-01/02/03

## Deferred Ideas

None -- discussion stayed within phase scope
