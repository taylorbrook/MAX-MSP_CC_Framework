# MAX Framework Effectiveness Review

## Executive Summary

The MAX framework is a well-architected system for generating valid .maxpat patches via Claude. After analyzing the codebase, all 13 feedback memory entries, 10 agent skills, 11 commands, the 4-layer validation pipeline, 5 critics, and project memory state, these are the highest-impact findings:

1. **Memory system is code-complete but never writes data.** All 10 project `.max-memory/patterns.md` files are empty placeholders (3 lines each). The global `~/.claude/max-memory/` directory does not exist. The `MemoryStore` class works -- it is never called during generation.

2. **Object database has systematic outlet type errors.** The extraction marked all MSP outlets as `signal: true` for ~667 objects. Only 16 have been corrected via `overrides.json`. This causes the validator to strip legitimate control connections.

3. **The validation pipeline does not catch 8 of 13 known feedback issues.** GenExpr `in1` vs `in 1`, line~ comma behavior, multislider fetch/outlet, umenu items format, gen~ param message syntax, comment #N substitution, Delay.read/write syntax, and inlet~/outlet~ confusion all slip through every layer.

4. **Agent architecture is prompt-routing, not process isolation.** All 10 agents run in the same Claude session. The "dispatch" model is a context-loading pattern, not true multi-agent isolation. This means agents can and do access context outside their designated scope.

5. **Two failing tests indicate real but contained issues.** The layout inlet alignment test (21px offset vs 15px tolerance) reflects a tuning problem in the layout engine. The minitaur round-trip em-dash encoding (3-byte vs multi-byte) is a `json.dumps(ensure_ascii=False)` interaction with special characters in the source patch.

---

## Dimension 1: Project Organization

### Finding 1.1: Clean module separation with clear API surface
**Evidence:** `src/maxpat/__init__.py` re-exports 46 symbols across 10 modules. Each module has a focused responsibility: `patcher.py` (core model), `validation.py` (4-layer pipeline), `critics/` (5 semantic reviewers), `hooks.py` (file I/O), `codegen.py` (code generation), `memory.py` (persistence), `layout.py` (positioning), `aesthetics.py` (styling), `rnbo.py` (export), `externals.py` (C++ externals).
**Assessment:** Well-organized. No circular imports. Clear separation between mechanical validation and semantic review.
**Impact:** N/A (strength, not issue)

### Finding 1.2: Object database structure creates lookup overhead
**Evidence:** 8 separate JSON files (`max/`, `msp/`, `gen/`, `jitter/`, `mc/`, `m4l/`, `rnbo/`, `packages/`) plus `overrides.json`, `aliases.json`, `relationships.json`, `pd-blocklist.json`. CLAUDE.md instructs: "If unsure which domain, check `max/objects.json` first (largest domain), then `msp/`, `jitter/`, `mc/`, etc."
**Assessment:** The `ObjectDatabase` class in `db_lookup.py` loads all domains into a single in-memory dict, so the file separation is a storage/maintenance concern, not a runtime one. However, agents are instructed to load specific domain files (e.g., "Do NOT load: msp/objects.json" in max-patch-agent SKILL.md), which means the per-domain split creates artificial boundaries in the prompt instructions.
**Recommendation:** **Medium impact, medium effort.** Consider adding a `db.lookup_any(name)` cross-domain method that agents use when unsure of domain, rather than the sequential search pattern described in CLAUDE.md. The ObjectDatabase already does this internally -- the agent instructions should match.

### Finding 1.3: Skill content is heavily duplicated across agents
**Evidence:** All 10 SKILL.md files contain identical blocks for: Aesthetic Capabilities (~20 lines), Layout options (~8 lines), Editing Functions (~10 lines), Edit Workflow (~6 lines), Assistance Comments (~6 lines), and "Direct JSON edits" note (~3 lines). Rough count: ~53 lines duplicated per agent x 7 agents that have all blocks = ~371 lines of repeated content.
**Assessment:** This duplication inflates context loading cost. When an agent loads its SKILL.md, approximately 30-40% of the content is identical to every other agent. Changes to shared capabilities (like adding a new Patcher method) require updating 7+ files.
**Recommendation:** **Medium impact, small effort.** Extract shared blocks into a `references/shared-capabilities.md` file referenced by each SKILL.md. Each SKILL.md retains only domain-specific content. This reduces per-agent context load by ~50 lines and ensures consistency.

