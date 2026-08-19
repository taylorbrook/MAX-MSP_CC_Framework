stage: iterate
progress: v0.9.0 tuning math corrected
created: 2026-08-13T16:23:07.863907+00:00
last_action: v0.9.0: noteFrequency() now anchors scale cents on the tonic of the note's octave (calc12TET(note - relativePitch)) instead of on the note's own 12-TET freq. Reverses the VST 'signature' doubled-interval path per user request. Also synced the 12 ratio textedits to the harm 16-30 engine default (they shipped with a stale Zarlino/JI table).
notes: VERIFY AT LOAD: play C4, SOUNDING PITCHES should read 1/1 C4+0c, 17/16 C#4+5c, 9/8 D4+4c, 19/16 D#4-2c, 5/4 E4-14c (+/- the random detune). Table ratio and (actual) decimal should now agree. Ratio column must read 1/1 17/16 9/8 19/16 5/4 21/16 11/8 23/16 3/2 13/8 7/4 15/8, matching the cents column.
current_stage: v0.9.0 - tuning math correction
status: v0.9.0 built - awaiting load test in MAX
version: 0.9.0
