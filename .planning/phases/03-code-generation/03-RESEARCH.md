# Phase 3: Code Generation - Research

**Researched:** 2026-03-09
**Domain:** GenExpr DSP code, js/V8 scripts, Node for Max JavaScript, .gendsp format, code validation
**Confidence:** HIGH

## Summary

Phase 3 extends the existing patch generation framework (Patcher/Box/Patchline model from Phase 2) to handle three code generation domains: Gen~ GenExpr DSP code, Node for Max JavaScript, and js object V8 JavaScript. The core challenge is embedding code correctly inside MAX's JSON structures (codebox inside gen~ patcher, js file references, node.script file references) while providing syntax validation that catches errors offline.

The existing codebase provides strong foundations: ObjectDatabase has 189 Gen~ operators for validation, the Patcher model already supports nested patchers (add_subpatcher), and the hooks system supports file write triggers. Key gaps to address: gen~ and js maxclass resolution (both incorrectly resolve to "newobj" instead of their own maxclass), node.script is absent from the database entirely, and no codebox JSON structure exists yet.

**Primary recommendation:** Build gen~ codebox embedding as a dedicated `add_gen` method on Patcher (analogous to add_subpatcher), implement GenExpr validator against gen/objects.json operators, extend hooks.py for .gendsp and .js validation triggers, and fix maxclass resolution for gen~, js, and gen.codebox~.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- GenExpr code style: well-commented with section headers, full Param range specs (min/max/default), section-block organization, descriptive variable names
- Codebox embedded in gen~ inside .maxpat is the default; standalone .gendsp only when explicitly requested
- .gendsp files contain codebox with GenExpr + in/out objects only -- no visual Gen~ operator layout
- Single codebox per gen~ object -- all DSP logic in one GenExpr block
- Node for Max is the primary JavaScript target; js (V8) gets secondary support (core handlers only)
- CommonJS module format for N4M: `const maxAPI = require('max-api')`
- Error logging on async operations: try/catch with maxAPI.post()
- Dict access patterns included when task involves structured data
- Both js and N4M auto-create corresponding boxes in .maxpat
- GenExpr validation: syntax + operator verification against gen/objects.json (189 operators)
- GenExpr validates: in/out declarations, Param declarations, operator existence -- skips variable liveness and type inference
- js validation: inlets/outlets declarations match handler count, outlet() index within bounds, required handlers present
- N4M validation: require('max-api') present, addHandler names are strings, maxAPI.outlet() called
- Report-only validation -- no auto-fix of code
- Auto-hook on file write: .gendsp triggers GenExpr validation, .js triggers js/N4M validation

### Claude's Discretion
- gen~ codebox API design (dedicated add_gen method vs generic Box with code attr vs other approach)
- GenExpr validator implementation architecture
- js/N4M validator implementation details
- Hook system extension approach for new file types

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| CODE-01 | Gen~ GenExpr code generation with correct syntax (in/out keywords, Param declarations, C-style operators) | GenExpr syntax fully documented: in/out keywords, Param with min/max/default, C-style ops, if/else/for/while, History, Buffer, Data. 189 gen operators in database for validation. |
| CODE-02 | Gen~ codebox objects embedded correctly in .maxpat patches | Codebox JSON structure researched: `maxclass: "codebox"`, `code` attribute holds GenExpr, embedded inside gen~ inner patcher alongside `in` and `out` objects. gen~ uses own maxclass (not "newobj"). |
| CODE-03 | Standalone .gendsp file generation for Gen~ patchers | .gendsp is JSON identical to .maxpat structure with patcher wrapper, codebox box, in/out boxes, and patchlines. Same DEFAULT_PATCHER_PROPS can be reused. |
| CODE-04 | Node for Max (node.script) JavaScript generation with MAX API integration | max-api module documented: addHandler, outlet, outletBang, post, getDict, setDict, updateDict. node.script not in database (needs handling). CommonJS require pattern. |
| CODE-05 | js object V8 JavaScript generation with patcher API access | js object in database with maxclass "js". Handlers: bang(), msg_int(), msg_float(), list(), anything(). inlets/outlets declarations, outlet(index, value). |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python | 3.12+ | Implementation language | Project standard from Phase 1-2 |
| pytest | 9.0.2 | Test framework | Already installed and configured |
| json (stdlib) | - | JSON serialization for .maxpat/.gendsp | Used throughout project |
| re (stdlib) | - | GenExpr syntax parsing/validation | Lightweight regex for operator extraction |
| pathlib (stdlib) | - | File path handling | Used throughout project |