### Finding 1.4: Two failing tests reflect real issues
**Evidence:**
- `test_layout.py::TestInletAlignment::test_child_inlet_aligns_under_parent_outlet` -- 21px offset vs 15px tolerance. The layout engine's inlet alignment nudges child boxes toward parent outlet positions, but the nudge is insufficient for certain box width combinations.
- `test_round_trip.py::TestSubpatcherByteIdentity::test_byte_identical_round_trip[minitaur]` -- The minitaur patch contains an em-dash character (`\u2014` = "---") that `json.dumps(ensure_ascii=False)` renders as the multi-byte UTF-8 sequence, while the original file stores it as the literal 3-byte em-dash. This is a 5-character length difference (976719 vs 976724).

**Assessment:**
- The layout test is a tuning issue, not architectural. The inlet_align feature was added in Phase 15; the tolerance may need adjustment or the alignment algorithm may need to account for variable-width boxes more aggressively.
- The round-trip test is a JSON serialization edge case. The `save_patch_roundtrip()` function uses `json.dumps(ensure_ascii=False)` which correctly preserves Unicode. The issue is that the original minitaur file uses a different encoding for the em-dash (likely written by MAX itself). This is a known limitation: byte-identical round-trip requires matching MAX's exact JSON serializer behavior.

**Recommendation:**
- Layout test: **Low impact, small effort.** Increase tolerance to 25px or improve the alignment algorithm to handle the specific box width combination. The 21px offset is still visually acceptable in MAX.
- Round-trip test: **Low impact, small effort.** Mark the test as `xfail` with a note about MAX's JSON serializer producing different Unicode encodings, or pre-process the original text to normalize em-dashes before comparison.

---

## Dimension 2: Persistent Issue Patterns

### Categorization of 13 Feedback Memory Entries

**Category A -- Object Database Inaccuracy (2 issues)**
1. `feedback_msp_outlet_types.md`: All MSP outlets extracted as `signal: true`. 16 objects corrected, hundreds remain.
2. `feedback_maxclass_newobj.md`: ~667 objects had wrong maxclass (should be `"newobj"` with text field, not their own name as maxclass).

**Category B -- MAX API/Format Misunderstanding (8 issues)**
3. `feedback_genexpr_io_syntax.md`: `in1`/`out1` (no space) for codebox, `in 1`/`out 1` for patcher objects.
4. `feedback_genexpr_delay_syntax.md`: `Delay.read()`/`.write()` in codebox, not `delay()`.
5. `feedback_gen_param_messages.md`: Plain `param_name $1` messages, not `@param_name $1`.
6. `feedback_bpatcher_args.md`: `#N` must be standalone token, not embedded in compound strings.
7. `feedback_comment_no_hash_sub.md`: Comment boxes don't do `#N` substitution.
8. `feedback_line_tilde_comma.md`: `line~` replaces ramps on new messages; no comma separation.
9. `feedback_multislider_fetch.md`: `fetch` not `fetchindex`; output from right outlet (1), not left (0).
10. `feedback_umenu_items_format.md`: Items use comma-as-elements: `["LP", ",", "HP", ",", "BP"]`.

**Category C -- Agent Not Loading Correct Context (1 issue)**
11. `feedback_inlet_outlet_maxclass.md`: Agent tried to create `inlet~`/`outlet~` which don't exist. The `inlet`/`outlet` objects use their own maxclass, determined by connections.

