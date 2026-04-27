# MAX Development Framework

This file defines how Claude works with MAX/MSP patches and code in this project. Every rule here is mandatory. When generating patches, writing GenExpr, creating RNBO exports, or scripting with Node for Max / js objects, follow these rules exactly.

## Object Database

The object knowledge base lives at `.claude/max-objects/` with one subdirectory per domain:

```
.claude/max-objects/
  max/objects.json       # Control flow, data, UI (470 objects)
  msp/objects.json       # Audio/signal processing (248 objects)
  jitter/objects.json    # Video, matrix, OpenGL (210 objects)
  mc/objects.json        # Multichannel wrappers (215 objects)
  gen/objects.json       # Gen~ DSP and Jitter operators (189 objects)
  m4l/objects.json       # Max for Live objects (33 objects)
  rnbo/objects.json      # RNBO export-compatible objects (560 objects)
  packages/objects.json  # Package objects (87 objects)
```

Each domain file is a JSON object keyed by object name. Every object entry contains: `name`, `maxclass`, `module`, `domain`, `inlets` (array with id/type/signal/hot), `outlets` (array with id/type/signal), `arguments`, `messages`, `min_version`, `verified`, `rnbo_compatible`, `variable_io`.

### Supplementary Files

- **`overrides.json`** -- Expert corrections that take precedence over extracted data. Deep-merged onto base objects.
- **`aliases.json`** -- Common shortcuts mapped to canonical names (e.g., `t` -> `trigger`, `b` -> `bangbang`, `sel` -> `select`).
- **`relationships.json`** -- Common object pairings and companions (e.g., `tapin~`/`tapout~`, `notein`/`stripnote`).
- **`pd-blocklist.json`** -- Pure Data objects that do NOT exist in MAX, with their MAX equivalents.
- **`extraction-log.json`** -- Extraction metadata and statistics.

### How to Use the Database

**Primary method -- `ObjectDatabase`:** Use the `ObjectDatabase` class from `src.maxpat.db_lookup` for all object lookups. It loads all 8 domain files, resolves aliases, applies overrides, and checks the PD blocklist automatically.

```python
from src.maxpat.db_lookup import ObjectDatabase

db = ObjectDatabase()
obj = db.lookup("cycle~")                          # Returns object dict or None, auto-resolves aliases
db.exists("t")                                     # True (resolves alias to "trigger")
db.is_pd_object("osc~")                            # True (PD object, not MAX)
db.get_pd_equivalent("osc~")                       # "cycle~"
db.compute_io_counts("trigger", ["b", "i", "f"])   # (1, 3)
db.get_outlet_types("cycle~")                      # ["signal"]
```

**Browse by domain:** The raw JSON files at `.claude/max-objects/{domain}/objects.json` are still available for browsing all objects in a domain or bulk operations, but for individual lookups always use `ObjectDatabase`.

**Check common companions:** Look up the object name in `relationships.json` to find commonly paired objects.

**Verify lookup results have non-empty I/O.** Some DB entries (especially in `packages/`) were extracted with `inlets: []` and `outlets: []`. `lookup()` returns these as real hits, but the patch builder cannot connect them — they are indistinguishable from "missing" at the connection site. Treat empty-I/O entries as missing and populate them via `overrides.json`. Use `db.audit_empty_io()` to enumerate them. When a user reports an object "missing" you've used before, check both `lookup()` returns AND inlet/outlet lengths -- not just `exists()`.

**The `maxclass` field in the DB is NOT authoritative.** Most MAX objects (`gen~`, `click~`, `expr`, `expr~`, `pack`, `route`, etc.) use `maxclass: "newobj"` with the object name in the `text` field. Only true UI widgets (`button`, `toggle`, `dial`, `meter~`, `gain~`, `ezdac~`, `flonum`, `number`, `scope~`, `spectroscope~`, `levelmeter~`, `multislider`, etc.) use their own name as `maxclass` with no `text` field. The authoritative source is `UI_MAXCLASSES` in `src/maxpat/maxclass_map.py`, NOT the database's `maxclass` field. Setting `maxclass` to a non-UI name causes "invalid attribute maxclass" errors at load.

## Rules

### Rule #1: Never Guess Objects

THE cardinal rule. If an object is not in the database, DO NOT use it. Do not hallucinate object names, inlet counts, outlet counts, or behaviors from training data. If unsure, look it up. If it is not there, it does not exist for our purposes. Flag the gap with a comment: `// UNKNOWN OBJECT: [name] -- not in database, verify manually`.

This applies to everything: object names, argument formats, message names, attribute names, inlet/outlet counts. The database is the single source of truth.

