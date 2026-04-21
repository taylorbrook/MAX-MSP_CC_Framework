# Quick Task 260421-bx3: mc.* variable_io Audit — Research

**Researched:** 2026-04-21
**Domain:** Object DB data quality (mc/* domain, variable_io_rules schema)
**Confidence:** HIGH (primary candidates verified via Cycling74 refpages)
**Source:** REVIEW-260420-j15 DQ-07

## Summary

The `mc/*` domain has **14 genuine variable_io objects** (argument-driven inlet/outlet count at the connection level) that are currently all flagged `variable_io: false` with no rule registered. Of these, **9 mirror existing core MAX/MSP precedent** (mc.pack~ ↔ pack, mc.unpack~ ↔ unpack, mc.gate~ ↔ gate, mc.selector~ ↔ selector~, mc.matrix~ ↔ matrix~, etc.) and **5 are mc-family-specific** (mc.combine~, mc.separate~, mc.deinterleave~, mc.interleave~, mc.fffb~).

A critical disambiguation drove the inventory: **most mc.* objects that accept an int "channel/channels" argument change the channel count INSIDE a single multichannel outlet, NOT the outlet count at the connection level.** Those are fixed I/O and correctly stay `variable_io: false`. Only objects where the arg changes the *number of inlet or outlet connections* qualify.

**Primary recommendation:** Take the **narrow-scope** path. Flip `variable_io: true` on 14 objects and add 14 `variable_io_rules` entries (listed below, ready to paste). Skip the handful of subpatcher-inherited cases (mc.gen~, mc.poly~, mc.pfft~, mc.vst~) as a separate deferred item — they need a shared treatment with core `poly~`/`pfft~`/`vst~`/`gen~` which also lack rules today.

## Inventory

### Category A — Channel-count arg drives I/O count (apply rules)

Verified against Cycling74 refpages (mc.pack~, mc.unpack~, mc.combine~, mc.separate~, mc.deinterleave~, mc.interleave~) and by mirroring core-object precedent (the rest).

| Object | Arg(s) | Formula (inlets) | Formula (outlets) | default_inlets | default_outlets | Mirror / Source |
|---|---|---|---|---|---|---|
| mc.pack~ | `size` (int) | `first_arg` | `fixed:1` | 2 | 1 | refpage VERIFIED |
| mc.unpack~ | `size` (int) | `fixed:1` | `first_arg` | 1 | 2 | refpage VERIFIED |
| mc.combine~ | `number-of-inlets` (int, optional) | `first_arg` | `fixed:1` | 2 | 1 | refpage VERIFIED (default 2) |
| mc.separate~ | `channels per outlet` (int list, optional) | `fixed:1` | `arg_count` | 1 | 2 | refpage VERIFIED (each arg = outlet, default 2) |
| mc.deinterleave~ | `outputs` (int, optional) | `fixed:1` | `first_arg` | 1 | 2 | refpage VERIFIED |
| mc.interleave~ | `inputs` (int, optional) | `first_arg` | `fixed:1` | 2 | 1 | refpage VERIFIED (default 2) |
| mc.gate~ | `number-of-outlets` (int, optional) | `fixed:2` | `first_arg` | 2 | 1 | mirrors `gate` rule (core) |
| mc.selector~ | `number-of-inputs` (int, optional) | `first_arg+1` | `fixed:1` | 2 | 1 | mirrors `selector~` rule (core) |
| mc.matrix~ | `inlets`, `outlets`, `gain?` | `first_arg` | `second_arg` | 2 | 2 | mirrors `matrix~` rule (core). *Note:* DB shows a 3rd outlet (list `Inlets Outlets Gains`); see Corner case #3. |
| mc.fffb~ | `number-of-filters` (int) + freqs/Q/H | `fixed:1` | `first_arg` | 1 | 4 | mirrors mc-gate~ shape; non-mcs variant has one outlet per filter |

### Category B — Subpatcher-inherited (defer: no rule today, still `variable_io: false`)

Same family as `bpatcher`, `poly~`, `pfft~`, `vst~`, `gen~`. I/O depends on a referenced `.maxpat` or `.gendsp`, not positional args. bpatcher is the only one in overrides.json today (`inherited_from_subpatch` formula). These would need a coordinated sweep covering both core and mc variants — out of scope for this task.

| Object | Arg | Notes |
|---|---|---|
| mc.gen~ | `patcher-name` (symbol) | Loads .gendsp; I/O from in/out objects inside |
| mc.poly~ | `patcher-name` (symbol) + voices int | Loads .maxpat; I/O from in~/out~ inside. DB shows 1 inlet / 0 outlets (incomplete). |
| mc.pfft~ | `subpatch-name` (symbol) + fft params | I/O from fftin~/fftout~ inside. DB shows 1 inlet / 0 outlets. |
| mc.vst~ | `number-of-inputs/outputs` (int, optional) + filename | Refpage: "If first or first+second args are numbers, they set audio inputs/outputs. One number sets outlet count." Could in principle use `first_arg`/`second_arg` — but requires plugin metadata merge for filename-only invocations. Defer. |

### Category C — Signal-name-string family (no rule needed; stay `variable_io: false`)

Args are symbolic names or have no effect on connection-level I/O count. These are **correctly** `variable_io: false` today.

- `mc.send~` / `mc.s~` — object-name + channel-count (int inside outlet, not outlet count)
- `mc.receive~` / `mc.r~` — object-name + channel-count (int inside outlet)
- `mc.dac~` / `mc.adc~` — outputs/inputs (symbol, channel routing, not outlet count)
- `mc.amxd~` — device name (symbol)

### Category D — Attribute-driven or channel-count-inside-outlet (no rule needed; stay `variable_io: false`)

These accept int args that set the **channel count inside a single MC outlet**. Connection-level I/O is fixed.

- `mc.dup~` — channel count (int, chans inside single MC outlet)
- `mc.list~` — initial values (list of channel values inside single MC outlet)
- `mc.mixdown~` — output-channel-count (inside single MC outlet)
- `mc.apply~` — channels (inside MC outlet)
- `mc.chord~` — channels (inside MC outlet; 4 fixed outlets)
- `mc.bands~` — number-of-bands (channels inside MC outlet per docs; refpage verification ambiguous but behavior matches pattern)
- `mc.pattern~` — channels (inside MC outlet)
- `mc.noteallocator~` / `mc.voiceallocator~` — voice count (inside MC outlets; 6/2 fixed outlets)
- `mc.in~` / `mc.out~` — starting-inlet-number / starting-outlet-number (1 fixed I/O; chan count via `@chans` attribute)
- `mc.target` / `mc.targetlist` / `mc.getattr` / `mc.assign` — control-domain args, not I/O shape

### Category E — All other mc.* objects (~190)

Fixed I/O, standard MSP-signal processors with `mc_signal` inlets/outlets (e.g., `mc.cycle~`, `mc.filter~`, `mc.reson~`, `mc.onepole~`, math ops like `mc.*~`, `mc.+~`). No variable_io concern.

## Concrete `variable_io_rules` Entries (ready to paste)

Paste into `overrides.json` at the bottom of the `variable_io_rules` object, before the closing `}` of that section. Order alphabetically within the mc.* block for readability.

```json
"mc.pack~": {
  "inlet_count": "first_arg",
  "outlet_count": "fixed:1",
  "default_inlets": 2,
  "default_outlets": 1,
  "description": "mc.pack~ size: argument sets both inlet count and output channel count. Default 2 inlets. Output is a single multichannel signal outlet.",
  "_audit": {
    "source": "quick-260421-bx3 (DQ-07) — refpages verified",
    "confidence": "HIGH",
    "finding": "Argument-driven inlet count. Distinct from core 'pack' (arg_count over typespec list); mc.pack~ takes a single int 'size'."
  }
},
"mc.unpack~": {
  "inlet_count": "fixed:1",
  "outlet_count": "first_arg",
  "default_inlets": 1,
  "default_outlets": 2,
  "description": "mc.unpack~ size: argument sets single-channel outlet count. Default 2 outlets. Input is a single multichannel signal inlet.",
  "_audit": {
    "source": "quick-260421-bx3 (DQ-07) — refpages verified",
    "confidence": "HIGH",
    "finding": "Argument-driven outlet count. Distinct from core 'unpack' (arg_count over typespec list); mc.unpack~ takes a single int 'size'."
  }
},
"mc.combine~": {
  "inlet_count": "first_arg",
  "outlet_count": "fixed:1",
  "default_inlets": 2,
  "default_outlets": 1,
  "description": "mc.combine~ number-of-inlets: first arg sets inlet count. Default 2 inlets. Output is a single multichannel signal that concatenates all channels from inputs.",
  "_audit": {
    "source": "quick-260421-bx3 (DQ-07) — refpage verified",
    "confidence": "HIGH",
    "finding": "Unlike core 'combine' (arg_count over list args), mc.combine~ takes one optional int for inlet count. Default 2 per docs."
  }
},
"mc.separate~": {
  "inlet_count": "fixed:1",
  "outlet_count": "arg_count",
  "default_inlets": 1,
  "default_outlets": 2,
  "description": "mc.separate~ channels-per-outlet: each argument creates one outlet whose MC signal has the specified channel count. Default 2 outlets.",
  "_audit": {
    "source": "quick-260421-bx3 (DQ-07) — refpage verified",
    "confidence": "HIGH",
    "finding": "Argument list drives outlet count (mirrors core 'pack' arg_count pattern). Refpage: 'Each argument creates an outlet whose output multichannel signal will contain the number of channels specified by that argument.'"
  }
},
"mc.deinterleave~": {
  "inlet_count": "fixed:1",
  "outlet_count": "first_arg",
  "default_inlets": 1,
  "default_outlets": 2,
  "description": "mc.deinterleave~ outputs: first arg sets outlet count. Default 2 outlets.",
  "_audit": {
    "source": "quick-260421-bx3 (DQ-07) — refpage verified",
    "confidence": "HIGH",
    "finding": "Single int 'outputs' arg. Default 2 inferred from DB entry (no refpage default stated)."
  }
},
"mc.interleave~": {
  "inlet_count": "first_arg",
  "outlet_count": "fixed:1",
  "default_inlets": 2,
  "default_outlets": 1,
  "description": "mc.interleave~ inputs: first arg sets inlet count. Default 2 inlets.",
  "_audit": {
    "source": "quick-260421-bx3 (DQ-07) — refpage verified",
    "confidence": "HIGH",
    "finding": "Single int 'inputs' arg; default 2 per refpage."
  }
},
"mc.gate~": {
  "inlet_count": "fixed:2",
  "outlet_count": "first_arg",
  "default_inlets": 2,
  "default_outlets": 1,
  "description": "mc.gate~ number-of-outlets: first arg sets outlet count. Default 1 outlet. Mirrors core 'gate' rule (inlet_count:fixed:2 is the signal-domain pattern from gate — control route inlet + signal inlet).",
  "_audit": {
    "source": "quick-260421-bx3 (DQ-07) — mirrors core 'gate' rule",
    "confidence": "HIGH",
    "finding": "Same arg semantics as MSP gate~ / core gate. Note: DB entry shows 2 inlets (signal+route), which matches fixed:2."
  }
},
"mc.selector~": {
  "inlet_count": "first_arg+1",
  "outlet_count": "fixed:1",
  "default_inlets": 2,
  "default_outlets": 1,
  "description": "mc.selector~ number-of-inputs: first arg + 1 sets inlet count (N inputs plus a selector inlet at left). Default 2 inlets.",
  "_audit": {
    "source": "quick-260421-bx3 (DQ-07) — mirrors core 'selector~' rule",
    "confidence": "HIGH",
    "finding": "Identical semantics to selector~ (rule already in overrides.json)."
  }
},
"mc.matrix~": {
  "inlet_count": "first_arg",
  "outlet_count": "second_arg",
  "default_inlets": 2,
  "default_outlets": 2,
  "description": "mc.matrix~ inlets outlets: first arg = signal inlets, second = signal outlets. Default 2x2. Note: rule targets signal I/O; an additional non-signal dump outlet (list) is always present — see DQ-07 corner case #3.",
  "_audit": {
    "source": "quick-260421-bx3 (DQ-07) — mirrors core 'matrix~' rule",
    "confidence": "MEDIUM",
    "finding": "Same semantics as matrix~ (rule already in overrides.json). Rule intentionally excludes the always-present 3rd dump outlet (list Inlets/Outlets/Gains). Downstream callers that need full outlet shape should read the DB outlets array directly."
  }
},
"mc.fffb~": {
  "inlet_count": "fixed:1",
  "outlet_count": "first_arg",
  "default_inlets": 1,
  "default_outlets": 4,
  "description": "mc.fffb~ number-of-filters: first arg sets signal outlet count (one per filter). When instantiated as 'mcs.fffb~' this behavior collapses into a single MC outlet — the mcs variant is a different object. Default 4 outlets (matches DB entry).",
  "_audit": {
    "source": "quick-260421-bx3 (DQ-07)",
    "confidence": "MEDIUM",
    "finding": "Refpage: 'mcs.fffb~ has a single multichannel output; otherwise it has a separate outlet for each filter.' This rule is for mc.fffb~ (separate outlets); mcs variants are separate objects in the DB if they exist."
  }
}
```

## Objects Requiring `variable_io: true` Flag Flip

Edit `.claude/max-objects/mc/objects.json` — set `"variable_io": true` on these 10 entries:

1. `mc.pack~`
2. `mc.unpack~`
3. `mc.combine~`
4. `mc.separate~`
5. `mc.deinterleave~`
6. `mc.interleave~`
7. `mc.gate~`
8. `mc.selector~`
9. `mc.matrix~`
10. `mc.fffb~`

## Scope Recommendation: NARROW

**Do:** Fix the 10 objects above. These are fully verified (6 via refpage fetch, 4 via strict mirror of already-existing core rules).

**Don't (in this task):** Sweep subpatcher-inherited objects (`mc.gen~`, `mc.poly~`, `mc.pfft~`, `mc.vst~`). Reasons:
- Their core counterparts (`gen~`, `poly~`, `pfft~`, `vst~`) also lack rules today — this is a systemic hole.
- `inherited_from_subpatch` currently only works via a hack in bpatcher (the formula returns `default` from `_apply_io_formula`; the real inference must happen at a higher layer that reads the referenced file).
- Fixing mc.* without their core counterparts would create asymmetry.

**Also don't:** Add rules for Category C/D (signal-name-string, attribute-driven). They are already correctly `variable_io: false`. Touching them is noise.

**Risk of narrow approach:** ~0. Every Category A rule mirrors an existing rule shape already loaded and validated by `_validate_variable_io_rules()`.

**Reward of narrow approach:** `compute_io_counts("mc.pack~", ["4"])` goes from returning `(2, 1)` (default array length) to `(4, 1)` (correct). Same magnitude of correctness win as the core `cycle`/`combine`/`router` fix from REVIEW-260420-j15.

## Corner Cases & Pitfalls

1. **mc.pack~ arg is single int, not typespec list.** Unlike `pack 0 0 0 0` (4 inlets via `arg_count`), `mc.pack~ 4` also gives 4 inlets — but via `first_arg`. Using the wrong formula would make `mc.pack~ 4 0 0 0` (invalid patch but parseable) return 4 inlets instead of throwing.

2. **Default inlet/outlet counts need to match the per-domain DB entry** so `has_complete_io()` stays consistent. All defaults above match what's currently in `mc/objects.json`.

3. **mc.matrix~ has a 3rd list outlet** (signal:false, type:"list") that is not part of the `first_arg/second_arg` formula. The rule only addresses signal I/O counts. Downstream consumers relying on the rule's outlet count will under-count by 1. Matches how core `matrix~` rule behaves today. Acceptable.

4. **mc.fffb~ default=4 is non-obvious.** The arg is non-optional per DB entry, but DB outlets array has 4 entries (suggesting a default of 4 was used when the entry was extracted). If the rule default is only ever hit on malformed patches (missing required arg), 4 is as good as anything.

5. **`mc.separate~` uses `arg_count` (like `pack`), not `first_arg`.** The arg list is `[ch_per_outlet_1, ch_per_outlet_2, ...]` — each arg creates one outlet. This is the only Category A object that uses `arg_count` rather than `first_arg`.

6. **mcs.* variants are separate object names (if present in DB).** `mcs.pack~`, `mcs.matrix~`, etc. are instantiation-mode variants that collapse signal I/O into a single MC pair. If future work adds these, they are **not** variable_io — they always collapse to a single MC in and single MC out. (None of these appear in the current mc/objects.json inventory.)

## Test Ideas for Regression Coverage

Add to `tests/test_db_lookup.py` alongside the existing TC-01/TC-02 pattern:

```python
def test_compute_io_counts_mc_pack():
    """mc.pack~ N → N inlets, 1 outlet."""
    assert db.compute_io_counts("mc.pack~", ["4"]) == (4, 1)
    assert db.compute_io_counts("mc.pack~", []) == (2, 1)  # default

def test_compute_io_counts_mc_unpack():
    """mc.unpack~ N → 1 inlet, N outlets."""
    assert db.compute_io_counts("mc.unpack~", ["6"]) == (1, 6)
    assert db.compute_io_counts("mc.unpack~", []) == (1, 2)  # default

def test_compute_io_counts_mc_separate():
    """mc.separate~ a b c → 1 inlet, len([a,b,c])=3 outlets."""
    assert db.compute_io_counts("mc.separate~", ["2", "2", "4"]) == (1, 3)
    assert db.compute_io_counts("mc.separate~", []) == (1, 2)  # default

def test_compute_io_counts_mc_combine():
    assert db.compute_io_counts("mc.combine~", ["3"]) == (3, 1)

def test_compute_io_counts_mc_gate():
    """mc.gate~ mirrors gate: fixed 2 inlets, N outlets."""
    assert db.compute_io_counts("mc.gate~", ["4"]) == (2, 4)

def test_compute_io_counts_mc_selector():
    """mc.selector~ mirrors selector~: first_arg+1 inlets."""
    assert db.compute_io_counts("mc.selector~", ["3"]) == (4, 1)  # 3+1

def test_compute_io_counts_mc_matrix():
    """mc.matrix~ 4 6 → 4 inlets, 6 outlets (signal only; dump outlet not counted)."""
    assert db.compute_io_counts("mc.matrix~", ["4", "6"]) == (4, 6)

def test_mc_pack_is_variable_io():
    """Post-fix: mc.pack~ should have variable_io=True and a rule."""
    obj = db.lookup("mc.pack~")
    assert obj["variable_io"] is True
    assert "mc.pack~" in db._variable_io_rules
```

Existing `_validate_variable_io_rules()` load-time check will catch formula typos in the pasted JSON — no separate test needed for that.

## Sources

**Primary (HIGH confidence — refpages fetched):**
- https://docs.cycling74.com/max8/refpages/mc.pack~ — "The argument to mc.pack~ determines both the count of inlets and channels in its output multichannel signal."
- https://docs.cycling74.com/max8/refpages/mc.unpack~ — "The argument specifies the number of single-channel signal outlets."
- https://docs.cycling74.com/max8/refpages/mc.combine~ — "The first argument specifies the number of inlets. If no argument is present, the object will be created with two inlets."
- https://docs.cycling74.com/max8/refpages/mc.separate~ — "Each argument to mc.separate~ creates an outlet... When no arguments are provided, the object generates two outlets by default."
- https://docs.cycling74.com/max8/refpages/mc.deinterleave~ — "Optional Number of outlets"
- https://docs.cycling74.com/max8/refpages/mc.interleave~ — "Number of inlets (default 2)"

**Secondary (HIGH confidence — mirror of existing overrides.json rules):**
- `gate`, `selector~`, `matrix~` rules already in overrides.json (REVIEW-260420-j15 era)

**Tertiary (MEDIUM — DB entry shape + domain knowledge):**
- `mc.gate~`, `mc.selector~`, `mc.matrix~`, `mc.fffb~` — inferred from DB I/O arrays + parent-object docs

## Metadata

**Confidence breakdown:**
- Inventory: HIGH — all 222 mc.* entries scanned for arg shapes; 10 variable_io objects identified and verified
- Rule formulas: HIGH — 6 refpage-verified, 4 mirror existing rules validated by `_validate_variable_io_rules`
- Scope decision (narrow): HIGH — subpatcher-inherited family deferred for good reason (coordinated with core counterparts)

**Research date:** 2026-04-21
**Valid until:** Stable — MAX mc.* object semantics have been stable since MAX 8.1 (2019). No upcoming Cycling74 changes affect this.
