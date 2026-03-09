# Domain Pitfalls

**Domain:** AI-assisted MAX/MSP development framework (Claude Code)
**Researched:** 2026-03-08
**Confidence:** HIGH (verified across multiple sources: academic research, Cycling '74 forums, official docs, SDK references, community tools)

---

## Critical Pitfalls

Mistakes that cause rewrites, broken patches, or fundamental architectural failures.

---

### Pitfall 1: No Official .maxpat JSON Specification

**What goes wrong:** The framework builds a patch generator against a reverse-engineered understanding of the .maxpat format, misses required fields, generates subtly invalid JSON, and patches silently fail to load or exhibit bizarre behavior in MAX.

**Why it happens:** Cycling '74 has never published an official .maxpat specification. The format is inferred from saved patches, community reverse-engineering, and libraries like py2max. Every field's semantics -- required vs. optional, default values, interaction effects -- is learned empirically.

**Consequences:**
- Patches open with missing objects or broken connections
- MAX silently drops malformed boxes rather than reporting errors
- Version-specific fields (e.g., `appversion` structure differences between MAX 8 and 9) cause silent failures
- Subpatcher nesting and bpatcher references break in non-obvious ways

**Prevention:**
- Build a canonical .maxpat template library by saving minimal patches from MAX itself (not hand-crafting JSON)
- Use py2max's battle-tested class hierarchy (Patcher, Box, Patchline) as a reference implementation -- it handles round-trip parsing
- Validate every generated patch against MAX-saved reference patches using structural diffing
- Track critical required fields: `fileversion` (integer, typically 1), `appversion` (object with major/minor/revision/architecture), `rect` (array of 4 numbers: [x, y, width, height]), `boxes` (array), `lines` (array)
- Always include `numinlets`, `numoutlets`, and `outlettype` arrays on every box -- MAX infers these but will misbehave if they conflict with the object's actual behavior

**Detection:** Patches that open in MAX but have missing objects, phantom connections, or objects in wrong positions. Test by opening generated patches in MAX and comparing object count against expected.

**Which phase should address it:** Phase 1 (Foundation) -- this is the absolute bedrock. Get the format wrong and nothing works.

---

### Pitfall 2: The maxclass vs. text Confusion

**What goes wrong:** The framework treats all MAX objects as `maxclass: "newobj"` with different `text` values, failing to handle the ~15 distinct maxclass types that require completely different JSON structures.

**Why it happens:** Most MAX objects (cycle~, +, metro, etc.) are indeed `maxclass: "newobj"` with the object name in the `text` field. But UI objects, comments, messages, subpatchers, and special objects each have their own maxclass value with unique required properties.

**Consequences:**
- UI objects (number boxes, sliders, dials) render as broken text boxes
- Message boxes don't function (they need `maxclass: "message"`, not `maxclass: "newobj"` with text "message")
- Comments don't display (need `maxclass: "comment"`)
- Subpatchers fail to load (need `maxclass: "newobj"` but with a nested `patcher` object inside the box)
- inlet/outlet objects in subpatchers need `maxclass: "inlet"` / `maxclass: "outlet"`, not newobj

**Prevention:**
- Maintain a maxclass lookup table. Known distinct maxclass values include: `newobj`, `message`, `comment`, `number`, `flonum`, `toggle`, `button`, `slider`, `dial`, `kslider`, `multislider`, `inlet`, `outlet`, `bpatcher`, `panel`, `live.dial`, `live.slider`, `live.toggle`, `live.menu`, `live.text`, `live.numbox`, `live.tab`, `ezdac~`, `ezadc~`, `scope~`, `spectroscope~`, `meter~`, `gain~`, `function`, `attrui`
- Each maxclass type must have a known set of required and optional properties
- The object knowledge base must map object names to their correct maxclass

**Detection:** Validate that every box in generated JSON has a recognized maxclass value and includes required properties for that maxclass type.

**Which phase should address it:** Phase 1 (Foundation) -- part of the core object knowledge base.

---

### Pitfall 3: Patchline Connection Validation False Positives

**What goes wrong:** The validator reports connections as valid when they will actually produce errors at runtime, or rejects connections that would work fine. The gap between structural validity and behavioral validity is wide.

**Why it happens:** MAX allows many structurally valid connections that are semantically wrong. A message box outlet can connect to almost any inlet -- MAX cannot know what message will emerge until runtime. Conversely, signal (audio) connections are type-checked but only when DSP is running.

**Consequences:**
- Framework generates patches that pass validation but crash or produce silence when audio is turned on
- "Object doesn't understand [message]" errors flood the MAX console at runtime
- Signal/message type mismatches go undetected (connecting a message outlet to a signal inlet)
- False confidence in patch correctness

**Prevention:**
- Implement multi-layer validation:
  1. **Structural:** Does the connection reference valid box IDs and valid inlet/outlet indices?
  2. **Type compatibility:** Is this a signal-to-signal or message-to-message connection? Signal outlets (from tilde~ objects) should connect to signal inlets.
  3. **Semantic plausibility:** Does this connection make functional sense? (e.g., a bang to a signal inlet is almost always wrong)
- Track outlet types in the object database: each outlet should be tagged as `signal`, `message`, `multichannelsignal`, or `jit_matrix`
- Track inlet types with the same taxonomy
- Accept that perfect validation is impossible without running MAX -- be explicit about what the validator can and cannot check

**Detection:** Count "object doesn't understand" errors and signal mismatch warnings when patches are opened in MAX. Track false positive and false negative rates over time.

**Which phase should address it:** Phase 2 (Validation) -- requires the object knowledge base from Phase 1 to be in place first.

---

### Pitfall 4: Hot Inlet / Cold Inlet Semantics Ignored

**What goes wrong:** Generated patches connect objects in ways that look correct topologically but violate MAX's hot/cold inlet conventions, producing patches that do nothing or produce wrong results.

**Why it happens:** In MAX, only the leftmost inlet (inlet 0) is "hot" -- receiving a message there triggers computation and output. All other inlets are "cold" -- they store values but don't trigger output. An LLM generating patches naturally connects things in whatever order seems logical, without understanding this fundamental convention.

**Consequences:**
- Patches where data flows in but nothing comes out (everything goes to cold inlets)
- Missing `trigger` or `t` objects that should force right-to-left evaluation order
- Race conditions where cold inlets haven't been set before hot inlets fire
- Patches that work intermittently depending on timing

**Prevention:**
- The object knowledge base must mark every inlet as hot or cold for every object
- Pattern templates must include `trigger` (or `t`) objects wherever multiple outlets need to feed into an object's inlets in a specific order
- Connection generation should default to connecting to hot inlets first, then cold inlets, with explicit `trigger` objects managing evaluation order
- Generate right-to-left, bottom-to-top ordering in patch layout to match MAX's execution model

**Detection:** Static analysis: any object with only cold-inlet connections and no bang/trigger to its hot inlet is suspicious. Flag patches where objects have populated cold inlets but nothing connected to inlet 0.

**Which phase should address it:** Phase 1 (Foundation) -- this is core MAX semantics that must be baked into every template and generation pattern.

---

### Pitfall 5: LLMs Confuse MAX/MSP with Pure Data

**What goes wrong:** Claude generates Pure Data syntax, object names, or connection patterns instead of valid MAX/MSP constructs.

**Why it happens:** Research confirms this is the most common AI failure mode with MAX (see: "Benchmarking LLM Code Generation for Audio Programming with Visual Dataflow Languages," 2024). MAX and Pure Data share a common ancestor and many similar concepts, but use different file formats, different object names, and different conventions. LLM training data contains significantly more PD content than MAX content, creating a strong bias toward PD syntax.

**Consequences:**
- Generated patches contain PD objects (`[osc~ 440]` with brackets instead of MAX's cycle~ 440)
- Connection syntax uses PD format instead of MAX JSON
- Object names are wrong (PD's `[dac~]` vs MAX's `ezdac~` or `dac~` which are different objects)
- Entire generated patches are useless

**Prevention:**
- The framework must aggressively constrain Claude's generation to MAX-specific patterns:
  - All object names must be validated against the MAX object database
  - Never allow bracket-syntax object references
  - Provide MAX-specific system prompts that explicitly warn against PD confusion
  - Include reference examples of correct MAX JSON format in every generation context
- The object knowledge base serves as a hard constraint -- if an object name isn't in the database, it's rejected
- Skills and templates should provide MAX-native examples, never abstract descriptions

**Detection:** Grep generated output for PD-specific syntax: square brackets around object names, `.pd` file extensions, PD-specific objects (e.g., `adc~` vs MAX's `ezadc~`, `throw~`/`catch~` semantics differences).

**Which phase should address it:** Phase 1 (Foundation) -- the object knowledge base is the primary defense.

---

### Pitfall 6: Gen~ Code Generation Scope and Compilation Errors

**What goes wrong:** Generated GenExpr code fails to compile inside gen~, or compiles but behaves incorrectly due to misunderstood scope rules, operator semantics, or gen~-specific constraints.

**Why it happens:** GenExpr looks like a simple C-like language but has critical differences:
- Variables are local-to-scope by default (no declaration keyword needed, but this means accidental shadowing)
- `history` objects in subroutines cannot be written to if they're globally defined
- `sample` and `nearest` operators validate that their first argument is a Gen patcher input -- this is checked at compile time and errors are thrown
- Parameter declarations must appear at the top of codebox text, before any other declarations
- The `in` and `out` keywords (equivalent to `in1`/`out1`) determine inlet/outlet count automatically

**Consequences:**
- GenExpr that looks syntactically valid but fails compilation with cryptic errors
- History objects silently ignored inside functions (no write, no error in some cases)
- Wrong number of inlets/outlets because `in`/`out` keywords weren't used correctly
- Buffer access errors because `sample`/`nearest`/`peek`/`poke` have special first-argument requirements

**Prevention:**
- Build a GenExpr validator that checks:
  - All `Param` declarations appear before other code
  - `history` objects are not written inside subroutines/functions unless locally declared
  - `in`/`out` keywords map to expected inlet/outlet counts
  - `sample`/`nearest`/`peek`/`poke` first arguments reference valid buffer/data names
- Provide GenExpr templates for common patterns (oscillators, filters, delays, envelopes)
- Test GenExpr generation against known-good reference implementations

**Detection:** GenExpr compilation errors surface immediately in MAX's console. Track compilation success rate as a framework quality metric.

**Which phase should address it:** Phase 3 (Gen~/Code) -- after foundation and validation are solid.

---

### Pitfall 7: RNBO Object Subset Assumption

**What goes wrong:** The framework generates RNBO patches using standard MAX objects that don't exist in RNBO, producing patches that fail to compile or export.

**Why it happens:** RNBO supports a strict subset of MAX objects with significant semantic differences. Developers assume "if it works in MAX, it works in RNBO" -- this is categorically false.

**Consequences:**
- RNBO compilation failures from unsupported objects
- Silent behavior differences (RNBO has no integers -- everything is 64-bit float)
- Symbol-based logic breaks completely (RNBO has no symbol type at all)
- MC~ objects unsupported
- Jitter objects unsupported
- `zl.` family renamed to `list.` family
- `send~/receive~` behavior isolated per rnbo~ instance (no cross-instance communication)
- Event-based gen (without tilde) not supported
- Message objects lose `$`, `;`, and `,` functionality

**Prevention:**
- Maintain a separate RNBO object whitelist distinct from the MAX object database
- RNBO agent/skill must validate against this whitelist before generation
- Flag any use of symbols, integers-as-integers, MC~ objects, or Jitter objects
- Warn about behavioral differences: parameters in gen~ are NOT exposed by default (need `@exposeparams 1`), audio processing is always on, send~/receive~ is instance-isolated
- Template library needs RNBO-specific variants of common patterns

**Detection:** RNBO compilation errors. Pre-generation object name checking against RNBO whitelist.

**Which phase should address it:** Phase 3 (RNBO/Gen~) -- dedicated RNBO support with its own validation layer.

---

## Moderate Pitfalls

---

### Pitfall 8: Patch Layout That Looks Terrible

**What goes wrong:** Generated patches are technically valid but objects are overlapping, connections cross everywhere, and the patch is unreadable when opened in MAX.

**Why it happens:** MAX patches are visual programs. Layout is not just aesthetic -- it communicates signal flow, grouping, and intent. Programmatic generation tends to produce grid-aligned or random layouts that ignore MAX conventions: top-to-bottom flow for signal chains, left-to-right for parallel paths, grouped related objects, comment annotations.

**Prevention:**
- Implement a layout engine that follows MAX conventions:
  - Signal flow goes top-to-bottom (sources above, destinations below)
  - Related objects grouped with visual proximity
  - Adequate spacing (minimum ~20px vertical, ~15px horizontal between objects)
  - Standard object widths based on text content (approximately 7px per character + padding)
  - `patching_rect` format is `[x, y, width, height]` where origin (0,0) is top-left
  - Comments placed above or beside the objects they describe
  - Avoid crossing patch cords where possible
- Use hierarchical layout algorithms (modified Sugiyama/layered graph drawing)
- Consider encapsulation: large patches should use subpatchers to keep each level readable

**Detection:** Visual inspection in MAX. Automated metrics: count crossing connections, measure object overlap area, check minimum spacing constraints.

**Which phase should address it:** Phase 2 (Layout/Validation) -- after objects and connections are correct, make them readable.

---

### Pitfall 9: External SDK Build System Fragility

**What goes wrong:** The framework generates C/C++ external code that compiles on the developer's machine but fails elsewhere, or builds successfully but the external doesn't load in MAX.

**Why it happens:** Multiple compounding issues:
- Max SDK and Min-DevKit are "rather stale" (community assessment, 2025) with features lagging behind MAX 8.6+
- Mixing Max SDK (C) and Min-DevKit (C++) requires undocumented setup -- namespace prefixing (`c74::max`), manual include path configuration
- Apple Silicon requires universal binary builds (`-DC74_BUILD_FAT=ON`) or ad-hoc code signing (`codesign --force --deep -s -`)
- Min-DevKit has limited support for dictionaries, notifications, and UI objects
- The SDK compiles successfully but the external appears "non-functional" in MAX (a documented issue)

**Prevention:**
- Default to Min-DevKit for new externals (modern C++, CMake-based, better DX) but document its limitations
- Provide pre-configured CMakeLists.txt templates with:
  - `CMAKE_OSX_ARCHITECTURES "x86_64;arm64"` (or `C74_BUILD_FAT=ON`)
  - Correct include paths for both SDK and Min-API
  - Ad-hoc codesigning post-build step for Apple Silicon
- Test build system on both Intel and Apple Silicon Macs
- Never mix Max SDK and Min-DevKit in the same project unless absolutely necessary
- Provide clear error messages when builds succeed but externals don't load (usually architecture mismatch or codesigning)

**Detection:** External loads in MAX without errors. Test with `loadbang` + `print` pattern to verify the external is actually executing.

**Which phase should address it:** Phase 4 (Externals) -- dedicated phase with its own build system validation.

---

### Pitfall 10: Audio Rate vs. Control Rate Mismatch

**What goes wrong:** Generated patches mix audio-rate (signal) and control-rate (message) connections incorrectly, producing patches that are silent, glitchy, or have enormous latency.

**Why it happens:** MAX has three distinct data domains with different timing characteristics:
- **Messages** (gray patch cords): Control rate, scheduled by the MAX scheduler, millisecond resolution at best
- **Signals** (yellow patch cords): Audio rate, sample-accurate, processed in vectors
- **Jitter matrices** (green patch cords): Frame rate, processed per-frame

An LLM generating patches doesn't inherently understand these distinctions. Connecting a message outlet to a signal inlet doesn't error -- MAX silently converts -- but the timing behavior changes dramatically.

**Prevention:**
- Object database must tag every inlet and outlet with its domain type: `message`, `signal`, `multichannelsignal`, `jit_matrix`
- Validation should warn when crossing domains without explicit conversion objects:
  - Message to signal: should use `sig~` or `line~` (with slewing to avoid clicks)
  - Signal to message: should use `snapshot~` (with appropriate interval)
- Template patterns should always use `line~` for parameter smoothing when controlling audio-rate parameters from messages
- Flag direct number/message connections to signal inlets as potential timing issues

**Detection:** Look for gray-to-yellow patch cord transitions without intermediary conversion objects.

**Which phase should address it:** Phase 1 (Foundation) -- domain tagging in the object database, Phase 2 (Validation) -- cross-domain connection warnings.

---

### Pitfall 11: Object Database Incompleteness and Staleness

**What goes wrong:** The object knowledge base is missing objects, has wrong inlet/outlet counts, or doesn't track version-specific availability, causing generated patches to reference non-existent objects or connect to wrong inlets.

**Why it happens:** MAX has 1000+ built-in objects across Max, MSP, Jitter, MC, and RNBO domains, plus thousands of third-party externals. Object behavior changes between versions. There is no single comprehensive machine-readable source -- extraction requires combining MAX's built-in refpages, the maxobjects.com database, and empirical testing.

**Consequences:**
- "Object not found" errors in generated patches
- Wrong inlet/outlet indices causing misconnections
- Missing arguments causing objects to use unexpected defaults
- Version-incompatible objects (e.g., MC~ objects in MAX 7 patches, v8 object in MAX 8)

**Prevention:**
- Build the object database from multiple sources:
  1. MAX's own refpages (authoritative for object existence and argument format)
  2. Empirical extraction: script MAX to instantiate each object and report inlet/outlet count/type
  3. Community databases (maxobjects.com) for coverage gaps
- Track MAX version compatibility per object
- Design the database for incremental updates -- new objects can be added without rebuilding
- Implement a "unknown object" path: if an object isn't in the database, generate it with explicit `numinlets`/`numoutlets` from the user's specification and flag it for manual verification

**Detection:** Track "object not found" rate in MAX console when opening generated patches.

**Which phase should address it:** Phase 1 (Foundation) -- the object database is the single most critical component.

---

### Pitfall 12: Node for Max File Naming and Module Conflicts

**What goes wrong:** Generated Node for Max scripts use generic filenames, fail to find dependencies, or conflict with other scripts in MAX's search path.

**Why it happens:** MAX uses a flat search path system. If two Node for Max scripts are both named `index.js`, MAX may load the wrong one. Additionally:
- Node for Max runs in a separate process (all interaction is asynchronous, breaking MAX's call chain)
- The `require` system must be used instead of ES module `import` in MAX 8 (though MAX 9 with v8 supports ES6+)
- npm packages with native dependencies can fail with node-gyp errors
- No Chrome inspector debugging support

**Prevention:**
- Always namespace Node for Max files: `projectname.scriptname.js` pattern
- Document the async boundary clearly -- Node for Max scripts cannot participate in MAX's synchronous message flow
- Provide templates that handle the `max-api` require pattern correctly
- Test npm dependencies on both Intel and Apple Silicon before including them in templates
- For MAX 9, use the v8 object where possible (ES6+ support, better performance)
- For MAX 8 compatibility, stick to ES5 / require syntax

**Detection:** "Script not found" errors, wrong script loaded (verify by printing a unique identifier at load), async timing issues.

**Which phase should address it:** Phase 3 (Code Generation) -- alongside js/v8 code generation.

---

### Pitfall 13: Execution Order Depends on Visual Position

**What goes wrong:** Generated patches have correct topology but wrong visual positioning, causing MAX's right-to-left, bottom-to-top execution order to produce incorrect results.

**Why it happens:** When an object has multiple outlets connected to different downstream objects, MAX evaluates those connections right-to-left based on the visual position of the destination objects. This means the physical layout of objects affects program behavior -- a property unique to visual programming languages and completely foreign to text-based code generation.

**Consequences:**
- Patches that produce correct results on one screen resolution but wrong results on another (if objects get repositioned)
- Subtle timing bugs that only manifest with specific data
- Patches that work in the generator's test layout but break when the user rearranges objects

**Prevention:**
- Always use explicit `trigger` (`t`) objects to control evaluation order rather than relying on visual position
- Layout engine should position objects in right-to-left order matching intended evaluation order
- Never generate patches that depend on implicit position-based ordering
- Template patterns should include `trigger` objects by default for any fan-out scenario
- Document this behavior in agent knowledge so Claude never generates position-dependent patches

**Detection:** Any object with multiple outlets connected to siblings at the same depth level without a `trigger` object is suspicious.

**Which phase should address it:** Phase 1 (Foundation) -- bake `trigger` usage into all templates from the start.

---

### Pitfall 14: Subpatcher and Abstraction Reference Breakage

**What goes wrong:** Generated patches reference abstractions (external .maxpat files) or bpatchers that don't exist in MAX's search path, or subpatcher nesting creates incorrect inlet/outlet routing.

**Why it happens:** Subpatchers are nested inline in the JSON (a `patcher` object inside a `box` with `maxclass: "newobj"` and text starting with `p `). Abstractions reference external files by name. Bpatchers reference external files via the `name` attribute. All three have different JSON structures and behaviors:
- Subpatcher inlets/outlets must have `inlet`/`outlet` objects inside the nested patcher
- Abstraction inlets/outlets are defined by the referenced file
- Bpatcher exposes the referenced patch's presentation view

**Prevention:**
- Generate subpatchers inline (safest -- no external file dependencies)
- When generating abstractions, generate both the referencing patch and the referenced .maxpat file
- Validate that subpatcher inlet/outlet objects match the connections from the parent patcher
- Track inlet/outlet ordering carefully: inlet/outlet order in a subpatcher is determined by their left-to-right position, not creation order
- Signal inlets/outlets in subpatchers require the corresponding `inlet~`/`outlet~` objects (not `inlet`/`outlet`)

**Detection:** "Patcher not found" errors when opening patches. Broken connections to subpatcher inlets.

**Which phase should address it:** Phase 2 (Validation/Templates) -- after core object generation is solid.

---

## Minor Pitfalls

---

### Pitfall 15: Floating Point vs. Integer Truncation

**What goes wrong:** Generated patches use integer-only objects (like `+` with integer arguments) where floating-point is needed, causing silent truncation.

**Prevention:** Always use floating-point arguments in arithmetic objects when precision matters. Use `+ 0.` instead of `+ 0` to force float mode. Document this in templates.

**Which phase should address it:** Phase 1 (Templates) -- include float-aware defaults.

---

### Pitfall 16: MAX 8 vs. MAX 9 Threading Changes

**What goes wrong:** Patches that work in MAX 8 behave differently in MAX 9 due to inlet threading changes.

**Prevention:** Track MAX version in project configuration. Use `deferlow` for thread-sensitive operations. Test generated patches in both versions where possible. Default to MAX 9-safe patterns.

**Which phase should address it:** Phase 1 (Foundation) -- version awareness in the object database.

---

### Pitfall 17: Overambitious Template Complexity

**What goes wrong:** Template library tries to cover every synthesis technique and effect type, resulting in hundreds of templates that are individually undertested and collectively unmaintainable.

**Prevention:** Start with 10-15 high-quality, thoroughly tested templates covering the most common patterns:
1. Simple oscillator with gain control
2. Subtractive synth voice (osc~ + filter~ + adsr~)
3. FM synthesis pair
4. Delay effect with feedback
5. MIDI note input to poly~ voice
6. Audio file playback (buffer~ + groove~)
7. LFO modulation routing
8. Envelope follower
9. Basic mixer (gain~ + meter~)
10. Gen~ codebox template (in/out with basic DSP)

Add templates only when a pattern is requested more than once.

**Which phase should address it:** Phase 2 (Templates) -- resist the urge to build all templates upfront.

---

### Pitfall 18: Validation Without Runtime Feedback Loop

**What goes wrong:** The validation system becomes a false oracle -- developers trust it absolutely, skip manual testing, and ship broken patches.

**Prevention:**
- Every validation result must clearly state what was checked and what was NOT checked
- Maintain a "validation coverage" metric: structural checks (HIGH coverage), type compatibility (MEDIUM coverage), semantic correctness (LOW coverage -- requires MAX runtime)
- Design the workflow to make manual testing in MAX fast and systematic:
  - Generate test protocols alongside patches
  - Include `print` objects at key signal points for debugging
  - Provide a "diagnostic mode" that adds monitoring objects to generated patches

**Which phase should address it:** Phase 2 (Validation) -- build honest validation from the start.

---

### Pitfall 19: Gen~ Execution Order in Patch vs. Codebox Mode

**What goes wrong:** Gen~ patches using visual operators have implicit execution order (poke before peek) that causes feedback issues, while the same logic in codebox mode gives explicit control.

**Prevention:**
- Prefer codebox for any Gen~ logic involving read/write ordering (buffer access, delay lines)
- In patch mode, be explicit about execution order using gen~ signal flow
- Document that poke/peek ordering matters and can cause single-sample feedback differences
- History and Delay objects have scope limitations inside functions -- always test

**Which phase should address it:** Phase 3 (Gen~/Code) -- Gen~ generation patterns.

---

### Pitfall 20: MC Multichannel Dynamic Channel Count Limitations

**What goes wrong:** Generated MC patches try to dynamically change channel counts at runtime, causing silent failures or audio restarts.

**Prevention:**
- MC channel counts via the `chans` attribute cannot change while audio is running without a full DSP restart
- `mc.send~` and `mc.receive~` require explicit channel count arguments (not dynamic)
- Maximum channel count is 1024 (hard limit)
- MC objects only work in MAX 8+ (backward compatibility break)
- Set channel counts at patch load time, not dynamically

**Which phase should address it:** Phase 3 or Phase 4 -- MC support is specialized.

---

## Phase-Specific Warnings

| Phase Topic | Likely Pitfall | Mitigation |
|-------------|---------------|------------|
| Foundation / Object Database | Incomplete object coverage, wrong inlet/outlet counts | Extract from MAX refpages + empirical testing, iterative updates |
| Foundation / .maxpat Format | Missing required JSON fields, silent load failures | Template-from-MAX approach, structural diffing against known-good patches |
| Foundation / Core Semantics | Hot/cold inlet violations, PD confusion, execution order | Bake MAX conventions into every template, constrain object names to database |
| Validation Layer | False positive/negative rates, overconfidence | Honest coverage reporting, multi-layer validation, always state what ISN'T checked |
| Layout Engine | Unreadable patches, position-dependent execution bugs | Sugiyama-style layout, explicit trigger objects, follow MAX visual conventions |
| Gen~/RNBO Code Generation | GenExpr scope errors, RNBO object subset violations | GenExpr syntax validator, RNBO object whitelist, separate validation layers |
| External SDK | Build failures on Apple Silicon, mixed SDK issues | Min-DevKit default, pre-configured CMake templates, codesigning automation |
| Node for Max / js | File naming conflicts, async boundary confusion, ES version mismatch | Namespace files, document async boundary, version-aware templates |
| Template Library | Overscoping, undertesting | Start with 10-15 core templates, expand based on demand |
| Manual Testing Gap | False oracle problem, skipping MAX runtime verification | Honest validation coverage metrics, generated test protocols, diagnostic mode |

---

## Sources

### Academic Research
- [Benchmarking LLM Code Generation for Audio Programming with Visual Dataflow Languages](https://arxiv.org/html/2409.00856v1) -- 600 generations tested, pass@1 of 0.30 for MaxMSP JSON, documents LLM failure modes

### Cycling '74 Official
- [.maxpat format specification discussion](https://cycling74.com/forums/specification-for-maxpat-json-format) -- confirms no official spec exists
- [RNBO Key Differences](https://rnbo.cycling74.com/learn/key-differences) -- RNBO subset limitations
- [GenExpr Documentation](https://docs.cycling74.com/userguide/gen/gen_genexpr/) -- GenExpr syntax and constraints
- [Max 8.2 SDK Overview](https://cycling74.com/articles/the-max-8-2-sdk-an-overview) -- CMake build system, Apple Silicon support
- [Node for Max JavaScript Differences](https://docs.cycling74.com/max8/vignettes/04_n4m_jsdifferences) -- js vs Node for Max limitations
- [Message Order and Debugging](https://docs.cycling74.com/max8/tutorials/basicchapter05) -- right-to-left execution, depth-first traversal
- [Error Messages Reference](https://docs.cycling74.com/max8/vignettes/error_messages) -- connection type mismatches
- [Max 9.0.0 Release Notes](https://cycling74.com/releases/max/9.0.0) -- v8 engine, threading changes
- [MC Documentation](https://docs.cycling74.com/max8/vignettes/mc_topic) -- multichannel limitations

### Community / Tools
- [py2max](https://github.com/shakfu/py2max) -- reference implementation for .maxpat generation
- [MaxMSP-MCP-Server](https://github.com/tiianhk/MaxMSP-MCP-Server) -- MCP server approach to LLM+MAX integration
- [Max SDK GitHub](https://github.com/Cycling74/max-sdk) -- SDK build issues
- [Min-DevKit GitHub](https://github.com/Cycling74/min-devkit) -- Min-DevKit limitations
- [MAX/MSP LLM Forum Discussion](https://cycling74.com/forums/max-and-large-language-models-generative-ai-gpt-etc) -- community experience with AI patch generation
- [MAX/MSP Gotchas (ModWiggler)](https://modwiggler.com/forum/viewtopic.php?t=169681) -- community-reported quirks

### SDK Documentation
- [Max SDK Inlets and Outlets](https://sdk.cdn.cycling74.com/max-sdk-8.0.3/chapter_inout.html) -- typed outlets, inlet creation
- [Max SDK MC API](https://sdk.cdn.cycling74.com/max-sdk-8.2.0/chapter_mc.html) -- MC backward compatibility