**Category D -- Documentation/Agent Guidance Gap (2 issues)**
12. `feedback_layout_spacing.md`: Agent used 80-120px spacing from training data instead of project's 20px default.
13. `feedback_assistance_comments.md`: Agent added comment box objects instead of using `comment` JSON attribute on inlets/outlets.

### Root Cause Analysis

| Category | Count | Fix Type | Recurrence Risk |
|----------|-------|----------|-----------------|
| A: DB inaccuracy | 2 | Proactive (bulk override) | High -- hundreds of MSP objects still wrong |
| B: API misunderstanding | 8 | Reactive (memory feedback) | Medium -- CLAUDE.md updated for most, but no validation catches them |
| C: Wrong context | 1 | Proactive (SKILL.md fix) | Low -- fixed in SKILL.md and CLAUDE.md |
| D: Guidance gap | 2 | Proactive (defaults + docs) | Low -- defaults.py and docs updated |

### Finding 2.1: Category B issues (API misunderstandings) are the most dangerous
**Evidence:** 8 of 13 issues are MAX API format misunderstandings that the LLM generates from training data rather than project rules. These are silent failures -- the patch generates without errors but behaves incorrectly in MAX.
**Assessment:** The current defense is CLAUDE.md documentation + Claude project memory files. This is a read-before-generate defense that relies on the agent reading and following rules. There is no programmatic validation for most of these patterns.
**Recommendation:** **High impact, medium effort.** Add targeted validation checks to the pipeline for the patterns in Category B. See Finding 4.2 for specific proposals.

### Finding 2.2: MSP outlet type errors are only 2.4% corrected
**Evidence:** `overrides.json` corrects outlet types for 16 MSP objects. `msp/objects.json` contains 248 objects. The memory file states: "The automated extraction that built `msp/objects.json` marked ALL outlets on MSP objects as `signal: true`." That means ~232 objects still have incorrect outlet type data.
**Assessment:** Any patch that connects from a non-primary outlet of an uncorrected MSP object risks having the connection auto-removed by Layer 3 validation (signal-to-control type mismatch). This is a ticking time bomb -- each new patch that uses an uncorrected object will fail silently.
**Recommendation:** **High impact, large effort.** Bulk-correct outlet types for all 248 MSP objects. The memory file provides a heuristic scan: find outlets marked signal where the digest contains "bang", "int", "float", "index", "done", "status". Apply as a one-time cleanup to `overrides.json`.

---

## Dimension 3: Agent/Skill Architecture

### Finding 3.1: Agent "dispatch" is prompt routing, not process isolation
**Evidence:** The router skill (`max-router/SKILL.md`) describes "Dispatch to all relevant agents" and "Merge outputs using the protocol in `references/merge-protocol.md`". However, there is no Sub-Agent invocation, no separate processes, and no isolation boundaries. All agents run as prompt context within a single Claude conversation. The "dispatch" is Claude reading the relevant SKILL.md and following its instructions.
**Assessment:** This is not necessarily a weakness -- the single-session model means agents can share context implicitly, which reduces merging complexity. However, it means:
- Agent boundaries are advisory, not enforced. The DSP agent CAN access `max/objects.json` even though its SKILL.md says "Do NOT load."
- Multi-agent "merging" is implicit (Claude combines the output) rather than explicit (merge protocol).
- The router's keyword matching is a prompt-level instruction, not a runtime dispatcher.
**Recommendation:** **Low impact, no effort needed.** The current architecture works well for its purpose. The advisory boundaries serve as context-loading guidance. True isolation would add overhead without proportional benefit given that all agents share the same underlying model.