### Rule #2: Verify Before Connect

Before creating any connection between objects, verify:
- Source object outlet index is within bounds (check outlet count, accounting for `variable_io` rules)
- Destination object inlet index is within bounds (check inlet count, accounting for `variable_io` rules)
- Signal type compatibility: signal outlets connect to signal inlets, control outlets to control inlets
- Exception: signal/float inlets accept both signal and control connections

Never connect outlet index 2 on an object that only has 2 outlets (indices 0 and 1). Always count from the database.

### Rule #3: Hot/Cold Inlet Ordering

When sending multiple values to an object:
- Send to cold inlets FIRST (right to left)
- Send to hot inlet LAST (leftmost, inlet 0) -- this triggers computation
- Use `trigger` (t) object for explicit fan-out ordering when timing matters
- Signal inlets are all "hot" in the audio domain -- ordering does not apply for MSP signal connections

Getting this wrong causes silent bugs where objects compute with stale values. Always use `trigger` for explicit ordering.

### Rule #4: Patch Style

- Top-to-bottom signal flow (audio flows down, control flows down)
- Use explicit `trigger` objects for fan-out instead of connecting one outlet to multiple inlets
- Add `comment` objects on non-obvious connections
- Prefer named `send`/`receive` (and `send~`/`receive~`) over long patch cords that cross the patch
- Use `patcher` (subpatchers) to organize complex logic into named sections
- Standard object spacing: ~20px vertical, ~15px horizontal gutter (matches defaults.py; user-confirmed tight spacing)

#### Multislider as Labeled Parameter Bank

When multislider bars represent labeled parameters (with comment labels alongside):
- Set `orientation: 0` (horizontal bars stacked vertically) explicitly
- Bar-to-label alignment formula: multislider height = `size * label_spacing` where label_spacing matches comment spacing (typically 24px for fontsize=10 labels)
- Comment labels start at the same Y as the multislider top, spaced at `ms_height / ms_size` intervals
- For fontsize=10 labels: use height=18, spacing=24px, so multislider height = size * 24
- Always set `contdata: 1` for real-time feedback during drag
- Always set `setstyle: 1` for bar display
- When adding utility/routing objects (prepend chains, init messages, js engines), encapsulate them in named subpatchers (`p drift`, `p settings`, etc.) to keep top-level patch clean
- Example extra_attrs for a 14-param bank: `{"size": 14, "setminmax": [0.0, 1.0], "orientation": 0, "contdata": 1, "setstyle": 1}`

**Reading values by index:** send `fetch $1` (NOT `fetchindex` -- it does not exist). The fetched value emerges from the **right** outlet (outlet 1); outlet 0 is for direct-edit/drag interaction. Don't insert `split` between multislider and the consumer -- multislider already emits the correct values, and `split` filters out valid step data.

### Rule #5: No Generator Scripts

Never create `generate.py` or similar intermediary Python scripts that regenerate `.maxpat` files from scratch. The Patcher API (`src.maxpat`) is the only sanctioned way to create and edit patches. Agents build Patcher instances in-memory during the `/max-build` or `/max-iterate` commands, then write via `save_patch_roundtrip()`. There is no separate generator script to maintain or re-run.

This rule exists because the generator pattern causes regeneration to overwrite manual edits and iterate improvements. It was deprecated in milestone 2.0.

### Rule #6: Z-Order Awareness

In `.maxpat` files, z-order is implicit: objects **earlier** in the `boxes` array render **on top** of later ones (index 0 = topmost).

- Background elements (panels, step markers): use `add_panel()` / `add_step_marker()` which set `background=1` to force behind all objects regardless of array position
- Overlay readouts (flonum on top of dial): use `bring_to_front(readout)` to move the readout to index 0 (renders on top)
- Overlay readouts must set `ignoreclick=1` so mouse events pass through to the interactive control underneath (unless the readout should be editable)
- Use `bring_to_front(box)` (index 0 = top), `send_to_back(box)` (end = bottom), or `set_z_index(box, index)` for explicit z-order control

The overlay readout pattern (from gen-eq):
1. Create the interactive control (e.g., `dial`)
2. Create the readout display (e.g., `flonum`)
3. Call `bring_to_front(readout)` to move it to index 0 (renders on top of dial)
4. Set `ignoreclick=1` on the readout so the dial remains interactive (omit for editable readouts)
5. Position the readout overlapping the dial (same or overlapping coordinates)

### Rule #7: Commit After Every Save

