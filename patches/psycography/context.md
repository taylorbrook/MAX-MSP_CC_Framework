# psycography

A performance + rehearsal patch for a fully-notated, multi-section piece. Drives a
generated click track and tightly-synchronized multichannel soundfile playback from a
single tempo map, and can start from any measure with everything correctly placed.

Stage: ideation → research

---

## 1. Kickoff brief (user)

- Performance patch for a fully-notated piece of music.
- Needs a **click track** and **multichannel playback** of soundfiles, **tightly synchronized**.
- Piece has **several sections**; some need the click, some do not. Sections are launched by **cues**.
- **Rehearsal requirement (critical):** the ensemble must be able to **start at any measure** and have
  both the click and the audio files land in the correct place.
- A **tempo map** is required (user will provide one for testing).
- Audio playback = **mono WAV files**, each routed to a **discrete audio channel** (~**9 channels**).
- **10 mic inputs** will be analyzed and may have processing applied.
- Large/complex → **build modularly**.

---

## 2. Locked architectural decisions (kickoff Q&A)

### Synchronization model — pre-rendered, seek & play
- The 9 mono WAVs are **bounced at final performance tempo** (all tempo changes baked into the audio).
- Playback = **seek to a sample offset + linear play**, sample-locked to a **master clock**.
- The **click is GENERATED from the tempo map**, not recorded.
- ⇒ No time-stretching needed. The tempo map exists to (a) generate the click and
  (b) map measure number → absolute time/sample for seeking both click and audio.

### Playback engine — RAM buffers + play~
- Each WAV loads into a `buffer~`; playback driven by a **shared signal-rate position ramp** into `play~`.
- Gives **sample-accurate seek**, instant jump to any measure, and perfect phase-lock across all files.
- Cost: RAM (~10 MB / min / mono 48k file). Verify total duration during research.

### Mic subsystem — scaffold + metering now
- Build the **10-channel input routing**, **per-channel metering**, and a **modular processing-insert
  slot per mic**, but leave actual analysis/DSP as **stubs** to fill in later.
- Keeps v1 focused on the timing core.

### Control surface — cue list + measure entry + GO
- On-screen **cue list** for sections, a **measure-number field** to jump anywhere, and a **GO/Stop** transport.

### Tempo map source — MIDI tempo track
- User provides a **MIDI file** whose tempo/meta track encodes the map.
- **Tempo changes are both sudden AND gradual** — the system must **follow the MIDI tempo track precisely**
  (ramps = dense series of Set-Tempo events; must integrate tick→time exactly).
- Implication: parse Set-Tempo (FF 51 03) + Time-Signature (FF 58) meta events + PPQ division;
  integrate to a precise **tick → seconds** map; derive **measure → tick** from meter events.

### Click design (all selected)
- **Downbeat accent** (needs meter from tempo map) + plain click on other beats.
- **Count-in** (e.g. one bar) before audio when launching from a measure.
- **Subdivisions** (eighths/triplets) toggleable per section.
- **Synth click sound** (cycle~/click~ burst), not a sample.

### Click routing — dedicated extra channel
- Click goes to its **own output** (e.g. ch 10) → conductor/performer monitor or headphone mix,
  separate from the 9 program channels.
- ⇒ Hardware target: **10 outputs** (9 program + 1 click) and **10 mic inputs**.

---

## 3. Core technical concept — master sample clock

