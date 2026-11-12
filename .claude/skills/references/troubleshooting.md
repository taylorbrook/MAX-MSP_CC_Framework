# Troubleshooting: MAX Console Messages

> MAX console message -> cause -> fix. Use it when the user pastes a console error or a patch misbehaves after it opens.
> Path: `.claude/skills/references/troubleshooting.md`. `C74/` below means `/Applications/Max.app/Contents/Resources/C74/`. "User guide" means `C74/docs/userguide/content/error_messages.json`, Max's own list of common console errors.

**How to read this table.** Text in `code` in the first column is the console wording as a source records it, with `<...>` for the variable part. Where no source records the exact wording, the row says "wording not recorded". Never invent console text. The Source column names a CLAUDE.md or shared-capabilities.md section, a Max bundle file, or the project and version where the message was seen. Python-side save errors (`PatchValidationError`, `StaleFileError`, `SaveGateWarning`) are not console messages; see `severity-contract.md`. `src/maxpat/diagnose.py` reads these four-column tables: every code span in the first cell outside parentheses is a console pattern, where `<...>` matches one word and `...` any text, so keep four columns and put example or companion wordings that are not patterns inside parentheses.

## Object creation

| Console message | Cause | Fix | Source |
|---|---|---|---|
| `<objectname>: No such object` | An RNBO- or Gen-only name at the Max top level (`expr~`, `floor~`, `wrap~`, `counter~`, `history`). `ObjectDatabase.lookup` still finds these in the RNBO or Gen domain. | Check `lookup(name)["domain"]` and `db.get_effective_restrictions(name)`, not just existence. Per-sample math goes in a `gen~` codebox or a chain of `-~` / `*~` / `+~`; for `floor~` use `trunc~` (non-negative input) or gen~ `floor`. | CLAUDE.md Rule #1 and "MSP (Audio/Signal)"; tremolo-am-ringmod demo (2026-10-04) for `expr~: No such object` |
| `<objectname>: No such object` | A Pure Data name (`osc~`, `lop~`, `hip~`, `bp~`, `tabread~`, `throw~` / `catch~`). | Use the MAX equivalent from `pd-blocklist.json` (`cycle~`, `onepole~`, `reson~`, `index~` / `play~` / `wave~`, `send~` / `receive~`). | CLAUDE.md "PD Confusion Guard" |
| `<objectname>: No such object` | `inlet~` or `outlet~`. They do not exist. | Use `inlet` / `outlet`; signal vs control is set by what connects to them. | CLAUDE.md "Subpatcher Inlet/Outlet Access" |
| `<objectname>: No such object` | `bach.llll2list` or `bach.list2llll`. The database entries are stale; the installed bach package does not have them. | Extract values with `bach.nth N` (1-based, one per index, `@unwrap 1` for a sublist); use `bach.flat`, `bach.iter` or `bach.pack` for conversions. | shared-capabilities.md "bach (package) Rules" |
| `<objectname>: No such object` | A package object whose package is not installed. The package critic flags `verified_installed: false` objects as "Object not installed". | Install the package from the Package Manager, or replace the object. If it is installed, re-run package extraction. | User guide; `src/maxpat/critics/package_critic.py` |
| `<objectname>: No such object` | An abstraction or external not in Max's search path (a `.maxpat` abstraction outside the patch's folder or project). | Keep abstractions next to the patch that uses them (or in its project) and open the patch from that folder. The save gate validates with the patch's path: an unknown name no abstraction resolves is an error (`unknown_object`), so save the abstraction first. | User guide ("make sure that the relevant file is in Max's Search Path") |
| `invalid attribute maxclass` | A non-UI object saved with its own name as `maxclass` (for example `"maxclass": "gen~"`). | Use `"maxclass": "newobj"` with the name in `text`. The authority is `UI_MAXCLASSES` in `src/maxpat/maxclass_map.py`, not the database's `maxclass` field. | CLAUDE.md "Object Database" |
| `bad arguments creating object` | A numeric bpatcher arg serialized as a JSON string (`"args": ["slot-1", "0"]`), so `#2` becomes the symbol `0` and `-~ #2` fails, once per instance. | Serialize numbers as JSON numbers (`args=[slot, 0]`); `add_bpatcher` coerces numeric strings, and validation errors on them (`bpatcher_numeric_args`). The user guide lists the general form as `<objectname> : bad argument creating object`: an argument the object does not understand, often a number where a symbol is expected. | CLAUDE.md "Bpatcher and Abstraction Arguments"; user guide |
| `base: bad number` | A word typed where `uzi` expects a number (`uzi 2 base 0`). The object database names uzi's two arguments `initial` and `base`, but both take numbers, not the words. | Write the numbers only: `uzi 2 0`. | TCI (2026-09) |
| `can't connect <objectname> to <objectname>` | On load, a saved cord whose inlet does not understand what the outlet sends, usually because an object failed to load. | Fix the object that failed (look for a `No such object` line above it), then re-check the cord. | User guide |
| `patcher connect: inlet <number> out of range` | An object's inlet or outlet count changed (new arguments to `gate`, `route`, `trigger`, ...) and old cords no longer fit. | Recompute I/O with `db.compute_io_counts(name, args)` and rewire; after `replace_box` always rewire the orphans (Rule #8). | User guide; CLAUDE.md Rule #8 |

