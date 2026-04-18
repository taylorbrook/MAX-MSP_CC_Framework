# physics-composition

An interactive audiovisual instrument where a 2D bouncing-ball simulation generates music, using Dada and Bach community packages. Per-ball pitch is derived from ball x-position on each bounce — dada.bounce is used strictly as a physics source, not as a MIDI sequencer.

## Signal Flow

1. **dada.bounce** runs a bouncing-ball simulation — 5 balls inside a V-shaped wall geometry. Motion is geometric (speed vector + perfectly-elastic wall bounces), not gravitational. Global speed is controlled by `playstep` (ms per simulation step). Attribute `bouncedata 1` is required to enable outlet-2 emission.
2. **Outlet 2 (Bounce occurrence)** emits one key-tagged llll per collision (verified 2026-04-17 from live help-patch capture): `[ball N] [position X Y] [speed VX VY] [edge E] [component C]`. Ball is 1-based int; position and speed are 2-float vectors; edge and component are ints. Speed is a true velocity vector (not a scalar magnitude), so ADSR velocity is derived by `sqrt(vx² + vy²)`. Emission requires `bouncedata 1`.
3. **Per-ball dispatch**: extract ball number via `bach.keys ball` on the outlet-2 llll, then `route 1 2 3 4 5` on the int to drive five parallel voice subpatchers. Position and speed are extracted the same way (`bach.keys position` / `bach.keys speed`) inside each voice.
4. **Per-voice pitch computation**: normalize hit-x to 0–1 across the known room domain; `freq = min_hz * pow(max_hz/min_hz, x_norm)` (log sweep). `speed_mag = sqrt(vx² + vy²)`, clamped and scaled to 0–1 for velocity. Plain `expr` objects — no `o.expr.codebox` needed.
5. **bach.roll display** — on each collision, stream `[onset, pitch_midicents, duration_ms, velocity]` to inlets 1–4, then bang inlet 0 to append a chord. `onset = cpuclock - start_time`; `pitch_midicents = ftom(freq) * 100`; `velocity = collision_speed_norm * 127`.
6. Audio output: per-ball `cycle~` voice with harmonic partial, `adsr~` envelope triggered from outlet-2 event, constant-power pan by x-position, summed to master `gain~` → `limi~` → `dac~ 1 2`.

## UI Controls

Real dada.bounce controls (no gravity/elasticity — those do not exist on this object):

- **Speed** → `playstep` attr (ms per step; lower = faster)
- **Ball size** → `ballsize` attr
- **Freq range** → two number boxes (min Hz / max Hz) feeding the per-voice `expr` x→freq mapper
- **Bounce data** → `bouncedata 1` (must be set at load)
- **Clear / reset** → `clear balls` to dada.bounce + `clear` to bach.roll
- **Play / Stop** → `play` / `stop` messages to dada.bounce (or `int 1` / `int 0`)

Not used (native playout path bypassed):
- `tonedivision`, `noteoff`, `indexaschannel`, `speedvel`, `notes`, `scores`, `type`, `mode`

## Design Decisions

