# Project Research Summary

**Project:** MaxSystem -- Claude Code Framework for MAX/MSP Development
**Domain:** AI-assisted development framework for visual audio programming (MAX/MSP)
**Researched:** 2026-03-08
**Confidence:** HIGH

## Executive Summary

MaxSystem is a Claude Code development framework -- not a MAX/MSP application -- that gives Claude the knowledge and validation infrastructure to generate MAX/MSP patches, Gen~ DSP code, RNBO~ exportable patches, Node for Max JavaScript, and C/C++ externals. The core challenge is that MAX's .maxpat file format has no official specification (confirmed by Cycling '74), the object ecosystem spans 1,900+ objects across six domains (Max, MSP, Jitter, MC, Gen~, RNBO~), and academic benchmarks show current LLMs achieve only a 0.30 pass@1 rate for MAX/MSP JSON generation. The framework's architecture is modeled after the proven Plugin Freedom System (13 agents, 27 skills, Python hooks), adapted to MAX/MSP's unique constraints: visual patch graphs stored as JSON, spatial layout that affects execution order, and strict signal/control type boundaries.

The recommended approach is Python-first for all framework infrastructure (hooks, validators, database construction, code generation utilities), leveraging py2max as a reference implementation for .maxpat format correctness and the local MAX installation's 1,924 XML reference files as the authoritative object data source. The Object Knowledge Base is the single most critical component -- every other feature depends on it, and object hallucination is the #1 reported failure mode when LLMs attempt MAX development. Build the database first from MAX's bundled refpage XML files, validate generation against it, and treat it as the hard constraint that prevents Claude from guessing or confusing MAX with Pure Data.

The key risks are: (1) the undocumented .maxpat format requiring reverse-engineering and continuous validation against MAX-saved reference patches, (2) the breadth of the object ecosystem making completeness an ongoing effort rather than a one-time task, and (3) the fundamental testing gap -- Claude cannot run MAX, so validation is necessarily static and the human must remain in the audio evaluation loop. These risks are mitigated by multi-layer validation (structural, semantic, domain), contract-driven generation where every patch traces back to planning documents, and honest validation coverage reporting that explicitly states what is NOT checked.

## Key Findings

### Recommended Stack

The framework runs entirely within Claude Code's native extension system. Python 3.14+ is the primary runtime for hooks, validators, and database construction -- matching the Plugin Freedom System's architecture and providing direct access to py2max. TypeScript (Zod 4.x for schema validation, Vitest 4.x for testing) is used only where it adds clear value. SQLite stores the object database. No external services, no Docker, no web UI.

**Core technologies:**
- **Python 3.14+**: Hook scripts, validators, database extraction from XML, py2max integration -- proven at PFS scale, no compilation step
- **py2max**: Reference implementation for .maxpat generation (1,157 objects, 418+ tests, 5 layout strategies) -- extracted as knowledge, not used as runtime dependency
- **SQLite**: Object database storage (zero-config, Python stdlib, single file) -- sufficient for ~2,000 objects
- **Claude Code Agents/Skills/Hooks**: Native extension points for domain-specialized subagents, workflow orchestration, and automated validation -- proven with PFS (11 agents, 27 skills)
- **Min-DevKit (0.6.0)**: Primary path for C++ external development -- modern C++, CMake-based, testing framework included
- **Zod 4.x**: TypeScript schema validation for .maxpat JSON structure (14x faster than v3) -- used for pre-generation structural validation
- **fast-xml-parser 5.4.x**: Parse 1,924 maxref XML files during database construction -- zero dependencies, TypeScript native

### Expected Features