## Messages

| Console message | Cause | Fix | Source |
|---|---|---|---|
| `<objectname>: doesn't understand <message-selector>` | The object got a message it has no method for, for example a symbol into a number box. | Check the selector with `db.selectors(name)` and the refpage; convert types upstream. Validation warns on a message box whose selector the destination does not list (`message_selector`, inlet 0 only). | User guide |
| `umenu: doesn't understand a` | `t a ...`: `trigger` has no `a` type, so it outputs the literal symbol `a`. | Use `b i f l s` only. Fan out directly for an anything message where order does not matter; use `t s s` for symbols where it does. See proven-forms.md "trigger types". | Ambire v0.5.0 (2026-10-01) |
| `fluid.dataset~: doesn't understand <name>` | A FluCoMa completion message with arguments (`transform <destname>`) went through `route transform`, which strips the selector and passes `<destname>` on, here into a `zl.reg` that stored and re-sent it. | Put `t b` after every completion `route` before chaining. | TCI (2026-09-26) |
| `wrong message or type` | A bach object with the default `@out n` (native) feeding a plain MAX object (`f`, `select`, `unpack`, `expr`). | Set `@out t` on every bach object whose outlet feeds a non-bach object (one character per llll outlet). | shared-capabilities.md "bach (package) Rules" |
| `function clip not found` | `expr clip($f1, 0., 1.)`: `expr`, `vexpr` and `if` have no `clip()`. | `expr min(max($f1, 0.), 1.)`. GenExpr does have `clip(x, lo, hi)`. Validation errors on it (`expr_clip`). | CLAUDE.md "MSP (Audio/Signal)" |
| `<objectname>: <name>: already in use` (seen as `sflist~: sf.files: already in use`, together with `object_register: ... cannot reregister`) | Named objects of different classes share one global name namespace: `coll sf.files` and `sflist~ sf.files` collide. | Give each named object its own name per class (`sflist~ sf.cues`, `coll sf.files`). See proven-forms.md "shared namespace". | Ambire v0.5.0 (2026-10-01) |
| `unsupported output bit depth 1` | A `live.menu` item index (outlet 0) was sent through `prepend format` where a symbol was expected. | Take the symbol from `live.menu` outlet 1 (Item Symbol). | TCI (2026-09) |

## gen~ compile

| Console message | Cause | Fix | Source |
|---|---|---|---|
| `dsp.gen: ... failed to compile genpatcher` / `gen~: failed to compile patcher` (a generic Lua error, no codebox line) | Usually a construct outside the proven-safe codebox set: tab characters, `else if` chains, nested or variable-bound `for` loops, 2-arg `peek` / 3-arg `poke`. Also follows a more specific codebox error. | Apply the codebox safe-construct rules: spaces only, nested `else { if ... }`, single constant-bound loops, explicit channel args. Look for a codebox error printed just before it. | CLAUDE.md "Gen~ (GenExpr DSP Code)", codebox safe-construct rules (spectraldetector v0.1.x -> v0.2.0); max-bridge v0.3.0 (2026-10-21) for `gen~: failed to compile patcher` |
| `codebox: can't assign to parameter <name>` | A new `Param` has the same name as a local assigned elsewhere in the codebox. The generic `failed to compile genpatcher` follows, and everything through that gen~ goes silent. | Before building, intersect the `Param` names with every assigned identifier (and with `History` / `Delay` / `Data` names); the intersection must be empty. Rename one. | Ambire v0.8.0 |
| `use of undeclared identifier 'sr'` (with cascading `maxb_NN` errors) | A local alias (`sr = samplerate;`, `RING = 1344000;`) used in an expression whose inputs are only Params and constants. gen~ hoists that expression out of the sample loop, where the alias does not exist. | Write `samplerate` and literal constants directly in Param-only expressions. | CLAUDE.md "Gen~", rule "No local aliases in Param-only expressions" (reverse-delay v0.2.1) |
| `use of undeclared identifier 'maxb_NN'` (or another hoisted temp, such as `'gmax_raw'`) | Hoisted Param-only temps emitted before their dependencies on some Max 9 builds. Which statements break varies by build. | De-hoist: declare `History one(1);`, compute `srs = samplerate * one;` and `k_<param> = <param> * one;` at the top of the per-sample body, and use only those downstream. | CLAUDE.md "Gen~", rule "Hoisted temps can be emitted out of order" (reverse-delay v0.3.3) |
| `The delay() operator is not supported in GenExpr; use the Delay.read and Delay.write instead.` | `delay()` in a codebox; it exists only in the gen~ visual patcher. | `Delay d(max_samples);` then `d.write(x)` and `d.read(t)`. | CLAUDE.md "Gen~" |
| `... not defined` (exact wording not recorded) | A variable used inside an `if` / `else` block that was not initialized before it. | Initialize the variable before the block. | CLAUDE.md "Gen~" |
| Compile refused, wording not recorded | A `Param` / `History` / `Delay` / `Buffer` / `Data` declaration after an expression. | All declarations first (Params, then Delay, History, Buffer/Data), then expressions. `add_gen()` reorders automatically. | CLAUDE.md "Gen~", declaration ordering |
| No message: the value is wrong | A GenExpr constant name (`e`, `pi`, `twopi`, ...) used as a variable; the constant silently wins. `==` in an `if` only warns. | Rename the variable (`ev`, not `e`); prefer range tests (`x > 0.5 && x < 1.5`). | CLAUDE.md "Gen~" (sample-layers v0.3.1; reverse-delay v0.2.1) |