### Supporting
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| textwrap (stdlib) | - | Code formatting | For GenExpr code indentation/cleanup |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| Custom regex parser for GenExpr | PLY/pyparsing AST parser | Overkill -- GenExpr validation is operator/keyword checking, not full compilation. Regex + string parsing sufficient for the scope defined (no type inference, no liveness). |

**Installation:**
No new dependencies needed. All stdlib.

## Architecture Patterns

### Recommended Project Structure
```
src/maxpat/
  __init__.py          # Extended public API (add gen/js/n4m exports)
  patcher.py           # Extended: add_gen(), add_js(), add_node_script()
  validation.py        # Extended: code validation layers
  hooks.py             # Extended: .gendsp and .js file write hooks
  codegen.py           # NEW: GenExpr code builder, js/N4M code builder
  code_validation.py   # NEW: GenExpr validator, js validator, N4M validator
  maxclass_map.py      # FIXED: add gen~, js, gen.codebox~ to UI_MAXCLASSES
  db_lookup.py         # Unchanged (gen/objects.json already loaded)
  defaults.py          # Extended: .gendsp patcher defaults
  layout.py            # Unchanged
  sizing.py            # Extended: gen~ and gen.codebox~ sizing
```

### Pattern 1: gen~ Codebox Embedding (add_gen method)
**What:** A dedicated method on Patcher that creates a gen~ box with an inner Gen patcher containing a codebox, in objects, and out objects -- all wired together.
**When to use:** Whenever generating a patch containing gen~ DSP processing.
**Why:** Mirrors the existing add_subpatcher pattern which creates nested patchers with inlet/outlet objects. gen~ follows the same structural pattern but with codebox instead of user objects.

**Example structure (from research):**
```python
def add_gen(
    self,
    code: str,
    num_inputs: int = 1,
    num_outputs: int = 1,
    params: dict[str, dict] | None = None,
    x: float = 0.0,
    y: float = 0.0,
) -> tuple[Box, Patcher]:
    """Add a gen~ object with embedded codebox.

    Creates:
    - Parent gen~ box (maxclass="gen~", not "newobj")
    - Inner Gen patcher with:
      - codebox (maxclass="codebox", code=genexpr_code)
      - in 1, in 2, ... objects connected to codebox inlets
      - out 1, out 2, ... objects connected from codebox outlets
      - Patchlines connecting in -> codebox -> out
    """
```

### Pattern 2: Codebox JSON Structure
**What:** The codebox box inside a gen~ patcher uses `maxclass: "codebox"` with a `code` attribute containing the GenExpr source.
**Source:** makegendsp.py analysis + Cycling '74 documentation

```json
{
  "box": {
    "maxclass": "codebox",
    "id": "codebox-1",
    "code": "// === OSCILLATOR ===\nParam freq(440, min=20, max=20000);\nout1 = cycle(freq);",
    "fontname": "Arial",
    "fontsize": 12.0,
    "numinlets": 1,
    "numoutlets": 1,
    "patching_rect": [50.0, 80.0, 400.0, 200.0]
  }
}
```

### Pattern 3: .gendsp File Structure
**What:** A .gendsp file is JSON with the same patcher wrapper as .maxpat, containing codebox + in/out objects.
**Source:** makegendsp.py, Cycling '74 docs

```json
{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
    "rect": [100.0, 100.0, 600.0, 450.0],
    "bgcolor": [0.9, 0.9, 0.9, 1.0],
    "boxes": [
      { "box": { "maxclass": "newobj", "text": "in 1", "id": "in-1", ... } },
      { "box": { "maxclass": "newobj", "text": "in 2", "id": "in-2", ... } },
      { "box": { "maxclass": "codebox", "code": "...", "id": "codebox-1", ... } },
      { "box": { "maxclass": "newobj", "text": "out 1", "id": "out-1", ... } }
    ],
    "lines": [
      { "patchline": { "source": ["in-1", 0], "destination": ["codebox-1", 0] } },
      { "patchline": { "source": ["codebox-1", 0], "destination": ["out-1", 0] } }
    ]
  }
}
```

Note: Inside .gendsp files, `in` and `out` objects use `"maxclass": "newobj"` with text `"in 1"`, `"out 1"` etc. The codebox uses `"maxclass": "codebox"`.