- **Architectural model**: Bypass dada.bounce's native playout (outlet 3). dada.bounce is a physics source only; pitch/velocity/envelope are computed externally from outlet 2. This preserves the original per-ball x-position → pitch design.
- **Polyphony**: One cycle~ voice per ball (fixed 5-voice allocation, no poly~)
- **Pitch mapping**: Microtonal, continuous. `freq = min_hz * pow(max_hz/min_hz, x_normalized)` — log sweep across the configured Hz range. No scale quantization.
- **bach.roll**: Accumulating score with a "clear" button to reset
- **Ball visuals**: Color-coded (dada.bounce renders its own canvas)
- **Frequency range**: Piano range (~55 Hz – 4186 Hz) as default; adjustable via UI min/max number boxes
- **Envelope**: Velocity-dependent ADSR — collision speed magnitude scales attack sharpness and decay length
- **Ball count**: Fixed 5 balls, configured via `addball` messages at load
- **Geometry**: V-shaped funnel — room graph with 3 vertices (top-left, apex-bottom, top-right) + 2 edges. Assigned via full-state `llll` message (see "Wall geometry llll" below). Edges carry NO metadata in decision B — they are pure bouncing surfaces.
- **Data routing (Q9)**: Per-ball dispatch via `route 1 2 3 4 5` on ball_num from outlet 2. Odot optional — use `o.expr.codebox` only if the per-voice math becomes awkward in plain `expr`.
- **Note triggers (Q10)**: All collision types (wall + ball-to-ball) emit on outlet 2 when `bouncedata 1`
- **Frequency range UI (Q11)**: Two number boxes (min Hz / max Hz) patched into the per-voice `expr` mapper
- **Visual layout (Q12)**: Split — dada.bounce canvas left, `bach.roll` right, controls bottom
- **Ball-to-ball collisions (Q13)**: Both balls re-trigger — dada.bounce emits one outlet-2 event per participating ball
- **Voice timbre (Q14)**: `cycle~` + one harmonic partial per voice (simple additive, per-ball partial ratio)
- **Ball launch/reset (Q15)**: Auto-respawn — verify in help patch whether default behavior reintroduces exiting balls, or whether a `flags` or boundary-check message is required
- **Stereo field (Q16)**: Pan by x-position (left wall = hard L, right wall = hard R), constant-power
- **bach.roll time window (Q17)**: Drive `zoom` attr programmatically as score grows; `clear` message resets
- **Gain staging (Q18)**: Per-voice `*~ 0.2` + master `gain~` + `limi~` safety limiter before `dac~`

## Required Packages

- Dada (dada.bounce) — requires Bach
- Bach (bach.roll) — display only, no bach.quantize / bach.score
- Odot (o.expr.codebox) — OPTIONAL. Plain `expr` + `route` covers this patch. Add Odot only if a future iteration adds bundle-based synth-parameter routing.
- Cage NOT required

## Research (2026-04-17, revised)

> **Revision note**: Initial research on 2026-04-16 was written against an unverified object database. The Dada, Bach, and Odot entries have since been populated from `.maxref.xml` sources, exposing material differences in outlet counts, available messages, and the absence of gravity/elasticity on `dada.bounce`. A second revision on 2026-04-17 locked the architectural decision to **bypass native playout** — dada.bounce emits physics events only; pitch/velocity/notation are computed externally. This section reflects verified data and the locked design.

### Object database confidence

- `dada.bounce`, `dada.bodies`, `dada.base`, `bach.roll`, `bach.score`, `o.pack`, `o.route`, `o.prepend`, `o.expr.codebox` — all `verified: true` with populated `messages` and `attributes` from official Max refpages.
- Caveat: `o.route` `variable_io` is still false in the DB, but in practice outlets = `#args + 1` (matched slots + unmatched). Compute real outlet count at build time if Odot is used.

### dada.bounce — corrected I/O

Outlets (5, previously recorded as 2):
- 0: Dump outlet (state export)
- 1: Queries and notifications (e.g., `addball` confirmations)
- 2: **Bounce occurrence** — primary signal source for this patch. Format locked 2026-04-17 via `bounce-outlet2-test.maxpat` capture:
  ```
  [ball N] [position X Y] [speed VX VY] [edge E] [component C]
  ```
  Five key-tagged sub-lllls. `ball` and `edge`/`component` are 1-based ints; `position` is world-space hit coords (2 floats); `speed` is the ball's velocity vector at the moment of contact (2 floats — NOT a scalar, so `speedvel` attr doesn't alter this outlet). Emission gated by `bouncedata 1`.
- 3: Playout — bach-ezmidiplay-compatible note data (midicents + velocity + duration) driven by edge-assigned `notes`/`scores`. **Unused in this patch** per the locked design.
- 4: Bang when the object state changes via UI interaction.

### dada.bounce — pitch lives on EDGES (not balls)

Per the refpage, `notes [pitch vel] [pitch vel] ...` assigns to edges in graph order, not to balls. The native playout model is "walls carry the scale; balls are playheads." This patch bypasses that model — edges receive no pitch metadata — so `mode`, `type`, `notes`, `scores`, and `tonedivision` are not configured.

### dada.bounce — verified llll shapes

**addball** (confirmed from refpage):
```
addball [coord x y] [speed vx vy] [color r g b a]
```
Optional sub-lllls: `[channel N]`, `[flags lock|mute|solo|...]`. NOT wrapped in outer parentheses.

