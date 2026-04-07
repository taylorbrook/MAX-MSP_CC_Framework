# Phase 24: Layout - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md -- this log preserves the alternatives considered.

**Date:** 2026-04-06
**Phase:** 24-layout
**Areas discussed:** Control grouping, Layout patterns, Spacing & sizing, Module structure

---

## Control Grouping

| Option | Description | Selected |
|--------|-------------|----------|
| Reuse Push bank groups | Phase 23's semantic clustering (varname prefix/keyword) already groups params by function. Single source of truth. | ✓ |
| Connection graph proximity | Group controls that connect to the same signal chain. Requires graph analysis. | |
| Explicit annotation | Agents or users tag controls with group names during build. | |

**User's choice:** Reuse Push bank groups
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Yes, live.comment headers | Each group gets a live.comment label above it. Standard M4L convention, costs ~18px height. | ✓ |
| No labels | Controls grouped by spacing only. | |
| Optional per-group | Labels by default, agents can suppress with a flag. | |

**User's choice:** Yes, live.comment headers
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Horizontal groups | Groups flow left-to-right. Each group is a vertical column. Widens device if needed. | ✓ |
| Wrap to rows | Controls wrap horizontally, groups stack vertically. Risks hitting 169px limit fast. | |

**User's choice:** Horizontal groups
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Yes, auto-fit | Start at 300px, expand if controls don't fit. Up to ~900px. | ✓ |
| Fixed 300px | Never change devicewidth. | |
| User-configurable | devicewidth passed as parameter, default 300px. | |

**User's choice:** Yes, auto-fit
**Notes:** None

---

## Layout Patterns

| Option | Description | Selected |
|--------|-------------|----------|
| live.tab + bpatcher swap | live.tab selects visible bpatcher. Standard M4L pattern. | ✓ |
| live.tab + scripting visibility | All controls in one patcher, toggle hidden via scripting. | |
| No tabs | Always single page, just widen device. | |

**User's choice:** live.tab + bpatcher swap
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Auto: >8 controls per group | Switch to tabbed if group has >8 or total exceeds fit. | ✓ |
| Auto: won't fit at 900px | Only tab when can't fit at max width. Tabs as last resort. | |
| Never auto -- explicit only | Agents request tabbed explicitly. | |

**User's choice:** Auto: >8 controls per group
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Readout over control | flonum overlaid on live.dial with ignoreclick=1. | |
| Popup panels | Hidden panels for advanced settings. | |
| Both | Readout overlays + popup panels. | ✓ |

**User's choice:** Both (readout overlays and popup panels)
**Notes:** None

---

## Spacing & Sizing

| Option | Description | Selected |
|--------|-------------|----------|
| Label row + control row | ~18px label, ~4px gap, remaining for controls. Two rows possible for small controls. | ✓ |
| Controls only | Full 169px for controls. No labels in layout math. | |
| Three-zone | 18px label + control + 15px readout below. Tightest fit. | |

**User's choice:** Label row + control row
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Exact sizing.py dims | live.dial always 44x66, etc. No scaling. | ✓ |
| Scalable within bounds | Controls can be resized. Risks visual inconsistency. | |

**User's choice:** Exact sizing.py dims
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Tight: 4-6px gap | Matches Ableton stock devices. Maximizes controls per row. | ✓ |
| Comfortable: 10-15px gap | More breathing room. Fewer controls per row. | |
| Auto-distribute | Evenly distribute across available width. | |

**User's choice:** Tight: 4-6px gap
**Notes:** None

---

## Module Structure

| Option | Description | Selected |
|--------|-------------|----------|
| New m4l_layout.py | Standalone module like m4l_export.py. layout_m4l_presentation(). | ✓ |
| Extend layout.py | Replace _apply_presentation_layout(). Single layout module. | |

**User's choice:** New m4l_layout.py
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| After polish, before export | build -> polish -> layout -> export. Explicit call by agents. | ✓ |
| During polish | m4l_polish.py calls layout internally. | |
| On save (auto) | Wired into hooks.py, auto on save. | |

**User's choice:** After polish, before export
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Yes, skip if set | Preserve manually-set presentation_rect. Only positions unset controls. | ✓ |
| Always recompute | Reposition everything regardless. | |

**User's choice:** Yes, skip if set
**Notes:** None

---

## Claude's Discretion

- Internal packing algorithm for controls within columns
- Exact threshold constants for tab vs single-page
- Popup panel implementation (show/hide scripting, sizing)
- live.tab + bpatcher wiring details
- Group ordering heuristic

## Deferred Ideas

None
