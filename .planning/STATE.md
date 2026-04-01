---
gsd_state_version: 1.0
milestone: v2.0
milestone_name: Direct .maxpat Editing
status: completed
stopped_at: Completed quick-260401-lpk-PLAN.md
last_updated: "2026-04-01T22:27:05.551Z"
last_activity: "2026-04-01 - Completed quick task 260401-lpk: Clean overrides.json, remove user abstractions, separate metadata-only"
progress:
  total_phases: 12
  completed_phases: 12
  total_plans: 28
  completed_plans: 28
  percent: 100
---

# Project State

## Project Reference

See: .planning/PROJECT.md (updated 2026-03-15)

**Core value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work -- with as much automated validation as possible before manual testing.
**Current focus:** v2.0 complete + tech debt cleanup

## Current Position

Phase: 19 of 19 (Tech Debt Cleanup)
Plan: 1 of 1
Status: Complete
Last activity: 2026-04-01 - Completed quick task 260401-lpk: Clean overrides.json, remove user abstractions, separate metadata-only

Progress: [██████████] 100%

## Performance Metrics

**Velocity:**

- Total plans completed: 7 (v2.0) / 39 (lifetime)
- Average duration: 6min (v2.0)
- Total execution time: 41min (v2.0)

**By Phase:**

| Phase | Plans | Total | Avg/Plan |
|-------|-------|-------|----------|
| 13 | 2 | 11min | 5.5min |
| 14 | 2 | 9min | 4.5min |
| 15 | 2 | 10min | 5min |

*Updated after each plan completion*
| Phase 15 P03 | 5min | 2 tasks | 2 files |
| Phase 16 P01 | 6min | 2 tasks | 2 files |
| Phase 17 P01 | 2min | 2 tasks | 4 files |
| Phase 17 P02 | 3min | 2 tasks | 5 files |
| Phase 17 P03 | 3min | 2 tasks | 10 files |
| Phase 18 P01 | 2min | 2 tasks | 21 files |
| Phase 18 P02 | 11min | 2 tasks | 18 files |
| Phase 19 P01 | 2min | 2 tasks | 4 files |
| Phase quick-260317-b86 P01 | 6min | 2 tasks | 3 files |
| Phase quick-260317-g0a P01 | 2min | 3 tasks | 12 files |
| Phase quick-260318-s03 P01 | 2min | 1 tasks | 1 files |
| Phase quick-260322-g3q P01 | 5min | 2 tasks | 2 files |
| Phase quick-260322-hhw P01 | 4min | 2 tasks | 2 files |
| Phase quick-260322-n59 P01 | 4min | 2 tasks | 23 files |
| Phase quick-260331-n24 P01 | 8min | 1 tasks | 1 files |
| Phase quick-260331-vs8 P01 | 9min | 2 tasks | 5 files |
| Phase quick-260331-w95 P01 | 3min | 2 tasks | 3 files |
| Phase quick-260401-j8z P01 | 2min | 1 tasks | 2 files |
| Phase quick-260401-l3t P01 | 1min | 2 tasks | 3 files |

## Accumulated Context

### Decisions

Decisions archived in PROJECT.md Key Decisions table.

Recent decisions for v2.0:

- [15-01]: EditResult uses @dataclass with default_factory for orphaned list
- [15-01]: modify_box syncs _raw["text"] explicitly (Box.to_dict round-trip path doesn't overlay text)
- [15-01]: replace_box captures orphaned connections before remove_box to preserve connection info
- [14-02]: Bounds checking is index-only (no signal type checking) per user decision in research phase
- [14-02]: Duplicate prevention returns existing patchline (idempotent) rather than raising
- [14-02]: remove_box() builds new list via comprehension to avoid mutating during iteration
- [14-01]: find_box short-circuits on first match; find_boxes collects all -- separate methods for ergonomics
- [14-01]: Alias resolution is bidirectional (t <-> trigger) via canonical form comparison
- [14-01]: read_patch delegates structural validation to from_dict() -- no extra strictness
- [13-02]: Box._raw excludes nested patcher key (inner patcher reconstructed from _inner_patcher to avoid stale data)
- [13-02]: outlettype only emitted in round-trip path if present in original _raw dict
- [13-02]: parameter_enable removed from _handled_keys -- preserved automatically via _raw
- [13-01]: Patchline dual-path to_dict -- _raw round-trip path preserves all original data; creation path builds from scratch
- [13-01]: Order=0 omitted in creation path to match MAX output format
- [13-01]: Patcher key ordering preserved by storing boxes/lines placeholders in props dict
- [Roadmap]: Split RW requirements across Phase 13 (round-trip) and Phase 14 (search + primitives) based on research dependency chain
- [Roadmap]: 6 phases derived from requirement dependencies, not category groupings -- round-trip must be proven before mutations
- [Research]: Zero new external dependencies -- all v2.0 built on existing codebase + stdlib
- [Phase 13]: save_patch_roundtrip preserves trailing newline status; detect_indent defaults to 4 spaces (MAX 9.1.2 format)
- [Phase 13]: save_patch_roundtrip is separate from write_patch -- creation path unchanged
- [Phase 15-02]: COLLISION_PAD = 5.0px around all boxes for collision detection readability
- [Phase 15-02]: insert_into_connection uses capacity = min(numinlets, numoutlets) for I/O mismatch handling
- [Phase 15-02]: I/O mismatch returns orphaned in EditResult (not ValueError) per CONTEXT.md locked decision
- [Phase 15-03]: signal_path excludes non-~ box itself from result (only ~ objects in signal chain)
- [Phase 15-03]: connected_components returns disconnected boxes as single-element groups (not separate list)
- [Phase 15-03]: Subpatcher crossing adds all inlet/outlet objects to result for full visibility
- [Phase 15-03]: _build_adj sorts adjacency by outlet/inlet index for left-to-right traversal order
- [Phase 16-01]: Prefix heuristics checked before tilde suffix (mc.foo~ is MC, not MSP)
- [Phase 16-01]: Section naming uses priority-based selection when multiple signatures found
- [Phase 16-01]: Signal chain wireless connections shown as "...-> receive~ name (wireless)" notation
- [Phase 16-01]: Control flow traces only notable origins (loadbang, metro, MIDI) -- not all control paths
- [Phase 17]: [17-01]: Unknown objects downgraded from error to warning so third-party patches pass validation
- [Phase 17]: [17-01]: Empty .maxpat uses Patcher + set_canvas_background for styled initial patch
- [Phase 17]: [17-02]: /max-build checks for existing .maxpat, offers overwrite or redirect to /max-iterate
- [Phase 17]: [17-02]: /max-iterate uses transparent strategy selection (surgical vs section rebuild)
- [Phase 17]: [17-02]: /max-onboard offers next steps after analysis (create project, iterate, or review)
- [Phase 17]: [17-03]: Editing section placed after Aesthetic Capabilities, before Output Protocol
- [Phase 17]: [17-03]: Output Protocol split into (New Patches) and (Edited Patches) subsections
- [Phase 17]: [17-03]: Domain focus notes use distinct examples per agent (route, cycle~, rnbo~, etc.)
- [Phase 18]: Untracked files deleted from disk only; 14 tracked files staged as git deletions
- [Phase 18]: SKILL.md verification tests updated to check v2.0 API names (save_patch_roundtrip) instead of v1.x (write_patch)
- [Phase 19]: [19-01]: Sentinel raw["patcher"] = None preserves key ordering instead of pop() which destroys ordered dict position
- [Phase quick-260317-b86]: COLLISION_PAD overlap uses half-pad expansion per rect (Minkowski sum) so 5px means 2.5px per side
- [Phase quick-260317-e14]: Rule #5 placed after Rule #4 (Patch Style), before Domain-Specific Rules section
- [Phase quick-260317-g0a]: GenExpr I/O syntax docs corrected: in1/out1 for codebox, in 1/out 1 for patcher objects only
- [Phase quick-260317-g0a]: Layout spacing docs corrected: ~20px vertical, ~15px gutter (matching defaults.py)
- [Phase quick-260317-g0a]: All /max: command format replaced with /max- across 10 skill files
- [Phase quick-260318-s03]: Inline project detection uses case-insensitive first-word match against list_projects()
- [Phase quick-260318-ujk]: Signal prefix heuristic: 'signal' if tilde-named, 'data' otherwise; 1-indexed positional fallback for unconnected I/O
- [Phase quick-260319-e32]: GitHub release tarball + npx scaffolder pattern for framework distribution (zero npm dependencies, Node 16+)
- [Phase quick-260319-f6q]: Override width is a floor (minimum), not an absolute value -- max(override, text_width)
- [Phase quick-260319-mnh]: MIDI-range sources to *~ gain inlet without normalization = blocker severity for hearing safety
- [Phase quick-260322-fpd]: ObjectDatabase.lookup() is the documented primary method; raw JSON files kept as secondary for browsing
- [Phase quick-260322-fyt]: Target ~250 lines total context for 3+ agent dispatch (not 200, based on actual section sizes)
- [Phase quick-260322-g3q]: expr/vexpr normalizer requires explicit division/scaling pattern -- no blanket pass
- [Phase quick-260322-g3q]: mc.gain~ in _GAIN_NAMES for recognition only; excluded from inlet-1 checks (single inlet object)
- [Phase quick-260322-g3q]: line~ tracing uses signal predecessor map to cross signal/control boundary
- [Phase quick-260322-hhw]: Soft limit is one-shot: after user says continue, no further soft-limit pauses (next stop is 5-identical escalation)
- [Phase quick-260322-hhw]: Accept option downgrades remaining blockers to warnings rather than silently dropping them
- [Phase quick-260322-hmn]: Version comment at (550, 10) top-right of default patcher; regex ^v\d+\.\d+\.\d+$ for in-place update
- [Phase quick-260322-hmn]: TYPE_CHECKING import for Patcher/Box avoids circular import in project.py
- [Phase quick-260322-n59]: 19 .gendsp patterns generated via write_gendsp() across 7 categories; agents reference via gen~ pattern-name newobj
- [Phase quick-260322-pkm]: Moved _apply_auto_styling to aesthetics.py to avoid circular imports; finalize_patch clears midpoints before regenerating for clean cable routing
- [Phase quick-260322-pxv]: Used open()+write()+flush()+fsync() instead of low-level os.open() for normal file permissions
- [Phase quick-260331-eqh]: set_z_index clamps out-of-range indices rather than raising; ValueError for missing box consistent with list.remove
- [Phase quick-260331-n24]: Round-trip text bug: from_dict() line 1950 defaults text to empty string for UI boxes without text key; fix is box_data.get('text') instead of box_data.get('text', '')
- [Phase quick-260331-nps]: box_data.get("text") returns None (not "") when original box has no text key -- to_dict handles None correctly
- [Phase quick-260331-o1y]: Control-Rate Fan-Out Rule placed between Z-Order and Aesthetics in shared-capabilities.md; MUST-level enforcement in all 4 specialist agents
- [Phase quick-260331-vs8]: Mixin pattern for Patcher decomposition: GraphMixin + AnalysisMixin, zero API changes
- [Phase quick-260331-w95]: shared-capabilities.md z-order section was stale after user's 8feeebf fix; corrected to match CLAUDE.md and patcher.py
- [Phase quick-260401-j8z]: get_outlet_types() returns maxpat-format strings (signal/''), not raw type fields; override includes _manual_original for audit trail
- [Phase quick-260401-jyk]: Audit-only task: 41 phantom overrides, 116 I/O corrections, 2 missing aliases (v->value, del->delay), 195 metadata-only entries identified
- [Phase quick-260401-l3t]: Bucket/Uzi overrides renamed to lowercase to match domain JSON convention
- [Phase quick-260401-l3t]: 5 non-object override entries removed (!, 1, 2, >p, ?) -- patch metadata artifacts
- [Phase quick-260401-lak]: maxclass=newobj for all 21 objects; I/O data from overrides.json _domain_other
- [Phase quick-260401-lpk]: verified-objects.json is tracking-only, not loaded by ObjectDatabase

### Pending Todos

None.

### Quick Tasks Completed

| # | Description | Date | Commit | Status | Directory |
|---|-------------|------|--------|--------|-----------|
| 260316-rzx | max-build should assume new patch, max-iterate for existing patches | 2026-03-17 | d8b2e22 | [260316-rzx-max-build-should-assume-new-patch-max-it](./quick/260316-rzx-max-build-should-assume-new-patch-max-it/) |
| 260316-uzv | Remove examples/ folder and list patches in README | 2026-03-17 | 0807246 | [260316-uzv-remove-examples-folder-and-list-patches-](./quick/260316-uzv-remove-examples-folder-and-list-patches-/) |
| 260317-b86 | Add post-generation patch layout validation critic | 2026-03-17 | 9467aa3 | [260317-b86-add-post-generation-patch-layout-validat](./quick/260317-b86-add-post-generation-patch-layout-validat/) |
| 260317-e14 | Remove generate.py approach and add safeguards | 2026-03-17 | 195096e | [260317-e14-remove-generate-py-approach-and-add-safe](./quick/260317-e14-remove-generate-py-approach-and-add-safe/) |
| 260317-g0a | Fix documentation inconsistencies (GenExpr syntax, spacing, command format) | 2026-03-17 | 793811b | [260317-g0a-thoroughly-review-the-entire-repo-for-in](./quick/260317-g0a-thoroughly-review-the-entire-repo-for-in/) |
| 260318-s03 | Add inline project switching to /max-iterate | 2026-03-18 | 9e41826 | [260318-s03-when-using-the-max-iterate-command-autom](./quick/260318-s03-when-using-the-max-iterate-command-autom/) |
| 260318-u2i | Remove TSC patch project from repo | 2026-03-19 | 10c5177 | [260318-u2i-remove-the-tsc-patch-and-project-by-dele](./quick/260318-u2i-remove-the-tsc-patch-and-project-by-dele/) |
| 260318-ujk | Auto-populate assistance comments on inlet/outlet objects | 2026-03-19 | 64f41d8 | [260318-ujk-auto-populate-assistance-comments-on-inl](./quick/260318-ujk-auto-populate-assistance-comments-on-inl/) |
| 260319-cws | Add assistance comment instructions to edit protocols | 2026-03-19 | e3cbd6b | [260319-cws-add-assistance-comment-instructions-to-e](./quick/260319-cws-add-assistance-comment-instructions-to-e/) |
| 260319-d83 | Investigate npx installer for framework distribution | 2026-03-19 | 625290b | [260319-d83-investigate-npx-installer-for-framework-](./quick/260319-d83-investigate-npx-installer-for-framework-/) |
| 260319-e32 | Create npx installer for framework distribution | 2026-03-19 | 56faca5 | Verified | [260319-e32-create-npx-installer-for-framework-distr](./quick/260319-e32-create-npx-installer-for-framework-distr/) |
| 260319-f6q | Fix layout spacing for send~/receive~ objects | 2026-03-19 | bc1b6ed | Verified | [260319-f6q-fix-layout-spacing-for-send-receive-obje](./quick/260319-f6q-fix-layout-spacing-for-send-receive-obje/) |
| 260319-mnh | Add gain safety guards for *~ and gain~ objects | 2026-03-19 | 6e591ef | Verified | [260319-mnh-add-gain-safety-guard-ensure-gain-multip](./quick/260319-mnh-add-gain-safety-guard-ensure-gain-multip/) |
| 260321-6mo | Add --full flag to /max-iterate for discuss-research-plan pipeline | 2026-03-21 | 491bdd0 | Verified | [260321-6mo-add-full-flag-to-max-iterate-for-discuss](./quick/260321-6mo-add-full-flag-to-max-iterate-for-discuss/) |
| 260322-bbh | Framework effectiveness review with prioritized recommendations | 2026-03-22 | cccf531 | Verified | [260322-bbh-review-the-repo-and-make-suggestions-tha](./quick/260322-bbh-review-the-repo-and-make-suggestions-tha/) |
| 260322-c7w | Guard signal-to-control auto-removal for unverified MSP objects | 2026-03-22 | e899cda | Verified | [260322-c7w-in-validation-py-validate-connections-ad](./quick/260322-c7w-in-validation-py-validate-connections-ad/) |
| 260322-dz9 | Add 8 new validation checks for MAX API misuse | 2026-03-22 | 45c3187 | Verified | [260322-dz9-add-8-new-validation-checks-for-max-api-](./quick/260322-dz9-add-8-new-validation-checks-for-max-api-/) |
| 260322-eai | Bulk-correct MSP outlet types for gain~ and index~ | 2026-03-22 | c2c88f1 | Verified | [260322-eai-bulk-correct-outlet-types-for-msp-object](./quick/260322-eai-bulk-correct-outlet-types-for-msp-object/) |
| 260322-eva | Retire the in-app memory system (max-memory-agent) | 2026-03-22 | b4d20a3 | Verified | [260322-eva-retire-the-in-app-memory-system-max-memo](./quick/260322-eva-retire-the-in-app-memory-system-max-memo/) |
| 260322-fee | Extract duplicated content blocks into shared-capabilities.md | 2026-03-22 | 587f034 | Verified | [260322-fee-extract-duplicated-content-blocks-from-a](./quick/260322-fee-extract-duplicated-content-blocks-from-a/) |
| 260322-fpd | Update CLAUDE.md and SKILL.md files to recommend ObjectDatabase | 2026-03-22 | 8f9ac8b | | [260322-fpd-update-claude-md-and-skill-md-files-to-r](./quick/260322-fpd-update-claude-md-and-skill-md-files-to-r/) |
| 260322-fyt | Add Context Budget section to max-router SKILL.md | 2026-03-22 | ac1351c | | [260322-fyt-add-context-budget-section-to-max-router](./quick/260322-fyt-add-context-budget-section-to-max-router/) |
| 260322-g3q | Extend DSP critic gain staging checks | 2026-03-22 | ce56fee | Verified | [260322-g3q-extend-dsp-critic-gain-staging-checks-wi](./quick/260322-g3q-extend-dsp-critic-gain-staging-checks-wi/) |
| 260322-hcn | Fix failing test layout inlet alignment tolerance | 2026-03-22 | 1ebd679 | | [260322-hcn-fix-failing-test-layout-inlet-alignment-](./quick/260322-hcn-fix-failing-test-layout-inlet-alignment-/) |
| 260322-hk7 | Add interactive mode note to max-iterate flags | 2026-03-22 | 6f73145 | | [260322-hk7-add-full-interactive-mode-note-to-max-it](./quick/260322-hk7-add-full-interactive-mode-note-to-max-it/) |
| 260322-hhw | Add soft limit to critic loop after 3 rounds | 2026-03-22 | ae39141 | | [260322-hhw-add-soft-limit-to-critic-loop-after-3-ro](./quick/260322-hhw-add-soft-limit-to-critic-loop-after-3-ro/) |
| 260322-hmn | Enforce version tracking with every max-iterate run | 2026-03-22 | 58bb2b6 | Verified | [260322-hmn-enforce-version-tracking-with-every-max-](./quick/260322-hmn-enforce-version-tracking-with-every-max-/) |
| 260322-n59 | Build reusable gen~ pattern library and standardized UI presets | 2026-03-22 | eb2513f | Verified | [260322-n59-build-reusable-gen-pattern-library-and-s](./quick/260322-n59-build-reusable-gen-pattern-library-and-s/) |
| 260322-pkm | Add finalize_patch() hook for centralized layout cleanup | 2026-03-23 | e8c735e | Verified | [260322-pkm-add-a-hook-so-that-the-appropriate-agent](./quick/260322-pkm-add-a-hook-so-that-the-appropriate-agent/) |
| 260322-pxv | Fix patch file caching with os.fsync on all write paths | 2026-03-23 | 6b57e00 | Verified | [260322-pxv-investigate-and-fix-patch-file-caching-i](./quick/260322-pxv-investigate-and-fix-patch-file-caching-i/) |
| 260331-eqh | Add z-order manipulation API and documentation | 2026-03-31 | adaa5ef | Verified | [260331-eqh-research-z-order-of-objects-in-max-and-a](./quick/260331-eqh-research-z-order-of-objects-in-max-and-a/) |
| 260331-n24 | Full repo analysis: identify improvements for next milestone | 2026-03-31 | f02dfbd | Verified | [260331-n24-full-repo-analysis-identify-improvements](./quick/260331-n24-full-repo-analysis-identify-improvements/) |
| 260331-nps | Fix round-trip text:"" bug and xfail externally-modified round-trip tests | 2026-04-01 | ea844a1 | | [260331-nps-fix-round-trip-text-bug-and-xfail-extern](./quick/260331-nps-fix-round-trip-text-bug-and-xfail-extern/) |
| 260331-o1y | Strengthen Rule #3 trigger enforcement across all specialist SKILL.md files | 2026-04-01 | 0642e94 | | [260331-o1y-strengthen-rule-3-trigger-enforcement-ac](./quick/260331-o1y-strengthen-rule-3-trigger-enforcement-ac/) |
| 260331-vs8 | Decompose patcher.py — extract graph/analysis mixins + maxclass validation | 2026-04-01 | e3b0415 | | [260331-vs8-decompose-patcher-py-extract-graph-trave](./quick/260331-vs8-decompose-patcher-py-extract-graph-trave/) |
| 260331-w95 | Update README and TECHNICAL.md for v2.3 release | 2026-04-01 | 0841a18 | Verified | [260331-w95-review-the-recent-updates-to-the-repo-an](./quick/260331-w95-review-the-recent-updates-to-the-repo-an/) |
| 260401-j8z | Fix info~ object outlets in MSP database | 2026-04-01 | 7ea4d72 | | [260401-j8z-fix-info-object-outlets-in-msp-database-](./quick/260401-j8z-fix-info-object-outlets-in-msp-database-/) |
| 260401-jyk | Audit objects database and overrides for correctness | 2026-04-01 | 268175a | Verified | [260401-jyk-audit-objects-database-and-overrides-for](./quick/260401-jyk-audit-objects-database-and-overrides-for/) |
| 260401-l3t | Clean object DB: add missing aliases, remove non-real entries, normalize case mismatches | 2026-04-01 | a62bcd4 | | [260401-l3t-clean-object-db-add-missing-aliases-remo](./quick/260401-l3t-clean-object-db-add-missing-aliases-remo/) |
| 260401-lak | Add missing objects to domain files identified in audit report | 2026-04-01 | bfed726 | Verified | [260401-lak-add-missing-objects-to-domain-files-iden](./quick/260401-lak-add-missing-objects-to-domain-files-iden/) |
| 260401-lpk | Clean overrides.json: remove user abstractions, separate metadata-only entries | 2026-04-01 | 2c0f9e4 | | [260401-lpk-clean-overrides-json-remove-user-abstrac](./quick/260401-lpk-clean-overrides-json-remove-user-abstrac/) |

### Blockers/Concerns

- ~~from_dict() has zero test coverage~~ RESOLVED: 31 round-trip tests in test_round_trip.py
- ~~Patchline color drop bug~~ RESOLVED: Patchline now has color, extra_attrs, _raw fields (Plan 13-01)
- ~~2 remaining round-trip bugs (bpatcher attrs, parameter_enable)~~ RESOLVED: Box._raw preservation handles all round-trip bugs (Plan 13-02)
- No official .maxpat spec exists -- unknown keys must be preserved defensively

## Session Continuity

Last session: 2026-04-01T22:43:17Z
Stopped at: Completed quick-260401-lpk-PLAN.md
Resume file: None