Every patch save MUST be committed to git. The `save_patch_roundtrip()`, `write_gendsp()`, and `write_js()` functions auto-commit via `auto_commit_patch()`. Do NOT rely on disk-only saves -- uncommitted work is vulnerable to loss from stash operations, branch switches, or concurrent instances.

**Prohibited:** `git stash` during any patch workflow. Three orphaned stashes containing significant patch work were discovered and recovered. Use `git commit` instead. If you need to context-switch, commit your current work first.

**Multi-instance safety:** When multiple Claude instances work on the repo simultaneously, each MUST only commit files within its active project directory. Never use `git add .` or `git add -A` during patch work.

### Rule #8: `replace_box()` Orphans Connections — Always Rewire

`Patcher.replace_box(old, new_name, args=...)` does NOT preserve connections. Every line touching `old_box` is captured as `EditResult.orphaned` and removed; the new box has the old position but no wires. The docstring is explicit: *"returns ALL old connections as orphaned (no auto-remap per CONTEXT.md locked decision). The caller handles rewiring."*

After every `replace_box` call, iterate `result.orphaned` and re-add the connections via `add_connection(...)`, mapping outlet/inlet indices through if the new object's I/O layout matches. If the I/O layout differs, manually rewire each connection. **Never assume connections survive a replace.** Silent disconnection from this trap has cost multi-version debugging cycles.

**Prefer `Patcher.replace_box_safe(old, new_name, args=..., rewire="auto")` for new code.** It delegates to `replace_box` internally, then auto-rewires every orphaned connection by index when the new box's I/O layout matches (same inlet AND outlet counts). On match, the returned `EditResult.orphaned` is empty — connections are preserved transparently. On I/O mismatch, it falls back to the existing orphan-return behavior so callers always have something to act on. Use `rewire="manual"` to opt back into the explicit-orphan workflow. The underlying `replace_box` is unchanged and still appropriate when you need to inspect or transform orphans before rewiring.

## Domain-Specific Rules

### MSP (Audio/Signal)

- Always terminate signal chains with `dac~` or `*~ 0.` (multiply by zero to mute)
- Use `*~ 0.5` or `*~` with `line~` for gain control -- never connect raw oscillators to `dac~` at full volume
- Gain safety: values feeding `*~` or `gain~` for volume control MUST be in the 0.0-1.0 range. Raw MIDI (0-127), slider, or number values must be normalized first (use `scale 0 127 0. 1.` or `/ 127.`). The validation pipeline and DSP critic will block output that violates this rule.
- Signal objects (names ending in `~`) process at audio rate -- they are always "on" once connected
- Use `snapshot~` to convert signal values to control rate for display
- Use `meter~` or `levelmeter~` for audio level monitoring
- Multichannel: `mc.` prefix objects handle multiple channels -- use `mc.pack~`/`mc.unpack~` to convert between MC and individual channels
- `line~` (signal-rate) **replaces** the active ramp on every new message. For multi-segment envelopes send a single space-delimited list (`$1 $2 0. $3` -- no comma). Comma-separated segments arrive as separate messages in the same scheduler tick and only the last takes effect (envelope never opens). Control-rate `line` queues comma-segments correctly; `line~` does not.
- `buffer~` has no `info` query and bare attribute names (`sizeinsamps`, `samplerate`) are setters, not getters. To read buffer contents/size, bridge through `fluid.buf2list` (FluCoMa: `buffer <name>` then `bang`) or `jit.buffer~` + `jit.matrixinfo` for dimensions. The right outlet only emits state after operations like `read`.
- `expr` and `expr~` do NOT have a `clip()` function. Use `min(max(x, lo), hi)` instead. `expr clip($f1, 0., 1.)` errors with "function clip not found".
- `floor~` is RNBO-only. In standard MSP use `trunc~` (equivalent for non-negative input -- covers `phasor * N` use cases). For signed input or true floor semantics, do the math in a Gen~ codebox where `floor` is native. Always check `domain` on DB lookups before using a tilde object at the top level.
- `umenu` items in `.maxpat` JSON use a comma-as-element format: `"items": ["LP", ",", "HP", ",", "BP", ",", "Notch"]`. Plain arrays and comma-separated strings both render as a single menu entry. Alternative: populate at runtime via `loadbang -> "clear, append X, append Y, ..."`.

### Gen~ (GenExpr DSP Code)