**Must have (table stakes):**
- **T2: Object Knowledge Base** -- the absolute foundation; object hallucination is the #1 failure mode. Source from 1,924 maxref XML files at `/Applications/Max.app/`
- **T1: Valid .maxpat JSON generation** -- patches must open in MAX without errors. Format is undocumented; must reverse-engineer from py2max and real patches
- **T3: Connection validation** -- outlet-to-inlet index bounds, signal/control type matching. Wrong connections cause silent failures
- **T4: Patch layout engine** -- objects positioned readably with top-to-bottom signal flow. Overlapping objects make technically valid patches unusable
- **T5: Gen~ code generation** -- GenExpr syntax for sample-level DSP. Claude writes C-like code naturally; needs syntax validation
- **T6: Node for Max / js code generation** -- JavaScript where Claude excels. Lowest complexity, highest natural quality
- **T9: Structured validation pipeline** -- multi-layer: JSON structure, object existence, connection validity, domain-specific checks

**Should have (differentiators):**
- **D1: Domain-specialized agents** -- patching, DSP/Gen~, RNBO~, js/Node, externals, layout. Single general agent fails at all domains
- **D5: Generator-critic validation loops** -- DSP critic, layout critic, connection critic catch errors serial review misses
- **D4: Persistent agent memory** -- learns user preferences and project idioms across sessions (proven in PFS)
- **D7: MAX 9 object coverage** -- ABL devices, step sequencer objects, array/string objects. Being current when competitors are not

**Defer (v2+):**
- **D2: RNBO~ patch generation** -- strict object subset constraints, separate validation layer needed. Build after MAX patching is solid
- **D3: C/C++ external development** -- most advanced domain; Min-DevKit/Max SDK stale per community. Defer until framework proves value
- **D8: Skill-based project lifecycle** -- full lifecycle overhead premature before basic generation is proven
- **MAX for Live** -- separate domain, separate API, separate testing. Only after standalone MAX works
- **Deep Jitter support** -- validation gap wider than audio. Support in knowledge base, defer specialized agents

### Architecture Approach

The framework lives entirely within `.claude/` and `projects/` directories. It adapts the Plugin Freedom System's agent-skill-hook-schema-critic architecture to MAX/MSP. Each MAX project gets isolated storage under `projects/[Name]/` with its own planning docs, patches, code, and test results. The data flow is: User Command -> Skill (orchestration) -> Agent (domain-specific generation) -> Validators (PostToolUse hooks) -> Critics (stage gates). The Object Database is consulted at every step -- agents read it during generation, validators cross-check against it post-generation.

**Major components:**
1. **Object Database** (references/object-db/) -- JSON files per domain namespace with inlet/outlet types, arguments, version compatibility. Populated from MAX's 1,924 XML refpage files. The single source of truth for all object properties
2. **Agent System** (agents/) -- 9 domain-specialized agents: patch-agent, dsp-agent, gen-agent, rnbo-agent, n4m-agent, external-agent, layout-agent, jitter-agent, validation-agent. Each loads relevant knowledge base slices
3. **Validation Pipeline** (hooks/validators/) -- Three layers: structural (JSON validity, required fields, ID uniqueness), semantic (object existence, connection type matching, signal chain termination), domain (signal flow sense, gain staging, GenExpr syntax, RNBO compatibility)
4. **Template Library** (templates/) -- Reusable .maxpat patterns, GenExpr code, RNBO patterns, N4M scripts, external scaffolding. Start with 10-15 high-quality templates, expand based on demand
5. **Hook System** (hooks/) -- Python scripts wired to Claude Code lifecycle events. SessionStart loads context, PostToolUse dispatches validators, SubagentStop persists memory

### Critical Pitfalls

1. **No official .maxpat specification** -- The format is reverse-engineered. Missing fields cause MAX to silently drop objects or refuse to load patches. Mitigate by building canonical templates from MAX-saved patches, using py2max as reference, and validating every generated patch against known-good structural patterns. Phase 1 must nail this.

2. **maxclass confusion** -- Most objects use `maxclass: "newobj"` but ~15 types (message, comment, number, flonum, toggle, inlet, outlet, bpatcher, etc.) require distinct maxclass values with unique JSON structures. Treating everything as "newobj" produces broken UI objects and non-functional subpatchers. Mitigate with a maxclass lookup table in the object database.