### Pattern 4: js Object Box in .maxpat
**What:** js object in .maxpat uses `maxclass: "js"` with file reference as first argument.
**Source:** Database entry confirms `"maxclass": "js"`.

```json
{
  "box": {
    "maxclass": "newobj",
    "text": "js my_script.js",
    "id": "obj-5",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": [""]
  }
}
```

Note: Despite the database listing `"maxclass": "js"`, in actual .maxpat files `js` objects use `"maxclass": "newobj"` with `"text": "js filename.js"`. The `js` as maxclass is for the object's standalone identity. This is similar to how `gen~` works -- it can be either `"maxclass": "gen~"` (when used as top-level UI) or embedded inside a newobj. For our code generation purposes, using `"newobj"` with `"text": "js filename.js"` is correct.

### Pattern 5: node.script Box in .maxpat
**What:** node.script uses `maxclass: "newobj"` with text `"node.script filename.js"`.

```json
{
  "box": {
    "maxclass": "newobj",
    "text": "node.script my_n4m_script.js",
    "id": "obj-6",
    "numinlets": 1,
    "numoutlets": 2,
    "outlettype": ["", ""]
  }
}
```

### Pattern 6: N4M JavaScript Template
**What:** Standard Node for Max script structure.
**Source:** Cycling '74 Node for Max API documentation.

```javascript
const maxAPI = require("max-api");

// === HANDLERS ===
maxAPI.addHandler("bang", () => {
    maxAPI.outlet("hello from Node!");
});

maxAPI.addHandler("set_value", (value) => {
    maxAPI.post(`Received value: ${value}`);
    maxAPI.outlet(value * 2);
});

// === DICT ACCESS ===
async function loadData() {
    try {
        const data = await maxAPI.getDict("my_dict");
        maxAPI.post(`Dict loaded: ${JSON.stringify(data)}`);
        maxAPI.outlet("dict_loaded");
    } catch (err) {
        maxAPI.post(`Error loading dict: ${err.message}`, maxAPI.POST_LEVELS.ERROR);
    }
}
```

### Pattern 7: js Object V8 JavaScript Template
**What:** Standard js object script structure.
**Source:** CLAUDE.md js section.

```javascript
inlets = 2;
outlets = 1;

function bang() {
    outlet(0, "bang received");
}

function msg_int(v) {
    outlet(0, v * 2);
}

function msg_float(v) {
    outlet(0, v * 0.5);
}

function list() {
    var args = arrayfromargs(arguments);
    outlet(0, args.length);
}
```

### Anti-Patterns to Avoid
- **Don't create codebox as a regular Box:** Codebox is not a standard MAX object -- it's a structural element inside gen~ patchers with its own JSON format (`code` attribute). It must be created directly as a dict, not through the Box constructor.
- **Don't use "newobj" maxclass for gen~:** gen~ uses its own maxclass `"gen~"` in .maxpat files. The current maxclass_map resolves it incorrectly to "newobj".
- **Don't auto-fix code:** Unlike patch connections which can be safely removed, code fixes risk semantic changes. Validation is report-only.
- **Don't treat codebox inlets/outlets like regular objects:** Codebox auto-detects its inlets/outlets from the GenExpr code's `in1`, `in2`, `out1`, `out2` keywords. The numinlets/numoutlets in the JSON must match what the code declares.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| GenExpr operator validation | Custom operator list | gen/objects.json (189 operators) via ObjectDatabase | Already extracted and verified in Phase 1; single source of truth |
| Object existence checking | New lookup code | ObjectDatabase.exists() / ObjectDatabase.lookup() | Already handles aliases, domains, PD blocklist |
| Nested patcher creation | Manual JSON assembly | Follow add_subpatcher pattern | Proven pattern for inner patcher with inlet/outlet objects |
| .maxpat JSON structure | Custom templates | DEFAULT_PATCHER_PROPS from defaults.py | Verified against MAX 9 format in Phase 2 |
| File write hooks | New hook system | Extend existing hooks.py write_patch / validate_file | Phase 2 FRM-05 infrastructure already handles hook dispatch |

**Key insight:** The gen/objects.json database is the critical asset for GenExpr validation. It contains all 189 valid Gen~ operators (abs, accum, cycle, delay, history, param, phasor, etc.). Any GenExpr function call can be validated against this list. Don't build a separate operator registry.

