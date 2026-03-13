# Domain Pitfalls: v1.1 Patch Quality & Aesthetics

**Domain:** Adding help patch auditing, database bulk updates, patch aesthetics, and layout refinement to existing MAX/MSP development framework
**Researched:** 2026-03-13
**Confidence:** HIGH for help patch parsing and DB pitfalls (verified against actual MAX installation and codebase), MEDIUM for aesthetic properties (reverse-engineered, no official spec), HIGH for layout pitfalls (verified against actual MAX help patch widths vs. calculated widths)

---

## Critical Pitfalls

Mistakes that corrupt the object database, break existing patch generation, or produce invalid patches.

---

### Pitfall 1: Help Patch Outlet Types Are Authoritative -- But Only for Connected Instances

**What goes wrong:** The help patch audit extracts `outlettype` from the first `buffer~` instance found and uses it as ground truth, but help patches contain multiple instances with different argument configurations that change outlet count and type, plus degenerate instances used as labels.

**Why it happens:** Many MSP objects have variable outlet counts depending on arguments. For example, `sfplay~` with 2 channels has outlets `["signal", "signal", "bang"]` while `sfplay~` with 1 channel has `["signal", "bang"]`. Help patches often contain both configurations in different subpatcher tabs.

**Evidence from this project:** Analysis of `buffer~.maxhelp` found 7 instances across subpatchers. Most had `outlettype: ["float", "bang"]` with `numoutlets: 2`, but one instance had `numoutlets: 0` (used as a label/comment with text `"buffer~  has its own sample rate..."`). Blindly first-matching or averaging would include the degenerate case.

**Consequences:**
- Outlet type arrays become wrong for specific argument configurations
- The override system (`overrides.json`) may get clobbered with incorrect "audited" data
- Validation strips valid connections by misidentifying outlet types
- The exact MSP outlet type bug that already happened (all outlets marked `signal` when many are `control`) gets reintroduced from a different source

**Prevention:**
- When auditing help patches, filter out degenerate instances (`numoutlets=0`, objects used as labels/comments with no connections)
- Prefer instances that have connections FROM them (demonstrating actual outlet usage) -- the `buffer~` instance at `outlettype: ["float", "bang"]` with connections `outlet 1 -> button inlet 0` and `outlet 0 -> flonum inlet 0` is the gold-standard source
- Track outlet types per argument configuration, not just per object name
- For variable-outlet objects (`sfplay~`, `groove~`, `vst~`), record the base/default outlet types and document how arguments change them
- Never overwrite existing `overrides.json` entries without human review -- the 16 manually corrected MSP objects represent hard-won ground truth

**Detection:** After bulk update, diff `overrides.json` against pre-update version. Any change to manually corrected entries is suspicious. Run the existing 624 test suite -- any regression in connection validation tests signals corrupted outlet type data.

**Phase:** Help patch audit phase. Must be addressed before any bulk writes to the DB.

---

### Pitfall 2: Bulk Database Update Breaks the Override Merge Order

**What goes wrong:** Bulk-updating `msp/objects.json` with help-patch-extracted outlet types overwrites the base data, making `overrides.json` corrections either redundant or conflicting.

**Why it happens:** The current `db_lookup.py` loads domain JSON files first, then deep-merges `overrides.json` on top (lines 66-81). This works because `overrides.json` is the authoritative layer -- it always wins. But if the help patch audit updates `msp/objects.json` with new outlet data, three failure modes emerge:

1. **Override becomes stale:** The base data now agrees with the override, making the override appear redundant. Someone removes the override. Later, the base data gets re-extracted from XML (which has the original bug) and the override is gone.
2. **Override conflicts with new base:** The help patch audit extracts `outlettype: ["signal", "bang"]` for `line~`, which contradicts the override that says `outlets: [{signal: true}, {signal: false}]`. The override format uses `outlets` array with `signal` boolean, while `outlettype` is a flat string array. The merge does not reconcile these different representations.
3. **Load order sensitivity:** RNBO objects load before MSP objects (see `DOMAIN_LOAD_ORDER` in `db_lookup.py`). If an RNBO variant of `cycle~` has different outlet types than the MSP variant, updating MSP data can mask the RNBO definition depending on load order.