### Finding 3.2: Router keyword matching has ambiguity gaps
**Evidence:** Dispatch rules map keywords to agents. "synth" -> DSP, "controls" -> UI, "step sequencer" -> Patch + js. But common requests like "MIDI-controlled FM synth with presets" involve 4+ domains (MIDI=Patch, FM=DSP, presets=Patch+js, controls=UI). The router must identify a "lead agent" but the keyword overlap is significant.
**Assessment:** In practice, Claude handles multi-domain tasks reasonably well because it has access to all SKILL.md files simultaneously. The keyword mapping serves as a starting heuristic, not a hard rule. The bigger risk is context overload -- loading 4 SKILL.md files means ~500 lines of instructions.
**Recommendation:** **Medium impact, small effort.** Add a "context budget" note to the router: for multi-domain tasks, load the lead agent's SKILL.md fully and only load the domain-specific sections (not aesthetic/editing boilerplate) for secondary agents. This keeps total context under ~200 lines per generation task.

### Finding 3.3: --full/--discuss/--research/--plan flags are well-designed
**Evidence:** Added in quick task 260321-6mo. The flags expand `/max-iterate` into a multi-phase workflow: discuss (clarify approach), research (investigate objects), plan (outline steps), then build. Each phase appends to `context.md`.
**Assessment:** Good design. The flags are composable, stripped from the change description, and the phases are optional. One concern: the discuss and plan phases are interactive (wait for user input), which breaks autonomous execution if combined with `--full` in a scripted workflow.
**Recommendation:** **Low impact.** Document that `--full` requires interactive mode. Consider a `--full-auto` variant that makes opinionated choices at discuss/plan phases for batch workflows.

### Finding 3.4: Critic loop "no hard round limit" with "escalate after 5 identical" is correct but could waste context
**Evidence:** `max-critic/SKILL.md`: "Loop continues until clean -- there is NO hard round limit. Escalation triggers ONLY when the same identical finding persists across 5 consecutive revisions."
**Assessment:** In theory, a novel finding on each round could loop indefinitely. In practice, the deterministic critics produce findings based on patch structure, which converges quickly. The 5-identical-finding escalation is the only exit condition for a stuck loop. A more practical risk: 3 rounds of revision typically add 1000+ tokens of context per round, so a 5-round loop costs ~5000 tokens.
**Recommendation:** **Low impact, small effort.** Add a soft limit: after 3 rounds, log a summary of all findings and ask the user to approve continuing. This prevents context waste without blocking genuine fixes.

---

## Dimension 4: Validation/Critic Pipeline Gaps

### Finding 4.1: Pipeline coverage map against known issues

| # | Feedback Issue | Layer 1 (JSON) | Layer 2 (Objects) | Layer 3 (Connections) | Layer 4 (Domain) | DSP Critic | Structure Critic | Layout Critic | Caught? |
|---|---------------|-----------------|-------------------|-----------------------|-------------------|------------|------------------|---------------|---------|
| 1 | MSP outlet types wrong | -- | -- | Incorrectly auto-removes valid connections | -- | -- | -- | -- | HARMFUL |
| 2 | maxclass "newobj" confusion | -- | -- | -- | -- | -- | -- | -- | NO |
| 3 | GenExpr in1 vs in 1 | -- | -- | -- | -- | -- | -- | -- | NO |
| 4 | GenExpr Delay syntax | -- | -- | -- | -- | -- | -- | -- | NO |
| 5 | gen~ param @ syntax | -- | -- | -- | -- | -- | -- | -- | NO |
| 6 | bpatcher #N compound | -- | -- | -- | YES (domain L4) | -- | -- | -- | YES |
| 7 | comment #N substitution | -- | -- | -- | -- | -- | -- | -- | NO |
| 8 | line~ comma behavior | -- | -- | -- | -- | -- | -- | -- | NO |
| 9 | multislider fetch/outlet | -- | -- | -- | -- | -- | -- | -- | NO |
| 10 | umenu items format | -- | -- | -- | -- | -- | -- | -- | NO |
| 11 | inlet~/outlet~ doesn't exist | -- | YES (objects L2) | -- | -- | -- | -- | -- | YES |
| 12 | Layout spacing | -- | -- | -- | -- | -- | -- | YES (overlap check) | PARTIAL |
| 13 | Assistance comments | -- | -- | -- | -- | -- | -- | -- | NO |

