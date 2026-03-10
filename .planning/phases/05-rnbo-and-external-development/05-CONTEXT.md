# Phase 5: RNBO and External Development - Context

**Gathered:** 2026-03-10
**Status:** Ready for planning

<domain>
## Phase Boundary

Generate RNBO-compatible patches with export target awareness (VST3/AU, Web Audio, C++) and scaffold C/C++ external projects using Min-DevKit with build system support. Upgrades the existing stub agents (max-rnbo-agent, max-ext-agent) from informational-only to full generation capabilities. Does not add new MAX domains, template libraries, or Max for Live support.

</domain>

<decisions>
## Implementation Decisions

### SDK choice for externals
- Min-DevKit only — modern C++17, CMake-based, header-only
- Classic Max SDK not in scope for Phase 5 (UI externals deferred to future phase)
- Min-DevKit included as git submodule per external project for always-latest access
- External source lives in `externals/` subdirectory inside the MAX project directory (`patches/my-project/externals/my-ext/`)
- Basic .maxhelp patch generated alongside every external

### Export target modeling
- Target-aware generation — user specifies target (VST3/AU, Web Audio, C++) when generating RNBO patches
- Framework constrains the patch based on target (e.g., Web Audio has no MIDI, C++ embedded has limited param count)
- Validation warns about target-incompatible features
- Param-to-plugin-parameter mapping auto-generated from GenExpr Param declarations (name, range, default)
- Strict self-containedness enforced — validation rejects RNBO patches referencing external files (samples, abstractions, buffer~ with file args)
- Full rnbo~ wrapper generated in parent .maxpat with inport/outport mapping, param exposure, and DAC/ADC connections — ready to open and export

### External template types
- Three archetypes supported via Min-DevKit: message/data, DSP/signal, and scheduler
- UI externals (custom paint/jbox) deferred — requires classic Max SDK not in Phase 5 scope
- Functional skeleton output — compiles and runs as no-op, includes inlet/outlet registration, message handlers with TODO bodies, DSP perform method (if audio), and help patch
- Intent-driven generation — ext-agent understands what the external does and produces tailored code (inlets, outlets, handlers, params) matching the user's description

### Build system integration
- Generate + compile — framework invokes cmake/make to produce a working .mxo bundle
- Auto-fix compile loop — parse errors, attempt fix, recompile, iterate until clean or escalate unresolvable issues to user
- Compiled .mxo placed in project externals directory (`patches/my-project/externals/my-ext/build/`)
- Post-compile validation: verify .mxo is valid Mach-O bundle with correct architecture (arm64). No MAX load testing (manual test checklist covers that)

### Claude's Discretion
- RNBO validation rule specifics per export target (exact constraint lists)
- Min-DevKit submodule pinning strategy (tag vs main branch)
- CMakeLists.txt template structure and configuration
- Auto-fix strategies for compile errors
- RNBO param grouping and ordering in generated patches

</decisions>

<specifics>
## Specific Ideas

- Ext-agent should work like other specialist agents — user describes intent, agent generates tailored code, not just templates
- Build loop mirrors the critic loop philosophy: iterate until clean, escalate what can't be auto-resolved
- RNBO patches should be ready to open and export immediately — full wrapper, not just inner content
- "No MAX automation" constraint means compile-only validation plus manual test checklist for load/runtime behavior

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- `rnbo/objects.json`: 560 RNBO-compatible objects (36K lines) — complete object subset for RNBO validation
- `rnbo_compatible` flag on all domain objects — cross-reference for rejecting non-RNBO objects
- `Patcher/Box/Patchline` data model: extend for rnbo~ container object generation
- `Box.__new__` pattern: use for rnbo~ structural objects (like gen~/subpatcher)
- `codegen.py` GenExpr builder: reuse for RNBO codebox generation (same GenExpr syntax)
- Critic loop infrastructure (`critics/`): extend with RNBO-specific and external-specific critics
- Stub agents (`max-rnbo-agent`, `max-ext-agent`): upgrade from read-only to full generation
- Router dispatch rules: already include RNBO and External domains
- `hooks.py` file write hooks: extend for .mxo validation
- `testing.py` manual test protocol: extend for external load/runtime testing

### Established Patterns
- Python scripting with pytest (Phases 1-4)
- Multi-layer validation: auto-fix + report for patches, report-only for code
- File write hooks trigger validation automatically
- Box.__new__ for structural objects bypassing DB lookup
- generate_patch() pipeline: layout -> serialize -> validate -> output
- Critic loop runs until clean, no round limit
- Agent dispatch via router with keyword/intent matching

### Integration Points
- RNBO generation extends generate_patch() with rnbo~ wrapper logic
- RNBO validation adds target-aware layer to existing validation pipeline
- External scaffolding generates files in project `externals/` directory
- External build invokes cmake/make via subprocess
- Both agents integrate with memory system for learned patterns
- Both agents integrate with critic loop for post-generation review
- Help patch generation uses existing .maxpat generation pipeline

</code_context>

<deferred>
## Deferred Ideas

- UI externals (custom paint/jbox) — requires classic Max SDK, future phase
- Classic Max SDK support — deferred, Min-DevKit covers most use cases
- RNBO polyphony/multivoice configuration — complex, not in initial scope
- External distribution packaging (signing, notarization) — separate concern

</deferred>

---

*Phase: 05-rnbo-and-external-development*
*Context gathered: 2026-03-10*
