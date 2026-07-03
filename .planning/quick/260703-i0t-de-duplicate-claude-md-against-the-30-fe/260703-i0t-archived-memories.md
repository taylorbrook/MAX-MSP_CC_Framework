# Archived feedback memories — quick-260703-i0t (2026-07-03)

Verbatim bodies of the 30 feedback memory files deleted from the memory directory after promotion into CLAUDE.md (the canonical rule surface per D-01). Separator format: "===== filename =====".


===== feedback_assistance_comments.md =====

---
name: Use assistance comments on inlets/outlets
description: Label inlets/outlets via the "comment" JSON attribute (mouse-over tooltip), not by adding comment box objects nearby
type: feedback
---

When the user asks for inlet/outlet labels, use the `comment` attribute on the inlet/outlet box in the .maxpat JSON — this is the "Assistance" field in MAX's inspector that shows as a mouse-over tooltip.

**Why:** The user explicitly prefers MAX's built-in assistance tooltip over freestanding comment boxes. Comment boxes clutter the patch; the `comment` attribute is the proper MAX convention for documenting I/O.

**How to apply:** When generating inlets/outlets in any patch (especially bpatchers), always populate the `"comment"` field with a descriptive label. Example: `"comment": "Audio Input Left"`. Do NOT add separate comment objects for this purpose.


===== feedback_bach_no_llll2list.md =====

---
name: bach has no llll2list/list2llll in installed version
description: Object DB lists bach.llll2list and bach.list2llll but neither exists in the user's bach install — runtime errors "No such object"
type: feedback
originSessionId: 5a78149b-6a12-4f75-a2ba-23a2a7fe75f6
---
The object database lists `bach.llll2list` and `bach.list2llll`, but the actual installed bach package does NOT include them. Patches using these objects fail at load with "bach.llll2list: No such object".

**Why:** The bach DB entries appear to be stale or aspirational. The real bach object set (per `_pkg-source/bach/interfaces/bach-obj-qlookup.json`) has 236 objects, none of which are `llll2list` or `list2llll`.

**How to apply:** Never use `bach.llll2list` or `bach.list2llll`. To extract individual values from a sub-llll like `[X Y]`, use multiple `bach.nth N` calls (one per index, 1-based). For converting MAX list → bach llll, just connect directly — bach inlets accept regular MAX lists in flat cases. For more complex conversions, use `bach.flat`, `bach.iter`, or `bach.pack`.


===== feedback_bach_out_attr.md =====

---
name: bach objects default to native output unreadable by MAX
description: bach.nth/bach.keys/etc default @out n produces bach.llll messages that plain MAX objects (f, select, unpack) reject with "wrong message or type"
type: feedback
originSessionId: 4f7a4acb-dd3a-483e-95e7-15253979f540
---
Every bach object has an `@out` attribute defaulting to `n` (native) — fast for bach→bach pipelines but unreadable by standard MAX objects. When a bach output feeds a non-bach object (`f`, `select`, `unpack`, `expr`, etc.), set `@out t` (text) or `@out m` (max) so the output becomes a valid MAX atom/list.

**Why:** Encountered in physics-composition voice subpatcher — collision events emitted llll from dada.bounce outlet 2, extracted via `bach.keys position` → `bach.nth 1` → `f 0.`. Every bounce logged `f: inlet: wrong message or type` and no sound came out. Root cause: native-format output is a `bach.llll` opaque message, not a float. Fixed in v0.0.3 by appending `@out t` to every `bach.keys` and `bach.nth` in each voice.

