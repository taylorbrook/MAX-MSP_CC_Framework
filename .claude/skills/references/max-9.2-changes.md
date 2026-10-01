# Max 9.2 Changes

> On-demand reference for patch and code generation. Synced 2026-10-01 against the installed bundle `Max 9.2.0 (e9c80e453de)` by quick task 261001-hwb.
> Path: `.claude/skills/references/max-9.2-changes.md`. `C74/` below means `/Applications/Max.app/Contents/Resources/C74/`.

## Evidence tiers

Every claim here carries one tier. Nothing in this file comes from memory.

- **[bundle]** — read from a file under `/Applications/Max.app` (refpage, help patch, objectmappings, example, user guide).
- **[db]** — follows from the object database as synced by `tools/sync_max_bundle.py`.
- **[notes]** — stated only by the Max 9.2.0 release notes. Unverified. **Do not rely on a [notes] item without a test in MAX**, and never invent an argument form, enum value or API name for one.

Nothing in this file has been run in MAX 9.2. [bundle] means "Max ships a file that says so", not "confirmed working".

## New objects (12) — all `min_version: 9.2`, `maxclass: newobj` [db]

| Object | Home | In / Out | Outlet types (DB) | Source of shape |
|---|---|---|---|---|
| `dspstress~` | `msp` | 1 / 0 | — | refpage (inlet "Specify cpu usage % here", methods `int` `float` `signal`); digest/description are unfilled templates [bundle] |
| `jit.web` | `jitter` | 1 / 2 | matrix, control | refpage + help box [bundle] |
| `jit.web~` | `jitter` | 1 / 4 | signal, signal, matrix, control | counts from refpage, types from help box (refpage types all four `signal`) [bundle] |
| `jit.gl.web` | `jitter` | 1 / 2 | control (`jit_gl_texture`), control | `max define jit.gl.web jit.web output_texture;` + help boxes in `jit.web.maxhelp`; no refpage [bundle] |
| `jit.gl.web~` | `jitter` | 1 / 4 | signal, signal, control (`jit_gl_texture`), control | `max define jit.gl.web~ jit.web~ output_texture;` + help box in `jit.web~.maxhelp`; no refpage [bundle] |
| `abl.device.reverb2~` | `packages/ableton-dsp` | 4 / 2 | signal ×2 | refpage: L, R, decaytime, size in; L, R out [bundle] |
| `abl.device.stereocompressor~` | `packages/ableton-dsp` | 6 / 3 | signal ×3 | refpage: L, R, attack, release, threshold, gain in; third outlet has no digest [bundle] |
| `abl.dsp.djfilter~` | `packages/ableton-dsp` | 4 / 1 | signal | refpage: input, control, resonance, drive in [bundle] |
| `jit.message` | `packages/jit.mo` | 1 / 2 | control ×2 | counts from help box (refpage declares none); optional `message` argument [bundle] |
| `jit.path.ui` | `packages/Jitter Tools` | 1 / 4 | matrix ×2, control ×2 | refpage + help box [bundle] |
| `jit.unpack.geomat` | `packages/Jitter Tools` | 1 / 5 | matrix ×4, control | `max define jit.unpack.geomat jit.unpack 4 @jump 3 2 3 4 @offset 0 3 5 8;` — its refpage's name attribute is the typo `jit.unpackl.gl` [bundle] |
| `jit.gl.tex2mat` | `packages/Jitter Tools` | 1 / 1 | matrix | `max define jit.gl.tex2mat v8 jit.gl.tex2mat.js;` — its refpage's name attribute is `v8`; optional `dimensions` list argument [bundle] |

- `jit.gl.web` / `jit.gl.web~` inherit their message and attribute lists from `jit.web` / `jit.web~` in the DB; whether every inherited name applies to the texture variant is unverified. [db]
- `ObjectDatabase.get_outlet_types()` emits `""` for matrix and texture outlets, as for every other Jitter object. [db]
- The page-side JavaScript calls `bindJitterMatrix(onMatrix)`, `bindJitterImage(onImage)`, `getJitterMatrix(inName, cb)` and `setJitterMatrix(outName, m)` appear in the web pages under `C74/packages/Jitter Tools/media/` (`matrix.webgl.html`, `matrix.roundtrip.invert.html`) and are mentioned in `C74/help/jitter/jit.web.maxhelp` [bundle]. They run inside the web page, not in the patch, and are not on the `jit.web` refpage — read those files before writing page code.

