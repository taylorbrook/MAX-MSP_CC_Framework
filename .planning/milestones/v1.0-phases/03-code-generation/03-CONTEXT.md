# Phase 3: Code Generation - Context

**Gathered:** 2026-03-09
**Status:** Ready for planning

<domain>
## Phase Boundary

Generate valid Gen~ GenExpr DSP code, js/V8 scripts, and Node for Max JavaScript that integrate correctly with MAX patches. Includes syntax validation, codebox embedding in .maxpat, standalone .gendsp file generation, and file write hooks for automatic validation. RNBO-specific generation and agent orchestration are separate phases.

</domain>

<decisions>
## Implementation Decisions

### GenExpr code style
- Well-commented: section headers (// === OSCILLATOR ===), Param descriptions, inline comments on non-obvious DSP math
- Full Param range specs always: `Param freq(440, min=20, max=20000);` — include min/max/default for every Param
- Section-block organization for multi-stage DSP: logical sections separated by comment headers, all code in one codebox
- Descriptive variable names: `osc_signal`, `filter_output`, `env_value` — self-documenting, easier to debug in gen~ inspector

### Codebox vs .gendsp
- Codebox embedded in gen~ inside .maxpat is the default — self-contained, one file has everything
- Standalone .gendsp only when explicitly requested
- .gendsp files contain codebox with GenExpr + in/out objects only — no visual Gen~ operator layout
- Single codebox per gen~ object — all DSP logic in one GenExpr block, multiple stages handled with section comments
- gen~ codebox API design: Claude's discretion

### js vs Node for Max
- Node for Max is the primary JavaScript target — full code generation with correct MAX API patterns
- js (V8) object gets secondary support: core handlers only (inlets/outlets declarations, bang/msg_int/msg_float/list handlers, outlet() calls) — no advanced patcher scripting (this.patcher)
- CommonJS module format for N4M: `const maxAPI = require('max-api')` — matches Cycling '74 docs and MAX's runtime
- Error logging on async operations: try/catch with maxAPI.post() for file I/O, network, Dict access — don't wrap simple synchronous operations
- Dict access patterns (maxAPI.getDict/setDict) included when task involves structured data — Claude decides based on context
- Both js and N4M auto-create corresponding boxes in .maxpat with correct file reference and inlet/outlet count matching the code's declarations

### Code validation
- GenExpr: syntax validation (balanced braces, semicolons, valid keywords) + operator verification against gen/objects.json database (189 operators)
- GenExpr validates: in/out declarations, Param declarations, operator existence — skips variable liveness and type inference
- js validation: inlets/outlets declarations match handler count, outlet() index within bounds, required handlers present
- N4M validation: require('max-api') present, addHandler names are strings, maxAPI.outlet() called
- Report-only — no auto-fix of code (unlike patch validation which can safely remove bad connections, code fixes risk semantic changes)
- Auto-hook on file write: .gendsp triggers GenExpr validation, .js triggers js/N4M validation — extends existing Phase 2 hook infrastructure

### Claude's Discretion
- gen~ codebox API design (dedicated add_gen method vs generic Box with code attr vs other approach)
- GenExpr validator implementation architecture
- js/N4M validator implementation details
- Hook system extension approach for new file types

</decisions>

<specifics>
## Specific Ideas

- GenExpr code should look like an experienced DSP developer wrote it — section blocks, descriptive names, well-structured Params
- N4M is the modern JavaScript path in MAX — invest depth there, js object is legacy/lightweight
- Validation follows the same philosophy as Phase 2: catch what we can offline, report clearly, don't block on warnings
- Code + patch integration: generating code also generates the corresponding MAX object wired up in the patch

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- `Patcher.add_subpatcher()`: Model for embedding gen~ with codebox — same nested patcher pattern
- `ObjectDatabase` with gen/objects.json: 189 Gen~ operators for GenExpr operator validation
- `validation.py` 4-layer pipeline: Architecture to extend with code-specific validation layers
- `hooks.py` file write hooks: Infrastructure to extend for .gendsp and .js file types
- `Box` model with `_inner_patcher` and `extra_attrs`: Supports embedding codebox inside gen~ boxes

### Established Patterns
- Python scripting with pytest for tests (Phase 1-2)
- Multi-layer validation with auto-fix + report (Phase 2)
- File write hooks trigger validation automatically (Phase 2 FRM-05)
- ObjectDatabase for name verification against JSON domain files
- Content-aware box sizing via `calculate_box_size()`

### Integration Points
- `generate_patch()` pipeline: Code generation extends this to handle gen~/js/node.script boxes
- `validate_patch()`: Code validation runs as additional layer or separate validator for code files
- `write_patch()` hooks: Extend to trigger code validation on .gendsp/.js writes
- File output: .js files go alongside .maxpat in patches/<project_name>/ directory

</code_context>

<deferred>
## Deferred Ideas

None — discussion stayed within phase scope

</deferred>

---

*Phase: 03-code-generation*
*Context gathered: 2026-03-09*