**Consequences:**
- 16 manually verified MSP outlet corrections silently lost
- `multislider` `fetch` correction (already in overrides) overwritten
- RNBO-specific outlet types (e.g., RNBO `cycle~` has 2 outlets vs. MSP `cycle~` with 1) clobbered by MSP data
- Connection validation regression across multiple existing patches

**Prevention:**
- Never bulk-write to domain JSON files if the data conflicts with `overrides.json`
- Audit script must load `overrides.json` first and skip any object that has manual overrides
- Implement a "dry run" mode for DB updates that shows a diff before writing
- Add a `source` field to extracted data: `"source": "help_patch"` vs `"source": "xml_refpage"` vs `"source": "manual_override"` -- manual always wins
- Keep the override system as the authoritative layer -- help patch data goes into base files, corrections stay in overrides

**Detection:** Run `python -m pytest tests/` after every bulk update. Specifically, connection validation tests that verify `buffer~` outlet 1 connects to control inlets. If this test breaks, the override merge is corrupted.

**Phase:** Must be designed before the audit runs. The audit pipeline needs an "override-aware" mode from the start.

---

### Pitfall 3: Help Patch Tab Structure Hides All Content in Subpatchers

**What goes wrong:** The help patch parser only reads top-level boxes and misses the actual example content, which is buried inside subpatcher tabs.

**Why it happens:** MAX help patches use a tab-based structure where the visible content is inside subpatchers with `showontab: 1`. The top-level patcher contains only infrastructure boxes.

**Evidence:** Analysis of `trigger.maxhelp` confirms: top-level has 6 boxes (3 subpatchers, a jsui, a message, a js helpstarter). The actual example objects with connections are inside:
- `p basic`: 20 boxes (the primary examples)
- `p examples`: 27 boxes (advanced examples)
- `p ?`: 0 boxes (empty "see also" tab)

A parser that only reads top-level boxes finds zero instances of `trigger`.

**Consequences:**
- Audit reports "object not found in its own help patch" for 100% of objects
- Outlet types extracted from zero connections
- Entire audit produces no useful data

**Prevention:**
- The help patch parser must recursively descend into all subpatchers
- Identify tab subpatchers by checking `showontab: 1` in the inner patcher properties
- For each subpatcher tab, collect all box instances and connection data
- Be aware that some help patches nest subpatchers inside subpatcher tabs (3+ levels deep)
- Handle the `p ?` tab gracefully -- it may have 0 boxes

**Detection:** After parsing, verify that at least one instance of the named object was found. If zero instances found, the parser failed to descend into tabs.

**Phase:** First step of the help patch audit pipeline. Must work before any data extraction.

---

### Pitfall 4: Box Width Calculation Is Inaccurate by -59px to +50px

**What goes wrong:** Generated patches have boxes that are too wide or too narrow, causing overlapping objects, excessive spacing, or patch cords that connect at wrong visual positions.

**Why it happens:** The current sizing formula (`len(text) * 7.0 + 16.0`) uses a fixed character width of 7px for Arial 12pt. But MAX uses proportional font metrics, not monospaced. Analysis of actual box widths from `trigger.maxhelp` reveals significant errors:

| Object text | Actual (MAX) | Calculated | Error |
|---|---|---|---|
| `js helpstarter.js trigger` | 132.0 | 191.0 | **-59px** (way too wide) |
| `+` | 89.5 | 40.0 | **+50px** (way too narrow) |
| `t b i` | 32.5 | 51.0 | -18px |
| `accum 0.` | 91.5 | 72.0 | +20px |
| `print 5` | 48.0 | 65.0 | -17px |
| `p basic` | 50.0 | 65.0 | -15px |

Key findings:
- Short object names get a minimum width from MAX that is larger than `MIN_BOX_WIDTH=40` (the `+` object is 89.5px for a single character)
- Long text gets narrower than calculated because most characters are narrower than 7px average
- The current `MIN_BOX_WIDTH=40` is too small -- MAX enforces at least ~50px for most objects

**Consequences:**
- Objects overlap when boxes are calculated too narrow
- Excessive horizontal spread when boxes are calculated too wide
- Inlet/outlet X positions calculated from wrong box widths cause cable routing to miss connection points
- The layout engine's parent-center-x alignment becomes inaccurate, increasing cable crossings