**How to apply:** Any bach object whose outlet connects to a non-bach consumer must set `@out t` (or `@out m`). The attribute string has one char per llll outlet (non-llll outlets like bang don't count). For a flat sublist like `[X Y]` in text format, `bach.keys key @out t` outputs a regular MAX list — can then `unpack f f` directly without intermediate `bach.nth`. Use `@unwrap 1` on bach.nth when the extracted element is itself a sublist you want to strip of its outer parens.


===== feedback_bpatcher_args.md =====

---
name: bpatcher-argument-substitution
description: "#N argument substitution in bpatchers must use standalone tokens, never compound strings like slot-#1"
type: feedback
---

When generating bpatcher subpatches that use `#N` argument substitution, `#N` must always be a standalone space-delimited token in object text. Compound forms like `slot-#1` or `#1-out` fail silently in MAX -- the `#1` is not replaced and the literal text is used.

**Correct pattern:**
- Pass full constructed names as bpatcher args: `["slot-1", "slot-1-out"]`
- Use `#1` and `#2` standalone: `buffer~ #1`, `send~ #2`

**Wrong pattern:**
- Pass just a number as arg: `[1]`
- Embed `#1` in compound strings: `buffer~ slot-#1`, `send~ slot-#1-out`

This applies to both newobj and message boxes. The validation pipeline (`validation.py`) now catches this pattern.


===== feedback_bpatcher_numeric_args.md =====

---
name: feedback_bpatcher_numeric_args
description: "bpatcher numeric args must be JSON numbers, not strings, or"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 34d8a3f8-7b4a-4691-b328-c173482471f2
---

When a bpatcher passes a numeric argument for `#N` substitution, it MUST be serialized as a JSON
number (`0`), not a string (`"0"`). `add_bpatcher(..., args=["slot-1", "0"])` writes `"args": ["slot-1", "0"]`,
and Max substitutes `#2` into `-~ #2` as the quoted symbol `0` → **"-~: bad arguments creating object"**
(fires once per affected box, e.g. 9× across 9 playvoice instances). Symptom the user reports: "there should
be no quotation marks for the 0 argument."

**Why:** object boxes (`-~`, `*~`, etc.) reject a symbol where they expect a number. The `args` ARRAY type is
load-bearing; object-box `text` (e.g. `"dac~ 10"`) is always a string and parses fine — only the bpatcher
`args` array matters.

**How to apply:** pass numeric bpatcher args as Python ints, e.g. `args=[slot, 0]` not `args=[slot, "0"]`.
To fix an existing patch surgically: `Patcher.from_dict` keeps bpatcher data in `box._raw` (NOT `box.args`,
which is empty post-round-trip, and `_bpatcher_attrs` is None). Convert numeric strings in `box._raw["args"]`
to ints, then `save_patch_roundtrip`. Slot/symbol args (e.g. `"slot-1"`) stay strings. Relevant to
[[project_psycography]] playvoice/playback; see also [[feedback_bpatcher_args]] (standalone-token rule).


===== feedback_buffer_info_query.md =====

---
name: buffer~ has no info/query message — use fluid.buf2list or other bridge
description: buffer~ doesn't understand "info" and bare attribute names are setters; read contents via fluid.buf2list or jit.buffer~
type: feedback
originSessionId: 14014e21-7d16-4ca5-bdcb-8969b859e04a
---
`buffer~` does NOT respond to `info`. It also does not respond to bare attribute names as queries — `sizeinsamps` alone errors with `missing arguments` because it's a setter (e.g., `sizeinsamps 48000` resizes). The full valid message list is: apply, clear, clearlow, crop, duplicate, enable, fill, filltype, import, importreplace, normalize, open, printmodtime, read, readagain, readtrim, replace, send, set, setsize, size, sizeinsamps, wclose, write, writeaiff, writewave.

**Why:** There's no first-class "query" API on `buffer~`. The right outlet emits state only after operations like `read` — not on demand.

**How to apply:** To get buffer contents or size, bridge through another object:
- **FluCoMa installed** — use `fluid.buf2list`: send `buffer <name>` to set reference, then `bang` to emit contents as a Max list (no size query needed).
- **No FluCoMa** — use `jit.buffer~` as a view onto the audio buffer; `jit.matrixinfo` reports dimensions. Or drive `peek~` with `uzi N` where N is a known upper bound.
- Never send bare attribute names (`info`, `sizeinsamps`, `samplerate`) expecting query semantics.


===== feedback_comment_no_hash_sub.md =====

---
name: Comment boxes don't support #N substitution
description: MAX comment objects ignore #N argument substitution in bpatchers; use loadbang→message→comment set chain instead
type: feedback
---

Comment boxes (`maxclass: "comment"`) do NOT perform `#N` argument substitution when loaded as bpatchers/abstractions. The text stays literal.

**Why:** User confirmed `#1` and `Bus #1` displayed literally in comment objects despite correct args on the bpatcher. Only `newobj` and `message` boxes perform `#N` substitution.

**How to apply:** For dynamic labels in bpatchers, use a `loadbang` → `message "set Label #1"` → `comment` chain. The message box performs the `#N` substitution, then sends the `set` message to update the comment's display text.


===== feedback_db_empty_io.md =====

---
name: DB objects with empty I/O are silently unusable
description: 168 DB entries have both inlets:[] and outlets:[] — lookup() returns them but patch builder can't connect; check I/O length before trusting a lookup result
type: feedback
originSessionId: 975dc4a1-379d-45a6-bb41-95f783f7115a
---
Objects in `.claude/max-objects/` that were extracted with `"inlets": []` and `"outlets": []` are returned by `ObjectDatabase.lookup()` as real hits but have no I/O schema — the patch builder treats them as "missing" because it can't make connections. This is indistinguishable from a genuine DB gap at the failure site.

As of 2026-04-19: 43 core-domain objects and 125 package objects have this shape. 23 core ones have no override. High-risk uncovered real objects: `bpatcher`, `funnel`, `expr`, `expr~`, `codebox`, `codebox~`, `pan`, `pan~`, `xfade`, `xfade~`, `waveform~`. `live.scope~` was discovered the same way (fixed via fresh add to `m4l/objects.json`, uncommitted as of this entry).

Update 2026-07-02 (quick-260702-gk6, commit 676b638): `audit_empty_io()` now returns an additive `by_source` key covering ALL 164 empty-I/O entries across every domain file (previously it saw only 43 — same-named package entries were shadowed by populated core entries in the merged dict). Biggest sources: packages/abclib 65, max 15, rnbo 11, packages/jit.mo 8, packages/grainflow 7. Use `by_source` to enumerate gaps per package.

**Why:** Extractor falls back to empty arrays on non-standard MAX ref pages. No gate on `empty_inlets_count` / `empty_outlets_count` in `extraction-log.json`. The 991f847 override for `live.scope~` only fixed domain, not I/O — patterns like this exist across the overrides file.

**How to apply:** When a user reports an object "missing" that you're sure you've used before, check `lookup()` returns AND inlet/outlet lengths — not just `exists()`. If either list is empty and there's no `variable_io_rules` entry, treat it as missing and populate via `overrides.json`. Before adding an object fresh to a domain file, search the packages/ subdirectories and `overrides.json` first — it may already exist with partial data worth merging.


===== feedback_expr_no_clip.md =====

---
name: MAX expr does not have clip() function
description: expr's function set is limited; use min(max(...)) instead of clip()
type: feedback
originSessionId: 5a78149b-6a12-4f75-a2ba-23a2a7fe75f6
---
The MAX `expr` object does NOT have a `clip()` function. Code like `expr clip($f1, 0., 1.)` fails at load with "expr: function clip not found".

**Why:** expr supports a fixed set of math functions (sin, cos, sqrt, pow, min, max, abs, etc.) but not the convenience clip/clamp helper that some other MAX objects support.

**How to apply:** Replace `clip(x, lo, hi)` in expr with `min(max(x, lo), hi)`. Example: `clip($f1/8., 0., 1.)` → `min(max($f1/8., 0.), 1.)`.


===== feedback_floor_tilde_rnbo.md =====

---
name: floor~ is RNBO-only, not MSP
description: floor~ doesn't exist in standard Max/MSP patches — use trunc~ (equivalent for non-negative signals) or ceil~/round~ variants
type: feedback
originSessionId: 14014e21-7d16-4ca5-bdcb-8969b859e04a
---
`floor~` is RNBO-only. Creating it at the top level of a .maxpat or inside a plain subpatcher fails with "No such object" when the patch loads in Max.

**Why:** The object DB lists `floor~` under the RNBO domain, which I read as "available" — but RNBO domain objects only exist inside `rnbo~` containers. Normal MSP code needs different primitives.

**How to apply:** For audio-rate integer truncation in an MSP context, use `trunc~` (truncates toward zero — equivalent to floor for non-negative input, which covers `phasor * N` use cases). For signed input where true floor semantics matter, build it manually: `trunc~ - (input <~ 0. && input !=~ trunc_output)` or migrate the math into a Gen~ codebox where `floor` is native. Always check `domain` on DB lookups before using a tilde object at the top level.


===== feedback_gen_param_messages.md =====

---
name: gen~ params use plain name messages, not @ attribute messages
description: To set gen~ Param values via messages, use "param_name $1" (no @). The @ attribute syntax does not work with gen~. Alternative is attrui object.
type: feedback
---

gen~ Param values are set by sending `param_name value` messages (NO @ prefix) to the gen~ inlet.

**Wrong:** `@depth $1` → gen~ (attribute syntax doesn't work with gen~)
**Right:** `depth $1` → gen~ (plain param name works)
**Also right:** `attrui` connected to gen~ (shows all params, sends correct format)

**Why:** gen~ does not parse incoming messages as attribute sets. It matches the first symbol against Param names directly.

**How to apply:** When building UI → gen~ parameter control chains, use message boxes with text `param_name $1` (no @). Or use `attrui` for a quick all-params interface.


===== feedback_genexpr_delay_syntax.md =====

---
name: GenExpr codebox uses Delay.read/write not delay()
description: In gen~ codebox, delay() is NOT supported. Must use Delay object with .write() and .read() methods. delay() is only for gen~ patcher (visual) mode.
type: feedback
---

In GenExpr codebox code, the `delay()` function is NOT available. Use the `Delay` object instead:

```
Delay myDelay(max_size);    // declaration (must be before expressions)
myDelay.write(input_signal); // write current sample
output = myDelay.read(time); // read at 'time' samples ago
```

Multiple reads from the same Delay at different positions are allowed (e.g., for pitch shifter dual-tap).

**Why:** MAX reports "The delay() operator is not supported in GenExpr; use the Delay.read and Delay.write instead." The `delay()` function is a gen~ patcher operator (visual object), not a codebox GenExpr function.

**How to apply:** When writing gen~ codebox code that needs delay lines, always use `Delay` declarations at the top (alongside Param/History), then `.write()` and `.read()` in the processing section. Also: variables used inside if/else must be initialized before the block to avoid "not defined" errors.


===== feedback_genexpr_io_syntax.md =====

---
name: GenExpr codebox uses in1/out1 not in 1/out 1
description: In gen~ codebox GenExpr code, input/output references use NO SPACE (in1, in2, out1, out2). The space form (in 1, out 1) is for gen~ patcher objects only.
type: feedback
---

GenExpr codebox code must use `in1`, `in2`, `out1`, `out2` (no space between keyword and number).

**Why:** The space form `in 1`, `out 1` is only valid for gen~ patcher objects (the visual `in` and `out` boxes). In codebox GenExpr code, `in 1` causes "statement missing ';'" errors because the parser sees `in` and `1` as two separate tokens.

**How to apply:** When writing GenExpr code strings for `add_gen()` or `build_genexpr()`, always use `in1`/`out1` format. The CLAUDE.md says "in 1" but that refers to patcher objects, not codebox code. The `parse_genexpr_io()` regex also expects `in1` format.


===== feedback_git_stash_prohibited.md =====

---
name: git stash is prohibited in this repo
description: CLAUDE.md Rule #7 forbids git stash; use commits or scoped test runs instead to verify regressions
type: feedback
originSessionId: 5d086a5c-ce21-4547-9d63-8666062ee143
---
Never use `git stash` in this repo. CLAUDE.md Rule #7 explicitly prohibits it after three orphaned stashes containing significant patch work were previously discovered and recovered.

**Why:** Worktree merges and multi-instance operation can silently orphan stashes; work can be lost. Stashes also pop unreliably when there are pyc collisions with the working dir.

**How to apply:**
- To verify "did my change cause this failure?", checkout a prior commit into a temp worktree, or run tests against `git show HEAD~N:path` — do NOT stash.
- To context-switch, `git commit` current work first (even as a WIP) rather than stashing.
- If tests leave `__pycache__` artifacts that interfere with checkouts, delete the pycache rather than stashing.
- If you already ran `git stash`, pop it immediately and verify `git status` matches the pre-stash state before moving on.


===== feedback_inlet_outlet_maxclass.md =====

---
name: inlet~/outlet~ do not exist as objects; use inlet/outlet
description: MAX has no separate inlet~ or outlet~ objects. Signal inlets use maxclass "inlet" (same as control). Signal type determined by connections.
type: feedback
---

There is no `inlet~` or `outlet~` object in MAX. Signal and control inlets both use the `inlet` object (maxclass: `"inlet"`). The signal/control distinction is determined by what's connected to them.

**Why:** Setting maxclass to "newobj" with text "inlet~" causes "No such object" errors in MAX. The `inlet` and `outlet` objects are in `UI_MAXCLASSES` and use their own name as maxclass.

**How to apply:** Always use `p.add_box("inlet")` and `p.add_box("outlet")` for abstraction I/O. Never create `inlet~` or `outlet~` boxes. Use `extra_attrs["comment"]` to label them (e.g., "L", "R", "signal in").


===== feedback_layout_spacing.md =====

---
name: tight_layout_spacing
description: User prefers very tight object spacing in MAX patches - ~20px vertical, ~5px between companions like gain~/meter~
type: feedback
---

Layout spacing should be tight, matching real MAX patch conventions. Previous values (V_SPACING=100, H_GUTTER=70) were far too spread out.

**Why:** User showed a manually-adjusted mixer strip with receive~ → gain~/meter~ at 16-20px vertical gap and 5px horizontal gap between gain~ and meter~. Generic "80-120px vertical, 150-200px horizontal" from CLAUDE.md does not match actual MAX patching style.

**How to apply:** Use V_SPACING=20, H_GUTTER=15, and companion detection (meter~ beside gain~, not below) for all generated patches. These values are now set in defaults.py.


===== feedback_line_tilde_comma.md =====

---
name: line~ comma message bug
description: line~ (signal-rate) replaces ramps on new messages; use single list not comma-separated segments for multi-segment envelopes
type: feedback
---

Never use commas in message boxes feeding `line~` for multi-segment ramps. Unlike control-rate `line` which queues comma-separated segments, signal-rate `line~` replaces the active ramp each time a new message arrives. Comma-separated messages arrive in the same scheduler tick but as separate messages, so only the last segment takes effect.

**Why:** In the rhythmic-sampler slot patch, `$1 $2, 0. $3` sent two messages to line~. The second ("ramp to 0") immediately overwrote the first ("ramp to vel"), so line~ stayed at 0 and the envelope never opened.

**How to apply:** For line~ envelopes, use a single list of alternating target-time pairs: `$1 $2 0. $3` (no comma). This sends one message that line~ interprets as a complete breakpoint function. This applies to any multi-segment line~ ramp — attack-decay, ADSR segments, etc.


===== feedback_live_scope_tilde.md =====

---
name: live.scope~ is a real MAX object
description: live.scope~ is a Live-UI oscilloscope available in MAX proper (not just M4L); 2 signal inlets, 1 bang outlet. Was missing from object DB — added to m4l/objects.json on 2026-04-19.
type: feedback
originSessionId: 31e0f7f4-f113-4f5e-8597-2259decb01f7
---
`live.scope~` is a real MAX object (verified in `patches/gong-model/generated/gong-model.maxpat`). It is the Live-UI styled oscilloscope equivalent of `scope~`.

**Signature:**
- `maxclass: "live.scope~"`
- 2 signal inlets (display, second channel/trigger)
- 1 bang outlet (refresh notification)

**Why:** On 2026-04-19 during `/max-new bassoon-model`, I flagged `live.scope~` as not in the database and asked the user to pick from `scope~` / `live.meter~` / `spectroscope~`. The user corrected me — it's a common object they use (gong-model uses it). It had simply been missing from the DB.

**How to apply:** Trust the user when they say a `live.*` object exists and isn't in the DB — Live UI objects were incompletely extracted. Verify by grepping existing `.maxpat` files in the repo (`patches/`) before declaring an object unknown. When a missing object is confirmed, add it to `.claude/max-objects/m4l/objects.json` so future lookups succeed.


===== feedback_m4l_no_gain.md =====

---
name: M4L devices don't need gain~ before plugout~
description: Skip gain~/live.gain~ before plugout~ in M4L devices -- Ableton's channel strip handles volume
type: feedback
---

Do not add gain~ or live.gain~ before plugout~ in Max4Live devices. Ableton handles volume control in its own channel strip, so an extra gain object is redundant and can cause silence (gain~ defaults to 0).

**Why:** gain~ initializes at 0 and requires user interaction to raise, making the device appear broken/silent on load. M4L instruments should output signal directly to plugout~.

**How to apply:** When building M4L devices (.amxd), route the final signal processing stage directly to plugout~ inlets. Also skip ezdac~ (standalone only). Volume, pan, and mute are handled by Ableton's mixer.


===== feedback_m4l_param_connect.md =====

---
name: M4L live.* objects need param_connect for gen~ Param binding
description: live.dial/live.slider must use param_connect attribute, not message-box patching, to bind to gen~ Params
type: feedback
originSessionId: 8a273319-2307-40f3-ac87-2275646b9604
---
M4L `live.dial` / `live.slider` objects must bind to gen~ Params via `param_connect`, NOT via intermediate message boxes. The correct pattern:

```json
{
    "maxclass": "live.dial",
    "param_connect": "<gen~_varname>::<param_name>",
    "parameter_enable": 1,
    "saved_attribute_attributes": {
        "valueof": {
            "parameter_initial": [0.5],
            "parameter_initial_enable": 1,
            "parameter_longname": "<param_name>",
            "parameter_shortname": "<param_name>",
            "parameter_mmin": 0.0,
            "parameter_mmax": 1.0,
            "parameter_modmode": 3,
            "parameter_type": 0,
            "parameter_unitstyle": 1
        }
    },
    "varname": "<param_name>"
}
```

The gen~ object must have a `varname` (e.g., `"gen~_AA"`) that matches the prefix in `param_connect`. No patchcord is needed between the dial and gen~ — `param_connect` IS the binding.

**WRONG pattern (what we did initially):** `live.dial` → `message "<param> $1"` → `gen~`. This passes values but does NOT expose the dial as a Live-automatable parameter and does not show it in Live's parameter list.

**Slider + line~ exception:** When `live.slider` feeds a signal-rate input (via `line~` → gen~ signal inlet), you CAN'T use `param_connect` (it only binds to Params, not signal inputs). Instead:
- Keep the `slider → line~ → gen~` signal path
- Add `parameter_enable: 1` + `saved_attribute_attributes.valueof` to the slider itself
- This makes it a standalone live.parameter that Live can automate; its value still flows through `line~` to the signal inlet

**Why:** User caught this — the auto-generated dials weren't bindable to parameters in Live's parameter list. Manual test: added a new dial in Max, used Inspector's "Parameter > Long Name" dropdown to pick `bell_brightness`, Max generated `param_connect` automatically.

**How to apply:** For any M4L patch where `live.dial`/`live.slider` should control a gen~ Param, use `param_connect` pattern from codegen. Reserve message-box routing only for non-Param targets (e.g., control-rate messages to an object that isn't gen~). The project's gen~ block MUST have a stable `varname` for this to work.


===== feedback_maxclass_newobj.md =====

---
name: feedback_maxclass_newobj
description: Most MAX objects use maxclass="newobj" with text field; only true UI widgets use their own maxclass
type: feedback
---

gen~, click~, and most MAX objects use `maxclass="newobj"` with the object name in the `text` field. Only true UI widgets (button, toggle, dial, meter~, gain~, ezdac~, flonum, number, scope~, spectroscope~, levelmeter~, etc.) use their own name as maxclass with no text field.

**Why:** The object database incorrectly sets `maxclass` to the object's own name for ~667 objects. The `UI_MAXCLASSES` set in `maxclass_map.py` is the actual source of truth. gen~ was incorrectly in that set, causing patches to fail in MAX with "invalid attribute maxclass" errors.

**How to apply:** When adding new objects to UI_MAXCLASSES, verify against a hand-made or known-working .maxpat file. Reference patches in `patches/scala-synth/generated/` and `patches/rhythmic-sampler/generated/` show correct maxclass usage. Never trust the database's `maxclass` field for this decision.


===== feedback_maxpat_roundtrip_and_diffing.md =====

---
name: feedback_maxpat_roundtrip_and_diffing
description: "Patcher.to_dict round-trip is lossless (uses box._raw); standalone Box.to_dict is lossy. Diff suspected .maxpat regressions against committed git objects, never the working tree."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 7066f9d6-a607-4512-8933-a29f072d9462
---

Two linked facts proven while debugging a phantom "layout broke the GO button" regression in psycography.

**1. `save_patch_roundtrip(patcher.to_dict(), path, orig)` is LOSSLESS.** `Patcher.from_dict` stores each box's raw JSON in `box._raw` (and unknown keys in `box.extra_attrs`), and `Patcher.to_dict()` merges `_raw` back — so hand-authored attributes like a panel's `ignoreclick:1`/`border`, message text, and `numinlets` survive a read→apply_layout→save cycle. Verified: committed layout commit diffed against pre-layout showed ONLY the added version-comment box; every wiring/behavior attr identical. The standalone **`Box.to_dict()` is LOSSY** (drops `extra_attrs`/`_raw` → e.g. `ignoreclick` becomes None, inlet counts get recomputed from the DB, message text with em-dashes mangles). Never serialize a single Box directly; always go through `Patcher.to_dict()`.

**Why:** I wrongly concluded apply_layout had stripped a background panel's `ignoreclick:1` (which would make the panel eat all presentation-mode clicks and disable the GO button). It hadn't — the sanctioned path preserved it.

**How to apply:** Trust `save_patch_roundtrip`. Don't revert a clean layout out of fear; confirm first.

**2. Diff suspected .maxpat regressions against COMMITTED git objects, not the working tree.** The "regression" came from reading a working-tree `main.maxpat` that carried the lossy-Box-serialization signature (ignoreclick dropped, numinlets recomputed) yet did NOT match its own HEAD commit — a transient degraded copy (possibly another instance / stray save; repo had stale `.claude/worktrees/` agent worktrees). Reading via `git show <commit>:path` for both sides gave the truth.

**How to apply:** When verifying whether a commit changed behavior, compare `git show A:file` vs `git show B:file` (or compare the working tree to `git diff --quiet HEAD -- file` first to confirm it's clean). A working-tree read alone can produce phantom diffs. Links: [[feedback_db_empty_io]], [[feedback_worktree_stash_danger]].


===== feedback_message_box_width.md =====

---
name: MAX message box rendered width
description: MAX renders message boxes wider than patching_rect width; use 8px/char + 25px chrome for layout spacing
type: feedback
---

When calculating layout spacing for message boxes in patching mode, the stored `patching_rect` width is NOT the actual rendered width. MAX adds visual chrome/padding beyond the stored width.

**Why:** First attempt used stored widths + 5px gap and boxes still overlapped visually. Second attempt with 8px/char + 25px chrome + 8px gap resolved all overlaps.

**How to apply:** When positioning message boxes to avoid overlap, estimate rendered width as `len(text) * 8 + 25` and use at least 8px gap between them. Do NOT rely on the stored `patching_rect[2]` width for spacing calculations.


===== feedback_msp_outlet_types.md =====

---
name: MSP outlet type extraction bug
description: The object DB extraction incorrectly marks all MSP object outlets as signal -- many are actually control (bangs, floats). Always verify outlet types for MSP objects with mixed outlets.
type: feedback
---

The automated extraction that built `.claude/max-objects/msp/objects.json` marked ALL outlets on MSP objects as `signal: true`. In reality, many MSP objects have mixed outlet types -- signal outlets for audio and control outlets for bangs/floats/lists (e.g., "done" notifications, peak values, indices).

This caused the validator to strip legitimate control connections (e.g., `buffer~ outlet 1 → message box`) because it saw them as "signal outlet to control inlet" errors.

**Fixes applied (2026-03-11):**
1. `src/maxpat/db_lookup.py` -- Added override merging logic; previously only `variable_io_rules` were loaded from `overrides.json`, the `objects` section was silently ignored.
2. `.claude/max-objects/overrides.json` -- Added correct outlet types for 16 commonly-used MSP objects with mixed outlets: `buffer~`, `info~`, `line~`, `curve~`, `play~`, `sfplay~`, `polybuffer~`, `train~`, `ramp~`, `meter~`, `peek~`, `thispoly~`, `stretch~`, `zigzag~`, `vst~`, `stash~`.

**When building future patches:** If connecting from an MSP object's non-primary outlet (anything beyond outlet 0) and the connection gets stripped by validation, check `overrides.json` first -- if the object isn't overridden yet, add it. The scan command to find suspects:
```python
# Outlets marked signal but digest suggests control
[o for o in obj['outlets'] if o['signal'] and any(kw in o['digest'].lower() for kw in ['bang', 'int', 'float', 'index', 'done', 'status'])]
```


===== feedback_multislider_fetch.md =====

---
name: multislider fetch message and outlet behavior
description: multislider uses "fetch" (not "fetchindex") and outputs fetched values from the RIGHT outlet, not the left
type: feedback
---

1. The message to retrieve a value at an index from multislider is `fetch $1`, NOT `fetchindex $1`. "fetchindex" does not exist.
2. When `fetch [index]` is sent to multislider, the value comes out of the RIGHT outlet (outlet 1), not the left outlet (outlet 0). The left outlet is for direct interaction/editing.
3. In a step sequencer, do NOT use `split` to filter velocities between the multislider and the envelope trigger. The multislider already outputs the correct velocity values — adding split creates unnecessary filtering that can block valid values.

**Why:** These errors appeared in a rhythmic sampler step sequencer patch and caused silent failures — wrong message name produced no output, wrong outlet assumption broke the data flow, and split filtered out valid step data.

**How to apply:** When generating patches that read from multislider by index (e.g., step sequencers), always use `fetch`, always connect from outlet 1 (right), and don't insert filtering objects between the multislider output and the downstream processing unless explicitly needed.


===== feedback_node_script_missing.md =====

---
name: feedback_node_script_missing
description: node.script (Node for Max) is absent from the object DB; use a build-time Python data tool instead
metadata: 
  node_type: memory
  type: feedback
  originSessionId: cd94fd64-73af-4b46-bf65-2693fd070fd3
---

`node.script` (the Node for Max object) is NOT in `.claude/max-objects/` — `db.lookup("node.script")`,
`"node"`, and `"nodescript"` all return None, and there's no alias. Per CLAUDE.md Rule #1 it therefore
cannot be used in generated patches, even though CLAUDE.md has a whole N4M section.

**Why:** Discovered while researching the `psycography` patch (MIDI tempo-track parsing). The DB gap forces
a choice between fragile in-patch binary parsing (`js`/`v8`) and an offline tool.

**How to apply:** For tasks that would naturally use Node for Max (file I/O, binary parsing, npm libs),
prefer a **build-time Python data tool** that emits `coll`/`dict` data files the patch loads with verified
objects — this is NOT a banned generator script (Rule #5 only forbids regenerating `.maxpat`). If in-patch
Node is truly required, first add `node.script` to the DB. See [[feedback_db_empty_io.md]] for related
DB-completeness gaps.


===== feedback_replace_box_orphans.md =====

---
name: replace_box orphans connections
description: Patcher.replace_box() removes ALL connections to/from the old box and returns them as orphaned — caller MUST rewire them
type: feedback
originSessionId: 36349722-2da9-4b19-a0b4-ed4960f717de
---
`Patcher.replace_box(old, new_name, args=...)` does NOT preserve connections. It captures every line touching `old_box` as `EditResult.orphaned` and removes them. The new box has the old position but no wires. The docstring is explicit: *"returns ALL old connections as orphaned (no auto-remap per CONTEXT.md locked decision). The caller handles rewiring."*

**Why:** Burned in `rhythmic-corpus-chopper` v0.0.9 — replaced `ears.slice~` with `ears.split~` and lost three connections (`ears.split~ outlet 0 -> t l l`, `zl.reg -> ears.split~ inlet 0`, `t b l outlet 1 -> ears.split~ inlet 1`), silently disconnecting the slicer. Took two extra version bumps to diagnose.

**How to apply:** After every `replace_box` call, iterate `result.orphaned` and re-add the connections via `add_connection(...)`, mapping outlet/inlet indices through if the new object's I/O layout matches. If a different I/O layout, manually rewire each connection. Never assume connections survive.


===== feedback_umenu_items_format.md =====

---
name: umenu items format
description: Correct .maxpat JSON format for umenu menu items uses comma-as-elements in array
type: feedback
---

umenu items in .maxpat JSON must use comma strings as separate array elements between item names:
```json
"items": [ "LP", ",", "HP", ",", "BP", ",", "Notch" ]
```

**Why:** Neither a plain JSON array `["LP", "HP", "BP", "Notch"]` nor a comma-separated string `"LP, HP, BP, Notch"` works — both result in all items appearing as a single menu entry. MAX's internal format treats `","` as a delimiter element within the array.

**How to apply:** When setting umenu items via `extra_attrs['items']` in the PatchBuilder, use the interleaved format. Alternatively, populate at runtime via loadbang → `clear, append X, append Y, ...` message chain (this always works reliably).


===== feedback_waveguide_loop_phase_comp.md =====

---
name: Resonant filters belong OUT of a waveguide loop; non-resonant LPFs need phase-delay compensation
description: Rules for adding filters to gen~ waveguide bore loops — high-Q goes post-loop, low-Q in-loop needs analytic phase-delay (not group-delay) compensation
type: feedback
originSessionId: 08f7409c-4bc8-4ca2-8982-17a9847364fc
---
Two distinct rules for filters and gen~ waveguide bore loops. Know which one applies before adding a filter to the feedback path.

## Rule 1 — Resonant (Q > ~1) filters go POST-LOOP

A resonant filter inside the feedback loop competes with the bore's self-excited mode. The loop locks onto whichever resonance has higher Q × gain, not onto freq_mod. No amount of phase-delay compensation fixes this — it's a mode-competition problem, not a phase-shift problem.

**Symptom:** sweeping the filter's fc causes the output fundamental to jump to the filter's fc, or to subharmonics, or to stable-but-wrong octaves. Python simulation reveals factor-of-N pitch jumps, not smooth detuning.

**Fix:** apply the filter POST-LOOP to `bore_return` (or whatever the bore output wavelet is). The loop sees the raw bore signal; the listener hears the filtered version. No tuning coupling.

Physical analog: bell radiation = how the pressure wave couples to the outside air. Bell reflection = how the pressure wave bounces back into the bore. These are different transfer functions even though they share physics — model them separately.

## Rule 2 — Non-resonant in-loop LPFs need phase-delay (NOT group-delay) compensation

An onepole / low-Q filter in the feedback path can stay in-loop safely, but its phase delay lengthens the round trip and shifts pitch as its coefficient sweeps. Subtract analytic **phase delay** (−φ(ω)/ω) from the target period. Never group delay — for resonant sections group delay overshoots phase delay by 3× or more.

**Onepole LPF** (y = y_prev + a·(x − y_prev), b = 1−a):
```
pd_samples = atan(b*sin(w) / (1 - b*cos(w))) / max(w, 0.0001)
```

**Biquad** — evaluate B(e^jw)/A(e^jw) as complex numbers, take atan2, subtract:
```
PB_re = b0 + b1*cos(w) + b2*cos(2w);  PB_im = -(b1*sin(w) + b2*sin(2w))
PA_re = 1  + a1*cos(w) + a2*cos(2w);  PA_im = -(a1*sin(w) + a2*sin(2w))
phi_H = atan2(PB_im, PB_re) - atan2(PA_im, PA_re)
if (phi_H > 0.01) phi_H -= TWOPI   // up to 2 unwraps for stable 2nd-order
pd_samples = -phi_H / max(w, 0.0001)
```

## Why

Four iterations on bassoon-model:
- **v0.3.1**: added a low-Q bore_damp onepole in the reflection path; needed onepole phase-delay compensation (worked).
- **v0.4.0/0.4.1**: replaced bell onepole with Q=2.5 biquad in the loop; even with correct phase-delay compensation, pitch jumped wildly as bell_bright swept (bore locked onto biquad's 500 Hz resonance instead of freq_mod). Group-delay form (v0.4.0) was also wrong, but even the fixed phase-delay form (v0.4.1) couldn't rescue an in-loop high-Q filter.
- **v0.4.2**: moved biquad out of the loop as a post-loop radiation filter. Python simulation confirmed bit-exact pitch stability across the bell_bright sweep at every target freq.
- **v0.5.0/0.5.1**: same trap on the reed side — placed Q=1-6 reed-channel BPF between reed LUT and bore injection (`bore_in_s = reed_filt + cone_return`). Sweeping reed_res_freq pulled the fundamental instead of coloring timbre. Fix (v0.5.1): bore injection reverts to dry reed_sig; reed_filt is summed into the bell biquad input (`rad_in = bore_return + reed_filt`) so the reed honk colors radiation only. Third confirmation that "source-side" filters between a driver nonlinearity and a waveguide still count as in-loop if the filter output feeds the delay line — not just filters in the reflection path.

## How to apply

1. **Q heuristic:** Q ≤ ~1 can live in-loop with phase-delay compensation. Q ≥ ~1.5 should go post-loop.
2. **Pre-flight with a Python simulation** before committing: implement the waveguide loop in numpy, sweep the new filter's controlling Param across its full range at a few target freqs, measure the output fundamental via autocorrelation or FFT. If pitch moves more than a few cents across the sweep, the architecture is wrong.
3. **In-loop compensation checklist:** share filter coefficients between the phase-comp block and the filter step (single source of truth); unwrap atan2 when total H phase drops past −π; clamp final compensation to a sane range (e.g., [0, 64] samples).
4. **Post-loop filters** don't need any compensation — they're not in the resonance path.


===== feedback_worktree_stash_danger.md =====

---
name: Worktree agents can orphan stashes and lose work
description: GSD worktree merge uses brittle git stash && merge && pop chain that breaks on conflict, leaving working tree changes orphaned in stash
type: feedback
---

NEVER use `git stash && git merge ... && git stash pop` as a chain. When merge conflicts, the `&&` short-circuits and `git stash pop` never runs, silently losing all uncommitted work.

**Why:** This has caused major setbacks multiple times. A GSD worktree agent merge orphaned stash@{0} containing 35 files of uncommitted patch work (scala-synth v0.1.3, rhythmic-sampler, minitaur, etc.). The user didn't realize until functionality was visibly missing.

**How to apply:**
- Before any worktree merge, check `git stash list` for orphaned stashes
- If working tree is dirty before a merge, commit or stash with explicit pop-back
- After ANY git stash operation, verify it was popped: `git stash list` should not grow
- If a merge conflicts after stash, resolve the conflict AND THEN run `git stash pop`
- The GSD worktree merge protocol has no explicit stash-restore step — this is the root bug