## Common Pitfalls

### Pitfall 1: gen~ Maxclass Resolution
**What goes wrong:** gen~ resolves to `"maxclass": "newobj"` instead of `"maxclass": "gen~"`. Generated patches would have incorrectly-typed gen~ boxes.
**Why it happens:** gen~ is not in the UI_MAXCLASSES set in maxclass_map.py, so resolve_maxclass returns "newobj".
**How to avoid:** Add `gen~`, `gen.codebox~`, and `js` to UI_MAXCLASSES (or create a separate SPECIAL_MAXCLASSES set that maps name -> maxclass using database lookup).
**Warning signs:** gen~ box in generated .maxpat has `"maxclass": "newobj"` instead of `"maxclass": "gen~"`.

### Pitfall 2: node.script Not in Database
**What goes wrong:** Creating a Box for node.script raises ValueError ("Unknown object: 'node.script'") because it's not in any domain database.
**Why it happens:** node.script was introduced in Max 8 but apparently was not extracted during the Phase 1 XML refpage extraction.
**How to avoid:** Either add node.script to the database (overrides.json or max/objects.json), or handle it as a special case in the Box constructor (similar to how structural maxclasses like patcher/bpatcher bypass standard lookup). The add_node_script method should bypass normal lookup.
**Warning signs:** ValueError when trying to create a node.script box.

### Pitfall 3: Codebox inlet/outlet Count Mismatch
**What goes wrong:** The codebox's numinlets/numoutlets in JSON don't match the in/out declarations in the GenExpr code, causing MAX to report errors on load.
**Why it happens:** GenExpr code uses `in1`, `in2`, `out1`, `out2` to implicitly declare inlets/outlets. The codebox JSON must have matching counts.
**How to avoid:** Parse the GenExpr code for `in\d+` and `out\d+` patterns to determine the actual inlet/outlet count. Set codebox numinlets/numoutlets accordingly.
**Warning signs:** MAX error messages about "inlet/outlet count mismatch" or "codebox has N inlets but code references M".

### Pitfall 4: GenExpr Semicolon Rules
**What goes wrong:** Missing semicolons between statements cause parse errors in MAX. A single expression doesn't need a semicolon, but multiple statements do.
**Why it happens:** Developers forget that GenExpr requires semicolons only when there are multiple statements.
**How to avoid:** Validation should check for missing semicolons when code has multiple statements. The safe default is always use semicolons.
**Warning signs:** "Unexpected token" errors in MAX when loading gen~ patches.

### Pitfall 5: js vs N4M Detection
**What goes wrong:** Validation applies wrong rules -- checking js patterns on N4M files or vice versa.
**Why it happens:** Both use .js extension. Detection must examine file content (require('max-api') for N4M, inlets/outlets declarations for js).
**How to avoid:** Content-based detection: if file contains `require("max-api")` or `require('max-api')`, it's N4M. If it contains `inlets =` and `outlets =`, it's js. Hooks should use this heuristic.
**Warning signs:** False positive validation errors on valid scripts.

### Pitfall 6: gen~ Inner Patcher vs Outer Box Confusion
**What goes wrong:** Connecting to gen~ uses the outer box's inlets/outlets (signal I/O), but the inner patcher contains the codebox with its own in/out objects. Confusing these layers causes broken patches.
**Why it happens:** gen~ has two levels: the MSP-level box (connects to other MSP objects) and the Gen-level patcher (contains codebox, in, out operators).
**How to avoid:** The add_gen method should clearly separate outer box (gen~ box with signal inlets/outlets) from inner patcher (codebox + in/out objects). The outer box's numinlets/numoutlets must match the inner patcher's in/out count.

## Code Examples

Verified patterns from official sources:

### GenExpr: Simple Oscillator with Param
```genexpr
// Source: Cycling '74 GenExpr docs + CLAUDE.md conventions
// === PARAMETERS ===
Param freq(440, min=20, max=20000);
Param amp(0.5, min=0, max=1);

// === OSCILLATOR ===
osc_signal = cycle(freq);

// === OUTPUT ===
out1 = osc_signal * amp;
```