## Existing objects: 9.2-only messages and attributes

Names below are in the DB after the sync [db] and are documented by the 9.2 refpage [bundle]. They are **not version-tagged** — the schema stores plain name lists — so a patch that must open on an older 9.x build must avoid them.

| Object | Messages | Attributes |
|---|---|---|
| `buffer~` | `replacechannel`, `replacechannel_samples`, `trim`, `trim_samples` | `url` |
| `udpsend` | `string` | `active`, `host`, `port` |
| `udpreceive` | — | `active`, `port`, `usestring` |
| `coll`, `coll.codebox` | `minany`, `maxany` (no arguments) | — |
| `pattrstorage` | `getstate`, `setstate` | — |
| `sfrecord~`, `mc.sfrecord~` | `start` (notes name only `start`; `stop` landed with it) | — |
| `seq` | `insert` (refpage text is an unfilled template — argument form unknown) | — |
| `dict.pack` | `clear`, `reset` | — |
| `dict.deserialize` | `string` | — |
| `dict.serialize` | — | `stringmode` |
| `fftin~` | `updatewindow` | — |
| `fftout~` | `copyinput`, `copyoutput`, `updatewindow` | — |
| `jweb` | `bang`, `int`, `float`, `list`, `jit_matrix` | — |
| `mousefilter` | — | `button` |
| `rslider` | — | `inputrangemode` |
| `abl.device.spectralresonator~` | — | `quantize` (0 / 1) |
| `abl.dsp.saturator~` | — | `bassthreshold` (threshold of the Bass Shaper curve) |
| `jit.anim.node` | — | `scalemode` (`local`, `parent`) |
| `jit.gl.asyncread` | — | `adapt`, `dim` |
| `jit.gl.mesh` | — | `usebvh` |
| `jit.gl.model` | — | `concat_geometry` |
| `jit.gl.multiple` | `texcoord_matrix` | — |
| `jit.gl.textmult` | `outputlayoutmatrix` | — |
| `jit.gl.textureset` | — | `insert` (the notes call it a message; the refpage documents an attribute) |
| `jit.gl.meshwarp` | `maskfeatherat`, `maskfeathercurveat`, `scalemaskat` | `checkerboard`, `checkerboardscale`, `edgeblend{left,right,top,bottom}`, `edgeblendcurve{left,right,top,bottom}`, `maskfeather`, `maskfeathercurve`, `scalemask` |

**DB gaps closed by the same sync, not named by the release notes** (documented by the installed bundle, so not necessarily new in 9.2) [db]: `buffer~` `crop_samples`; `cycle~` / `mc.cycle~` attr `buffer_autoupdate`; `abl.dsp.darkhall~` / `prism~` / `quartz~` / `shimmer~` / `tides~` attr `freezein`; `jit.gl.mesh` attr `instances`; `jit.gl.textmult` attrs `line_length`, `leadscale`, `tracking`, `fontname`, `depth`, `weight`, `slant`; `jit.gl.pass` / `jit.gl.shader` / `jit.gl.slab` msg `open`; `jit.gl.pbr` (15 messages, 34 attributes); `jit.fx.rota` (10 attributes); `jit.movie` `frame_coarse`, `jump_coarse`, attr `seamless_loopcount`; `live.scope~` (`bang` + 17 attributes); `max` `closedspstatus`, `closepreferences`; `paraminspector` attr `_parameter_visible_undoable`; `textbutton` attr `usegradient`.

**Release-note features with no DB entry** — the schema has no place for enum values or message arguments, or the bundle does not document them:

- `function` attr `mousemode` enum is `Free`, `Shift`, `Reorder` [bundle].
- `nrpnin` attr `hires` enum is `Off`, `MSB first`, `MSB output`, `Output any` [bundle].
- `gen~` attr `gen` carries `alias="file"` in its refpage, i.e. `@file` = `@gen` [bundle].
- `detonate`: `export [filename] [time] [file-format] [tempo]`, `write [filename] [tempo]`, all optional [bundle]; a time value of `2` selecting ms export is [notes].
- `thispatcher` `showparameterwindow` followed by 1 or 0 is described in the refpage [bundle] but is not in the DB message list (it sits in an entry list, not a method element).
- `alpha_mode` is listed as an attribute in 23 bundled Jitter refpages [bundle] and is not in the DB; the `alpha_blend` attribute named by the notes appears in no bundled refpage [notes].
- [notes] only, nothing found in the bundle: `dict.compare` `@fuzzy`; `expr` / `vexpr` "constants functionality a la Gen"; `maxurl` `streaming_buffering`; `thisobject` support for Jitter objects; `pattr` / `pattrstorage` array / string / dict handling; `jit.fft` arbitrary-sized input; `jit.proxy` `getattribute` / `getstate` / `getparam*`; `jit.gl.pbr` line and quad rendering; `jit.fx` `bang`; scrambler / sharktooth / Bass Shaper are enum entries (`Scrambler`, `Sharktooth`, `Bass Shaper` appear in the ABL refpages [bundle]) — look the enum up before using one.

## buffer~

Argument forms exactly as `C74/docs/refpages/msp-ref/buffer~.maxref.xml` declares them [bundle]. `[x]` = optional.

| Message | Arguments | Effect per the refpage |
|---|---|---|
| `replacechannel` | dst-channel (int), [src-file (symbol)], [src-channel (int)], [src-offset ms (float)], [src-duration ms (float)], [resize-to-src-duration flag (int)] | Copy one channel to another in the same buffer, or from an external file when src-file is given. Data lands at the start of the dst channel; existing contents are zeroed. |
| `replacechannel_samples` | same, offset and duration as int | Same, in samples (the refpage labels these two args "(ms)" but describes them as samples). |
| `trim` | [start-pad ms (float)], [end-pad ms (float)], [reference-channel (int)] | Remove leading and trailing silence, optionally add padding, resize the buffer. No channel given = analyse all channels. |
| `trim_samples` | [start-pad (int)], [end-pad (int)], [reference-channel (int)] | Same, in samples. |
| `crop_samples` | start and end (list, samples) | Crop to a selection and resize. Not named by the notes. |

- Attribute `url` (symbol, get / set): digest "Remote URL"; the description is an unfilled template, so accepted schemes and load timing are unknown [bundle].
- **Retain-on-resize argument is [notes] only.** The notes say `setsize` / `sizeinsamples` take an extra argument that keeps the previous contents. The 9.2 refpage still documents `setsize <ms> [channels]` and `sizeinsamps <samples> [channels]` with no such argument, and the message is spelled `sizeinsamps`, not `sizeinsamples` [bundle]. Do not generate it until tested.
- CLAUDE.md's standing rule is unchanged: `buffer~` has no `info` query and bare attribute names are setters.

## udpsend / udpreceive

- `udpsend`: object arguments `host` (symbol) and `port` (int) are still declared, both non-optional [bundle]. New attributes `host` (symbol), `port` (int, 1–65535) and `active` (int, enabled by default; when off the object "won't send any data") [bundle]. New message `string` — "A string object will be parsed and sent as string data" [bundle].
- `udpreceive`: object arguments `port` (int) and an optional full-packet symbol [bundle]. New attributes `port` (int, 1–65535), `active` (int, enabled by default) and `usestring` (int — "string data will be output as a string object, bypassing Max's symbol table") [bundle].
- The 9.2 refpages no longer list `port` / `host` as *messages*; the DB keeps the old message names because they are valid on older builds [db]. Existing patches that send `port N` / `host X` need no change.

## v8

**Object scope.** The notes attribute every item here to "the v8 object". The bundle distinguishes two engines [bundle]: `v8` = "Execute Javascript (Modern Engine)", ECMAScript 6+; `js` = "Execute Javascript (Legacy Engine)", ECMAScript 5. `v8ui` and `v8.codebox` are the Modern-Engine UI and codebox objects; `jsui` is Legacy. The bundled 9.2 examples run in `v8.codebox` (all seven network patches), `v8` and `v8ui` (the FFT examples). Nothing in the bundle shows these additions in `js` / `jsui` — treat them as `v8`-family only.

