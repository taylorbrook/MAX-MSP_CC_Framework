# intelligent-corpus-remixer

A sample analysis and playback instrument that uses FluCoMa, EARS, and Odot community packages for corpus-based concatenative synthesis.

## Packages Required

- FluCoMa (Fluid Corpus Manipulation)
- EARS (Essentia Analysis and Retrieval for Sound)
- Odot (OSC-based data bundling)

## Signal Flow

### 1. Loading & Slicing (p load-slice)
- ears.readfile loads audio files into buffers
- Support both single file (dropfile/dialog) and batch folder loading
- fluid.bufonsetslice~ detects onsets per buffer
- ears.crop slices buffers at onset points into individual slice buffers (OR keep single source buffer and store offset+duration — see Q3b decision: single shared buffer~)

### 2. Feature Extraction (p extract)
- fluid.bufmfcc~ extracts MFCC timbral descriptors per slice
- fluid.bufloudness~ extracts loudness per slice
- Descriptors stored in a fluid.dataset~
- fluid.umap~ reduces 13D MFCC to 2D for plotter display

### 3. Clustering (p cluster)
- fluid.kmeans~ clusters slices by timbral similarity
- User-adjustable cluster count (K) via number box

### 4. Data Bundling (Odot)
- o.pack bundles each slice with cluster ID, MFCC centroid, and loudness
- o.route fans out by cluster for cluster-specific operations

### 5. Playback (p playback)
- fluid.plotter displays 2D UMAP descriptor space — click near a point to trigger that slice
- Custom gen~ DSP inside poly~ (8 voices) handles slice playback
- Single shared buffer~ + offset/duration lookups from fluid.dataset~
- Native playback speed, 5ms linear fade envelope, full-slice seamless loop
- Metro-driven random mode picks slices within the currently selected cluster
- Loop toggle per slice

## Audio Output
- Stereo dac~ with master gain

## UI
- fluid.plotter~ as primary interface (click-to-trigger in 2D descriptor space)
- Cluster assignments visible in plotter (color-coded)
- Cluster audition via plotter interaction

## Kickoff Answers
- Audio output: stereo dac~ with master gain
- File loading: both single file (dropfile/dialog) and batch folder
- Cluster count: user-adjustable K via number box
- Playback: one-shot + looping option per slice
- UI: fluid.plotter~ only (click-to-trigger in 2D space)

## DB Findings (rescanned 2026-04-16)
- FluCoMa, EARS, Odot packages fully present in `.claude/max-objects/packages/`
- Buffer-processing FluCoMa objects ARE in DB: `fluid.bufonsetslice~`, `fluid.bufmfcc~`, `fluid.bufloudness~`, `fluid.bufampslice~`, `fluid.bufnoveltyslice~`, `fluid.buftransientslice~`, `fluid.bufstats~`, `fluid.bufcompose~`, etc.
- Real-time variants also present: `fluid.onsetslice~`, `fluid.mfcc~`, `fluid.loudness~`
- Canonical dataset/ML names (all end in `~`): `fluid.dataset~`, `fluid.kmeans~`, `fluid.kdtree~`, `fluid.pca~`, `fluid.umap~`, `fluid.normalize~`, `fluid.standardize~`, `fluid.robustscale~`, `fluid.mds~`
- Plotter: `fluid.plotter` (no tilde) and `fluid.jit.plotter`
- EARS: `ears.readfile`, `ears.crop`, `ears.slice`, `ears.descriptors`, `ears.loudness`, `ears.pitch`, `ears.timestretch~`, `ears.pitchshift~`, etc.
- Odot: `o.pack`, `o.route`, `o.expr.codebox`, `o.if`, `o.select`, `o.var`, `o.collect`, `o.union`, `o.schedule`

## Decisions (recorded 2026-04-16)

**Q1 — Buffer objects exist in DB.** Use `fluid.bufonsetslice~`, `fluid.bufmfcc~`, `fluid.bufloudness~` directly. Rationale: idiomatic FluCoMa workflow; real-time variants are not needed for offline analysis.

**Q2 — `fluid.umap~` for dimensionality reduction.** MFCC 13D → 2D via UMAP. Rationale: nonlinear reduction preserves cluster separation better than PCA, which matters for the plotter's visual grouping. Cost: slower to fit, but runs once on the corpus.