Everything is a function of a single **absolute master clock** (samples/seconds since the piece's zero):

1. **Preprocess the MIDI tempo track → a precise timeline:**
   - cumulative **tick → seconds** (integrate piecewise-constant tempo segments; ramps are fine-grained),
   - **measure/beat → tick → seconds → sample** lookup,
   - a precomputed **click-event list** (time, accent | beat | subdivision) so clicks fire sample-accurately
     even through tempo ramps (do NOT drive a live metro off a changing tempo).
2. **Master transport** broadcasts the current absolute sample position (e.g. via `send~`).
3. **Consumers read off the master clock:**
   - playback `play~` reads each buffer at `(master − file_start_offset)`,
   - click scheduler fires the next precomputed event when the master crosses its time.
4. **Start at measure N** = set master clock to `seconds(N) × SR`; every consumer follows automatically.

---

## 4. Proposed modular breakdown (to refine in research)

| Module | Responsibility |
|--------|----------------|
| `timeline` (node.script/js) | Parse MIDI tempo+meter track → measure↔sample map + click-event list (coll/dict) |
| `transport` | Master sample clock; GO/STOP; seek-to-sample; seek-to-measure; broadcast position |
| `cues` | Section/cue list; per-cue click on/off, subdivision, active files; advance + measure-jump |
| `click` | Read click-event list + master pos → accented/plain/subdivision synth click; count-in; dedicated out |
| `playback` | 9× `buffer~`+`play~` driven by master pos → discrete channels (per-file bpatcher, `#1` args) |
| `mics` | 10-ch `adc~`/`mc` input; per-channel meter; modular processing-insert slot (stub) (per-mic bpatcher) |
| `io` | `dac~` 10 out (9 program + click) / `adc~` 10 in; mc-based routing |
| `main` UI | Cue list, measure field, GO/STOP, bar:beat clock display, meters (presentation mode) |

Modularity via bpatchers with standalone `#N` args (per CLAUDE.md bpatcher rule).

---

## 5. Open items / defaults to confirm later
- Sample rate / interface channel layout (assume 48k, 10-in/10-out).
- Count-in length (default 1 bar) and how it interacts with mid-piece starts.
- Subdivision options per section (eighths / triplets).
- Click synth timbre + accent differentiation (pitch/level).
- Whether a Python build-time MIDI→timeline tool is acceptable vs. in-patch node.script parsing
  (lean in-patch node.script to keep runtime self-contained; not a banned generator script either way).
- Mic analysis types when that subsystem is filled in (amplitude/onset/pitch/spectral).

---

## 6. Research findings (DB-verified)

All objects below were verified against `.claude/max-objects/` via `ObjectDatabase`. I/O counts shown
are the no-arg defaults; objects flagged `variable_io` change with arguments.

### 6.0 KEY DECISION — MIDI parsing is a build-time Python tool, NOT in-patch

**`node.script` (Node for Max) is NOT in the object database** → Rule #1 forbids using it. Rather than
fall back to fragile in-patch binary SMF parsing (`js`/`v8` reading the file byte-by-byte), the precise
tempo-track integration is done **offline** by a small build-time tool:

- `tools/midi_to_timeline.py` — parses the SMF: PPQ division, all Set-Tempo (FF 51 03) and
  Time-Signature (FF 58 04) meta events. Integrates piecewise-constant tempo segments to an exact
  **tick → seconds** function (dense ramp events integrate naturally → gradual changes handled precisely).
  Emits two `coll`-format text files the patch loads at runtime:
    - `<piece>_measures.txt` — `index(measure) → sample_offset, num, den` (measure → absolute sample)
    - `<piece>_clicks.txt`   — `index → sample_offset, type` (type 0=beat, 1=accent/downbeat, 2=subdivision)
- This is **NOT a banned generator script** (Rule #5 forbids regenerating `.maxpat`; this only produces
  *data*). The runtime patch stays 100% DB-verified objects.
- Tradeoff vs. self-contained: re-importing a new MIDI requires re-running the tool. Acceptable — the user
  authors MIDI offline anyway. (Could add `node.script` to the DB later for in-patch parsing if desired.)
- **TODO:** add `node.script` to the object DB (gap discovered this session).

### 6.1 Master sample clock (`transport` module)

The whole system is driven by ONE absolute sample counter. Everything else reads off it, so
"start at measure N" = seek the clock and every consumer follows automatically.

- **`count~`** (MSP, in=2 sig, out=1 sig) — free-running sample counter = master clock. `set <sample>`
  seeks; int 1/0 (or `stop`) starts/stops. Its signal output = current absolute sample position.
- Broadcast position with **`send~ master` / `receive~ master`** (verified, rnbo ok) so every module taps
  the same sample-locked signal without spaghetti cords.
- Seek-to-measure: cue manager looks up `measures.txt` coll → `set <sample>` to `count~`.
- Bar:beat readout: `snapshot~` the master signal at ~50ms → reverse-lookup against the measures coll
  (control rate is fine for a display).

### 6.2 Multichannel playback (`playback` module) — sample-accurate, seekable

Per file (×9), wrapped in a bpatcher `playvoice` with standalone `#N` args (`#1`=buffer name, `#2`=channel,
`#3`=start-offset-samples):

- **`buffer~ #1`** (in=1, out=2) — holds the mono WAV; `read`/`replace` to load. **`info~`** reads length.
- Position math: `receive~ master` → **`-~ #3`** (subtract file start offset in samples) →
  **`*~ 0.020833`** (samples→ms at 48k = `1000/sr`) → **`play~ #1`** (in=1 sig position-in-ms, out0 sig,
  out1 sync). `play~` outputs **0 outside the buffer range**, so each file is automatically silent before
  its entrance and after its end — no gating needed.
- All 9 `play~` read the same `master` signal ⇒ inherently phase-locked, sample-accurate, instant seek.
- Output: each voice's signal → its discrete channel. Two routing options (see 6.4).
- RAM note: ~10 MB/min per mono 48k file. Confirm total piece duration; if all 9 run full-length and the
  piece is long, watch total RAM. (Alternative `sfplay~`/disk-stream exists but seeking is coarser — only
  fall back if RAM is a real constraint.)

### 6.3 Click engine (`click` module) — sample-accurate crossing detection

Drive the click off the master clock so it never drifts and survives seeks, while staying per-section
flexible (accent / subdivision / on-off):

- Click events live in a **`coll`** (`clicks.txt`), sorted by sample. A pointer holds the next event.
- Crossing detection in the signal domain (sample-accurate): `receive~ master` and a `sig~ <next_sample>`
  into **`>=~`** → **`edge~`** (out 0 = rising-edge bang). The bang = "fire this click", then advance the
  coll pointer and load the next event's sample into the `sig~`. `edge~`/`>=~` verified.
- Click synth (verified, all rnbo-ok): trigger a short tone burst — **`cycle~`** (pitched) or **`click~`**
  (impulse) → **`*~`** shaped by a fast **`line~`** or **`adsr~`/`curve~`** envelope. Accent vs. plain vs.
  subdivision = different pitch/level chosen from the event `type` field.
- **Count-in**: when launching from measure N, the cue manager seeks `count~` to N minus the count-in span
  (looked up in the measures coll) so the precomputed click events play the lead-in naturally.
- **Subdivision / click on-off per section**: gate the synth output with a **`*~`** whose coefficient the
  cue manager sets per section; subdivision events (`type 2`) are additionally gated by a per-section toggle.
- Routes to its **dedicated output channel** (see 6.4), separate from the 9 program channels.

### 6.4 I/O & routing (`io` module) — 10 out / 10 in via MC

- **Outputs (10 = 9 program + 1 click):** assemble with **`mc.pack~ 10`** (variable_io → 10 sig inlets,
  1 mc outlet) → **`mc.dac~ 1 2 3 4 5 6 7 8 9 10`** (in=1 mc). Program voices → inlets 1–9, click → inlet 10.
  - Simpler non-MC alternative: **`dac~ 1 2 3 4 5 6 7 8 9 10`** (variable_io → 10 sig inlets) with discrete
    cords. Either is valid; MC keeps the patch tidy and matches the requested mc scaffolding.
- **Inputs (10 mics):** **`mc.adc~ 1 2 3 4 5 6 7 8 9 10`** (in=1, out=1 mc) → **`mc.unpack~ 10`**
  (variable_io → 10 sig outlets) for per-channel access.
- Assume 48 kHz; interface with ≥10 in / ≥10 out.

### 6.5 Mic subsystem scaffold (`mics` module)

Per mic (×10), bpatcher `micstrip` with `#1`=channel index:

- One `mc.unpack~` outlet → **`meter~`** (in=1, out=1) or **`levelmeter~`** per channel for monitoring.
- **Modular processing-insert slot:** route the channel through a **`send~`/`receive~`** pair or a
  bypassable **`*~`** + placeholder `gain~`, leaving an empty insert point. DSP/analysis (amplitude,
  onset, pitch, spectral) added later — stubbed for v1.
- Verified candidates for later DSP: `onepole~`, `biquad~`, `svf~`, `clip~`, `scale~` (all in DB).

### 6.6 Cue / section manager (`cues` module)

- Section table in a **`coll`** (cue index → start measure, click on/off, subdivision on/off, active files).
- **GO/Stop**: `textbutton`/`button` → drives the master `count~` (seek + start/stop).
- **Jump to measure**: `number`/`flonum` → measures coll → `count~ set`.
- Cue list UI: **`umenu`** or **`tab`** (verified) for section selection; `coll` holds the data.
- Optional state recall via **`pattrstorage`**/`preset` for per-section settings.

### 6.7 Main UI (`main` / presentation)

- `textbutton` GO/STOP, `number` measure field, bar:beat `comment`/`number` display, per-channel `meter~`
  bank, cue `umenu`/`tab`. Background `panel` (background=1). Presentation-mode layout per CLAUDE.md.

### 6.8 Verified object set (quick reference)

| Module | Objects (all DB-verified) |
|--------|---------------------------|
| transport | `count~`, `send~`/`receive~`, `snapshot~`, `coll` |
| playback | `buffer~`, `play~`, `info~`, `-~`, `*~`, `bpatcher` (per-voice `#N` args) |
| click | `coll`, `sig~`, `>=~`, `edge~`, `cycle~`/`click~`, `line~`/`adsr~`/`curve~`, `*~` |
| io | `mc.pack~`, `mc.dac~`, `mc.adc~`, `mc.unpack~` (or `dac~`/`adc~` with channel args) |
| mics | `mc.unpack~`, `meter~`/`levelmeter~`, `send~`/`receive~`, `*~`, `bpatcher` |
| cues | `coll`, `textbutton`/`button`, `number`/`flonum`, `umenu`/`tab`, `pattrstorage` |
| ui | `textbutton`, `number`, `comment`, `meter~`, `umenu`/`tab`, `panel` |

**PD-confusion guard cleared:** no PD objects used (no `osc~`/`lop~`/`tabread~`/`throw~`). Pitched click
uses MAX `cycle~`, not PD `osc~`.

### 6.9 Resolved decisions from research
- MIDI parsing → **build-time Python tool** emitting `coll` data (node.script not in DB).
- Master clock → **single `count~`**, broadcast via `send~ master`.
- Playback seek → `play~` reading shared master position; out-of-range auto-silence (no manual gating).
- Click sync → **signal-domain `>=~` + `edge~` crossing detection** against a precomputed `coll`
  (sample-accurate, seek-safe, per-section flexible).
- I/O → **MC** (`mc.pack~`→`mc.dac~`, `mc.adc~`→`mc.unpack~`); discrete `dac~`/`adc~` is the fallback.

### 6.10 Still open (sensible defaults for build)
- Exact `count~` seek message form — verify in MAX (`set <sample>` assumed).
- Count-in length default = 1 bar.
- Click timbre: accent = higher pitch/louder `cycle~` burst; subdivision = quieter.
- Confirm total file durations for RAM budget before committing all-RAM playback.

---

## 7. Build log

### Module 1 — transport (BUILT, committed)
Files: `generated/transport.maxpat`, `generated/transport_barbeat.js`. Stage = build.
Validation clean; critic 0 blockers (warnings = benign control→signal on `count~` inlet 0 + cosmetic
cable midpoints). Built as a standalone `.maxpat` to be embedded later as a bpatcher.

**Integration contract (what other modules rely on):**
- **Audio broadcast:** `send~ master` carries the absolute sample position. Consumers `receive~ master`.
- **Control inlet 0** accepts messages (route `go stop seeksample seekmeasure`):
  - `go` → start clock · `stop` → halt · `seeksample <N>` → jump to sample N ·
    `seekmeasure <M>` → jump to measure M (looks up `coll psycography_measures`).
- **Outlet 0:** current sample (control, from `snapshot~ 50`). **Outlet 1:** `bar beat` list (or `—`).
- Built-in test UI inside the patch (GO/STOP buttons, seek number boxes, sample + bar:beat displays).

**Data contracts the timeline tool (next) must satisfy:**
- `coll psycography_measures`: key = measure number → `sample_offset, num, den` (forward seek).
- `transport_barbeat.js` beat grid: feed via messages `clear` then `add <sample> <bar> <beat>` per beat
  (ascending). Reverse-lookup emits `bar beat`. Until loaded, readout shows `—`.

**Verify in MAX (test items):**
- `set <sample>` then `bang` seeks-then-starts `count~` from the set value (not from 0). If `bang` resets
  to initial, switch GO to send the position as an int, or use the `set`→`go` ordering confirmed in MAX.
- `count~` free-runs without a count-limit for the full piece duration (no premature wrap).
- `textbutton` GO/STOP emit a usable trigger in `mode 0` (normalized via `t b` / message box).

### Module 2 — timeline (BUILT, committed)
Files: `tools/midi_to_timeline.py` (pure-Python SMF parser → coll data), `tools/make_synth_midi.py`
(test fixture), `tools/synthetic_tempo.mid`. Wired a data-loader into `transport.maxpat` (loadbang →
read measures coll, clear+dump beats → `add` into `transport_barbeat.js`, `delay 300` before dump for
coll read latency).

**Validated on real data — Flow 1** (`Psychography - Full score - Flow 1.mid`):
- 480 PPQ, 64 tempo events (incl. ritardandi 33–96 bpm), 33 meter changes (4/4, 2/4, 3/4, 5/4).
- 218 measures, 824 beats, ~11.9 min. m2 = sample 174545 = 3.636 s (= 4/4 @66 bpm), integration exact.
- Active data files in `generated/`: `psycography_measures.txt`, `psycography_beats.txt`, `_timeline.json`.
- Tool default `--outdir` resolves to project `generated/` via `__file__` (input MIDI may live anywhere).
- Regenerate per flow: `python3 tools/midi_to_timeline.py <flow.mid> --sr 48000`.

**⚠ Precision test item (12-min piece → 34.2M samples > 2²⁴):** the master `count~` clock as an absolute
sample counter exceeds 32-bit-float integer precision (~16.7M = 5.8 min). Max 6+ uses 64-bit double
signals, so this is almost certainly fine. Even if signals were 32-bit, every consumer reads the SAME
master signal, so quantization is COMMON-MODE → inter-channel + click-vs-audio sync is preserved (only a
few-sample absolute offset late in the piece, inaudible). **Verify in Max:** playback/click stay tight at
~minute 11. Mitigation if needed: reset master to 0 at each section start (cue manager seeks anyway, so
the counter never needs to grow huge).

**Multi-flow note:** folder is "Flows from Psychography" → piece likely has multiple flows/movements.
The cue/section manager (later) should load per-flow timeline data (swap the coll files / parameterize name).

---

## 8. Conductor / free-section handling (ARCHITECTURE DECISION)

**Problem:** some sections drop the click and the conductor controls time (rubato/fermata, unknown
duration); later sections the click returns. A single monotonic master timeline can't span these.

**Resolution — the piece is an ordered list of *sections*, not one continuous timeline.**
Sample-accuracy only needs to hold *within* a click section. A free section is a gap where the master
clock is PARKED; re-entry re-establishes sync via the existing seek-to-measure + GO primitive (the same
"start anywhere" rehearsal feature, used in performance at each boundary). **The transport core does not
change.**

Two section types:
- **CLICK** — master clock runs, sample-accurate; click + audio locked (as built).
- **FREE** — clock parked (stopped), click muted, conductor leads. Audio is per-section configurable.

Decisions (Q&A):
- **Free-section audio = per-section configurable.** Some free sections silent; others play a sustained
  bed on a SEPARATE **free-running** path (NOT clock-locked) — conductor plays over it.
- **File continuity = segment per section.** No click-locked program file crosses a free boundary; each
  click section's audio is rendered/segmented to its own range.
- **Section list = manually authored, editable** (a coll/data file or in-patch table):
  `section -> start_measure, type(click|free), click_opts, free_audio(none|file refs)`.
- **Click re-entry = operator GO, no count-in** (immediate on the conductor's downbeat). Count-in remains
  a REHEARSAL-only toggle (mid-piece starts), not used for performance re-entry.

Implementation impact:
- **Transport:** add **auto-stop at section end** — `>=~ <section_end_sample>` → `edge~` → `stop` (same
  crossing-detector pattern as the click engine), so a click section halts at the next section's downbeat
  and can't run into conductor time. Core clock/seek/GO untouched.
- **New cue/section manager module:** drives the section list. GO advances. CLICK → seek master to
  start measure + GO + arm auto-stop at end. FREE → park clock, mute click, trigger sustained free-audio
  (if any), wait for operator GO to advance.
- **Playback module:** click-locked program voices (segmented per section, positioned by master clock)
  PLUS a separate free-running audio path for sustained free-section beds.
- Supersedes the earlier "one absolute monotonic timeline" framing in §3; the master clock is still
  absolute-sample within a section, just parked across free sections.

### Module 3a — transport auto-stop (BUILT, committed)
Additive edit to `transport.maxpat`. New command vocabulary on the command inlet (via the existing
route's unmatched outlet → `route endstop endstopmeasure`):
- `endstop <sample>` — arm auto-stop at an absolute sample (or `endstop 1000000000` to disarm).
- `endstopmeasure <m>` — arm at a measure (resolved via a 2nd, data-sharing `coll psycography_measures`).
Mechanism: `receive~ master` → `>=~ <thresh>` → `edge~` → `t b b` → [`stop` → count~] + [**new outlet 2:
"ended"** bang]. Default threshold `1e9` = disarmed (no spurious stop at load). NEW transport outlet 2 =
section-ended notification for the cue manager.

### Module 3b — cue/section manager (BUILT, committed)
Files: `cues.maxpat`, `cues_engine.js`, `psycography_sections.txt` (placeholder — EDIT with real sections).
Engine logic unit-tested in Node (all scenarios pass). Section model: a click run flows continuously
through consecutive click sections and auto-stops at the next FREE section; on transport "ended" the
engine enters that free section and waits for GO.
- **Section list format** (`psycography_sections.txt`, a coll): `index, start_measure type;` where
  type `1`=click, `0`=free. Placeholder = `1,1 1; 2,40 0; 3,56 1; 4,100 0; 5,120 1;` (illustrative only).
- **cues.maxpat I/O:** inlet 0 = operator (`go`, `jump N`, `reset`); inlet 1 = `ended` (bang from
  transport); outlet 0 = transport commands; outlet 1 = status (`section n start type total`);
  outlet 2 = hooks (`clickmute 0|1`, free-audio later).
- Built-in test UI: GO button, jump number, status display.

**Integration (wire in the main patch later):**
- `cues` outlet 0 → `transport` command inlet 0.
- `transport` outlet 2 (ended) → `cues` inlet 1.
- `cues` outlet 2 (clickmute / free-audio) → click + playback modules (when built).

**Verify in Max:** with `cues` driving `transport`, GO walks sections — click sections seek+run+auto-stop
at the next free boundary, free sections park the clock. `jump N` for rehearsal. (Standalone, watch
`cues` outlet 0 / status display; full loop needs both modules connected.)

### Module 4 — playback (BUILT, committed)
Files: `generated/playvoice.maxpat` (per-voice bpatcher), `generated/playback.maxpat` (9-voice engine + free bed).
Validation clean; critic 0 blockers (warnings = benign control→signal on the meter/mc taps + cosmetic
cable midpoints). Built against empty/silent buffers (no WAVs yet); `read` path loads files later.

**`playvoice.maxpat`** — standalone `#N` args: **`#1` = buffer name, `#2` = start-offset-samples**
(no channel arg — channel is assigned externally by which `mc.pack~` inlet the voice feeds).
- Position math: `receive~ master` → `-~ #2` (subtract this file's start offset) → `sampstoms~`
  (samples→ms at the **real SR**, replaces the old hardcoded `*~ 0.020833`) → `play~ #1` (signal
  position inlet). `play~` outputs 0 outside the buffer range ⇒ each voice is silent before its entrance
  and after its end — no gating.
- `buffer~ #1` (RAM; `read`/`replace` via the cmd inlet). `info~ #1` banged by `buffer~`'s read-complete
  outlet → total-time-ms (outlet 6) → length readout + outlet 1. `meter~` taps `play~` out 0.
- **I/O contract:** inlet 0 = buffer cmds (`read`/`replace <file>`); outlet 0 = audio (signal);
  outlet 1 = buffer length (ms). Visible top band (meter + length) = the per-voice tile dashboard.

**`playback.maxpat`** — 9× `playvoice` bpatchers (`name=playvoice.maxpat`, args `slot-N 0`; arg2 offset =
placeholder 0, set per-segment from the timeline later) → `mc.pack~ 9` → **`mc.*~` (master test mute,
toggle: on=pass via loadbang, uncheck=mute)** → `mc.dac~ 1 2 3 4 5 6 7 8 9` (program channels 1–9; click
owns ch 10 via transport). Per-voice metering = each playvoice tile's internal `meter~`.
- Per-voice load: 9 `read` message boxes (one per slot) → each bpatcher cmd inlet (file dialog).
- **Free-section bed (SEPARATE free-running path, NOT master-locked):** `buffer~ freebed` + `groove~
  freebed @loop 1` self-clocked by `sig~ 1.`; started/stopped by the cues free-audio hook
  (`inlet → route freeaudio clickmute → sel 1 0 → [0 ms start | stop] → groove~`). Output through a
  gain-safe `clip 0. 1.` → `*~ 0.` (init silent) → `meter~` tap + **`send~ freebed_out`** (named bus for
  per-section routing — full per-section bed config comes later). The `clickmute` route branch is consumed
  by the click module (wired elsewhere).

**Integration (wire in the main patch later):**
- Each `playvoice` `receive~ master` taps `transport`'s `send~ master` (no explicit wire needed).
- `cues` outlet 2 (clickmute / free-audio) → `playback` hooks inlet.
- `playback` `mc.dac~` → program out 1–9; click → out 10 (from the click module via transport).

**Verify in Max (§9 open items this module depends on):**
- `count~` `set <sample>`-then-`go` resumes from the set sample (seek + section re-entry rely on it).
- `play~` with a signal ms-position from `sampstoms~` tracks the master clock and auto-silences out of
  range (no clicks at buffer edges); all 9 voices stay phase-locked since they share `receive~ master`.
- `groove~ @loop 1` + `sig~ 1.` + a `0` (ms) message starts a looping bed; `stop` halts it.
- bpatcher `#1`/`#2` substitution: `buffer~ slot-N`, `-~ <offset>`, `play~ slot-N`, `info~ slot-N` resolve
  per instance.

### Next: Module — click engine (§6.3) + main UI assembly (§6.7) wiring transport + cues + playback together

---

## 9. RESUME POINTER / build playbook (read this first in a fresh window)

**State (stage=build):** transport (clock+seek+GO/STOP+bar:beat+auto-stop), timeline tool (MIDI→coll data,
Flow 1 loaded), cue/section manager, **playback (playvoice + 9-voice engine + free bed)** — all BUILT &
committed. **Next: click engine** (§6.3: signal-domain `>=~`/`edge~` crossing detection off `receive~
master` against `clicks` coll → accent/plain/subdivision synth → dedicated ch 10) **then main-patch
assembly** (wire transport + cues + playback together; presentation UI §6.7).

**Module files** in `generated/`: `transport.maxpat`+`transport_barbeat.js`, `cues.maxpat`+`cues_engine.js`,
`playvoice.maxpat`, `playback.maxpat`, `psycography_sections.txt` (placeholder),
`psycography_measures.txt`/`_beats.txt`/`_timeline.json` (Flow 1).
Tools in `tools/`: `midi_to_timeline.py`, `make_synth_midi.py`. Not yet assembled into one main patch.
NOTE: the timeline tool does NOT yet emit `clicks` coll data — the click engine needs a `<piece>_clicks.txt`
(index → sample_offset, type 0=beat/1=accent/2=subdivision); add that emitter when building the click module.

**How patches are built here (mechanics):**
- Build a `Patcher` in-memory in an EPHEMERAL script under `/tmp` (NOT in the repo — Rule #5), run with
  `cd /Users/taylorbrook/Dev/MAX && PYTHONPATH=/Users/taylorbrook/Dev/MAX python3 /tmp/x.py`.
- Pipeline: `validate_patch(p.to_dict(), db)` → `review_patch(...)` (returns a LIST of findings with
  `.severity`/`.finding`/`.suggestion`; gate save on 0 blockers) → `save_patch_roundtrip(dict, path,
  original_text=orig)` → `auto_commit_patch(proj, base, description=..., files=[...])`.
- To EDIT an existing patch, `Patcher.from_dict(json.loads(path.read_text()), db=db)` then add boxes/cords.
  **Round-trip preserves the user's manual Max edits** (e.g. their `number~` debug monitor survived).
- js files: write with the Write tool to `generated/`; `add_js(filename, num_inlets, num_outlets)` only
  references them. Unit-test js logic in Node (mock `outlet/post/arrayfromargs`) before wiring.

**Gotchas:** Bash cwd PERSISTS across calls — a prior `cd` into `generated/` doubled `Path.cwd()` paths;
hardcode `base = Path("/Users/taylorbrook/Dev/MAX")` in build scripts. `find_box(text=...)` throws on
boxes whose `text` is None (UI boxes post-round-trip) — scan `p.boxes` guarding None instead, and match
exact text when a substring (e.g. "stop") also appears inside another box ("route ... stop ..."). Empty-IO
UserWarnings for `outlet`/`comment`/`send~`/`dac~` are benign (serialized I/O is correct). Control→signal
and missing-midpoint critic warnings on this project are benign/cosmetic.

**Open verify-in-Max items:** `count~` `set`-then-`go` resumes from the set sample (underpins all seek +
section re-entry); 12-min piece = 34.2M samples > 2²⁴ float precision (common-mode, likely fine — check
~min 11); coll read latency vs the `delay 300` before dump; `textbutton` button-mode output (normalized
via `t b`). Edit `psycography_sections.txt` with the real Flow 1 sections (current list is a placeholder).