3. **Hot/cold inlet semantics** -- Only inlet 0 is "hot" (triggers computation). Connecting data only to cold inlets produces patches that do nothing. Missing `trigger` objects cause evaluation order bugs. Mitigate by marking every inlet as hot/cold in the database and requiring explicit `trigger` objects for fan-out scenarios.

4. **LLMs confuse MAX/MSP with Pure Data** -- Academic research confirms this is the most common AI failure mode. PD bracket syntax, wrong object names, wrong file formats. Mitigate with the object knowledge base as a hard constraint: if an object name is not in the database, it is rejected.

5. **Signal vs. control rate mismatch** -- Connecting message outlets to signal inlets (or vice versa) without conversion objects produces silence or glitchy audio. Mitigate by tagging every inlet/outlet with domain type in the database and flagging cross-domain connections without `sig~`, `line~`, or `snapshot~` intermediaries.

## Implications for Roadmap

Based on combined research, the dependency graph is clear: Object Database -> Generation -> Validation -> Agents -> Orchestration -> Expansion. Feature dependencies from FEATURES.md confirm T2 (Object KB) is the root of the entire tree.

### Phase 1: Foundation and Object Database
**Rationale:** Every other component depends on the Object Knowledge Base. Without it, Claude hallucinates objects, gets inlet/outlet counts wrong, and confuses MAX with Pure Data. The .maxpat format must also be nailed here -- get the JSON structure wrong and nothing opens in MAX. This phase addresses the 4 most critical pitfalls simultaneously.
**Delivers:** System config detection, directory structure, core JSON schemas, Object Database populated from MAX refpage XML (prioritize ~100 most-used MSP/Max objects), basic settings.json with hook skeleton, canonical .maxpat templates saved from MAX itself.
**Addresses:** T2 (Object Knowledge Base), foundation for T1 (.maxpat generation)
**Avoids:** Pitfalls 1 (no spec), 2 (maxclass confusion), 4 (hot/cold inlets), 5 (PD confusion), 11 (DB incompleteness)

### Phase 2: Patch Generation Core
**Rationale:** With the Object DB in place, build the generation engine and validation pipeline. These are tightly coupled -- generation consults the DB, validation checks against it. Layout is included here because unreadable patches are effectively broken even when structurally valid. This phase produces the first end-to-end working output: a .maxpat file that opens correctly in MAX.
**Delivers:** patch-agent, layout engine (grid/columnar with MAX conventions), structural validator, object validator, connection validator, PostToolUse hook wiring.
**Addresses:** T1 (valid .maxpat generation), T3 (connection validation), T4 (patch layout), T9 (validation pipeline basics)
**Avoids:** Pitfalls 3 (connection false positives), 8 (terrible layout), 10 (rate mismatch), 13 (execution order), 14 (subpatcher breakage)

### Phase 3: Gen~/DSP and Code Generation
**Rationale:** Gen~ is the primary DSP code entry point and Claude writes C-like code naturally. Node for Max / js is Claude's strongest subsystem (native JavaScript). These code generation domains are high-value, moderate-complexity additions once the patching foundation works. Includes DSP-specific agent and GenExpr syntax validation.
**Delivers:** gen-agent with GenExpr generation + validation, dsp-agent for MSP signal chains, n4m-agent for JavaScript, GenExpr syntax validator, JS validator, initial template library (10-15 core patterns), Gen~ code templates.
**Addresses:** T5 (Gen~ code generation), T6 (Node/js code generation), T7 (template library - initial), D7 (MAX 9 objects - version tagging in DB)
**Avoids:** Pitfalls 6 (GenExpr scope errors), 12 (N4M file naming), 17 (overambitious templates), 19 (Gen~ execution order)

