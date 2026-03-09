# Feature Research

**Domain:** Claude Code development framework for MAX/MSP patch and code generation
**Researched:** 2026-03-08
**Confidence:** MEDIUM (no precedent exists for this exact product category; analogous systems inform but don't validate)

## Feature Landscape

### Table Stakes (Users Expect These)

Without these, the framework produces output that doesn't work when opened in MAX, or requires so much manual fixing that Claude adds no value over manual patching.

| # | Feature | Why Expected | Complexity | Notes |
|---|---------|--------------|------------|-------|
| T1 | Valid .maxpat JSON generation | Patches must open in MAX without errors. The .maxpat format has no official spec -- structure must be reverse-engineered from real patches. Incorrect JSON = MAX refuses to open. This is the absolute minimum bar. | HIGH | No official spec from Cycling '74. py2max (418+ tests, 1157 objects) is the best reference for format correctness. Must handle: patcher wrapper, boxes array with maxclass/numinlets/numoutlets/patching_rect, lines array with patchline source/destination pairs, nested subpatchers. Format validation is non-trivial -- MAX silently ignores some malformations but crashes on others. |
| T2 | MAX object knowledge base | Claude must know what objects exist, their inlet/outlet counts, accepted arguments, and message types. Without this, Claude hallucinates objects (community reports this as the #1 failure mode for LLMs + MAX). | HIGH | py2max's MaxRef database covers 1,157 objects. Cycling '74 docs cover all objects but in HTML reference format, not structured data. Need: object name, maxclass, numinlets, numoutlets, arguments (required + optional), accepted messages per inlet, output types per outlet, domain (Max/MSP/Jitter/MC). Must track MAX 8 vs MAX 9 differences (new ABL objects, 40+ array objects, 30+ string objects in MAX 9). |
| T3 | Connection validation | Patchlines must connect valid outlet indices to valid inlet indices. Signal (audio) outlets must connect to signal inlets. Control outlets should not connect to signal-only inlets. Wrong connections = silent failures or crashes in MAX. | MEDIUM | Rules: outlet index < numoutlets, inlet index < numinlets. Signal connections (tilde objects) vs control connections follow different rules. MC connections add another layer. Connection validation prevents the most common category of broken patches. |
| T4 | Patch layout engine | Objects must be positioned with readable spatial arrangement when opened in MAX. Overlapping objects, crossed patch cords, and random placement make patches unusable even if technically valid. | MEDIUM | py2max offers 5 layout strategies (grid, flow, columnar, matrix, horizontal/vertical) and 3 layout engines (WebCola, ELK, Dagre). MAX convention: signal flow goes top-to-bottom, control flow left-to-right. Objects should be spaced ~80-120px vertically, ~150-200px horizontally. Patch cords should not cross when avoidable. Subpatchers should encapsulate complexity. |
| T5 | Gen~ code generation | Gen~ is the primary DSP code entry point. GenExpr is a C/JS-like language for sample-level DSP. Claude can write GenExpr naturally since it resembles C. Must generate syntactically valid GenExpr with correct in/out keywords. | MEDIUM | GenExpr: typeless, locally-scoped variables, C-style operators (no ++), in1/in2/out1/out2 keywords for I/O, Param declarations for parameters, require() for file includes. gen~ codebox objects embed GenExpr directly in patches. Also need .gendsp file generation for standalone Gen~ patchers. |
| T6 | Node for Max / js code generation | JavaScript is where Claude excels naturally. Node for Max (node.script) runs full Node.js with npm access. The js object runs V8 JavaScript with direct MAX API access. Both are heavily used in modern MAX development. | LOW | Node for Max: async, ES2022+, npm packages, but no direct patcher scripting. js object: synchronous, direct patcher API access, Jitter API, Live API. MAX 9.1 expanded V8 with XMLHttpRequest, SQLite, SnapshotAPI. Claude generates JavaScript natively -- this is the easiest subsystem. |
| T7 | Template library for common patterns | Expert users need starting points for synthesis, sequencing, effects, control, and Jitter patches. Templates encode best practices (trigger for ordering, poly~ for voices, abstraction for reuse) that prevent common mistakes. | MEDIUM | Critical templates: subtractive synth, FM synth, delay effect, reverb, step sequencer, MIDI input/output, OSC communication, audio I/O routing, basic Jitter video pipeline, MC multichannel setup. Templates should be composable -- a synth template can be dropped into a sequencer template. |
| T8 | Multi-project isolation | Each MAX project needs its own context, history, and state. A granular synth project should not contaminate a step sequencer project. The Plugin Freedom System proved this is essential for framework usability. | LOW | Follows PFS pattern: per-project directories, per-project STATUS.md, project-scoped agent memory. Projects are independent MAX packages or standalone patches. Low complexity because PFS already established the pattern. |
| T9 | Structured patch validation pipeline | Multi-layer validation before the user opens the patch in MAX. Pre-generation (does the plan make sense?), post-generation (is the JSON valid? are objects real? do connections work?), domain-specific (is signal flow correct? are DSP rates consistent?). | MEDIUM | Layer 1: JSON schema validation. Layer 2: Object existence check against knowledge base. Layer 3: Connection validity (index bounds, signal/control type matching). Layer 4: Domain-specific (MSP signal flow, Jitter matrix dimensions, MC channel counts). Catches errors Claude cannot test since it cannot run MAX. |

### Differentiators (Competitive Advantage)

These features are what make MaxSystem exceptional compared to asking a raw LLM to generate MAX patches (which community consensus says produces "non-functional mess" -- Cycling '74 forums, 2025-2026).

| # | Feature | Value Proposition | Complexity | Notes |
|---|---------|-------------------|------------|-------|
| D1 | Domain-specialized agents | Different MAX development tasks require different expertise: patching (spatial layout + object selection), DSP/Gen~ (sample-level audio math), RNBO~ (exportable subset constraints), js/Node (JavaScript + MAX API), externals (C/C++ + Max SDK). A single general agent fails at all of them. Specialized agents with domain contracts produce expert-quality output in each area. | HIGH | Modeled after PFS: 11+ agents with JSON Schema contracts. Proposed agents: patch-agent (layout + object selection + connections), dsp-agent (Gen~ code + MSP signal chains), rnbo-agent (exportable patch constraints + code export), js-agent (Node for Max + js/V8 code), external-agent (C/C++ with Min-DevKit or Max SDK), ui-agent (Presentation Mode layouts), critic agents (validation per domain). Each agent loads relevant slice of object knowledge base. |
| D2 | RNBO~ patch generation with export awareness | RNBO patches look like MAX patches but have strict constraints (no arbitrary Max objects, only RNBO-compatible subset). RNBO exports to VST3/AU plugins, Web Audio, Raspberry Pi, and C++ -- massive value if patches export correctly. No existing tool validates RNBO constraints at generation time. | HIGH | RNBO supports gen~ fully, but only a subset of Max objects. Must maintain RNBO-compatible object list separately from full MAX object DB. Key differences from Max: different message handling, no arbitrary JavaScript, restricted object set. Export targets: audio plugins (VST3/AU), web (JavaScript/Web Audio), hardware (Raspberry Pi), C++ source. Validate export compatibility before user attempts export in MAX. |
| D3 | C/C++ external development support | Building MAX externals is the most advanced MAX development task. Min-DevKit (modern C++) and Max SDK (C) both available. Claude can generate C/C++ code, CMake configs, and build scripts. No existing AI tool supports this workflow. | HIGH | Min-DevKit: modern C++, CMake-based, recommended by Cycling '74. Max SDK: C, lower-level, more control. Both are "rather stale" per community (waiting for Max 8.6+ API access). Need: project scaffolding, inlet/outlet setup, message handling, DSP processing methods, build system. PFS's CMake and C++ expertise transfers directly. |
| D4 | Persistent agent memory with write-back | Agents learn the user's preferences, common patterns, and project-specific idioms across sessions. PFS proved this works: 4 agents with seed patterns, 10KB cap, deduplication, write-back via SubagentStop. Applied to MAX: "user prefers poly~ over multiple instances," "project uses OSC port 8000," "always include loadbang for initialization." | MEDIUM | Direct port from PFS v1.4. Agent memory files in .claude/agent-memory/. Write-back on session completion. Deduplication via key phrases. 10KB cap per agent. Seed patterns for MAX-specific knowledge. Accumulates across projects when patterns are universal (MAX conventions) vs project-scoped (specific object preferences). |
| D5 | Generator-critic validation loops | After generating a patch, specialized critics review it before the user sees it. DSP critic checks signal flow and rate consistency. Layout critic checks readability. Object critic validates against knowledge base. Multiple critics catch errors a single pass misses. PFS proved this pattern catches issues serial review misses. | MEDIUM | PFS pattern: generator produces, critics review, generator revises. For MAX: DSP critic (signal flow, audio rate consistency, feedback loops), structure critic (subpatcher encapsulation, abstraction opportunities, naming conventions), connection critic (signal/control type matching, ordering issues). Critics are read-only -- they analyze but don't modify. |
| D6 | Intelligent object selection with context | Given a task description, recommend the right MAX objects. Not just "use cycle~ for a sine wave" but "use poly~ with 8 voices because this is a synth, use mc.cycle~ if targeting multichannel, use gen~ codebox if you need waveshaping." Context-aware selection based on project requirements and performance implications. | MEDIUM | Requires structured object knowledge beyond inlet/outlet counts: performance characteristics, common use patterns, idiomatic alternatives, version-specific availability. Build recommendation engine on top of T2 knowledge base. Example: "For filtering" -> recommend biquad~ (efficient, standard), svf~ (multimode), onepole~ (simple lowpass), filtercoeff~ + cascade~ (precision), gen~ codebox (custom). |
| D7 | MAX 9 object coverage including ABL objects | MAX 9 (Oct 2024) and 9.1 (Oct 2025) added significant new objects: ABL audio devices (autofilter, compressor, drum buss), new DSP components (meldfilter, meldosc, pitchestimator), 40+ array objects, 30+ string objects, step sequencer objects (stepfun~, stepdiv~, stepcounter~), text.codebox. Being current with MAX 9 when other tools are not is a real advantage. | MEDIUM | Must version-tag objects in knowledge base. New MAX 9 objects that matter: ABL devices (high-quality audio processing with custom inputs), step sequencer objects (previously required complex patching), text.codebox (code-first object creation), array/string objects (previously required js for basic data manipulation). Users stuck on MAX 8 need compatibility warnings. |
| D8 | Skill-based project lifecycle | Skills for each phase of MAX project development: ideation (what to build), research (what objects/patterns to use), planning (patch architecture), execution (generation), verification (validation). Scoped per project. Proven pattern from PFS with 27 skills across the full plugin lifecycle. | MEDIUM | Direct adaptation from PFS. MAX-specific skills: patch-ideation (creative brief for MAX projects), object-research (find right objects for the task), patch-planning (architecture decomposition into subpatchers/abstractions), patch-generation (create .maxpat files), patch-verification (run validation pipeline), patch-iteration (incorporate user feedback from testing in MAX). |

### Anti-Features (Commonly Requested, Often Problematic)

Features that seem good but create problems. These are deliberate exclusions.

| # | Feature | Why Requested | Why Problematic | Alternative |
|---|---------|---------------|-----------------|-------------|
| A1 | Real-time MAX control via OSC/MCP | "Let Claude control MAX directly!" -- MCP servers for MAX exist (tiianhk/MaxMSP-MCP-Server). Seems like the ultimate integration: Claude generates, MAX runs, Claude hears results. | Claude cannot process audio. Real-time control adds massive complexity (network protocol, state synchronization, error recovery). The MCP server requires MAX 9 + V8 + Python + running MAX instance. Creates fragile dependency on MAX being open and configured. Testing gap remains -- Claude still cannot evaluate whether audio sounds correct. | Offline generation with structured manual testing protocol. Claude generates .maxpat, user opens in MAX, user reports results via structured form (works/doesn't work/sounds wrong + description), Claude iterates. Keep the human in the audio evaluation loop where they belong. |
| A2 | Patch-from-screenshot / visual understanding | "Claude should look at my patch screenshot and understand it." Multimodal LLMs can read images. Seems natural for a visual patching tool. | MAX patches are dense visual graphs. Object text is small. Patch cords overlap. Subpatcher contents are hidden. Screenshot analysis gives Claude a fuzzy approximation of what it could read precisely from the .maxpat JSON. JSON is the source of truth -- screenshots are lossy representations. Investing in screenshot understanding competes with investing in JSON understanding. | Read the .maxpat file directly. Claude can parse JSON precisely. For user communication about visual layout issues, ask the user to describe what they see or provide specific object names. |
| A3 | Automatic patch complexity management | "Claude should automatically decide when to use subpatchers vs inline objects." Seems like good engineering practice. | Encapsulation decisions are architectural choices that depend on the user's mental model, project scope, and personal preferences. Automated decisions here override the expert user's judgment. Some users prefer flat patches for debugging. Others prefer deep nesting for organization. The framework should suggest but not enforce. | Provide encapsulation recommendations via critic feedback. "This section could be a subpatcher" as a suggestion, not an automatic action. Let templates demonstrate good encapsulation patterns. |
| A4 | Full Jitter/GL as primary focus | "Support video/GL generation equally with audio." Jitter is a major MAX domain with complex 3D graphics, shader programming, and matrix operations. | Jitter patches involve textures, shaders, GL rendering contexts, and real-time video -- all impossible to validate without MAX running. The testing gap is even wider than audio. Jitter expertise is more niche than MSP. Trying to be equally good at everything dilutes quality everywhere. | Support Jitter objects in the knowledge base. Generate basic Jitter patches (video player, effects chain). But do not invest equally in Jitter-specific validation, agents, or templates. MSP/audio is primary. Expand Jitter support based on user demand. |
| A5 | MAX for Live integration | "Generate patches that work in Ableton Live." MAX for Live is a huge use case. Adds Live API access, device types, parameter mapping. | Separate domain with its own constraints: Live API, device types (audio effect, instrument, MIDI effect), parameter mapping to Ableton, M4L-specific objects (live.*, pluggo~). Doubles the object knowledge base scope. Testing requires Ableton Live + MAX for Live license. Conflating MAX standalone and M4L development creates confusion. | Defer entirely to a future milestone. The core framework must work for standalone MAX first. M4L support can be added as a layer on top once the foundation is solid. The object knowledge base can be extended to include live.* objects later. |
| A6 | py2max/MaxPyLang as runtime dependency | "Use py2max as the patch generation engine." py2max has 1157 objects, layout engines, validation, SVG preview. Seems like free infrastructure. | Creates Python dependency in a Claude Code framework that should generate .maxpat JSON directly. py2max is a third-party library with its own update cycle. Claude can generate JSON natively -- adding Python as an intermediary adds complexity without proportional value. py2max's object database is valuable as a reference, but its runtime is unnecessary. | Extract knowledge from py2max (object database, format patterns, layout algorithms) as reference material for building MaxSystem's own generation. Use py2max as a validation cross-reference, not a runtime dependency. Study its 418+ tests for edge cases. |
| A7 | Agent teams for patch generation | "Parallelize generation -- one agent does DSP, another does UI, a third does control logic." Seems like it would speed up complex patch creation. | Patch generation modifies a single .maxpat file. Parallel agents editing the same JSON create merge conflicts. PFS learned this: "Agent teams for implementation stages... two teammates editing PluginProcessor.cpp leads to overwrites." Patch generation is inherently serial -- objects must be placed, then connected, in order. | Use agent teams for read-only work: parallel research (what objects to use for this task), parallel review (DSP critic + layout critic + connection critic). Keep generation serial with a single patch-agent that consults specialist agents via subagent calls. |

## Feature Dependencies

```
T2 (Object Knowledge Base)
    |
    +---> T1 (Valid .maxpat generation) -- needs object DB for numinlets/numoutlets/maxclass
    +---> T3 (Connection validation) -- needs object DB for inlet/outlet types
    +---> T5 (Gen~ code generation) -- needs gen~ operator knowledge
    +---> T6 (Node/js code generation) -- needs MAX API knowledge
    +---> T9 (Validation pipeline) -- uses object DB for existence checks
    +---> D1 (Specialized agents) -- each agent loads relevant KB slice
    +---> D2 (RNBO generation) -- needs RNBO-compatible object subset
    +---> D6 (Intelligent object selection) -- recommendation engine over KB
    +---> D7 (MAX 9 coverage) -- extends KB with version tagging

T1 (Valid .maxpat generation)
    |
    +---> T4 (Patch layout engine) -- layout operates on valid patch structure
    +---> T7 (Template library) -- templates are valid .maxpat files
    +---> T9 (Validation pipeline) -- validates generated patches

T4 (Patch layout engine)
    |
    +---> T7 (Template library) -- templates need good layout
    +---> D5 (Generator-critic loops) -- layout critic needs layout engine

T8 (Multi-project isolation)
    |
    +---> D4 (Persistent agent memory) -- memory scoped to projects
    +---> D8 (Skill-based lifecycle) -- lifecycle scoped to projects

T9 (Validation pipeline)
    |
    +---> D5 (Generator-critic loops) -- critics invoke validators

D1 (Specialized agents)
    |
    +---> D3 (External development) -- external-agent is one specialist
    +---> D5 (Generator-critic loops) -- critic agents are specialists
    +---> D8 (Skill-based lifecycle) -- skills orchestrate agents
```

### Dependency Notes

- **T2 is the foundation of everything.** Without the object knowledge base, nothing else works correctly. Object hallucination is the #1 failure mode reported by the community. This must be built first and thoroughly.
- **T1 depends on T2** because generating valid .maxpat JSON requires knowing each object's maxclass, numinlets, numoutlets, and valid arguments. You cannot generate a box without knowing its properties.
- **T4 (layout) and T7 (templates) depend on T1** because layout operates on structurally valid patches and templates are valid patches.
- **D1 (agents) depends on T2** because each agent needs domain-specific knowledge. The DSP agent needs MSP objects, the RNBO agent needs the RNBO-compatible subset, the Jitter agent needs jit.* objects.
- **D2 (RNBO) requires its own object subset** derived from T2. RNBO supports gen~ fully but only a restricted set of Max objects. Generating a patch with unsupported objects means export fails.
- **D5 (critic loops) requires T9 (validation)** because critics invoke the validation pipeline and report results to the generator for revision.
- **T8 (multi-project) enables D4 (memory) and D8 (lifecycle)** because agent memory and project lifecycle phases must be scoped to individual projects.

## MVP Definition

### Launch With (v1)

Minimum viable framework -- enough to generate patches that actually work in MAX.

- [ ] **T2: Object knowledge base** -- the absolute foundation; without accurate object data, everything else produces garbage. Source from py2max's MaxRef (1,157 objects), Cycling '74 docs, and manual curation. Prioritize MSP audio objects first.
- [ ] **T1: Valid .maxpat JSON generation** -- produce files MAX opens without errors. Must handle patcher wrapper, boxes, patchlines, nested subpatchers, and attributes.
- [ ] **T3: Connection validation** -- verify outlet-to-inlet index bounds and signal/control type matching before the user opens the patch.
- [ ] **T4: Patch layout engine** -- objects positioned readably with top-to-bottom signal flow. Start with grid/columnar layout. Does not need to be beautiful, just usable.
- [ ] **T5: Gen~ code generation** -- GenExpr syntax validation, codebox integration, .gendsp file output. Claude writes GenExpr naturally since it resembles C.
- [ ] **T6: Node/js code generation** -- JavaScript generation for node.script and js objects. Claude's strongest subsystem -- leverage it.
- [ ] **T9: Validation pipeline (basic)** -- JSON validity, object existence check, connection bounds check. Minimum 3 layers.

### Add After Validation (v1.x)

Features to add once core generation produces working patches consistently.

- [ ] **T7: Template library** -- add once the generation engine is stable enough to produce reliable template content. Trigger: user successfully opens 5+ generated patches without JSON errors.
- [ ] **T8: Multi-project isolation** -- add when users start building multiple MAX projects with the framework. Trigger: second project request.
- [ ] **D1: Specialized agents** -- add domain agents as the single-agent approach hits quality ceilings in specific domains. Trigger: Gen~ output quality is good but patch layout quality suffers (or vice versa).
- [ ] **D4: Persistent agent memory** -- add when users report Claude forgetting project preferences across sessions. Trigger: repeated correction of the same preferences.
- [ ] **D5: Generator-critic loops** -- add when validation catches errors that should have been prevented at generation time. Trigger: >30% of generated patches need post-generation fixes.
- [ ] **D6: Intelligent object selection** -- add when object choice quality becomes a bottleneck. Trigger: user frequently overrides Claude's object choices.
- [ ] **D7: MAX 9 object coverage** -- add version-tagged objects when MAX 9 users request new objects. Trigger: user asks for ABL/step/array objects.

### Future Consideration (v2+)

Features to defer until the framework is proven.

- [ ] **D2: RNBO patch generation** -- complex domain with its own constraints; defer until MAX patching is solid. The RNBO-compatible subset is a strict filter on the full object DB -- needs the DB to be comprehensive first.
- [ ] **D3: C/C++ external development** -- most advanced domain; requires Min-DevKit/Max SDK research, build system setup, and platform-specific compilation. Defer until the framework proves value for patching.
- [ ] **D8: Skill-based project lifecycle** -- full lifecycle management is overhead for a framework that hasn't proven basic generation. Add when users want structured multi-session projects.
- [ ] **MAX for Live support** -- separate domain, separate API, separate testing requirements. Only after standalone MAX is solid.
- [ ] **Jitter deep support** -- validation gap is wider than audio. Support basic Jitter in v1 knowledge base but defer specialized agents/templates/critics.

## Feature Prioritization Matrix

| Feature | User Value | Implementation Cost | Priority | Phase |
|---------|------------|---------------------|----------|-------|
| T2: Object knowledge base | HIGH | HIGH | P1 | 1 |
| T1: Valid .maxpat generation | HIGH | HIGH | P1 | 1 |
| T3: Connection validation | HIGH | MEDIUM | P1 | 1 |
| T4: Patch layout engine | HIGH | MEDIUM | P1 | 1 |
| T5: Gen~ code generation | HIGH | MEDIUM | P1 | 1 |
| T6: Node/js code generation | MEDIUM | LOW | P1 | 1 |
| T9: Validation pipeline | HIGH | MEDIUM | P1 | 1 |
| T7: Template library | MEDIUM | MEDIUM | P2 | 2 |
| T8: Multi-project isolation | MEDIUM | LOW | P2 | 2 |
| D1: Specialized agents | HIGH | HIGH | P2 | 2-3 |
| D4: Persistent memory | MEDIUM | MEDIUM | P2 | 2 |
| D5: Generator-critic loops | HIGH | MEDIUM | P2 | 2 |
| D6: Object selection engine | MEDIUM | MEDIUM | P2 | 3 |
| D7: MAX 9 objects | MEDIUM | MEDIUM | P2 | 2 |
| D2: RNBO generation | HIGH | HIGH | P3 | 3 |
| D3: External development | HIGH | HIGH | P3 | 4 |
| D8: Skill-based lifecycle | MEDIUM | MEDIUM | P3 | 3 |

**Priority key:**
- P1: Must have for launch -- framework is useless without these
- P2: Should have -- adds significant value, build after core works
- P3: Future -- high value but high cost, defer until foundation is proven

## Competitor Feature Analysis

| Feature | py2max | MaxPyLang | MaxMSP-MCP-Server | Max Patch Pal (GPT) | MaxSystem (Our Plan) |
|---------|--------|-----------|-------------------|---------------------|---------------------|
| Patch generation | Python API for .maxpat creation | Python API, simpler than py2max | Requires running MAX | Chat-based suggestions, no file output | Direct .maxpat JSON generation via Claude |
| Object database | MaxRef: 1,157 objects | Minimal | Reads from MAX docs | Training data only (hallucination-prone) | Comprehensive KB from multiple sources |
| Layout | 5 strategies, 3 engines | Basic placement | N/A (MAX handles layout) | N/A | Convention-based layout engine |
| Validation | Connection validation, tests | Basic | Runtime validation via MAX | None | Multi-layer offline validation pipeline |
| Gen~ support | Can embed gen~ objects | Unknown | Can interact with gen~ in MAX | Can suggest GenExpr | GenExpr generation + syntax validation |
| RNBO support | .rnbopat file support | Unknown | Unknown | None | RNBO-aware generation with export validation |
| External dev | None | None | None | None | Min-DevKit/Max SDK scaffolding + code gen |
| AI integration | None (pure Python) | "Vibecoding" prompt examples | MCP bridge to Claude/Cursor | ChatGPT wrapper | Native Claude Code framework with agents |
| Offline operation | Yes | Yes | No (requires MAX) | N/A (cloud) | Yes -- no MAX dependency for generation |
| Learning/memory | None | None | None | None (stateless) | Persistent agent memory across sessions |

**Key insight:** py2max is the closest comparable tool but operates in a fundamentally different paradigm (Python scripting vs AI-assisted development). MaxSystem's value is not in replacing py2max but in giving Claude the knowledge and validation infrastructure to generate MAX patches that actually work -- something the community consensus says current LLMs cannot do.

## Sources

### Authoritative (HIGH confidence)
- [Cycling '74 Official Documentation -- Objects](https://docs.cycling74.com/userguide/objects/) -- object reference, inlet/outlet behavior
- [Cycling '74 GenExpr Documentation](https://docs.cycling74.com/max8/vignettes/gen_genexpr) -- GenExpr language syntax and semantics
- [Cycling '74 Node for Max API](https://docs.cycling74.com/nodeformax/api/) -- Node for Max capabilities and limitations
- [Cycling '74 RNBO](https://rnbo.cycling74.com/) -- RNBO export targets and gen~ integration
- [Cycling '74 Max 9 Release Notes](https://cycling74.com/releases/max/9.1.0) -- new objects and API changes
- [Cycling '74 Min-DevKit](https://github.com/Cycling74/min-devkit) -- C++ external development

### Verified (MEDIUM confidence)
- [py2max GitHub](https://github.com/shakfu/py2max) -- .maxpat format reference, 1,157 object MaxRef DB, 5 layout strategies, 418+ tests
- [MaxPyLang GitHub](https://github.com/Barnard-PL-Labs/MaxPyLang) -- alternative Python patch generation, vibecoding integration
- [MaxMSP-MCP-Server](https://github.com/tiianhk/MaxMSP-MCP-Server) -- MCP bridge for MAX/AI integration
- [Cycling '74 Forums: Vibe Coding with MAX](https://cycling74.com/forums/advice-required-for-vibe-coding-with-max-ai-llm-coding-assistants) -- community experience with AI + MAX (consensus: "non-functional mess" without specialized knowledge)
- [Cycling '74 Forums: .maxpat Format](https://cycling74.com/forums/specification-for-maxpat-json-format) -- confirmation that no official spec exists
- [Cycling '74 Forums: Best Practices](https://cycling74.com/forums/best-practices-in-max) -- trigger for ordering, poly~ usage, abstraction patterns
- [Plugin Freedom System](file:///Users/taylorbrook/Dev/VST-development/) -- 13 agents, 27 skills, multi-layer validation, persistent memory, proven architecture

### Analogous Systems (MEDIUM confidence)
- [Unity MCP](https://github.com/CoplayDev/unity-mcp) -- MCP bridge pattern for visual editors (Unity + Claude/Cursor)
- [AgentCoder](https://arxiv.org/html/2312.13010v3) -- multi-agent code generation with programmer/tester/executor agents

---
*Feature research for: Claude Code development framework for MAX/MSP*
*Researched: 2026-03-08*