**Result:** 2 fully caught, 1 harmful (makes things worse), 1 partial, 9 not caught at all.

### Finding 4.2: Eight specific validation gaps to fill
**Evidence:** Issues 3, 4, 5, 7, 8, 9, 10, and 13 slip through the entire pipeline.
**Recommendation:** **High impact, medium effort.** Add targeted checks to Layer 4 (`_validate_domain_rules`) or a new Layer 5 (pattern-specific rules):

1. **GenExpr I/O syntax** (`in 1`/`out 1` in codebox code): Scan `codebox` objects for whitespace between `in`/`out` and digit. Fix: regex `r'\b(in|out)\s+\d'` on codebox code attribute. Severity: error.

2. **GenExpr `delay()` usage**: Scan codebox code for `delay(` function call. Fix: regex `r'\bdelay\s*\('`. Severity: error with suggestion to use `Delay.read()/write()`.

3. **gen~ `@param` message syntax**: Scan message boxes connected to gen~ for `@` prefix. Fix: regex `r'@\w+\s+\$'` in message text where destination is gen~. Severity: warning.

4. **Comment #N substitution**: Scan comment boxes for `#\d+` text. Fix: regex `r'#\d+'` in boxes with `maxclass: "comment"`. Severity: warning with suggestion for loadbang->message->set chain.

5. **line~ comma in messages**: Scan message boxes connected to line~ for comma separators. Fix: detect `,` in message text where destination is `line~`. Severity: warning.

6. **multislider `fetchindex`**: Scan message boxes for `fetchindex` text. Fix: literal string match. Severity: error with suggestion to use `fetch`.

7. **umenu items format**: Scan umenu boxes for `items` attribute that is a plain array without comma separators. Fix: check if items array has length > 1 and contains no `","` elements. Severity: warning.

8. **Assistance comments on inlets/outlets**: After generation, check that inlet/outlet boxes in subpatchers have non-empty `comment` attribute. Severity: note.

### Finding 4.3: DSP critic gain staging is solid but has gaps
**Evidence:** The DSP critic (`dsp_critic.py`) checks:
- gen~ I/O mismatch (blocker)
- Oscillator -> dac~ without *~/gain~ (blocker)
- Control-rate to signal-rate connections (warning)
- MIDI-range sources to *~ gain inlet without normalization (blocker)

Missing scenarios:
- **`line~` feeding *~ gain inlet with values > 1.0**: If a message box sends `127 100` to line~ which feeds *~, the peak value is 127x (dangerous). The current check only catches _MIDI_RANGE_SOURCES directly connected, not through line~.
- **`expr` or `vexpr` output to gain**: The `_is_normalizer` check returns True for any expr/vexpr, which is too permissive. An expr could output values > 1.0.
- **MC gain staging**: The `mc.*~` multiply objects are not checked.

**Recommendation:** **Medium impact, medium effort.**
- Add `line~` to the backward trace in `_check_unsafe_gain_sources` (trace through line~ to its message sources).
- Make the `expr`/`vexpr` normalizer check conservative (treat as non-normalizer unless the expression contains `/127` or similar pattern).
- Add MC variants to gain staging checks.

### Finding 4.4: Validation Layer 3 is harmful for uncorrected MSP objects
**Evidence:** Layer 3 (`_validate_connections`) checks signal type compatibility. For MSP objects with incorrect outlet type data (all outlets marked `signal: true`), legitimate control connections from non-primary outlets are auto-removed with `auto_fixed=True`. The user never sees the error because it's silently "fixed."
**Assessment:** This is the most harmful pipeline behavior -- it actively damages correct patches. The auto-fix of removing connections should be conservative: only remove connections where both the database data and the connection pattern confirm incompatibility.
**Recommendation:** **High impact, small effort.** Add a safeguard: only auto-remove signal-to-control connections when the source object is NOT in the `msp/` domain (where outlet types are known to be unreliable). For MSP objects not in `overrides.json`, downgrade from auto-fix removal to warning-only. This is a one-line change in `_validate_connections`:

```python
# In _validate_connections, before auto-removing:
src_name = _extract_object_name(src_box)
if src_name and src_name.endswith("~") and obj_data and not obj_data.get("_overridden"):
    # MSP object not in overrides -- outlet types unreliable
    results.append(ValidationResult("connections", "warning", ...))
    # Do NOT auto-remove
else:
    # Trusted data -- auto-remove
    to_remove.append(idx)
```

---

## Dimension 5: Memory System Utilization

### Finding 5.1: All 10 project memory files are empty
**Evidence:** Every `patches/{project}/.max-memory/patterns.md` contains only:
```
# {project} -- Learned Patterns

Patterns discovered during development.
```
Zero pattern entries across all 10 projects.

### Finding 5.2: Global memory directory does not exist
**Evidence:** `ls ~/.claude/max-memory/` returns "No such file or directory". The `MemoryStore(scope="global")` would create it on first `.write()` call, but `.write()` has never been called.

### Finding 5.3: Memory write-back is documented but never executed
**Evidence:**
- `/max-build` step 8: "Write-back memory -- use the max-memory-agent to store notable patterns learned during generation."
- `/max-iterate` step 18: "Write-back memory -- store any new patterns from the modification."
- `max-memory-agent/SKILL.md` describes "Auto Write-Back Protocol" with 6 steps.

However, there is no automated trigger for memory write-back. The protocol depends on Claude choosing to invoke the memory agent after generation. In practice, the generation + critic loop + file write consumes the available context/attention, and the write-back step is skipped.

**Assessment:** The gap between Claude's project memory (13 rich feedback entries) and the in-app memory system (0 entries) reveals the fundamental issue: the in-app memory is designed for persistence across sessions, but the same purpose is served by Claude's built-in project memory (`~/.claude/projects/`). The two systems are redundant.

### Finding 5.4: Claude project memory IS the effective memory system
**Evidence:** All 13 feedback memory files in `~/.claude/projects/-Users-taylorbrook-Dev-MAX/memory/` are substantive, specific, and actionable. They were created by the user's explicit feedback, not by automated write-back. They are loaded automatically at conversation start by Claude's memory system.
**Assessment:** The Claude project memory is more effective than the in-app system because: (a) it's always loaded, (b) it's human-curated, (c) it uses the platform's native persistence.

### Finding 5.5: Recommendation for memory system
**Recommendation:** **High impact, medium effort.** Two options:

**Option A (Recommended): Retire the in-app memory system.** Remove the memory write-back steps from `/max-build` and `/max-iterate`. Remove `max-memory-agent` skill. Keep `memory.py` module for potential future use but stop referencing it in commands and skills. This removes cognitive overhead and unused code paths. Consolidate all learning into Claude project memory files.

**Option B: Automate memory writes.** Add a post-critic hook that automatically writes findings to project memory:
```python
# In the critic loop, after review_patch():
for result in results:
    if result.severity == "blocker":
        memory_store.write(MemoryEntry(
            pattern=result.finding[:60],
            domain="critic",
            observed=datetime.now().isoformat()[:10],
            context=f"Found during {project_name} generation",
            rule=result.suggestion,
        ))
```
This bridges the gap but creates noisy entries. Option A is simpler and more aligned with how the system actually works.

---

## Prioritized Action Items