| Addition | Identifiers seen in bundled examples | Tier |
|---|---|---|
| fetch | `await fetch(url)`, `fetch(url, { method, headers, body })`, `response.ok`, `response.status`, `response.json()` | [bundle] `v8_simple_fetch_example.maxpat` |
| HTTP client / server | `require('http')`, `http.get(url, cb)`, `http.request(options, cb)`, `http.createServer((req, res) => …)`, `server.listen(port, cb)` | [bundle] `v8_simple_http_client_example.maxpat`, `v8_simple_http_sever_example.maxpat` (sic) |
| TCP | `require('net')`, `net.createConnection({ port, host }, cb)`, `net.createServer(cb)`, `socket.on('data' / 'end' / 'error')` | [bundle] `v8_simple_tcp_example.maxpat` |
| UDP | `require('dgram')`, `dgram.createSocket('udp4')`, `.bind()`, `.send()`, `.on('message', (msg, rinfo) => …)`; byte buffers are **`IOBuffer.from(...)`** because `Buffer` is Max's audio-buffer class | [bundle] `v8_simple_udp_example.maxpat` |
| WebSocket | `new WebSocket(url)` with `onopen` / `onmessage` / `onclose` / `onerror`; `new WebSocketServer({ port, host })` with `.on("connection" / "listening" / "error" / "close")` | [bundle] `v8_simple_websocket_example.maxpat` |
| XMLHttpRequest | `new XMLHttpRequest()`, `.open()`, `.setRequestHeader()`, `.responseType`, `.onload`, `.onerror`, `.send()` | [bundle] `v8_simple_xhr_example.maxpat` |
| Console | `console.log(...)`, `console.error(...)` | [bundle] all seven network examples |
| `MaxFFT` | `new MaxFFT(size, { normalize: true, spectrum: "unpacked" })`, `MaxFFT.alloc(size)`, `fft.forward(frame)`, `fft.inverse(spectrum, frame)`, `MaxFFT.isFastSize(n)`, `MaxFFT.nearestFastSize(n, "real", bool)` | [bundle] `Examples/javascript/v8-fft/*.js` |
| `MaxFFT2D` | `new MaxFFT2D(rows, cols, { type: "complex", precision: "float32", normalize: true })`, `MaxFFT2D.isFastSize(rows, cols, "complex")`, `.forward()`, `.inverse()` | [bundle] `v8-maxfft2d-jitter-gate.js` |
| Engine 14.6 (changelog: 14.6.202) | — | [notes] |
| Native timers `setTimeout`, `setInterval`, `setImmediate`, `queueMicroTask` (spelling as in the notes) | none — no bundled v8 example calls them | [notes] |
| `toJSON()` on Dict, MaxArray, MaxString | none | [notes] |
| Named pipes | none | [notes] |

- **Timers conflict.** The user guide shipped inside the 9.2 bundle (`C74/docs/userguide/content/javascript.json`) still says timing functions like `setImmediate` and `setTimeout` "are not available" and to use `Task` instead [bundle]. That contradicts the release notes. Until tested in MAX, keep using `Task` for timing.
- Only the option values listed above were seen. Other option keys, other event names and the full method set of `MaxFFT` are not established — read the bundled example before writing code against it.
- Network clients and servers go into generated code only when the task explicitly asks for them. `node.script` remains the choice when a patch must run on a build older than 9.2.

## Gen

- [notes] The `require` system "was substantially improved: nested requires now work, and required gendsp files can reliably be used as functions from codeboxes". The bundled user guide (`gen/gen_genexpr.json`) documents `require` for `.genexpr` files [bundle]; requiring `.gendsp` files is [notes].
- [notes] Compiler-correctness fixes: dead code elimination removing live code, over-aggressive constant folding and variable collapsing, variable-renaming and aliasing collisions, handling of stateful / side-effecting operators (`poke`, `latch`, `counter`).
- **None of CLAUDE.md's gen~ rules is retired.** These fixes plausibly touch the hoisting and aliasing failures the rules work around, but no rule has been re-tested on 9.2 and patches must still compile on older 9.x builds on other machines. De-hoisting with `History one(1)`, no local aliases in Param-only expressions, the codebox safe-construct set, constant-name avoidance and declaration ordering all stay in force until each is individually re-verified in MAX and recorded in CLAUDE.md.

## Patcher format

- [notes] "patch cords can now be in the background layer."
- The JSON key for that is **unknown**. All 48 patches in the bundle saved by 9.2 (`appversion` 9.2.x, of 3,948 scanned) use only the patchline keys `source`, `destination`, `midpoints`, `order`, `hidden`, `color` [bundle]. No patch in this repo has been re-saved by 9.2. Do not guess the key.
- Unknown keys are already safe: `Patcher.from_dict` → `to_dict` preserves them through `_raw`, and `tests/test_round_trip.py::TestUnknownKeyTolerance::test_unknown_keys_survive_round_trip_and_validation` proves a synthetic unknown key on a patchline, a box and the patcher survives round-trip and `validate_patch`.
- Generator output is unchanged: new patches are still written with `appversion` 9.0.0.

