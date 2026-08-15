stage: iterate
progress: slice 3 confirmed working in MAX (v0.2.0)
created: 2026-08-13T16:23:07.863907+00:00
last_action: v0.6.0: 3 osc groups in wavetable mc.gen~ codebox; per-instance params via applyvalues (FIRST applyvalues use on mc.gen~ — verify at load; fallback: setvalue per instance). LFO A/B moved into codebox; cycle~ A remains filter phase source.
notes: v0.6.0 built, awaiting load test. Codebox now 24 peeks/instance worst case (CPU ~x3). New UI: spacing (def 0.) / inversion (def 0.3) flonums, in presentation row with chord-feel controls. Save normalized outlettype/numinlets metadata patch-wide to MAX-native values (DB-backed roundtrip overlay) — one-time diff churn, loads identically.
current_stage: v0.6.0 built — chord feel completion (spacing/inversion octave randomization, per-sub-voice LFO phase offsets), awaiting load test
status: v0.7.0 built: temperament presets, awaiting load test
version: 0.7.2