| # | Action | Impact | Effort | Dimension | Finding |
|---|--------|--------|--------|-----------|---------|
| 1 | Add 8 targeted validation checks for Category B feedback issues | HIGH | MEDIUM | D4 | 4.2 |
| 2 | Bulk-correct MSP outlet types in overrides.json (232 remaining objects) | HIGH | LARGE | D2 | 2.2 |
| 3 | Add safeguard: don't auto-remove connections for uncorrected MSP objects | HIGH | SMALL | D4 | 4.4 |
| 4 | Retire in-app memory system (or automate writes) | HIGH | MEDIUM | D5 | 5.5 |
| 5 | Extract shared SKILL.md blocks into references/shared-capabilities.md | MEDIUM | SMALL | D1 | 1.3 |
| 6 | Add cross-domain lookup guidance for agents | MEDIUM | SMALL | D1 | 1.2 |
| 7 | Add line~ and MC variants to gain staging critic | MEDIUM | MEDIUM | D4 | 4.3 |
| 8 | Add context budget note to router for multi-domain tasks | MEDIUM | SMALL | D3 | 3.2 |
| 9 | Fix layout inlet alignment test (increase tolerance or improve algorithm) | LOW | SMALL | D1 | 1.4 |
| 10 | Fix round-trip em-dash test (xfail or normalize) | LOW | SMALL | D1 | 1.4 |
| 11 | Add soft limit (3 rounds) to critic loop before continuing | LOW | SMALL | D3 | 3.4 |
| 12 | Document --full requires interactive mode | LOW | SMALL | D3 | 3.3 |

---

## Two Failing Tests Analysis

### Test 1: `test_child_inlet_aligns_under_parent_outlet` (test_layout.py:638)

**Failure:** `assert abs(outlet_x_pos - inlet_x_pos) <= 15.0` -- actual difference is 21.0px (73.0 - 52.0).

**Root cause:** The layout engine's inlet alignment feature (`inlet_align=True` in LayoutOptions) nudges child boxes horizontally to align their inlet with the parent's outlet. For the specific box width combination in this test, the nudge is insufficient because the child box is narrower than expected and the outlet position of the parent lands at a position that requires more than 15px of adjustment.

**Systemic implication:** This is a tuning issue, not a design flaw. The inlet alignment algorithm works correctly for most cases (all other layout tests pass). The tolerance of 15px was set as a quality threshold; 21px is still visually acceptable in MAX (objects are typically 60-120px wide, so 21px offset is minor).

**Fix options:**
1. Increase tolerance to 25px (reflects reality of what's visually acceptable)
2. Improve the alignment algorithm to be more aggressive in nudging (may cause other tests to shift)
3. Accept as a known limitation and mark xfail

### Test 2: `test_byte_identical_round_trip[minitaur/generated/minitaur.maxpat]` (test_round_trip.py:1170)

**Failure:** Round-trip produces 976724 bytes vs original 976719 bytes. The diff shows: original has `"MINITAUR --- Moog Bass Synthesizer"` (em-dash as single character), round-trip produces `"MINITAUR \u2014 Moog Bass Synthesizer"` (em-dash as 6-character escape or equivalent multi-byte).

**Root cause:** `json.dumps(ensure_ascii=False)` in `save_patch_roundtrip()` preserves the Unicode em-dash character (\u2014) as the literal UTF-8 multi-byte sequence. MAX's own JSON serializer may write it differently (as the raw character or a different escape). The length difference (5 bytes) corresponds to the multi-byte representation of em-dash characters appearing in the patch.

**Systemic implication:** This is a known limitation of byte-identical round-tripping with Unicode characters. The JSON is semantically identical -- any JSON parser will read the same value. The visual output in MAX is identical. This only fails the byte-identity test.

**Fix options:**
1. Mark as `xfail(reason="MAX JSON serializer uses different Unicode encoding for em-dash")`
2. Pre-process both strings to normalize Unicode before comparison
3. Accept semantic equivalence and change the test to compare parsed dicts instead of raw text

---

## Summary of System Health

The MAX framework is fundamentally sound. The core architecture (Patcher model, validation pipeline, critic system, agent routing, file I/O hooks) is well-designed and well-tested (1175 tests, 2 failures). The highest-leverage improvement is closing the validation gap for Category B issues (MAX API misunderstandings) -- these are the errors that actually cause patches to fail in MAX, and they currently slip through all automated checks. The second priority is the MSP outlet type data quality, which actively damages correct patches when Layer 3 auto-removes valid connections.