### Phase 4: Orchestration and Agent Infrastructure
**Rationale:** With core generation, code domains, and validation working, add the orchestration layer that ties everything together: multi-project isolation, persistent agent memory, generator-critic loops, and skill-based workflows. These are force multipliers on existing capabilities, not new generation domains.
**Delivers:** Multi-project isolation, persistent agent memory with write-back, generator-critic validation loops (DSP critic, layout critic, connection critic), patch-workflow skill, slash commands (/patch, /gen, /project), specialized agent refinements.
**Addresses:** T8 (multi-project isolation), D1 (domain-specialized agents - refinement), D4 (persistent memory), D5 (generator-critic loops), D6 (intelligent object selection), D8 (skill-based lifecycle)
**Avoids:** Pitfall 18 (validation without feedback - critic loops add second opinion layer)

### Phase 5: RNBO and External Development
**Rationale:** These are the highest-complexity, highest-value expansion domains. RNBO enables VST3/AU/Web export from generated patches -- massive value but requires its own object whitelist and validation layer. External development (C/C++ with Min-DevKit) is the most advanced MAX development task. Both require the full foundation to be solid.
**Delivers:** rnbo-agent with export-aware generation, RNBO object whitelist + validator, external-agent with Min-DevKit scaffolding, CMake template generation, build system validation, RNBO/external templates.
**Addresses:** D2 (RNBO~ generation), D3 (C/C++ external development)
**Avoids:** Pitfalls 7 (RNBO object subset), 9 (SDK build fragility)

### Phase 6: Expansion and Polish
**Rationale:** After the core framework is proven, expand coverage: full object database (all 1,900+ objects), Jitter support, MC multichannel, advanced layout algorithms, help patch generation. These are incremental improvements driven by user demand.
**Delivers:** Full Object DB coverage, Jitter agent + objects, MC domain support, advanced layout (Sugiyama-style), help-patch generation, diagnostic mode for generated patches.
**Addresses:** Remaining D7 (full MAX 9 coverage), Jitter support, MC support
**Avoids:** Pitfall 20 (MC channel count limitations)

### Phase Ordering Rationale

- **Object DB first** because the dependency graph from FEATURES.md shows T2 is the root node for T1, T3, T5, T6, T9, D1, D2, D6, and D7. Nothing works correctly without it.
- **Generation + Validation together** because they form a tight feedback loop: generation consults the DB, validation checks against it, and both need to be in place before the first usable output.
- **Code generation before orchestration** because Gen~/js generation adds high-value output types with moderate complexity, while orchestration is a multiplier on existing capabilities (not useful until there are capabilities to multiply).
- **RNBO and externals last** because they are the most complex domains with the most constraints, and both require the full validation pipeline to catch their unique failure modes.
- **This ordering avoids the overambition pitfall** (Pitfall 17) by delivering working output early (Phase 2) and expanding based on proven foundation.

### Research Flags

Phases likely needing deeper research during planning:
- **Phase 1:** Needs `/gsd:research-phase` for .maxpat format edge cases (subpatcher nesting, bpatcher references, presentation mode JSON structure). The format is undocumented and py2max covers the common cases but not all edge cases.
- **Phase 3:** Needs `/gsd:research-phase` for GenExpr syntax specifics (scope rules, History behavior in functions, buffer access operators). No parser exists; must build custom validation.
- **Phase 5 (RNBO):** Needs `/gsd:research-phase` for RNBO object subset enumeration. The exact list of supported objects is not machine-readable and changes between MAX versions.
- **Phase 5 (Externals):** Needs `/gsd:research-phase` for Min-DevKit/Max SDK current state. Community reports them as "rather stale" -- need to verify what works on current macOS/Apple Silicon.

Phases with standard patterns (skip research-phase):
- **Phase 2:** Well-documented patterns. Layout algorithms (grid, columnar) are straightforward. Validation layers follow established static analysis patterns. PFS provides proven hook wiring patterns.
- **Phase 4:** Direct port from Plugin Freedom System. Agent memory, project isolation, skill lifecycle, and critic patterns are all proven at PFS scale with 11 agents and 27 skills.

## Confidence Assessment