### GenExpr: Filter with History (Feedback)
```genexpr
// Source: Cycling '74 GenExpr docs
// === PARAMETERS ===
Param cutoff(1000, min=20, max=20000);
Param resonance(0.5, min=0, max=1);

// === STATE ===
History y1(0);
History y2(0);

// === FILTER ===
x = in1;
coeff = clamp(cutoff / samplerate(), 0, 0.5);
y1 = y1 + coeff * (x - y1);
y2 = y2 + coeff * (y1 - y2);

// === OUTPUT ===
out1 = mix(y2, y1, resonance);
```

### GenExpr: Multi-input with Control Flow
```genexpr
// Source: Cycling '74 GenExpr docs
// === PARAMETERS ===
Param amount(0, min=-1, max=1);

// === WAVESHAPER ===
x = in1 * (1 + abs(amount));
if (amount >= 0) {
    out1 = tanh(x);
} else {
    out1 = (2 / 3.14159) * atan(x);
}
```

### Codebox JSON Inside gen~ Patcher
```json
{
  "box": {
    "maxclass": "codebox",
    "id": "codebox-1",
    "code": "Param freq(440, min=20, max=20000);\nParam amp(0.5, min=0, max=1);\nout1 = cycle(freq) * amp;",
    "fontname": "Arial",
    "fontsize": 12.0,
    "numinlets": 0,
    "numoutlets": 1,
    "outlettype": [""],
    "patching_rect": [50.0, 80.0, 400.0, 200.0]
  }
}
```

### Complete gen~ Box in .maxpat (Outer Structure)
```json
{
  "box": {
    "maxclass": "gen~",
    "id": "obj-1",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": ["signal"],
    "patching_rect": [100.0, 100.0, 150.0, 22.0],
    "patcher": {
      "fileversion": 1,
      "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
      "rect": [100.0, 100.0, 600.0, 450.0],
      "bgcolor": [0.9, 0.9, 0.9, 1.0],
      "boxes": [
        { "box": { "maxclass": "newobj", "text": "in 1", "id": "in-1", "numinlets": 0, "numoutlets": 1, "outlettype": [""], "patching_rect": [50.0, 20.0, 30.0, 22.0] } },
        { "box": { "maxclass": "codebox", "code": "out1 = in1 * 0.5;", "id": "codebox-1", "numinlets": 1, "numoutlets": 1, "outlettype": [""], "patching_rect": [50.0, 80.0, 400.0, 200.0], "fontname": "Arial", "fontsize": 12.0 } },
        { "box": { "maxclass": "newobj", "text": "out 1", "id": "out-1", "numinlets": 1, "numoutlets": 0, "outlettype": [], "patching_rect": [50.0, 320.0, 30.0, 22.0] } }
      ],
      "lines": [
        { "patchline": { "source": ["in-1", 0], "destination": ["codebox-1", 0] } },
        { "patchline": { "source": ["codebox-1", 0], "destination": ["out-1", 0] } }
      ]
    }
  }
}
```

### N4M Script Template
```javascript
// Source: Cycling '74 Node for Max API docs
const maxAPI = require("max-api");

// === HANDLERS ===
maxAPI.addHandler("bang", () => {
    maxAPI.outlet("processed");
});

maxAPI.addHandler("set_value", async (value) => {
    try {
        await maxAPI.setDict("my_data", { value: value });
        maxAPI.outlet("stored", value);
    } catch (err) {
        maxAPI.post(`Error: ${err.message}`, maxAPI.POST_LEVELS.ERROR);
    }
});
```

