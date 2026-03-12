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

**Look up an object:** Read the domain JSON file and find the object by its name key. If unsure which domain, check `max/objects.json` first (largest domain), then `msp/`, `jitter/`, `mc/`, etc.

**Browse by domain:** List the keys in the relevant domain's `objects.json` to see all available objects.

**Check RNBO compatibility:** Read the `rnbo_compatible` field on any object. Only objects with `rnbo_compatible: true` can be used in RNBO patches.

**Resolve aliases:** Check `aliases.json` first. If the name is an alias, look up the canonical name in the appropriate domain file.

**Check common companions:** Look up the object name in `relationships.json` to find commonly paired objects.

**Check inlet/outlet counts:** Read the `inlets` and `outlets` arrays. For `variable_io: true` objects, compute actual counts from arguments using the `io_rule` field.

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
- Standard object spacing: ~80-120px vertical, ~150-200px horizontal

## Domain-Specific Rules

### MSP (Audio/Signal)

- Always terminate signal chains with `dac~` or `*~ 0.` (multiply by zero to mute)
- Use `*~ 0.5` or `*~` with `line~` for gain control -- never connect raw oscillators to `dac~` at full volume
- Signal objects (names ending in `~`) process at audio rate -- they are always "on" once connected
- Use `snapshot~` to convert signal values to control rate for display
- Use `meter~` or `levelmeter~` for audio level monitoring
- Multichannel: `mc.` prefix objects handle multiple channels -- use `mc.pack~`/`mc.unpack~` to convert between MC and individual channels

### Gen~ (GenExpr DSP Code)

- GenExpr uses C-style syntax with `in 1`, `in 2` for inputs and `out 1`, `out 2` for outputs
- Use `Param` for user-controllable parameters (maps to gen~ attributes)
- Use `History` for single-sample delay (feedback loops, state)
- `Buffer` and `Data` for sample data access
- Gen~ operates at sample rate -- every operation runs once per sample
- No conditional branching cost -- both branches always execute (SIMD-friendly)
- Codebox objects embed GenExpr in `.maxpat` patches; `.gendsp` files are standalone Gen~ patchers

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