**Prevention:**
- Extract actual box widths from help patches as ground truth for a per-object width lookup table (at least for the 50 most common objects)
- Use a proportional character width approach instead of fixed 7px: narrow chars (`i`, `l`, `1`, `.`) at ~4px, wide chars (`m`, `w`) at ~10px, typical at ~6-7px
- Increase `MIN_BOX_WIDTH` to at least 50px (many MAX objects enforce a wider minimum)
- For arithmetic operators (`+`, `-`, `*`, `/`) that MAX renders extra-wide, maintain a small override table
- Consider extracting widths empirically from a corpus of help patches

**Detection:** Compare calculated widths against actual widths from help patches for the top 50 most-used objects. Currently P95 error is ~50px, target should be under 10px.

**Phase:** Layout refinement phase. Can be done incrementally -- start with the override table for the worst offenders.

---

## Moderate Pitfalls

---

### Pitfall 5: The "bgfillcolor" Dict Has Undocumented and Version-Varying Structure

**What goes wrong:** Generated patches include `bgfillcolor` properties that render incorrectly or are silently ignored because the dict structure is incomplete or wrong.

**Why it happens:** The `bgfillcolor` property is a nested dict with format that differs between solid color and gradient modes. Cycling '74 has never documented the exact JSON schema. Evidence from help patches and community forums shows:

**Solid color mode (panel in attrui.maxhelp):**
```json
{
  "mode": 0,
  "angle": 270.0,
  "proportion": 0.39
}
```

**Gradient mode (panel in attrui.maxhelp):**
```json
{
  "mode": 1,
  "angle": 270.0,
  "proportion": 0.39,
  "grad1": [0.96, 0.83, 0.16, 1.0],
  "grad2": [0.76, 0.59, 0.10, 1.0],
  "bordercolor": [0.90, 0.80, 0.39, 1.0]
}
```

