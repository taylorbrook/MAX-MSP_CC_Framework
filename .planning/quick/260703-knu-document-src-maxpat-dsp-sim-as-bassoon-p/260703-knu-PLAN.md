---
phase: 260703-knu
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/dsp_sim/__init__.py
  - src/maxpat/dsp_sim/README.md
  - .planning/PROJECT.md
autonomous: true
requirements: [DOC-DSPSIM-SCOPE, DOC-DSPSIM-DEFER]
must_haves:
  truths:
    - "Anyone opening the dsp_sim module can tell within the first paragraph that it is a bassoon-waveguide-specific pre-flight harness, not a general DSP simulator"
    - "The 3 supported topologies (bore_only, reed_bore, reed_bore_post_radiation) are named and described"
    - "How and when to run the pre-flight sim (CLI, run_simulation API, tests/dsp_sim/ gate) is documented"
    - "The deferred idea (broaden with general topologies: gain chain, feedback delay, filter cascade) is recorded in the project's existing v6.0/future convention"
  artifacts:
    - src/maxpat/dsp_sim/README.md
  key_links:
    - "PROJECT.md ### Future bullet is the single existing home for the deferred v6.0 idea — no new tracking file"
---

<objective>
Document `src/maxpat/dsp_sim/` as bassoon-project-specific and record the deferred broadening idea (general topologies) in the project's existing v6.0 backlog convention. Decision is already made: document-as-scoped now, broaden later as a v6.0 roadmap item.

Purpose: The module reads as a generic "DSP pre-flight simulator" but only supports 3 bassoon-waveguide topologies. Future readers (and future Claude sessions) must not mistake it for a general-purpose simulator. The deferred broadening must land where the project already tracks future work so it is not lost.
Output: Scoped module docstring, a new `src/maxpat/dsp_sim/README.md`, and one `### Future` bullet in PROJECT.md.
</objective>

<execution_context>
@$HOME/.claude/gsd-core/workflows/execute-plan.md
@$HOME/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@.planning/PROJECT.md

# The module being documented (read to ground the docs — do NOT change its behavior)
@src/maxpat/dsp_sim/__init__.py
@src/maxpat/dsp_sim/runner.py
@src/maxpat/dsp_sim/topologies/__init__.py

# CLAUDE.md Gen~ rule this module serves:
# "Pre-flight any new in-loop waveguide filter with a numpy simulation before committing"
# and "Waveguide loop filters: resonant filters go POST-LOOP" — the reed_bore_post_radiation
# topology encodes the v0.4.2+ post-loop invariant. Reference this rule in the README so the
# link between the CLAUDE.md guidance and this harness is explicit.

# CONVENTION NOTES (already discovered — do not re-investigate):
# - No backlog/ideas file exists. PROJECT.md ### Future is the established list of forward-looking
#   feature ideas (Template library, M4L integration, etc.); deferred scope is tagged "v6.0+"
#   throughout PROJECT.md Key Decisions and STATE.md. Use ### Future — do NOT invent a new file.
# - topologies/__init__.py already scopes its 3 topologies to "the bassoon shapes"; the GAP is the
#   TOP-LEVEL __init__.py docstring ("offline numpy waveguide stability harness") which never says
#   bassoon-specific. That is the docstring to scope.
# - No README exists anywhere under src/ — a module README is standard documentation, not a new
#   tracking structure.
</context>

<tasks>

<task type="auto">
  <name>Task 1: Scope the dsp_sim module docstring and add a README</name>
  <files>src/maxpat/dsp_sim/__init__.py, src/maxpat/dsp_sim/README.md</files>
  <action>
Documentation only — do NOT change any code, imports, __all__, or signatures in this module.

(1) Edit the top-level module docstring in `src/maxpat/dsp_sim/__init__.py` (currently opens "DSP pre-flight simulator -- offline numpy waveguide stability harness."). Add an explicit scope sentence near the top stating this module is bassoon-waveguide-specific: it is the offline numpy pre-flight harness for the bassoon-model waveguide patch, serving the CLAUDE.md Gen~ rule that any new in-loop waveguide filter must be pre-flighted with a numpy simulation before committing. Name the 3 supported topologies (bore_only, reed_bore, reed_bore_post_radiation) as bassoon shapes, note the mirror= escape hatch for off-catalogue patches, and add a "See README.md in this package for scope, topologies, and usage." pointer. Keep the existing D-01/D-03/etc. references and the usage example intact — only prepend/expand the scope framing.

