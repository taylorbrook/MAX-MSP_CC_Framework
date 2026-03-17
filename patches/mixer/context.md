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