**Wall geometry** (confirmed via the `dump` / `llll` state message):
```
bounce [room [VERTICES] [EDGES]] [balls BALL1 BALL2 ...]
```
- `VERTICES = [[coord x y] METADATA...] [[coord x y] METADATA...] ...` — list of vertex lllls.
- `EDGES = [start_idx end_idx METADATA...] [start_idx end_idx METADATA...] ...` — list of edge lllls, 1-based indices into VERTICES.
- V-funnel room (minimum): 3 vertices `[coord -100 80]`, `[coord 0 -80]`, `[coord 100 80]` and 2 edges `[1 2]`, `[2 3]`. No edge metadata — empty edge llll past the two vertex indices.
- Send as `llll` prefix: `llll bounce [room [[[coord -100 80]] [[coord 0 -80]] [[coord 100 80]]] [[1 2] [2 3]]] [balls]`.

**Starting the sim**: `int 1` (alias of `play`); `int 0` / `stop` halts. `bang` performs a single step (test only).

**Key attributes for decision B**:
- `playstep` (ms per step) — global speed slider
- `ballsize` (pixels) — ball radius
- `bouncedata 1` — REQUIRED to enable outlet-2 emission
- `showballs` / `showroom` / `showgrid` — visual toggles
- `center`, `domain`, `range` — viewport controls

### dada.bounce outlet 2 consumption (decision B)

Outlet-2 llll (locked shape): `[ball N] [position X Y] [speed VX VY] [edge E] [component C]`.

On each collision:
1. Fan out the llll three ways via `t l l l` (or `bach.t`) — one copy each for ball-number extraction, position extraction, and speed extraction.
2. Ball-number extraction: `bach.keys ball` → emits the value sub-llll → `bach.nth 1` → int → `route 1 2 3 4 5`. Outlet N drives voice N.
3. Position extraction (inside voice): `bach.keys position` → `bach.llll2list` → `unpack f f` → `hit_x`, `hit_y`.
4. Speed extraction (inside voice): `bach.keys speed` → `bach.llll2list` → `unpack f f` → `vx`, `vy`.
5. Per-voice math:
   - `x_norm = (hit_x - domain_min) / (domain_max - domain_min)` (domain known from the V-funnel geometry, ±100 by default).
   - `freq = min_hz * pow(max_hz/min_hz, x_norm)` — log sweep.
   - `speed_mag = sqrt(vx² + vy²)`, clamped to a useful range and scaled to 0–1 for velocity.
   - Drive `adsr~` trigger + oscillator freq.
   - Forward `[cpuclock_now, ftom(freq)*100, fixed_duration_ms, velocity*127]` to bach.roll inlets 1–4, then bang inlet 0.
6. All computation in plain `expr` / `pow` / `sqrt`; no `o.expr.codebox` required.

**Note on ball indexing**: The live capture showed NOTIFY addball returning indices 2, 3, 4 for three `addball` messages. There is a default pre-existing ball 1 in an empty `dada.bounce`. If we want exactly 5 user-controlled balls, either `clear balls` before `addball ×5` (indices 1..5), or `addball ×4` and let the default fill slot 1. Confirm which is cleaner during build.

### bach.roll — corrected I/O

Inlets (6, previously recorded as 1):
- 0: bang or full llll (append / assemble)
- 1: onsets (ms) — separate-syntax stream
- 2: pitches or MIDIcents — separate-syntax stream
- 3: durations (ms) — separate-syntax stream
- 4: velocities (1–127) — separate-syntax stream
- 5: extras

Outlets (8, previously recorded as 4):
- 0: whole-object dump
- 1–5: per-parameter dumps
- 6: playout (re-synthesis via transport) — unused here
- 7: bang when changed

Live accumulation pattern (this patch):
- On each outlet-2 event: pipe onset/pitch/duration/velocity to inlets 1–4, then bang inlet 0. One chord per collision, built from the separate streams.
- Reset: `clear` (full) or `clearall`.
- Zoom-as-grows: drive `zoom` attr (horizontal %) programmatically from running onset range.
- Pitch input in midicents — no voice/clef config needed for piano-roll mode.

### Odot — retained as optional only

- `o.pack [/addr1, /addr2, ...]` — address arguments on box; inlet values bind to addresses.
- `o.route [/addr1 /addr2 ...]` — variable outlet count (N+1).
- `o.prepend /address`, `o.expr.codebox` — standard Odot idioms.
- Decision B's data needs are simple enough for plain `route` + `expr`; Odot not required.