**Q3 — Custom gen~ playback engine inside poly~.** Build a gen~ codebox DSP and wrap it in `poly~` for voice allocation.
- **Q3a — Polyphony:** `poly~` wrapping gen~, **8 voices** (default). Overlapping slice triggers stack into available voices; voice-steal on exhaustion.
- **Q3b — Sample access:** Single shared `buffer~` holds full source audio. Each voice receives per-slice offset+duration from `fluid.dataset~` lookup. Rationale: O(1) slice count, no buffer-switching latency, scales to large corpora.
- **Q3c — Pitch/speed:** Native playback rate only. No rate/pitch params. Rationale: simplest, bit-perfect, avoids interpolation artifacts; can be added later.
- **Q3d — Envelope:** Simple 5ms linear fade-in/out per voice to prevent clicks at slice boundaries. No ADSR.
- **Q3e — Loop behavior (when loop toggle ON):** Wrap phase accumulator modulo slice duration — seamless full-slice loop. Ping-pong and internal loop points deferred.

**Q4 — `fluid.dataset~` as central registry.** Single dataset holds per-slice {buffer ref, offset, duration, cluster id, MFCC centroid, loudness}. Query with `fluid.kdtree~` for nearest-neighbor lookups. Rationale: one source of truth, scales to thousands of slices, integrates with FluCoMa ML pipeline.

**Q5 — Top-level patch with subpatchers per stage.** `p load-slice`, `p extract`, `p cluster`, `p playback`, `p ui`. Rationale: clear logical separation, readable signal flow, no wire tangle.

## Status

All discussion questions resolved. Ready for `/max-build` (or `/max-research` for gen~ playback engine prototyping first).

## Research (2026-04-16)

### R1 — FluCoMa analysis pipeline (message-driven, control rate)

Every `fluid.buf*~` object is control-rate despite the `~` suffix. They take messages at inlet 0 (parameters + source/dest buffer names) and emit a completion bang at outlet 0. They are NOT audio-rate objects — the tilde flags "processes buffer~ data" not "runs in DSP chain."

**Analysis graph** (driven by `trigger` / `t b b b` fan-out after `ears.readfile` completes):

```
ears.readfile src.wav  →  (buffer name)  ──┐
                                            ▼
           [fluid.bufonsetslice~ @source src @indices onsets_buf @threshold 0.5 ...]
                                            │  (bang on completion)
                                            ▼
        [fluid.bufmfcc~ @source src @features mfcc_buf @numcoeffs 13]
                                            │
                                            ▼
        [fluid.bufloudness~ @source src @features loud_buf]
                                            │
                                            ▼
        [fluid.bufstats~ @source mfcc_buf @stats mfcc_mean_buf @select mean]
                                            │  (per-slice MFCC centroid)
                                            ▼
              [fluid.dataset~ corpus addpoint <id> <13d vector>]
```

**Key attributes / messages** (all set via message or `@attr val` args):
- `fluid.bufonsetslice~`: `@source`, `@indices` (output buffer of onset sample indices), `@threshold`, `@metric`, `@minslicelength`.
- `fluid.bufmfcc~`: `@source`, `@features` (output buffer, 13 coeffs × num_frames), `@numcoeffs 13`, `@startcoeff 1` (skip coeff 0 = energy), `@windowsize`, `@hopsize`.
- `fluid.bufloudness~`: `@source`, `@features`, `@kweighting 1`, `@truepeak 1`.
- `fluid.bufstats~`: reduces per-frame features to per-slice stats (mean/std/...); use `@select mean` to get a single centroid vector per slice. Essential for going from per-frame MFCC to per-slice descriptor.

**Slicing strategy (Q3b confirmed: single shared buffer~):**
- Do NOT call `ears.crop` to carve slices into separate buffers.
- Instead, read the onset buffer (samples) with `peek~` or `uzi`-driven message loop to enumerate slice offsets.
- For each onset `i`: store `{id: i, offset: onsets[i], duration: onsets[i+1] - onsets[i]}` in `fluid.dataset~ slice_meta` (as a 2D point: [offset_samples, duration_samples]) and in a separate descriptor dataset for clustering.

### R2 — fluid.dataset~ operations used in this project

`fluid.dataset~` is a FluCoMa-side id→vector store. Messages used:
- `addpoint <id> <val1 val2 ...>` — write a point.
- `get <id>` — read a point (result out outlet 0 as a list).
- `getpoint <id> <output_buffer>` — write a point into a `buffer~` for further processing.
- `dump` — emit full dataset as dict for inspection.
- `clear` — reset.
- `size`, `print`, `read <path>`, `write <path>`.

**Two-dataset pattern** (recommended to keep descriptors and slice locations independent):
- `fluid.dataset~ descriptors` — per-slice MFCC mean (13D) used for clustering + UMAP input.
- `fluid.dataset~ slice_meta` — per-slice [offset, duration] in samples for playback lookup.
- Both use the same integer slice id.

### R3 — Clustering and 2D projection

**K-means:**
- `fluid.kmeans~ @numclusters K` then `fit descriptors labels` message where `labels` is a `fluid.labelset~`.
- `fluid.labelset~` is the string-valued sibling of dataset — stores `id → "cluster_N"` mappings.
- Query cluster of slice id: `get <id>` on labelset; returns cluster label.