## Fixed bugs that touch this repo's guidance

All [notes]. "No change" means the repo rule stands as written.

| Fix | Guidance it touches | Change |
|---|---|---|
| Param Connect: short name no longer overridden when loading or pasting | CLAUDE.md M4L `param_connect` rule (`parameter_shortname` in `saved_attribute_attributes`) | No change — keep setting both names explicitly |
| `jweb`: `window.max.outlet()` now outputs single-argument messages | none (no jweb guidance) | No change |
| `counter`: fixed internal state before any output | skills use `counter` in examples | No change |
| `sfrecord~`: correct sample rate used for saved files | none | No change; `start` message is new (above) |
| `preset`: captures MC attributes | none for the `preset` object | No change |
| `mc.mixdown~`: `pans` no longer changes when `pancontrolmode` changes | no rule; `patches/granularsynthtest` and `patches/ji-harmonizer` use `mc.mixdown~` | No change; re-check those two if panning differs on 9.2 |
| `mc.record~`: inlets properly created; `stepfun~`: fixed right signal outlet | DB I/O | No change — DB already 3 / 1 and 2 / 2, equal to the 9.2 refpages [db] |
| `pattrstorage`: outputmode 1 / subscribemode 1, client registration | skills mention pattrstorage | No change |
| `live.gain~`: automation dot drawing | CLAUDE.md M4L "no `live.gain~` before `plugout~`" | No change |
| `loadbang`: defeating disabled when opening help files | CLAUDE.md loadbang chains | No change |
| poundsign arguments: suppress "bad number" errors | CLAUDE.md `#N` rules | No change — standalone-token and JSON-number rules stay; the message it suppresses is not the "bad arguments creating object" error those rules prevent |
| `rnbo~`: CPU spike when typing a space in the object box | editor only | No change |
| `dac~`: fixed `wclose` | none | No change |
| `v8`: XMLHttpRequest callbacks, Task `this` binding, `dict.set()` arbitrary classes, crash fixes | js guidance | No change |
| `udpsend`: port 0 regression, large packets | none | No change |

## No repo impact

- Monaco Editor (Windows support, find / replace, completions, 32k truncation) — editor only.
- Parameter Window (OSC attributes, undo / redo, revert names) — editor UI; nothing generated depends on it.
- Themes / menubar colour, Sidebar, Clue Bar, autocompletion scrolling, Find in Patch — editor only.
- Windows Media Foundation video engine, `jit.dx.grab` OBS support, Windows installer (Inno Setup), Windows menubar / font fixes — Windows only; this repo targets macOS.
- `bpatcher` box sizing when typing a filename, Inspector / Preferences / Save dialog fixes — interactive editing only.
- Standalone / collective / Project packaging fixes, `vst~` / `amxd~` crash fixes, audio-driver fixes — runtime stability, no generation rule.

## Check in MAX before relying on it

1. Instantiate each of the 12 new objects and confirm inlet / outlet counts match the table above.
2. `jit.web~` and `jit.gl.web~`: outlet order (audio L, audio R, matrix or texture, dumpout).
3. `jit.gl.web`: whether the message list inherited from `jit.web` is right for the texture variant.
4. A gen~ codebox that today needs the de-hoist workaround (`History one(1)`), compiled without it on 9.2 — and on an older 9.x build before any rule is relaxed.
5. `buffer~ trim` and `replacechannel`; whether `setsize` / `sizeinsamps` accept a retain argument and in which position.
6. `v8`: `setTimeout` / `setInterval` (release notes say yes, bundled user guide says no), `toJSON()` on a Dict, one network example.
7. `udpsend` / `udpreceive` with `@port`, `@host`, `@active` as attributes.
8. Save a patch with one patch cord in the background layer, commit it, and read the new patchline key from the committed JSON.

## Keeping the DB in step with Max

After any Max update: `python3 tools/audit_db.py`, then `python3 tools/sync_max_bundle.py` (dry-run report), then `--apply new|define --names <explicit names>` and `--apply deltas`. The tool is additive, idempotent and cannot write `overrides.json`.