- GenExpr codebox uses C-style syntax with `in1`, `in2` for inputs and `out1`, `out2` for outputs (no space -- `in 1`/`out 1` is only for gen~ patcher objects, not codebox code)
- Use `Param` for user-controllable parameters (maps to gen~ attributes)
- Use `History` for single-sample delay (feedback loops, state)
- For longer delay lines, declare `Delay myDelay(max_samples);` then use `myDelay.write(x)` / `myDelay.read(t)`. **The `delay()` function is NOT supported in codebox** -- it is only valid in gen~ patcher (visual) mode. MAX errors with "The delay() operator is not supported in GenExpr; use the Delay.read and Delay.write instead." Multiple reads from the same Delay at different positions are allowed (e.g., dual-tap pitch shifter)
- `Buffer` and `Data` for sample data access
- Gen~ operates at sample rate -- every operation runs once per sample
- No conditional branching cost -- both branches always execute (SIMD-friendly)
- Variables used inside `if`/`else` blocks must be initialized before the block, otherwise GenExpr errors with "not defined"
- Codebox objects embed GenExpr in `.maxpat` patches; `.gendsp` files are standalone Gen~ patchers
- **Declaration ordering**: ALL declarations (`Param`, `History`, `Delay`, `Buffer`, `Data`) MUST appear before ANY expressions or assignments. gen~ will refuse to compile code with declarations after expressions. The `add_gen()` method auto-reorders declarations, but always write code with declarations at the top: Params first, then Delay, then History, then Buffer/Data, then all expressions.
- **Setting Param values from MAX:** send `param_name $1` messages to the gen~ inlet (NO `@` prefix). `@param_name $1` is attribute syntax and does NOT work with gen~ -- gen~ matches the first symbol against Param names directly. Use `attrui` connected to gen~ for an auto-generated all-params interface.

### Subpatcher Inlet/Outlet Access

When connecting to inlet/outlet objects inside a subpatcher created by `add_subpatcher()`, use `get_inlets()` / `get_outlets()` to access them by index. Do NOT search by `box.text` -- all inlet objects have identical text `"inlet"` and all outlet objects have identical text `"outlet"`.

```python
_, inner = p.add_subpatcher("control", inlets=4, outlets=2)
inlets = inner.get_inlets()   # [inlet_0, inlet_1, inlet_2, inlet_3]
outlets = inner.get_outlets()  # [outlet_0, outlet_1]

# Connect to the third inlet (index 2)
inner.add_connection(some_box, 0, inlets[2], 0)
```

**No `inlet~` / `outlet~` objects exist in MAX.** Always use `inlet` / `outlet` (maxclass `"inlet"` / `"outlet"`); the signal-vs-control distinction is determined entirely by what connects to them. Creating a `newobj` with text `inlet~` or `outlet~` fails with "No such object".

