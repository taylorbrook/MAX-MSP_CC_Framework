stage: iterate
progress: slice 3 confirmed working in MAX (v0.2.0)
created: 2026-08-13T16:23:07.863907+00:00
last_action: v0.8.0: added 12-row SOUNDING PITCHES table in presentation (x700-968, y106-390). ji-engine.js drives 36 named comment cells (pd_f/pd_i/pd_n <row>) via JSOBJ.patcher.getnamed + message('set',...) -- no outlet, no patch cords.
notes: Display math unit-tested in Node (note names, cents fallback for tempered presets, voiceCount gating, note-off clear, a4 reference, octaveStretch). VERIFY AT LOAD: getnamed-driven comment cells populate on note-on. Fallback if not: route/prepend-set chain from a new js outlet.
current_stage: v0.8.0 — sounding-pitch display (freq / table+actual interval / nearest 12-TET note)
status: v0.8.0 built — SOUNDING PITCHES readout added, awaiting load test in MAX
version: 0.8.0
