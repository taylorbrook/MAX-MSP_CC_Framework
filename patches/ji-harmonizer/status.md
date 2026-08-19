stage: iterate
progress: v0.9.0 confirmed working in MAX
created: 2026-08-13T16:23:07.863907+00:00
last_action: v0.9.0: noteFrequency() now anchors scale cents on the tonic of the note's octave (calc12TET(note - relativePitch)) instead of on the note's own 12-TET freq. Reverses the VST 'signature' doubled-interval path per user request. Also synced the 12 ratio textedits to the harm 16-30 engine default (they shipped with a stale Zarlino/JI table).
notes: Confirmed in MAX 2026-08-19: 9/8 sounds D4+4c, table ratio and (actual) decimal agree, ratio column matches the cents column. The VST 'signature' doubled-interval path is gone for good -- see context.md 'Decisions (iterate, 2026-08-19)'.
current_stage: v0.9.0 - tuning math correction
status: v0.9.0 confirmed working in MAX
version: 0.9.0