**UMAP (13D → 2D for plotter):**
- `fluid.umap~ @numdimensions 2 @numneighbours 15 @mindist 0.1`
- `fittransform descriptors descriptors_2d` — fits UMAP and writes 2D points into a second dataset for plotting.
- Runs once on corpus load (slow); no need to refit during playback.

**Normalize before UMAP** with `fluid.normalize~` or `fluid.standardize~` on the descriptors dataset — MFCC coeffs have very different ranges across dimensions and UMAP respects distance geometry.

### R4 — fluid.plotter click-to-trigger

`fluid.plotter` (no tilde) is a UI object that displays a 2D dataset and emits messages on interaction.
- Load the 2D UMAP dataset: `set descriptors_2d` message.
- Optionally colorize by cluster: `labels cluster_labels` message.
- On mouse click/drag, the plotter emits `point <id>` out outlet 0 → that id is the slice to trigger.

**Click-to-trigger chain:**
```
fluid.plotter → [route point] → (id) → [pack offset duration] from slice_meta
                                     → send to poly~ voice: "note <offset> <duration> <loop_flag>"
```

To look up offset/duration from `slice_meta`, send `get <id>` → dataset result comes out outlet 0 as a list (not directly routable by point). Use an `fluid.bufcompose~`-driven batch preload OR a `coll` mirror populated at analysis time for O(1) lookups without dataset message round-trips.

**Decision: use `coll slice_meta` as a lookup mirror.** At analysis completion, iterate dataset ids (`uzi` + `get`) and `store` each into `coll` as `<id>, offset duration;`. Playback then uses `<id>` → `coll` → `offset duration` list inline.

### R5 — poly~ voice dispatch pattern (8-voice, gen~-based)

**Voice subpatch `slice-voice.maxpat`:**

```
[in 1] (trigger message "note offset duration loop")
   │
   [route note]
   │
   [unpack 0. 0. 0.]          → offset, duration, loop_flag
   │                            │         │
   [thispoly~ 1] (claim voice)  │         │
                                │         │
   [gen~ slice-playback]  ◄─────┴─────────┘
       │  (stereo out)
   [out~ 1] [out~ 2]
```

**Top-level poly~ instantiation:**
- `poly~ slice-voice 8 @steal 1` — 8 voices, steal oldest when all busy.
- Trigger: `note <offset_samples> <duration_samples> <loop>` — auto-dispatches to free voice.
- `thispoly~ 1` inside the voice marks it busy; `thispoly~ 0` on slice completion marks it free.

**Gen~ `slice-playback` codebox (internal logic):**

```
Param offset(0);
Param duration(1);
Param loop(0);
History phase(0);
History running(0);
History voiceage(0);   // samples since trigger for fade-in/out envelope

// Phase accumulator: count samples since trigger, wrap on loop
next_phase = phase + 1;
end_reached = (next_phase >= duration);

// If not looping and end reached → stop, release voice (handled outside gen~ via thispoly~)
next_running = running;
next_phase_out = next_phase;
if (end_reached) {
    if (loop > 0.5) {
        next_phase_out = 0;        // wrap to slice start
    } else {
        next_running = 0;
        next_phase_out = duration; // park at end
    }
}

// Read sample at (offset + phase) from shared source buffer
read_pos = offset + next_phase_out;
sampleL = peek(source, read_pos, 0);
sampleR = peek(source, read_pos, 1);

// 5ms linear fade envelope (5ms * 44100 = 220.5 samples; use samplerate)
fade_samples = 0.005 * samplerate;
fade_in  = min(1, voiceage / fade_samples);
fade_out = loop > 0.5 ? 1 : min(1, (duration - next_phase_out) / fade_samples);
env = running * fade_in * fade_out;

// Advance state
phase = next_phase_out;
running = next_running;
voiceage = voiceage + running;

out1 = sampleL * env;
out2 = sampleR * env;
```

**Declaration order rule:** Params first, then History, then expressions (per CLAUDE.md). Buffer reference: use `buffer source` declared in the gen~ patcher (not codebox), named to match the outer `buffer~ source` via `set` message or gen~ attribute.

**Trigger → gen~ param wiring:**
- `note offset duration loop` message → `unpack` → three `message` boxes: `offset $1`, `duration $1`, `loop $1` → gen~ left inlet.
- Also send `reset` (bang) to gen~ via a message to re-seed `phase` and `voiceage` to zero — simplest is to make a `Param trigger(0)` that edge-detects and manually zeros `phase`/`voiceage` in codebox.

### R6 — Random mode (metro-driven cluster-filtered picker)

