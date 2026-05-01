---
status: partial
phase: 31-layout-ux-builders
source: [31-VERIFICATION.md]
started: 2026-04-30
updated: 2026-04-30
---

## Current Test

[awaiting human testing]

## Tests

### 1. Overlay readout drag + ignoreclick pass-through (LAYOUT-01)
expected: Load a patch using `p.add_overlay_readout` on a dial in MAX 9. Drag the dial — the flonum overlay shows the dragged value with N decimal places (per `format='%.Nf'`). Mouse clicks pass through to the dial (ignoreclick=1 is honored — dragging the readout area drags the dial, not the readout).
result: [pending]

### 2. M4L gen synth parameter binding + audible DSP (LAYOUT-04)
expected: Generate an `.amxd` from `p.add_m4l_gen_synth(params=[('freq', 0., 1.), ('depth', 0., 1.)])` and load it into Ableton Live 11/12 as a Max for Live device. Each `live.dial` appears in Live's device parameter list and the parameter strip; right-click → "Add Automation" works; gen~ Param `freq`/`depth` updates audibly when the dial moves; no Ableton volume warning, no broken-binding error in Max console.
result: [pending]

### 3. Auto-companion-placement visual layout (LAYOUT-03)
expected: Generate a patch with auto-companion-placement: `cycle~` → `meter~` + monkey-patched status outlet → flonum, run `apply_layout(p)`, save patch, and load in MAX 9. `meter~` sits to the right of `cycle~` at the same y; the status-overlay flonum is visually on top of its source box, click passes through to the source, drag the source and the overlay updates.
result: [pending]

### 4. Labeled param bank pixel alignment (LAYOUT-02)
expected: Generate a labeled param bank with 14 params via `p.add_labeled_param_bank`, save, and load in MAX 9. Multislider bars are vertically aligned with their comment labels at fontsize=10 (each bar/label pair spaced 24px apart); `contdata=1` means values stream during drag; `setstyle=1` shows bar fills. Note: WR-05 deferred cosmetic risk for names ≥9 chars — confirm whether this is acceptable.
result: [pending]

## Summary

total: 4
passed: 0
issues: 0
pending: 4
skipped: 0
blocked: 0

## Gaps