## FluCoMa and files

| Console message | Cause | Fix | Source |
|---|---|---|---|
| `Wrong Point Size` (from `fluid.kdtree~ knearest`) | `fluid.list2buf` with the default `@autosize 1` received its list on the scheduler thread; it warns `auto-sizing is enabled but object called from high-priority thread; use defer to resize` and skips the resize, so the query buffer has the wrong length. A `defer` in front did not help (Max 9.1.5). | Never rely on autosize: `fluid.list2buf <frames> 1 @autosize 0`, or `@destination <buf> @autosize 0` with `buffer~ <buf> @samps N`. See proven-forms.md "FluCoMa". | Traces (2026-09-20); `fluid.list2buf` refpage (`autosize` applies only on the main thread) |
| `Please provide a valid dictionary...` / `labelDict is null` (from `fluid.plotter`) | `read` then `dump` sequenced with `trigger`: `read` runs at low priority (deferlow), so `dump` runs first on an empty dataset. | Chain `dump` off the `read` completion message (`route dump read` on the dump outlet). See proven-forms.md "FluCoMa". | Traces (2026-09-20); `fluid.dataset~` refpage (`read` "using deferlow internally") |
| `Could not open file for writing` / `... not found` (FluCoMa `read` / `write`) | An HFS-style path from `opendialog fold` (`Macintosh HD:/<folder>/...`, volume name, colon, then the path), which `buffer~` and `dict` accept but FluCoMa does not. | Pass the folder through `conformpath max boot` before building FluCoMa paths. | TCI (2026-09-26) |
| `Can't allocate buffer` (FluCoMa query buffers) | FluCoMa cannot allocate a buffer off the main thread (here with Overdrive on). | Pre-allocate the buffer in the patch (`buffer~ <name> @samps N`) and point the FluCoMa object at it. | TCI (2026-09) |
| `invalid start frame 0` (`fluid.bufflatten~`) | An upstream `fluid.bufstats~` with an invalid `@select` value (`median`), so its output buffer was empty. | Use the refpage names: `mean std skewness kurtosis low mid high` (`mid` is the median). | TCI (2026-09-28); `fluid.bufstats~` refpage |
| `<filename>: can't open` / `error opening file` | The file is missing, unreadable, or outside the search path. | Check the path and the search path; use absolute POSIX paths for FluCoMa. | User guide |

## Silent failures (no console message)

These produce no error, only wrong behavior. Each has a proven-forms.md entry.

- Float chain flatlines at an integer: an arg-less `+ - * /` or an all-int `scale` (proven-forms.md "int truncation").
- An `mc.*` object plays one value on every channel: a bare list instead of `applyvalues` (proven-forms.md "MC").
- `waveform~` ignores clicks: no `setmode` (proven-forms.md "waveform~").
- Messages hit the wrong subpatcher inlet: port boxes reordered by x (proven-forms.md "subpatcher port x-order").
- `jit.bfg` outputs zeros: an invalid `@basis` name accepted silently (proven-forms.md "enum values").
- `jit.expr` output frozen at its first-frame values while bare references still update: named-matrix maths cached under the default `@cache 1` (proven-forms.md "jit.expr @cache 0").