**Label inlets/outlets via the `comment` attribute** (MAX's "Assistance" field, shown as a mouseover tooltip in the parent patcher), NOT freestanding `comment` objects. Set it through `extra_attrs={"comment": "Audio Input Left"}`. Comment boxes near inlets clutter the patch; the `comment` attribute is the proper MAX convention.

### RNBO (Export-Ready Patches)

- ONLY use objects with `rnbo_compatible: true` in the database
- RNBO uses `rnbo~` as the container object (like `gen~` but for full patches)
- RNBO patches must be self-contained -- no external file dependencies for export targets
- Export targets: VST3/AU (plugin), Web Audio (browser), C++ (embedded)
- Some RNBO objects have different behavior than their MAX counterparts (e.g., different outlet count) -- check the `rnbo/` domain objects for RNBO-specific definitions
- `param` objects in RNBO map to plugin parameters for VST3/AU export

### Node for Max (N4M / node.script)

- `node.script` objects run Node.js -- use `const maxAPI = require('max-api')` for MAX communication
- `maxAPI.addHandler('message_name', callback)` to receive messages from MAX
- `maxAPI.outlet(value)` to send data back to MAX
- `maxAPI.post('message')` for console output visible in MAX
- `maxAPI.getDict('dict_name')` and `maxAPI.setDict('dict_name', data)` for Dict access
- `node.script` has a single inlet (messages) and configurable outlets
- Use for: file I/O, network requests, complex data processing, anything Node.js does better than MAX

### js (V8 JavaScript / js object)

- `js` object runs V8 JavaScript inline in MAX
- `inlets = N` and `outlets = N` to configure I/O count
- Handler functions: `bang()`, `msg_int(v)`, `msg_float(v)`, `list()`, `anything(msg, args)`
- `outlet(outlet_index, value)` to send data
- `post('message')` for console output
- Access patcher: `this.patcher.getnamed('object_name')`
- Use for: UI logic, data transformation, algorithmic composition, anything needing scripted control

### Max for Live (M4L / .amxd)

- **No `gain~` / `live.gain~` / `ezdac~` before `plugout~`.** Ableton's channel strip handles volume; an extra gain stage is redundant and `gain~` defaults to 0 (silence on load). Route the final signal-processing stage directly to `plugout~`. Volume, pan, and mute live in Ableton's mixer.
- **`live.dial` / `live.slider` bind to gen~ Params via `param_connect`, not message-box patching.** Set `param_connect: "<gen~_varname>::<param_name>"`, `parameter_enable: 1`, plus the `saved_attribute_attributes.valueof` block (`parameter_initial`, `parameter_longname`, `parameter_shortname`, `parameter_mmin`, `parameter_mmax`, `parameter_modmode`, `parameter_type`, `parameter_unitstyle`). The gen~ object MUST have a stable `varname` matching the prefix in `param_connect`. No patch cord between the dial and gen~ -- `param_connect` IS the binding.
- Without `param_connect`, the dial passes values via message routing but does NOT appear in Live's parameter list and is not Live-automatable.
- **Slider -> line~ -> gen~ signal-rate exception:** when a slider feeds a signal inlet via `line~`, you cannot use `param_connect` (it only binds to Params, not signal inputs). Keep the `slider -> line~ -> gen~` signal path and add `parameter_enable: 1` + `saved_attribute_attributes.valueof` to the slider itself so Live still sees it as a standalone live.parameter. Its value flows through `line~` to the signal inlet while remaining Live-automatable.

## PD Confusion Guard

Check `.claude/max-objects/pd-blocklist.json` before using any unfamiliar object. Common confusions:
- `osc~` is PD -- use `cycle~` in MAX
- `lop~` is PD -- use `onepole~` in MAX
- `hip~` is PD -- use `onepole~` (with inversion) in MAX
- `bp~` is PD -- use `reson~` in MAX
- `tabread~` is PD -- use `index~`, `play~`, or `wave~` in MAX
- `throw~`/`catch~` is PD -- use `send~`/`receive~` in MAX

If you are about to use an object with `~` that is not in the database, check the PD blocklist for the MAX equivalent.

## Version Compatibility

All patches target MAX 9. This is the required version for all projects -- do not ask users to choose a version.

- Check `min_version` field before using objects
- MAX 9 objects (`array.*`, `string.*`, `abl.*`): only available in MAX 9+
- MC objects (`mc.*`): available from MAX 8.1+

## Bpatcher and Abstraction Arguments (`#N` Substitution)

When a `.maxpat` file is loaded as a bpatcher (or abstraction), MAX substitutes `#1`, `#2`, etc. with the arguments passed via the bpatcher's `args` attribute.

**Critical rule: `#N` must be a standalone token in the object text, never embedded in a compound string.**

```
WRONG:  buffer~ slot-#1          (compound -- #1 embedded in "slot-#1")
RIGHT:  buffer~ #1               (standalone -- pass "slot-1" as the arg)

WRONG:  send~ slot-#1-out        (compound)
RIGHT:  send~ #2                 (standalone -- pass "slot-1-out" as second arg)
```

When a bpatcher instance needs multiple distinct names (e.g., a buffer name and a send name), pass each as a separate argument and use `#1`, `#2`, etc. as standalone tokens:

```json
"args": [ "slot-1", "slot-1-out" ]
```

Inside the subpatch, use `#1` and `#2` directly:
- `buffer~ #1` becomes `buffer~ slot-1`
- `send~ #2` becomes `send~ slot-1-out`

This applies equally to newobj boxes and message boxes (`set #1`, `setbuffer #1`).

**Comment boxes do NOT perform `#N` substitution.** Only `newobj` and `message` boxes do. Putting `#1` (or `Bus #1`) in a `comment` box's text leaves the literal string in place. For dynamic labels in bpatchers, use a `loadbang` -> `message "set Label #1"` -> `comment` chain: the message box performs the substitution and sends `set` to update the comment's display text.

## Variable I/O Objects

Some objects change inlet/outlet count based on arguments. Check `variable_io` and `io_rule` fields:
- `trigger b i f` has 3 outlets (not the default 2)
- `pack 0 0 0 0` has 4 inlets (not the default 2)
- `route foo bar baz` has 4 outlets (3 match + 1 unmatched)

Always compute actual I/O count from arguments when generating connections. The default counts in the database are for the no-argument case.

## File Conventions

- Patches: `.maxpat` (JSON format)
- Gen~ patches: `.gendsp` (JSON format, similar structure to .maxpat)
- Node for Max: `.js` files referenced by `node.script` object
- js object: `.js` files referenced by `js` object
- Externals: `.mxo` bundles (macOS)
- Projects: `.maxproj` (project container)
