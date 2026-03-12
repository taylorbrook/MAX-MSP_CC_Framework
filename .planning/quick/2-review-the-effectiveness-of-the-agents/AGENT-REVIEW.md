# Agent System Effectiveness Review

## Executive Summary

The 10-agent system is well-architected for its purpose: giving Claude enough structure and domain knowledge to generate valid MAX/MSP patches, code, and projects. The separation of concerns across 6 specialists with a router, critic, memory, and lifecycle layer is sound, and the BOUNDARIES.md files prevent cross-domain confusion effectively. The biggest strengths are the object database enforcement (Rule #1), the deterministic critic pipeline, and the clear dispatch rules. The most significant gaps are: (1) no critic coverage for JavaScript output (js/N4M), (2) an API signature mismatch in the lifecycle agent's `save_test_results` documentation, (3) the memory write-back protocol is aspirational with no automation enforcing it, and (4) the multi-agent merge protocol is theoretically clean but untestable in practice since Claude executes sequentially.

## Per-Agent Assessments

### 1. max-router

- **Effectiveness:** High
- **Strengths:**
  - Well-structured keyword-to-agent mapping with primary and secondary keyword tiers
  - Ambiguity resolution scheme is explicit (count primary keywords, check intent, default hierarchy DSP > Patch > js > UI)
  - Multi-domain dispatch patterns cover the most common real-world tasks (synth+UI, sequencer+js, etc.)
  - Clear "When NOT to Use" section prevents router from being invoked for non-generation commands
  - Correctly tells Claude NOT to load object database files (delegates to specialists)
- **Weaknesses:**
  - Keyword-based dispatch has inherent fragility: a user saying "filter" could mean data filtering (js agent) or audio filtering (DSP agent). The edge case table in dispatch-rules.md does not address this.
  - The router skill does not reference `relationships.json` or `aliases.json` for enriching keyword detection, even though these files could improve dispatch accuracy for abbreviated object names.
  - No dispatch logging mechanism exists in code -- the skill says "Log dispatch decision" but there is no Python function to do this.
- **API accuracy:** No Python API references to check -- the router is a pure prompt-level orchestrator.
- **Recommendation:** Add "filter (data)" vs "filter (audio)" to the edge case disambiguation table. Consider adding a lightweight dispatch log write function to support future debugging.

---

### 2. max-critic

- **Effectiveness:** High
- **Strengths:**
  - Deterministic, code-based criticism (not LLM judgment) is the right design choice for reliability
  - Clear severity hierarchy (blocker/warning/note) with explicit blocking behavior
  - Escalation trigger is well-designed: 5 consecutive identical findings, NOT a round limit. This avoids premature cutoff while catching genuine stuck loops.
  - Automatic RNBO critic invocation when rnbo~ boxes are detected is elegant
  - Four critic modules (DSP, structure, RNBO, external) cover the most important domains
- **Weaknesses:**
  - **No js/N4M critic module.** The code_validation.py validators (validate_js, validate_n4m) check structural patterns (inlets declaration, require statement), but there is no semantic critic for JavaScript output. A js critic could check for: unreachable handlers, outlet index beyond declared count in complex code paths, missing error handling in async N4M operations.
  - The SKILL.md says `review_patch(patch_dict, code_context)` but the actual signature is `review_patch(patch_dict, code_context=None, ext_code=None, ext_archetype="message")`. The additional parameters for external review are not documented in the critic skill.
  - The critic protocol (critic-protocol.md) only describes DSP and structure critics being invoked. RNBO and external critics are not mentioned in the protocol, even though they exist and are automatically invoked.
- **API accuracy:** `review_patch` documented as `review_patch(patch_dict, code_context)` -- missing the `ext_code` and `ext_archetype` optional params. Functional but incomplete documentation.
- **Recommendation:** Create a `js_critic.py` module that performs semantic review of js/N4M code (outlet bounds in branches, handler completeness, async error handling). Update critic-protocol.md to document all 4 critic modules.

---

### 3. max-patch-agent

- **Effectiveness:** High
- **Strengths:**
  - Comprehensive domain context loading with correct object database scope (max/objects.json only)
  - Explicit negative context loading ("Do NOT load: msp, gen, rnbo")
  - Key Python API functions documented with correct signatures (verified: `add_connection`, `write_patch(patcher, ...)`, `generate_patch`)
  - Bpatcher argument substitution rules (#N standalone token) are a critical MAX-specific detail that prevents a common silent bug
  - Pattern application section reinforces CLAUDE.md rules with specificity
  - BOUNDARIES.md has a clear handoff table with what context to provide to each target agent
- **Weaknesses:**
  - Does not document the `add_comment()` or `add_message()` helper methods on Patcher, even though these are commonly needed for patch annotation. Agents may use the generic `Box("comment")` path instead of the cleaner helper.
  - Does not mention `add_node_script()` or `add_js()` Patcher methods, which are needed when the patch agent is lead and needs to add a js/node.script placeholder for the js agent.
- **API accuracy:** All documented signatures are accurate. `write_patch(patcher, path, validate=True)` matches. `add_connection(src_box, src_outlet, dst_box, dst_inlet)` matches.
- **Recommendation:** Add `add_comment()`, `add_message()`, `add_node_script()`, and `add_js()` to the Key Functions list. These are essential when the patch agent is lead in multi-agent tasks.

---

### 4. max-dsp-agent

- **Effectiveness:** High
- **Strengths:**
  - Correct separation of GenExpr code generation vs MSP signal chain construction
  - Declaration ordering rule for GenExpr is documented prominently and matches the validation check in code_validation.py
  - Signal chain construction section is specific to MAX idioms (cycle~ not osc~, proper gain staging)
  - Optional MC domain loading is appropriate -- only when multichannel is requested
  - API signatures verified: `build_genexpr(params, code_body, num_inputs=1, num_outputs=1)`, `generate_gendsp(code, num_inputs=None, num_outputs=None)`, `Patcher.add_gen(code, num_inputs=None, num_outputs=None)` -- all match
- **Weaknesses:**
  - References `write_gendsp()` in the output protocol but does not document its signature. The actual signature is `write_gendsp(code, path, num_inputs=None, num_outputs=None)`.
  - The SKILL.md lists `parse_genexpr_io(code)` in capabilities but it is called `parse_genexpr_io` in the actual code -- naming is correct but the function is not in the Key Functions list despite being referenced in the capability description.
  - No mention of the `validate_genexpr()` function's operator validation feature (Check 5 and Check 6 in code_validation.py), which validates GenExpr operators against gen/objects.json. This is a powerful feature that the agent should know about.
- **API accuracy:** All documented signatures match actual code. No mismatches found.
- **Recommendation:** Add `write_gendsp(code, path)` and `parse_genexpr_io(code)` to Key Functions. Document the operator validation feature of `validate_genexpr()`.

---

### 5. max-rnbo-agent

- **Effectiveness:** High
- **Strengths:**
  - Explicit Python API reference block with import paths -- best documentation format among all agents
  - Correct clarification that `validate_rnbo_patch` operates on the inner RNBO patcher, not the wrapper
  - Export target constraint table is concise and actionable
  - `RNBODatabase` usage is well-documented with both `.is_rnbo_compatible()` and `.lookup()` methods
  - BOUNDARIES.md is clean with a simple handoff table
- **Weaknesses:**
  - Does not document the `generate_rnbo_wrapper` return type (returns a Patcher instance, not a dict). The caller needs to know to call `.to_dict()` or pass to `write_patch()`.
  - Context loading instructs reading msp/objects.json and gen/objects.json alongside rnbo/objects.json, but the RNBO agent's purpose is RNBO-specific generation. The RNBODatabase already handles cross-domain compatibility checks internally. Loading the full MSP and gen databases adds unnecessary context.
  - No reference to the `parse_genexpr_params()` function in the capabilities section text, even though it is in the imports. The workflow of extracting GenExpr params and mapping them to RNBO param objects is important and should be explicitly described.
- **API accuracy:** All function signatures match. `add_rnbo(patcher, objects, params, target, audio_ins, audio_outs)` is correct. `validate_rnbo_patch(patch_dict, target)` is correct.
- **Recommendation:** Document `generate_rnbo_wrapper` return type. Remove unnecessary MSP/gen database loading (RNBODatabase handles it). Add explicit GenExpr-to-RNBO param mapping workflow description.

---

### 6. max-js-agent

- **Effectiveness:** Medium
- **Strengths:**
  - Clear differentiation table between N4M and js V8 environments (module system, async support, file I/O, etc.)
  - Correct API signatures: `generate_n4m_script(handlers, dict_access=None)`, `generate_js_script(num_inlets=1, num_outlets=1, handlers=None)`
  - Validation functions documented: `validate_js(code)`, `validate_n4m(code)`, `detect_js_type(code)`
  - BOUNDARIES.md correctly notes that code validation is report-only (no auto-fix) per project decision
- **Weaknesses:**
  - **No critic coverage for output.** Unlike patch, DSP, RNBO, and external agents, the js agent's output goes through `validate_js`/`validate_n4m` (structural checks only) but has no semantic critic review. The critic skill's `review_patch()` does not examine JavaScript code context meaningfully -- it only runs DSP, structure, RNBO, and external critics.
  - The output protocol mentions `write_js()` but does not document its signature. Actual: `write_js(code, path)` which writes then validates (report-only).
  - Context loading says "Do NOT load object database JSON files" but when generating code that uses `this.patcher.getnamed()`, the agent needs to know what objects exist in the patch. The guidance to "consult the Patch agent for object names" is vague for single-session execution.
  - No memory domain loading for "node" patterns -- the SKILL.md says `~/.claude/max-memory/js/` but the memory agent's auto-inject protocol lists separate "js" and "node" domains. The js agent should load both.
- **API accuracy:** All documented signatures are accurate.
- **Recommendation:** Create a `js_critic.py` module for semantic js/N4M review (see critic recommendation). Document `write_js(code, path)` signature. Clarify cross-agent object reference protocol for `this.patcher.getnamed()` usage.

---

### 7. max-ext-agent

- **Effectiveness:** High
- **Strengths:**
  - End-to-end workflow documented: scaffold -> generate code -> setup min-devkit -> build -> validate .mxo -> help patch
  - Build loop with auto-fix and loop detection (error hashing) is well-designed
  - Three archetypes (message, dsp, scheduler) cover the main external categories
  - Post-compile .mxo validation (Mach-O type, arm64 architecture) catches build failures that would silently produce unusable binaries
  - `review_external` reference for code review is correctly documented
- **Weaknesses:**
  - Does not document the `generate_external_code` kwargs that differ by archetype (inlets/outlets for message, num_inputs/num_outputs for dsp, interval_default for scheduler). These are important for callers.
  - Does not reference `BuildResult` dataclass fields (success, mxo_path, errors, attempts, message) in the output protocol.
  - The "When NOT to Use" section mentions "UI externals using the classic Max SDK (deferred)" -- this could confuse Claude into thinking UI externals are planned. It should be clearer that this is out of scope.
- **API accuracy:** `scaffold_external(project_dir, name, archetype, description)` matches. `build_external(ext_dir, max_attempts=5)` matches. `setup_min_devkit(ext_dir)` matches. `generate_help_patch(name, archetype)` matches (actual has optional inlets/outlets params not documented in SKILL.md but this is minor).
- **Recommendation:** Document archetype-specific kwargs for `generate_external_code`. Add `BuildResult` field descriptions.

---

### 8. max-ui-agent

- **Effectiveness:** Medium
- **Strengths:**
  - Comprehensive list of UI objects organized by category (knobs/faders, numbers, buttons, selection, display, special)
  - Layout engine integration section is detailed and accurate -- documents component detection, within-row ordering, midpoint generation, recursive layout
  - Critical note that `presentation_rect` set before `apply_layout` is preserved is correctly documented
  - Visual design patterns section provides concrete spacing values (10px between controls, 20px between groups)
  - BOUNDARIES.md correctly separates presentation_rect authority (UI agent) from patching_rect authority (lead agent/layout engine)
- **Weaknesses:**
  - No Python API functions documented beyond `apply_layout(patcher)`. The UI agent's work is primarily setting attributes on Box objects directly, which is fine, but it should document the Box attributes it needs to set: `box.presentation = True`, `box.presentation_rect = [x, y, w, h]`, `box.extra_attrs["bgcolor"]`, etc.
  - Does not reference `Patcher.add_comment()` for label creation, which is the cleanest way to add labels.
  - No mention of the `_apply_presentation_layout()` fallback behavior (4-per-row grid) -- the skill says "always set presentation_rect explicitly" but does not warn about the fallback that runs if you do not.
  - Context loading says to read `max/objects.json` (470 objects) focusing on UI-relevant objects. This is a large file to load for a subset of ~20 UI objects. A more targeted loading instruction would reduce context cost.
- **API accuracy:** `apply_layout(patcher)` matches the actual function signature.
- **Recommendation:** Document Box presentation attributes explicitly. Reference `add_comment()` for labels. Consider creating a lightweight UI object subset file to avoid loading the full 470-object max/objects.json.

---

### 9. max-memory-agent

- **Effectiveness:** Medium
- **Strengths:**
  - Dual-scope design (global + project) is appropriate for the use case
  - Deduplication by domain + pattern name (case-insensitive) prevents duplicate entries
  - Auto Write-Back Protocol is well-thought-out: check for duplicates before writing, write only genuinely new patterns
  - Auto-Inject Protocol correctly specifies domain-filtered loading for relevant agents
  - Python API is clean with `MemoryStore(scope, project_dir)`, `write(entry)`, `read(domain)`, `list_domains()`, `delete(pattern, domain)`
  - BOUNDARIES.md is appropriately restrictive
- **Weaknesses:**
  - **Write-back is aspirational.** No agent is programmatically forced to call the write-back protocol after generation. It relies on the LLM remembering to do it. In a `/max-build` flow, the command file mentions "Write-back memory" as step 8, but there is no enforcement mechanism.
  - **No staleness detection.** Memory entries have an "observed" date but no mechanism to age out or flag patterns that may be outdated as the codebase evolves.
  - The SKILL.md does not specify what happens when the `~/.claude/max-memory/` directory does not exist on first use. The code handles this gracefully (mkdir parents=True), but the agent should know it does not need to create it manually.
  - Context loading says to read `src/maxpat/memory.py` before operations, but the agent could work from the API documented in the SKILL.md itself without reading the source file every time.
- **API accuracy:** All documented API matches actual code. `MemoryStore.write(entry)` returns `bool`, `read(domain)` returns `list[MemoryEntry]`, `delete(pattern, domain)` returns `bool` -- all correct.
- **Recommendation:** Consider adding a `/max-build` hook that automatically triggers memory write-back, rather than relying on LLM compliance. Add guidance that `~/.claude/max-memory/` is created automatically on first write.

---

### 10. max-lifecycle

- **Effectiveness:** Medium
- **Strengths:**
  - Project creation with full directory scaffolding is clean
  - Status tracking with freeform progress strings is flexible
  - Desync detection (active project references nonexistent directory) is a good defensive feature
  - Three reference docs (project-structure, status-tracking, test-protocol) provide useful supplementary detail
- **Weaknesses:**
  - **API signature mismatch for `save_test_results`.** The SKILL.md documents `save_test_results(results, project_dir)` and test-protocol.md shows the same. The actual Python signature is `save_test_results(project_dir, test_name, results_md)` -- different parameter order, different parameter names, AND a missing required `test_name` parameter. This would cause a runtime error if Claude followed the documented call.
  - Does not document the `list_projects(base_dir)` return type (returns `list[str]` of project directory names, sorted).
  - The SKILL.md references `generate_test_checklist(patch_dict, name, path)` but the actual signature is `generate_test_checklist(patch_dict, patch_name, patch_path="")` -- parameter names differ (`name` vs `patch_name`, `path` vs `patch_path`). Functionally equivalent but could cause confusion.
  - The `/max-test` command references `save_test_results(results, project_dir)` -- repeating the incorrect signature from the SKILL.md.
  - No mention of how to handle the case where `test-results/` directory does not exist (code creates it with mkdir).
- **API accuracy:** **Significant mismatch found.** `save_test_results` documented as `(results, project_dir)` but actual is `(project_dir, test_name, results_md)`. This is a 3-parameter function with different ordering. `generate_test_checklist` documented with simplified parameter names.
- **Recommendation:** **Fix the `save_test_results` documentation immediately** -- update both SKILL.md and test-protocol.md to use the correct signature `save_test_results(project_dir, test_name, results_md)`. Fix `generate_test_checklist` parameter names.

---

## Cross-Cutting Findings

### Dispatch & Routing

The router's keyword-based dispatch is effective for clear-cut tasks but has known weaknesses for ambiguous terms. The dispatch-rules.md edge case table covers 7 common ambiguity scenarios but misses:

- **"filter"** -- data filtering (js) vs audio filtering (DSP). The default hierarchy (DSP > Patch > js > UI) would route this to DSP, which is correct for most MAX users but incorrect for data processing tasks.
- **"buffer"** -- could mean `buffer~` MSP object (DSP), `Buffer` Gen~ declaration (DSP), or Node.js Buffer for binary data (js).
- **"delay"** -- could mean `delay` control-rate object (Patch), `delay~` MSP object (DSP), or `Delay` Gen~ operator (DSP).

The dispatch system handles these through secondary keyword context (if "delay" appears with "signal" or "~", it goes to DSP; if it appears alone, it goes to Patch). This is reasonable but could be explicitly documented.

The router has no fallback for completely ambiguous descriptions. If keyword counting ties across domains and no intent pattern matches, the default hierarchy kicks in. This is acceptable but could be improved with a "ask the user for clarification" option.

### Critic Coverage

| Agent Output | Critic Module | Coverage |
|-------------|---------------|----------|
| Patch (.maxpat) | `structure_critic`, `dsp_critic` | Full -- fan-out, hot/cold, signal flow, gen~ I/O |
| GenExpr (.gendsp) | `dsp_critic` + `validate_genexpr` | Full -- operators, syntax, I/O, params |
| RNBO (rnbo~) | `rnbo_critic` | Full -- param naming, I/O, duplicates, target fitness |
| External (C++) | `ext_critic` | Full -- archetype requirements, code structure |
| **js V8** | `validate_js` only | **Partial -- structural checks only, no semantic critic** |
| **Node for Max** | `validate_n4m` only | **Partial -- structural checks only, no semantic critic** |

The js/N4M gap is the biggest critic coverage issue. The structural validators catch missing declarations and basic structure, but do not perform semantic analysis (dead code paths, logic errors in handlers, outlet index correctness in conditional branches, race conditions in async N4M operations).

### Memory Integration

| Agent | Reads Memory? | Writes Memory? | Memory Domain |
|-------|--------------|----------------|---------------|
| max-patch-agent | Yes (project + global/patch) | Via write-back protocol | patch, routing |
| max-dsp-agent | Yes (project + global/dsp) | Via write-back protocol | dsp |
| max-js-agent | Yes (project + global/js) | Via write-back protocol | js, node |
| max-ui-agent | Yes (project + global/ui) | Via write-back protocol | ui, layout |
| max-rnbo-agent | No context loading for memory | No | - |
| max-ext-agent | No context loading for memory | No | - |
| max-router | Yes (project + domain-filtered global) | No | All |
| max-critic | No | No | - |
| max-lifecycle | No | No | - |

**Gaps:**
- RNBO and ext agents have no memory integration at all. If a user consistently uses specific RNBO param naming conventions or external archetype preferences, these are not captured.
- Memory write-back is aspirational -- it depends on the `/max-build` command flow remembering to call it, which relies on LLM compliance.
- The critic agent could potentially write memory entries for recurring warnings (e.g., "this user consistently gets flagged for fan-out issues"), but this is out of scope for v1.0.

### Multi-Agent Coordination

The merge protocol is theoretically sound:
1. Lead agent generates structure with placeholders
2. Secondary agent generates domain-specific output matching the interface
3. I/O verification ensures counts match
4. Merge with conflict resolution rules (UI agent wins for presentation_rect, domain expert wins for object choices)

**Practical concerns:**
- Claude executes sequentially in a single context window. The protocol describes separate agents returning structured dicts, but in practice Claude reads the router skill, then the specialist skill, and generates everything in sequence. The "merge" happens in Claude's working memory, not as a formal data pipeline.
- The I/O verification step is not enforced by any code. The protocol says "Check that B's output matches A's interface expectations" but this is a manual check during generation, not a programmatic validation.
- The structured dict output format (`{"agent": ..., "role": ..., "files": ..., "patch_contributions": ...}`) is not used by any Python function. It is a specification for Claude's internal organization but not a real data contract.
- **This is acceptable for v1.0.** The merge protocol serves as a mental model for Claude rather than a rigid system. Its value is in teaching Claude to think about cross-domain interfaces.

### Test Coverage

`test_agent_skills.py` (512 lines, ~40 tests) covers:

**What is tested:**
- Directory existence (all 10 skill dirs)
- SKILL.md existence and frontmatter (name, description)
- Cross-reference accuracy (correct object database references, protocol file references)
- Non-stub status (RNBO and ext agents are no longer stubs)
- API signature accuracy (parameter names and order for key functions)
- Import path correctness (public API imports in commands)
- Escalation semantics (critic protocol mentions repeated findings, not round limit)
- Boundary file existence (all 7 specialists + memory agent)

**What is NOT tested:**
- **Python API changes.** If someone renames `add_connection` to `connect` in patcher.py, the test checking that SKILL.md references `add_connection` would still pass (it checks the SKILL.md string, not the actual Python function name). A test could import the actual function and check it exists.
- **Context loading accuracy.** Tests verify SKILL.md mentions "msp" but do not verify that the actual file path `msp/objects.json` exists in the database.
- **Boundary completeness.** Tests check that BOUNDARIES.md exists but do not verify that every "When NOT to Use" scenario in SKILL.md has a corresponding entry in BOUNDARIES.md.
- **Command-to-skill mapping.** No test verifies that `/max-build` invokes the router skill, or that `/max-verify` invokes the critic skill. These are documented but not tested.
- **Memory domain consistency.** No test verifies that memory domain names used in agents match what the memory store expects.

---

## Prioritized Recommendations

| Priority | Area | Recommendation | Impact | Effort |
|----------|------|---------------|--------|--------|
| 1 | Lifecycle API | Fix `save_test_results` documentation in lifecycle SKILL.md, test-protocol.md, and max-test.md to match actual signature `(project_dir, test_name, results_md)` | High -- prevents runtime errors | Low |
| 2 | Critic Coverage | Create `js_critic.py` semantic critic for js V8 and N4M output (outlet bounds in branches, handler completeness, async error handling) | High -- closes the biggest validation gap | Medium |
| 3 | Critic Docs | Update critic SKILL.md and critic-protocol.md to document all 4 critic modules (DSP, structure, RNBO, external) and the full `review_patch` signature including `ext_code` and `ext_archetype` params | Medium -- prevents incomplete critic invocation | Low |
| 4 | Test Robustness | Add tests that import actual Python functions and verify they exist, not just check SKILL.md string content. E.g., `from src.maxpat.patcher import Patcher; assert hasattr(Patcher, 'add_connection')` | Medium -- catches drift between code and docs | Low |
| 5 | Patch Agent | Add `add_comment()`, `add_message()`, `add_node_script()`, `add_js()` to max-patch-agent Key Functions list | Medium -- enables cleaner multi-agent lead patterns | Low |
| 6 | Memory RNBO/Ext | Add memory context loading to max-rnbo-agent and max-ext-agent SKILL.md files (project patterns + global patterns for their domains) | Medium -- enables pattern learning for specialized agents | Low |
| 7 | Dispatch Edge Cases | Add "filter (data vs audio)", "buffer (MSP vs Gen vs Node)", and "delay (control vs signal)" to dispatch-rules.md edge case table | Low -- improves routing accuracy for ambiguous terms | Low |
| 8 | DSP Agent Docs | Document `write_gendsp(code, path)`, `parse_genexpr_io(code)` signatures and validate_genexpr operator validation feature | Low -- improves agent knowledge of available tools | Low |
| 9 | UI Agent | Document Box presentation attributes (`box.presentation`, `box.presentation_rect`, `box.extra_attrs["bgcolor"]`) explicitly in SKILL.md | Low -- makes the agent more self-sufficient | Low |
| 10 | Memory Automation | Add automatic memory write-back hook to the post-generation pipeline instead of relying on LLM compliance | Medium -- ensures patterns are actually captured | High |
| 11 | RNBO Context | Remove unnecessary MSP/gen database loading from RNBO agent context (RNBODatabase handles cross-domain compatibility internally) | Low -- reduces context window cost | Low |
| 12 | Lifecycle Params | Fix `generate_test_checklist` parameter names in SKILL.md from `(patch_dict, name, path)` to `(patch_dict, patch_name, patch_path)` | Low -- cosmetic accuracy | Low |

## Summary Statistics

- Agents with no issues found: 0/10
- Agents with minor issues only: 5/10 (router, patch, dsp, rnbo, ext)
- Agents with moderate issues: 4/10 (critic, js, ui, memory)
- Agents with significant gaps: 1/10 (lifecycle -- API signature mismatch)
- Total recommendations: 12
- High-priority recommendations: 2
- Medium-priority recommendations: 5
- Low-priority recommendations: 5