### js Object Script Template
```javascript
// Source: CLAUDE.md js section
inlets = 2;
outlets = 1;

function bang() {
    outlet(0, "ready");
}

function msg_int(v) {
    outlet(0, v * 2);
}

function msg_float(v) {
    outlet(0, v);
}

function list() {
    var args = arrayfromargs(arguments);
    outlet(0, args);
}
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| gen.codebox~ as standalone MSP object | Codebox embedded inside gen~ patcher | MAX 6+ | Codebox is always inside gen~ (or gen.codebox~ at top level) |
| js object (Spidermonkey/ES5) | Node for Max (node.script, Node.js) | MAX 8 (2018) | N4M is the modern path; js is legacy but still functional |
| Manual .gendsp creation | Programmatic JSON generation | Always available | .gendsp is just JSON -- same as .maxpat |
| require('max-api') install via npm | max-api auto-provided by MAX runtime | MAX 8+ | No npm install needed; MAX provides the module |

**Deprecated/outdated:**
- js object (ECMAScript 5) is legacy but NOT deprecated -- still works in MAX 9, just limited vs N4M
- `gen.codebox~` as top-level MSP object is valid but uncommon -- embedding codebox inside gen~ is the standard pattern

## Critical Codebase Findings

### 1. Maxclass Resolution Gap (HIGH priority)
The current `maxclass_map.py` does not include `gen~` or `js` in `UI_MAXCLASSES`. Both objects have their own maxclass in the database (`"maxclass": "gen~"`, `"maxclass": "js"`). However, real .maxpat behavior is nuanced:
- `gen~` appears as `"maxclass": "gen~"` when it's a standalone UI object (like gen.codebox~)
- `js filename.js` appears as `"maxclass": "newobj"` with `"text": "js filename.js"` in standard patches
- For gen~ with embedded patcher, the correct approach is `"maxclass": "gen~"` with a `"patcher"` key

**Recommendation:** Handle gen~ as a special case in add_gen (similar to add_subpatcher using Box.__new__). For js, keep as newobj (standard text-based object). gen.codebox~ should be added to UI_MAXCLASSES if standalone top-level usage is needed.

### 2. node.script Database Absence (MEDIUM priority)
`node.script` is not in any domain database. This means Box("node.script") would raise ValueError. The add_node_script method must bypass the standard Box constructor (like add_subpatcher).

### 3. Existing Nested Patcher Pattern (HIGH value)
`add_subpatcher` provides the exact pattern needed for `add_gen`:
- Creates parent box using `Box.__new__()` to bypass DB lookup
- Sets custom maxclass, numinlets, numoutlets
- Creates inner Patcher with structural objects
- Sets `_inner_patcher` for JSON embedding
- Returns (box, inner_patcher) tuple

### 4. Hook Extension Point (HIGH value)
`hooks.py` currently handles `.maxpat` only. Extension requires:
- Adding `.gendsp` support to write functions
- Adding `.js` content detection (N4M vs js object)
- Calling appropriate validators based on file type

### 5. GenExpr Operator Set (HIGH value)
The `gen/objects.json` has all 189 Gen~ operators. Key categories:
- Math: abs, add, sub, mul, div, mod, pow, sqrt, log, exp
- Trig: sin, cos, tan, atan, atan2
- Waveform: cycle, phasor, triangle, noise, train
- Buffer: buffer, data, peek, poke, wave, sample, lookup
- State: history, delay, latch, sah, counter, accum
- Control: param, in, out, gate, selector, switch
- Comparison: eq, neq, gt, gte, lt, lte, clamp, clip, fold, wrap
- Conversion: mtof, ftom, atodb, dbtoa, mstosamps, sampstoms
- Signal: samplerate, vectorsize, elapsed, fixdenorm, fixnan, dcblock

## Open Questions

1. **Codebox outlettype in gen~ patcher**
   - What we know: Codebox outlets are signal-rate inside gen~, but the outlettype might be `[""]` (control) or `["signal"]` in the JSON
   - What's unclear: The exact outlettype value codebox uses inside gen~ patcher JSON
   - Recommendation: Use `[""]` for codebox outlettype (gen~ operates at sample rate internally, types are implicit). Verify with a real .maxpat if available.

2. **node.script outlet count configuration**
   - What we know: node.script typically has 1 inlet and configurable outlets. The outlet count may be set by the `@outlets` attribute or by argument.
   - What's unclear: Exact JSON attribute for outlet count vs argument-based configuration
   - Recommendation: Default to 2 outlets (data + status) and allow caller to specify. The outer box should be created via Box.__new__ similar to subpatcher pattern.

3. **gen~ bgcolor in inner patcher**
   - What we know: makegendsp.py sets `"bgcolor": [0.9, 0.9, 0.9, 1.0]` for gen patchers. DEFAULT_PATCHER_PROPS does not include bgcolor.
   - What's unclear: Whether bgcolor is required for gen~ inner patchers or just cosmetic
   - Recommendation: Include bgcolor `[0.9, 0.9, 0.9, 1.0]` for gen~ inner patchers as it matches MAX's default gen~ appearance. Low risk -- cosmetic only.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | None (default pytest discovery) |
| Quick run command | `python3 -m pytest tests/ -x -q` |
| Full suite command | `python3 -m pytest tests/ -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| CODE-01 | GenExpr syntax generation (in/out, Param, C-style ops) | unit | `python3 -m pytest tests/test_codegen.py::TestGenExpr -x` | Wave 0 |
| CODE-01 | GenExpr operator validation against gen/objects.json | unit | `python3 -m pytest tests/test_code_validation.py::TestGenExprValidator -x` | Wave 0 |
| CODE-02 | gen~ codebox embedded in .maxpat | unit | `python3 -m pytest tests/test_codegen.py::TestGenBox -x` | Wave 0 |
| CODE-02 | gen~ codebox JSON structure correct | unit | `python3 -m pytest tests/test_codegen.py::TestGenBox::test_codebox_structure -x` | Wave 0 |
| CODE-03 | .gendsp file generation | unit | `python3 -m pytest tests/test_codegen.py::TestGendsp -x` | Wave 0 |
| CODE-03 | .gendsp file write with validation hook | integration | `python3 -m pytest tests/test_codegen.py::TestGendsp::test_write_gendsp -x` | Wave 0 |
| CODE-04 | N4M JavaScript generation | unit | `python3 -m pytest tests/test_codegen.py::TestN4M -x` | Wave 0 |
| CODE-04 | N4M validation (require, addHandler, outlet) | unit | `python3 -m pytest tests/test_code_validation.py::TestN4MValidator -x` | Wave 0 |
| CODE-05 | js object script generation | unit | `python3 -m pytest tests/test_codegen.py::TestJsObject -x` | Wave 0 |
| CODE-05 | js validation (inlets, outlets, handlers) | unit | `python3 -m pytest tests/test_code_validation.py::TestJsValidator -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/ -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -q`
- **Phase gate:** Full suite green before /gsd:verify-work