```
[metro 250] → [bang] → (cluster_id) from UI number box
                         ↓
    [zl filter <cluster_id>] on a list of all (slice_id, cluster_id) pairs
                         ↓
    [zl.nth random]       → random slice_id within that cluster
                         ↓
    [coll slice_meta] get  → [offset duration]
                         ↓
    → poly~ note message
```

Store the `(slice_id, cluster_id)` pairs in a second `coll cluster_index` populated from the `fluid.labelset~` dump at cluster-fit completion. Pre-filter by cluster id before random pick — avoids rejection sampling.

### R7 — Odot bundling (optional enrichment, lower priority)

Odot is useful for passing rich metadata between subpatchers without many parallel cords, but NOT required for the core playback path. Suggested use:
- `o.pack /id $1 /offset $2 /duration $3 /cluster $4 /loudness $5` builds a bundle per slice at analysis completion.
- `o.route /cluster` fans bundles out by cluster id (each cluster on its own outlet) for cluster-specific UI or processing.
- `o.schedule` for time-based triggering of slice sequences (deferred until rhythmic sequencing is added).

**Decision: defer Odot until after v1 is working.** Core path uses `coll` + message lists. Odot adds value when we layer on rhythmic sequencing, cluster-based effects routing, or OSC export to external tools.

### R8 — Package companions / auditioning

- `fluid.plotter` + `fluid.dataset~`: plotter consumes a 2D dataset via `set <dataset_name>` message; labels via `labels <labelset_name>`.
- `fluid.kdtree~` pairs with `fluid.dataset~` for nearest-neighbor queries — useful later if we add "nearest slice to clicked point" behavior.
- `ears.readfile` → `buffer~` (creates/writes a named buffer, emits buffer name out outlet 0).

### R9 — Subpatcher organization (top-level)

```
[p load-slice]   — ears.readfile, fluid.bufonsetslice~, enumerate onsets → coll slice_meta
[p extract]      — fluid.bufmfcc~, fluid.bufloudness~, fluid.bufstats~, populate fluid.dataset~ descriptors
[p cluster]      — fluid.normalize~, fluid.kmeans~ → fluid.labelset~; fluid.umap~ → descriptors_2d
[p playback]     — fluid.plotter, coll slice_meta lookup, poly~ slice-voice 8
[p ui]           — dropfile, K count number, loop toggle, master gain, random-mode metro
```

Top-level buses:
- `send/receive slice_trigger` (list: offset duration loop) → feeds `poly~` note message.
- `send~/receive~ voice_L`, `voice_R` → summed to master gain → `dac~ 1 2`.

### R10 — Version compatibility notes

- FluCoMa package: requires install via Package Manager (verified in DB); all objects have `min_version: 8.0`.
- EARS package: same.
- Gen~ `peek` operator with 8-argument form (name, channels + inlets for wave_phase/start/end/channel): available in MAX 7+.
- `poly~ @steal 1` attribute: MAX 5+.
- `fluid.umap~`: FluCoMa 1.0.3+ (current package version — verified).

### R11 — Risks and open technical questions (for build phase)

1. **Voice retrigger mid-slice**: if a voice is stolen while playing, gen~ state (phase, voiceage) resets correctly via `Param trigger` re-seed but may cause a click if fade-in is truncated. Mitigation: `@steal 1` with oldest-voice stealing gives best odds; 8 voices should be sufficient for UI click cadence.
2. **Stereo vs mono source**: `peek source read_pos 0` vs `1` assumes stereo. Add a channel-count branch OR document that corpus must be stereo. Simplest: monoize in gen~ (sum L+R, divide 2) if only one channel present.
3. **Offset/duration precision**: onsets from `fluid.bufonsetslice~` are in samples (integer). Offsets passed to gen~ as float Params round to nearest sample inside `peek` — fine for slice boundaries.
4. **coll vs dataset round-trip latency**: `fluid.dataset~ get <id>` is async. `coll` is synchronous. Using `coll` as mirror is the right call for real-time click response.
5. **UMAP determinism**: UMAP is stochastic — layout changes per fit. Optional: set `@seed N` on `fluid.umap~` for reproducible plotter layouts across sessions.

### Research summary

The build plan is feasible with the objects present in DB. Key engineering tasks for `/max-build`:
1. Analysis pipeline in `p load-slice` + `p extract` with `trigger b b b` chains between completion bangs.
2. `coll slice_meta` mirror populated from `fluid.dataset~` at analysis done.
3. `poly~ slice-voice 8 @steal 1` with gen~ codebox per voice implementing phase accumulator + 5ms fade + loop wrap + `peek source` read.
4. `fluid.plotter` emits `point <id>` → `coll` lookup → `note offset duration loop` to poly~.
5. `metro` + `zl filter` for cluster-filtered random mode.