(2) Create `src/maxpat/dsp_sim/README.md` covering, in this order:
  - Scope (one lead paragraph): bassoon-waveguide-specific pre-flight stability harness, NOT a general DSP simulator. State what it is for (catch waveguide pitch-lock / mode-competition / runaway / no-oscillation before a bassoon patch ships) and cite the CLAUDE.md Gen~ pre-flight rule.
  - The 3 topologies: bore_only (passive bore + onepole damping, sanity structure), reed_bore (bore + McIntyre-Woodhouse reed, v0.3.x ancestor), reed_bore_post_radiation (v0.4.2+ shape, post-loop bell biquad + post-loop reed BPF — encodes the "resonant filters go POST-LOOP" invariant). Note each mirrors patches/bassoon-model/generated/bassoon.gendsp.
  - The mirror= escape hatch: run_simulation(mirror=callable) covers off-catalogue patches without adding a topology.
  - When/how to run: the `run_simulation(...)` API (topology or mirror, params, sweep_param, sweep, verdict cascade runaway > no_oscillation > mode_competition > phase_drift), the `python -m src.maxpat.dsp_sim` CLI with verdict-priority exit codes, and the live-patch gate convention `tests/dsp_sim/test_<stem>.py`. Reference max-dsp-agent's SKILL.md pre-flight gate.
  - Scope & future work: one short section noting the module is intentionally scoped to the bassoon waveguide today, and that broadening it with general topologies (simple gain chain, feedback delay, filter cascade) is a deferred v6.0 roadmap item tracked in .planning/PROJECT.md (### Future).
Ground every claim in the actual module files (runner.py, topologies/__init__.py) — do not invent parameters or verdict names.
  </action>
  <verify>
    <automated>python -c "import src.maxpat.dsp_sim as m; d=m.__doc__ or ''; assert 'bassoon' in d.lower(), 'docstring not scoped to bassoon'; assert 'README' in d, 'no README pointer'; from src.maxpat.dsp_sim import run_simulation, SimulationReport; print('import OK, docstring scoped')" && grep -qi 'bassoon' src/maxpat/dsp_sim/README.md && grep -q 'bore_only' src/maxpat/dsp_sim/README.md && grep -q 'reed_bore_post_radiation' src/maxpat/dsp_sim/README.md && grep -qi 'run_simulation' src/maxpat/dsp_sim/README.md && echo README_OK</automated>
  </verify>
  <done>Module docstring explicitly states bassoon-waveguide scope and points to README; README.md exists describing the 3 topologies, the mirror escape hatch, and when/how to run the pre-flight sim; no code/signature changes (import still succeeds).</done>
</task>

<task type="auto">
  <name>Task 2: Record the deferred broadening idea in PROJECT.md ### Future</name>
  <files>.planning/PROJECT.md</files>
  <action>
Add one bullet to the existing `### Future` list in `.planning/PROJECT.md` (the list containing "Template library for common MAX patterns", "MAX for Live integration", etc.). Match the existing bullet style (`- [ ] ...`). The bullet records the deferred idea: broaden the dsp_sim pre-flight simulator beyond the bassoon waveguide with general topologies — simple gain chain, feedback delay, filter cascade — as a v6.0 roadmap item. Reference `src/maxpat/dsp_sim/`. Do NOT invent a new backlog file, do NOT edit STATE.md's Deferred Items table (that table is for milestone tech-debt carryover, not new feature ideas), and do NOT touch any other section of PROJECT.md.
  </action>
  <verify>
    <automated>grep -n 'gain chain\|feedback delay\|filter cascade' .planning/PROJECT.md | grep -qi 'dsp_sim\|topolog\|pre-flight' || grep -A40 '### Future' .planning/PROJECT.md | grep -qi 'dsp_sim'; grep -A40 '### Future' .planning/PROJECT.md | grep -qi 'dsp_sim' && echo FUTURE_BULLET_OK</automated>
  </verify>
  <done>PROJECT.md ### Future contains a new bullet naming the deferred dsp_sim broadening (general topologies: gain chain, feedback delay, filter cascade) as v6.0 work; no other tracking file created.</done>
</task>

</tasks>

<verification>
- `python -c "from src.maxpat.dsp_sim import run_simulation"` still succeeds (no behavior change).
- Module docstring and README both scope the module to the bassoon waveguide.
- README names all 3 topologies and documents how/when to run the pre-flight sim.
- The deferred v6.0 broadening idea lives in PROJECT.md ### Future (existing convention), not a new file.
</verification>

<success_criteria>
- src/maxpat/dsp_sim/__init__.py docstring explicitly states bassoon-waveguide scope + README pointer.
- src/maxpat/dsp_sim/README.md exists with scope, 3 topologies, mirror escape hatch, and usage (API + CLI + tests gate).
- .planning/PROJECT.md ### Future has one bullet capturing the deferred general-topology broadening as v6.0 work.
- Zero code/signature changes to dsp_sim; imports unchanged.
</success_criteria>

<output>
Create `.planning/quick/260703-knu-document-src-maxpat-dsp-sim-as-bassoon-p/260703-knu-SUMMARY.md` when done.
</output>