**Known gotchas (verified via Cycling '74 forums):**
- `proportion` value of exactly `1.0` causes visual glitch ("jumps in the middle again") -- must cap at `0.9999`
- `pt1`/`pt2` coordinates override `angle` -- setting `pt1`/`pt2` makes subsequent `angle` messages non-functional
- The `bgfillcolor` dict "only stores attributes that deviate from defaults" -- generating the full dict with all fields may produce unexpected results
- Setting `bgfillcolor` as a flat list `[r, g, b]` forces single-color mode, destroying any gradient configuration

**Consequences:**
- Panels with no visible gradient despite gradient being specified
- Colors appearing different than intended
- MAX 8 patches loading with wrong colors when opened in MAX 9 or vice versa

**Prevention:**
- Always use gradient mode (`mode: 1`) when specifying panel backgrounds with gradients
- Cap `proportion` to `[0.0, 0.9999]` range
- Do not mix `angle` with `pt1`/`pt2` -- use one or the other
- Extract known-good panel configurations from MAX help patches as templates
- Test generated aesthetic properties by opening in MAX and visually inspecting

**Detection:** Visual inspection only -- there is no offline way to verify color rendering. Add a "panel gallery" test patch for manual review.

**Phase:** Aesthetic implementation phase. Must handle before adding panel/background support to the generator.

---

### Pitfall 6: Panel Z-Order and the "background" Property

**What goes wrong:** Panels intended as visual backgrounds appear in front of objects, obscuring them.

**Why it happens:** In MAX, panels have a `background` property (integer: 0 or 1). When `background: 1`, the panel renders behind all other objects. When `background: 0` (default), the panel renders in its normal layer position, determined by creation order in the `boxes` array.

**Evidence:** The actual MAX JSON from `attrui.maxhelp` confirms: `"background": 1` is set on panels used as section backgrounds. Without this property, the panel renders ON TOP of objects added before it in the boxes array.

**Consequences:**
- Panels cover objects, making the patch unusable
- Users have to manually send panels to background in MAX
- Professional appearance ruined

**Prevention:**
- Always set `"background": 1` on panels used as section/group backgrounds
- Place panel boxes at the BEGINNING of the `boxes` array (first items render first)
- Use both approaches together: `background: 1` AND early array position
- Also set `"ignoreclick": 1` on background panels so they do not interfere with clicking objects
- Document that panel `patching_rect` must fully encompass the objects it backgrounds -- leave 10-15px margin on all sides

**Detection:** Open the generated patch in MAX. If panels obscure objects, the z-ordering is wrong.

**Phase:** Aesthetic implementation, specifically panel support.

---

### Pitfall 7: Aesthetic Properties on Comment Boxes Use Different Property Names

**What goes wrong:** Comment styling (font, color, background) applied using the same properties as other boxes renders differently or is ignored.

**Why it happens:** Comment boxes (`maxclass: "comment"`) in MAX have a distinct rendering path. Key differences:
- Comments use `clearcolor` (not `bgcolor`) for their background -- this is a patcher-level style property
- Comments support `textcolor` but the property name in JSON is `textcolor` (not `fontcolor` or `color`)
- Comments do not support `bgfillcolor` gradients
- The `fontface` property uses integer codes: 0=regular, 1=bold, 2=italic, 3=bold+italic
- Comment box height does not auto-adjust to font size in the JSON -- changing `fontsize` requires manual update of `patching_rect[3]`

The current `sizing.py` uses `COMMENT_HEIGHT = 20.0` as a fixed value regardless of font size.

**Consequences:**
- Comments with larger fonts get clipped vertically
- Background color applied via `bgcolor` has no visible effect on comments
- Styled comments look correct in JSON but wrong in MAX

**Prevention:**
- Maintain separate style property maps for comments vs. other box types
- Comment height should be calculated from font size: approximately `fontsize * 1.5 + 4` pixels
- Use `textcolor` (not `color`) for comment text color
- Test comment rendering in MAX with different font sizes

**Detection:** Open a test patch with styled comments in MAX. If text is clipped or background is invisible, the properties are wrong.

**Phase:** Aesthetic implementation, specifically comment styling.

---

### Pitfall 8: Layout Test Assertions Break on Any Spacing Change

**What goes wrong:** Refinements to the layout algorithm cause many existing tests to fail because they assert specific pixel positions or narrow ranges.

**Why it happens:** The current test suite (`test_layout.py`) has assertions like:
- `assert 10 <= gap <= 40` (vertical gap range)
- `assert 5 <= gutter <= 30` (horizontal gutter range)
- `assert abs(actual_gap - expected_gap) < 5.0`

These ranges were calibrated for `V_SPACING=20` and `H_GUTTER=15`. Changing these constants or changing box sizing shifts every position.

**Evidence:** When `V_SPACING` was changed from 100 to 20 (documented in `feedback_layout_spacing.md`), the spacing tests had to be updated. Any further refinement will require another round.

**Consequences:**
- Developers avoid layout improvements because they trigger mass test breakage
- Tests get widened to pass (making them useless for regression detection)
- Actual layout quality regressions go undetected

**Prevention:**
- Refactor layout tests to test relative properties (A is above B, B is above C, no overlap) rather than absolute pixel ranges
- Keep a small set of "golden" test patches for intentional regression detection
- Derive spacing assertions from the constants themselves: `gap >= V_SPACING * 0.8` and `gap <= V_SPACING * 1.5`
- Add visual regression tests: generate a patch, serialize to JSON, compare against a known-good JSON fixture
- When changing layout constants, restructure tests FIRST, then change constants

**Detection:** Run `pytest tests/test_layout.py -v` after any layout change. If more than 3 tests fail from a single constant change, the tests are too brittle.

**Phase:** Before layout refinement starts. Restructure tests first, then refine layout.

---

### Pitfall 9: Help Patch maxclass-to-Name Mapping Goes Wrong Direction

**What goes wrong:** The help patch parser cannot match objects in help patches to objects in the database because help patches use maxclass values while the database keys by object name.

**Why it happens:** In help patches, UI objects appear with their maxclass as the key (e.g., `"maxclass": "number"` for number boxes, `"maxclass": "flonum"` for float number boxes). The `maxclass_map.py` module resolves name-to-maxclass, but the audit needs maxclass-to-name (the reverse direction).

Additionally, for `maxclass: "newobj"`, the object name is the first token of the `text` field. For UI objects, the maxclass IS the name. The parser must handle both cases consistently.

**Prevention:**
- Build a reverse maxclass-to-name lookup from `maxclass_map.py`
- For `maxclass: "newobj"`, extract the name from `text` (first space-delimited token) -- this matches `_extract_object_name` in `validation.py`
- For UI objects (non-newobj maxclass), the maxclass IS the object name
- Handle `aliases.json` reverse mapping for aliased names

**Detection:** Track "object found in help patch but not in DB" rate. If it exceeds 5%, the name resolution is broken.

**Phase:** Help patch audit pipeline design.

---

### Pitfall 10: Inlet/Outlet X-Position Calculation Compounds Box Width Error

**What goes wrong:** Midpoint generation and cable routing calculates inlet/outlet X positions from box width, but box width is inaccurate (Pitfall 4), causing cable routing to target wrong coordinates.

**Why it happens:** The `_outlet_x` and `_inlet_x` functions in `layout.py` compute outlet position as:
```python
usable = w - 2 * _IO_MARGIN  # _IO_MARGIN = 7.0
spacing = usable / (n - 1)
return x + _IO_MARGIN + outlet_idx * spacing
```

A 50px width error on the source box shifts the outlet X position by up to 43px (for a 2-outlet box). The midpoint generation then creates L-shaped cable segments at wrong positions.

**Consequences:**
- Cables visually miss their connection points (cosmetic -- MAX ignores midpoints for actual connections)
- Bus routing places the bus X too far right (based on rightmost object edge, which is wrong)
- Companion positioning (meter~ beside gain~) has wrong gap

**Prevention:**
- Fix box width calculation first (Pitfall 4) before refining midpoint generation
- After improving sizing, recalibrate midpoint thresholds (`HORIZONTAL_THRESHOLD`, `BUS_MARGIN`)
- Increase `HORIZONTAL_THRESHOLD` from 20px to 30px to account for sizing error margin

**Detection:** Open generated patches in MAX. If cables have visible kinks at wrong positions, the midpoint calculation uses wrong widths.

**Phase:** Layout refinement, after box sizing is improved. Order matters: fix sizing, then fix routing.

---

### Pitfall 11: Help Patch Objects May Have Stale Data from Older MAX Versions

**What goes wrong:** The audit extracts box properties that are stale because the help patch was saved with an older MAX version.

**Why it happens:** MAX saves the current state of an object's I/O configuration into the `.maxhelp` JSON at save time. If a help patch was created in MAX 7 and the object gained a new outlet in MAX 8, the saved `numoutlets` is stale until re-saved. The `appversion` field in each help patch records which MAX version saved it.

**Evidence:** The extraction log shows 133 objects with empty inlets and 159 with empty outlets in the XML refpages. Help patches may have similar gaps.

**Consequences:**
- Extracted data disagrees with XML refpage data
- Stale help patches produce wrong outlet counts
- The audit finds "corrections" that are regressions

**Prevention:**
- Cross-reference help patch data with XML refpage data -- they should agree on I/O count
- If they disagree, prefer the help patch (reflects runtime behavior) but flag discrepancy for review
- Check `appversion` in each help patch to identify potentially stale data
- For the 133+159 objects with empty I/O in XML, the help patch is the ONLY source of truth

**Detection:** Generate a discrepancy report: objects where help patch I/O count differs from XML refpage I/O count. Review each manually.

**Phase:** Help patch audit pipeline.

---

## Minor Pitfalls

---

### Pitfall 12: Presentation Mode Properties Interfere with Patching Mode

**What goes wrong:** Adding `presentation: 1` and `presentation_rect` to objects for aesthetic layout changes behavior when toggling between patching and presentation mode.

**Prevention:**
- Only set `presentation: 1` on objects intended for the presentation view
- `presentation_rect` is independent of `patching_rect` -- always set both
- The `openinpresentation` patcher property determines which mode opens first -- set intentionally
- Do not set `presentation: 1` on non-UI objects unless they serve a presentation purpose

**Phase:** Aesthetic implementation.

---

### Pitfall 13: Style System Conflicts with Per-Object Properties

**What goes wrong:** Setting the `style` patcher property changes all object colors to a theme, overriding per-object color settings.

**Prevention:**
- If using patcher-level `style`, do not also set per-object color properties (they get overridden)
- If using per-object colors, leave `style` as `""` (empty string, the default)
- Safe approach for v1.1: do not use the `style` system. Apply aesthetics through explicit per-object and per-patcher properties only.

**Phase:** Aesthetic implementation.

---

### Pitfall 14: The 292 Empty-I/O Objects Are the Highest Value Audit Targets

**What goes wrong:** The audit focuses on objects that already have correct data while ignoring the 292 objects (133 empty inlets + 159 empty outlets) that need it most.

**Prevention:**
- Prioritize auditing objects with empty inlets or empty outlets
- These are guaranteed to benefit from help patch data extraction
- Track coverage: X of 133 empty-inlet objects now have inlet data, X of 159 empty-outlet objects now have outlet data

**Phase:** Help patch audit prioritization.

---

### Pitfall 15: Help Patch Coverage Gaps for Operators and MC Objects

**What goes wrong:** Operator objects (`+`, `-`, `*~`) and MC objects (`mc.cycle~`, `mc.gain~`) share help files or have no dedicated help files, making them unauditable.

**Prevention:**
- Map operator help files to their variants (e.g., `plus.maxhelp` should audit `+`)
- Map MC objects to base counterparts (`mc.cycle~` inherits outlet types from `cycle~`)
- For MSP operators, infer outlet types from the operator family (all MSP operators `+~`, `-~`, `*~`, `/~` have `["signal"]` outlets)
- Document unaudited objects and track as known gaps

**Phase:** Help patch audit, coverage mapping.

---

### Pitfall 16: Recursive Subpatcher Layout Can Be Slow

**What goes wrong:** The layout engine calls `apply_layout` recursively for every inner patcher (layout.py line 153-155). With deeply nested subpatchers, this becomes slow.

**Prevention:**
- Add a depth limit (e.g., max 10 levels of recursion)
- For bpatchers, do not layout the inner patcher (it may be a shared file)
- The current implementation already skips subpatchers with no boxes

**Phase:** Layout refinement, if nested patches become an issue.

---

## Phase-Specific Warnings

| Phase Topic | Likely Pitfall | Mitigation |
|---|---|---|
| Help patch parsing | Tab structure hides all content in subpatchers (P3) | Recursive descent parser, verify found count > 0 |
| Help patch parsing | Multiple instances with different configs (P1) | Filter by has-connections, track per-argument configs |
| Help patch parsing | maxclass-to-name mismatch (P9) | Reverse lookup from maxclass_map.py + aliases.json |
| Help patch parsing | Stale data from old MAX versions (P11) | Cross-reference with XML, check appversion |
| DB bulk update | Override merge order broken (P2) | Override-aware audit, never overwrite manual corrections |
| DB bulk update | 292 empty-I/O objects highest priority (P14) | Prioritize empty objects, track coverage metrics |
| Aesthetic: panels | Z-order and background property (P6) | Always `background: 1`, panel first in boxes array |
| Aesthetic: bgfillcolor | Undocumented dict structure (P5) | Extract from MAX, cap proportion at 0.9999, test visually |
| Aesthetic: comments | Different property names than other boxes (P7) | Separate style map, height from fontsize |
| Aesthetic: style | System conflicts with per-object (P13) | Do not use patcher `style` property in v1.1 |
| Layout: sizing | 50px+ width error (P4) | Per-object width lookup, proportional char widths |
| Layout: routing | Compounded width error in cables (P10) | Fix sizing before fixing routing |
| Layout: tests | Brittle pixel assertions (P8) | Refactor to relative assertions before refining layout |

---

## Integration Risk Matrix

Changes to the existing v1.0 system and their risk of breaking it.

| Change | Risk | What Breaks | Prevention |
|---|---|---|---|
| Writing to `msp/objects.json` | **CRITICAL** | 16 manual outlet type overrides, connection validation | Override-aware writes, dry-run mode, test suite gate |
| Adding `bgcolor`/`bgfillcolor` to `Box.to_dict()` | MODERATE | All existing test fixtures, JSON comparison tests | Add via `extra_attrs`, not core dict |
| Changing `V_SPACING` or `H_GUTTER` | MODERATE | 6+ layout tests with pixel range assertions | Refactor tests first |
| Changing `calculate_box_size()` | **CRITICAL** | Every layout test, every generated patch width | Keep old formula as fallback, add override table alongside |
| Adding `background` property to panel | LOW | Nothing -- additive change | Ensure default is `1` for background panels |
| Modifying `_generate_midpoints()` | MODERATE | 5 midpoint tests with exact coordinate assertions | Test properties (count, direction) not exact values |
| Changing `overrides.json` structure | **CRITICAL** | `db_lookup.py` merge logic, all 624 tests | Do not change structure -- only add entries |

---

## Sources

### Project Evidence (verified against actual codebase)
- `/Users/taylorbrook/Dev/MAX/.claude/max-objects/overrides.json` -- 16 manually corrected MSP outlet types, multislider correction
- `/Users/taylorbrook/Dev/MAX/.claude/max-objects/extraction-log.json` -- 133 empty inlets, 159 empty outlets, 2,015 total objects
- `/Users/taylorbrook/Dev/MAX/src/maxpat/layout.py` -- layout engine with `_outlet_x`/`_inlet_x` calculations, companion placement
- `/Users/taylorbrook/Dev/MAX/src/maxpat/sizing.py` -- `CHAR_WIDTH=7.0`, `MIN_BOX_WIDTH=40.0`, `COMMENT_HEIGHT=20.0`
- `/Users/taylorbrook/Dev/MAX/src/maxpat/db_lookup.py` -- `DOMAIN_LOAD_ORDER`, override merge logic (lines 66-81)
- `/Users/taylorbrook/Dev/MAX/src/maxpat/defaults.py` -- `V_SPACING=20`, `H_GUTTER=15`
- `/Users/taylorbrook/Dev/MAX/tests/test_layout.py` -- spacing range assertions calibrated for current constants

### MAX Installation Evidence (verified against local MAX 9)
- `/Applications/Max.app/Contents/Resources/C74/help/` -- 2,096 help patches across 5 directories (max: 472, msp: 261, jitter: 203, m4l: 32, packages: 1,128)
- `trigger.maxhelp` -- tab structure with `showontab: 1` subpatchers, top level has 6 boxes, content in `p basic` (20 boxes) and `p examples` (27 boxes)
- `buffer~.maxhelp` -- 7 instances, ground truth `outlettype: ["float", "bang"]`, one degenerate instance with `numoutlets: 0`
- `attrui.maxhelp` -- panel with `background: 1`, `mode: 1`, `grad1`/`grad2`/`proportion`/`angle`/`bordercolor`

### Width Analysis (measured from trigger.maxhelp vs. calculated)
- `js helpstarter.js trigger`: actual=132px, calc=191px, error=-59px
- `+`: actual=89.5px, calc=40px, error=+50px
- `t b i`: actual=32.5px, calc=51px, error=-18px
- `accum 0.`: actual=91.5px, calc=72px, error=+20px
- `print 5`: actual=48px, calc=65px, error=-17px

### Community Sources
- [Panel bgfillcolor attributes](https://cycling74.com/forums/panel-bgfillcolor-attributes-how-to-specify-as-3-floats) -- proportion limit gotcha
- [Scripting Panel Gradients](https://cycling74.com/forums/scripting-panel-gradients) -- pt1/pt2 vs angle conflict, dict opacity
- [Color and the Max User Interface (MAX 8)](https://docs.cycling74.com/max8/vignettes/max_colors) -- style color property names (13 properties)
- [Patcher-level Formatting (MAX 8)](https://docs.cycling74.com/max8/vignettes/format_palette_patcher_level) -- style system interactions

### Project Memory Files (known issues from v1.0)
- `feedback_msp_outlet_types.md` -- MSP outlet type extraction bug, 16 corrections applied
- `feedback_bpatcher_args.md` -- #N compound string substitution failure mode
- `feedback_layout_spacing.md` -- tight spacing requirements (V_SPACING=20, H_GUTTER=15)
- `feedback_multislider_fetch.md` -- fetch vs fetchindex, outlet 1 not outlet 0