| Area | Confidence | Notes |
|------|------------|-------|
| Stack | HIGH | Python + Claude Code extensions proven by PFS. py2max verified locally. All tools version-checked. Local MAX installation confirmed with 1,924 refpage XML files. |
| Features | MEDIUM | No precedent for this exact product category. Feature priorities derived from community failure reports and PFS analogy. Table stakes are clear; differentiator value is projected, not proven. |
| Architecture | HIGH | Direct adaptation of PFS architecture (13 agents, 27 skills, Python hooks) which is production-proven. MAX-specific adaptations (Object DB, layout engine, .maxpat pipeline) are well-reasoned from reverse-engineering. |
| Pitfalls | HIGH | Verified across academic research (LLM benchmarks), Cycling '74 forums, official documentation, SDK references, and community tools. Multiple independent sources confirm the same failure modes. |

**Overall confidence:** HIGH -- The architecture is proven (PFS), the pitfalls are well-documented, and the stack is verified locally. The primary uncertainty is in feature prioritization (MEDIUM) because no comparable product exists to validate against.

### Gaps to Address

- **Object Database completeness timeline:** Starting with ~100 objects is sufficient for Phase 1-2, but the path to full 1,900+ coverage needs a concrete extraction pipeline. Plan for incremental expansion with priority based on user requests.
- **.maxpat edge cases:** Subpatcher nesting depth, bpatcher with args, poly~ voice management, and presentation mode JSON structures need empirical testing against MAX-saved patches. Cannot be fully resolved from documentation alone.
- **GenExpr parser:** No existing parser or formal grammar for GenExpr. Must build custom tokenizer/validator. Scope and complexity unknown until Phase 3 research.
- **RNBO object whitelist:** The exact set of RNBO-compatible objects is not published as a machine-readable list. Must extract from RNBO documentation and refpage files, then validate empirically.
- **Validation false positive/negative rates:** The multi-layer validation system's accuracy can only be measured against real-world usage. Plan to track and tune during Phase 2.
- **MAX 8 vs MAX 9 behavioral differences:** Threading changes, new objects, and API differences between versions need systematic cataloging. The object database version-tagging approach handles this in theory but needs validation.

## Sources

### Primary (HIGH confidence)
- [Cycling '74 Official Documentation](https://docs.cycling74.com/) -- object references, GenExpr syntax, Node for Max API, RNBO documentation
- [Max SDK GitHub](https://github.com/Cycling74/max-sdk) -- v8.2.0, CMake build system, Apple Silicon support
- [Min-DevKit GitHub](https://github.com/Cycling74/min-devkit) -- v0.6.0, modern C++ external development
- [Claude Code Extension Documentation](https://code.claude.com/docs/en/) -- hooks, skills, agents, plugins
- Local MAX Installation at `/Applications/Max.app/` -- 1,924 maxref XML files verified on machine
- Plugin Freedom System at `/Users/taylorbrook/Dev/VST-development/` -- proven architecture (13 agents, 27 skills)

### Secondary (MEDIUM confidence)
- [py2max](https://github.com/shakfu/py2max) -- .maxpat format reference, 1,157 object MaxRef DB, 418+ tests
- [Benchmarking LLM Code Generation for Audio Programming](https://arxiv.org/html/2409.00856v1) -- 0.30 pass@1 for MaxMSP JSON, documents LLM failure modes
- [Cycling '74 Forums](https://cycling74.com/forums/) -- community consensus on AI+MAX ("non-functional mess"), .maxpat format (no official spec), best practices
- [MaxMSP-MCP-Server](https://github.com/tiianhk/MaxMSP-MCP-Server) -- MCP bridge approach (evaluated and rejected as anti-feature)

### Tertiary (LOW confidence)
- [maxobjects.com](http://www.maxobjects.com/) -- community object database, useful for coverage gap identification but not authoritative
- [MaxPyLang](https://github.com/Barnard-PL-Labs/MaxPyLang) -- alternative Python patch generation, minimal documentation

---
*Research completed: 2026-03-08*
*Ready for roadmap: yes*