### Wave 0 Gaps
- [ ] `tests/test_codegen.py` -- covers CODE-01, CODE-02, CODE-03, CODE-04, CODE-05 (generation)
- [ ] `tests/test_code_validation.py` -- covers CODE-01, CODE-04, CODE-05 (validation)
- [ ] `tests/fixtures/expected/gen_codebox.maxpat` -- fixture for gen~ codebox patch comparison
- [ ] `tests/fixtures/expected/simple.gendsp` -- fixture for .gendsp file comparison

## Sources

### Primary (HIGH confidence)
- gen/objects.json -- 189 Gen~ operators verified from Phase 1 extraction
- msp/objects.json -- gen~ and gen.codebox~ entries with full attribute data
- max/objects.json -- js object entry with handlers, arguments, messages
- Existing codebase (patcher.py, validation.py, hooks.py) -- Phase 2 patterns verified by running 237 passing tests
- makegendsp.py (suncop/makegendsp) -- .gendsp JSON structure with codebox format

### Secondary (MEDIUM confidence)
- [Cycling '74 GenExpr docs](https://docs.cycling74.com/max8/vignettes/gen_genexpr) -- GenExpr syntax, keywords, control flow
- [Cycling '74 Node for Max API](https://docs.cycling74.com/nodeformax/api/) -- max-api methods: addHandler, outlet, post, getDict, setDict
- [Cycling '74 node.script reference](https://docs.cycling74.com/max8/refpages/node.script) -- node.script attributes, messages, process model
- [Cycling '74 N4M JavaScript differences](https://docs.cycling74.com/max8/vignettes/04_n4m_jsdifferences) -- js vs node.script comparison
- [Cycling '74 Gen Overview](https://docs.cycling74.com/userguide/gen/_gen_overview/) -- .gendsp file format description

### Tertiary (LOW confidence)
- Codebox outlettype value inside gen~ patcher -- not verified against real .maxpat file
- node.script outlet count attribute -- documentation unclear on exact mechanism

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- no new dependencies, all stdlib Python
- Architecture: HIGH -- follows existing Phase 2 patterns (add_subpatcher, validation layers, hooks)
- GenExpr syntax: HIGH -- verified against Cycling '74 official docs + 189-operator database
- .gendsp format: HIGH -- verified via makegendsp.py reference implementation
- N4M API: HIGH -- verified against official Cycling '74 API docs
- js object API: HIGH -- verified against CLAUDE.md + database entry
- Codebox JSON details: MEDIUM -- some details (outlettype, exact sizing) need validation against real files
- Pitfalls: HIGH -- identified through codebase analysis (maxclass gap, node.script absence confirmed by running code)

**Research date:** 2026-03-09
**Valid until:** 2026-04-09 (stable domain -- MAX/GenExpr syntax doesn't change frequently)