### Per-ball voice architecture (5 voices)

Per voice (subpatcher `p voice` with `#1` = ball id 1..5):
- `cycle~ [freq]` fundamental + `cycle~ [freq * partial_ratio]` harmonic — sum via `+~`.
- `adsr~ A D S R` triggered from the routed outlet-2 event. A/D scaled by collision speed.
- `*~` envelope applied to summed oscillators.
- Per-voice `*~ 0.2` headroom stage.
- Per-voice constant-power pan: two `*~` taps (left = `cos(pan·π/2)`, right = `sin(pan·π/2)`), pan ∈ [0,1] from normalized x-position.
- Output routed to master L and R buses.

Master chain:
- 5 voices (L) → `+~` → master L; same for R → stereo `gain~` → `limi~ 2` (ceiling -0.1 dB) → `dac~ 1 2`.
- No MC. For a fixed 5-voice allocation, explicit cos/sin panning is clearer.

### Pitch mapping (confirmed microtonal / continuous)

- `freq = min_hz * pow(max_hz/min_hz, x_normalized)`.
- Defaults: min_hz = 55, max_hz = 4186. ~6.25 octaves.
- Per-ball partial ratio (fixed): ball1=2.0, ball2=3.0, ball3=1.5, ball4=2.5, ball5=4.0. Distinct timbral fingerprint per ball without poly~ cost.

### Version / compatibility notes

- All core MSP objects (`cycle~`, `adsr~`, `*~`, `+~`, `gain~`, `limi~`, `dac~`, `mtof`, `ftom`, `curve~`) are pre-Max-8 and safe.
- Dada and Bach: `min_version: 8` — Max 9 target is fine.
- No package objects are `rnbo_compatible` — this patch is standalone, not RNBO-exportable.

### Alternatives considered

- `dada.bodies` over `dada.bounce`: gravitational N-body — wrong aesthetic.
- `bach.score` over `bach.roll`: metered staff notation — wrong fit for microtonal continuous output.
- Native dada playout (decision A): simpler, but forces "pitch lives on walls" model — rejected because per-ball pitch-from-position is the defining musical gesture of this patch.
- `cage.scale` + `bach.quantize`: discarded per microtonal decision.
- Plain `coll` + `multislider` score display: lighter but loses the piano-roll affordance.

### Open verification items (flag at build time)

Resolved:
- ~~bach.roll live-append~~ → separate inlets 1–4 + bang inlet 0.
- ~~bach.roll fit-to-view~~ → drive `zoom` attr programmatically.
- ~~dada.bounce start behavior~~ → `play`/`stop` or `int 1`/`int 0`.
- ~~dada.bounce gravity/elasticity~~ → doesn't exist; UI uses `playstep`/`ballsize`.
- ~~`notes` message llll~~ → `[pitch vel] [pitch vel] ...` per edge — unused in decision B.
- ~~Wall geometry message~~ → `llll bounce [room [VERTICES] [EDGES]] [balls ...]`.
- ~~`addball` syntax~~ → `addball [coord x y] [speed vx vy] [color r g b a]`.
- ~~Outlet 3 enable~~ → irrelevant (unused in decision B).
- ~~bach.roll MIDI-cent config~~ → default piano-roll mode accepts midicents directly.

Resolved 2026-04-17 via `bounce-outlet2-test.maxpat` live capture:
- ~~Outlet 2 delimiter shape~~ → nested key-tagged llll: `[ball N] [position X Y] [speed VX VY] [edge E] [component C]`.
- ~~Speed vector vs. scalar~~ → 2-component velocity vector (`[vx vy]`). `speedvel` attr does not affect this outlet.
- ~~Outlet 2 ball indexing~~ → 1-based ints; `edge` is also 1-based; `component` observed as always 1 in the captured run (semantics TBD if we hit multi-component geometry).

Still requires live help-patch observation:
- Auto-respawn behavior when a ball exits the room — is this default, or does it require a `flags` setting or wrap-around attribute? Test by giving a ball a velocity high enough to exit the V-funnel and watching whether it reappears. Low priority — worst case is a `clear balls` + re-`addball` on a timer.
