# mixer

Virtual mixing console for controlling signal flow in MAX.

## Requirements
- Adjustable number of tracks (channel strips)
- Up to 8 sends per track with selectable tap point: pre-fader, post-fader, post-pan
- Adjustable number of busses (aux returns)
- Insert points on each track (pre-fader send/return)
- Standard mixer features: input gain, fader, pan, mute, solo, metering
- Master section with master fader and metering

## Architecture
- **mixer.maxpat** — Top-level container with dynamic track/bus creation
- **mixer-strip.maxpat** — Channel strip bpatcher abstraction (#1 = strip ID)
- **mixer-bus.maxpat** — Bus/return strip bpatcher abstraction (#1 = bus ID)
- **mixer-master.maxpat** — Master section

## Signal Flow (per channel strip)
```
inlet L/R
  → Input Gain
  → Insert Send → [external processing] → Insert Return
  → PRE-FADER TAP (sends can tap here)
  → Fader
  → POST-FADER TAP (sends can tap here)
  → Pan
  → POST-PAN TAP (sends can tap here)
  → Mute
  → outlet L/R + send~ to master
```

## Routing
- Inter-strip routing via send~/receive~ with strip ID naming
- Bus inputs via receive~ collecting from all channel sends
- Master receives summed channel outputs
- Dynamic instantiation via thispatcher scripting

## Decisions
- Stereo throughout (L/R pairs)
- selector~ 3 per send for tap-point switching
- gate~ for mute
- gain~ + meter~ for metering at multiple points
- Stereo faders (strip, bus, master): R channel is a second `gain~` slaved to the visible L `gain~` (L outlet 1 → R inlet 0). The R `gain~` is deliberately excluded from presentation (v0.3.0).
- Dynamic strips/busses are saved with the patch on purpose: mixer-manager.js reuses existing `strip-N`/`bus-N` on load so their patch cords survive. Lowering a count removes the highest-numbered strips (and their cords) (v0.4.0).
- Strip bpatcher args: `N mixer-in-N-L mixer-in-N-R` (#1 label, #2/#3 `receive~` audio inputs, summed with inlets 1-2).
- State recall (v0.5.0): pattrstorage `mixstate` in mixer.maxpat, slot 1 only, file `mixer-state.json` beside the patch. Written on window close (closebang) or the `save` message; read + recalled 50 ms after `load`. autopattr in each abstraction has `@autorestore 0` so the file is the single source of truth. Unnamed controls (send 1/2 internal dials, slaved R gain~) are deliberately not stored. Strip/bus counts come from the saved bpatchers, not the file.
- Sends UI (v0.6.0): all 8 sends on the strip face, one row each (`sendN` dial + `tapN` umenu). `p sends` has one control inlet taking `level N 0-127` / `tap N 0-2`. Old v0.5.0 state for `sends::tapN`/`sends::levelN` no longer recalls (controls moved); `send1`/`send2` names kept.
- Solo (v0.6.0): solo-in-place. Strips `send mixer-solo` -> `solo N 0/1` -> mixer-manager.js -> `messnamed mixer-solo-any`. Busses are solo-safe. Mute/solo gate sits after the fader (v0.7.1): Post/Pan sends are cut, Pre-fader sends stay live (monitor-send convention).
- Levels (v0.7.0): pan law is equal-power (-3 dB each side at centre) on strips and busses -- centre level is +3 dB vs v0.6.0's linear law. Trim is -20..+20 dB (dial 0-128, 64 = 0 dB). Trim/pan/send levels ramp over 20 ms; mute/solo over 5 ms. Fader labels assume gain~ geometry: 4 px inset, 158 steps across the fader height.
- Naming (v0.8.0): internal send~/receive~ names are set at runtime by mixer-manager.js (`applyNames`) to `<ID>-master-L`, `<ID>-bus-N-L`, `<ID>-solo(-any)` where ID is random per load. The names saved in the abstractions (`master-L`, `bus-N-L`, ...) are only fallbacks. Objects are found by varname (`tomasterL`, `fromL`, `sends::busNL`, `solofwd`, `soloany`, `inL`, `outL`, top-level `solorecv`) -- keep those varnames when editing. Port prefix comes from the `name mixer` message box on the top level.
- Master (v0.8.0): M mute (5 ms ramp) after the fader; outlets 1-2 and `send~ <name>-out-L/R` carry the post-mute mix.
