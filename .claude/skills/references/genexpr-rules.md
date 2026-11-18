# GenExpr Rules (gen~ codebox, `.gendsp`, `mc.gen~`)

Full gen~ rule set for codebox code, `.gendsp` patchers and `mc.gen~`. max-dsp-agent reads this file before writing or editing any GenExpr. CLAUDE.md "Gen~ (GenExpr DSP Code)" keeps the one-line imperatives; this file holds the full text, the derivations and the per-version evidence behind each rule.

## Basics

- GenExpr codebox uses C-style syntax with `in1`, `in2` for inputs and `out1`, `out2` for outputs (no space -- `in 1`/`out 1` is only for gen~ patcher objects, not codebox code)
- Use `Param` for user-controllable parameters (maps to gen~ attributes)
- Use `History` for single-sample delay (feedback loops, state)
- For longer delay lines, declare `Delay myDelay(max_samples);` then use `myDelay.write(x)` / `myDelay.read(t)`. **The `delay()` function is NOT supported in codebox** -- it is only valid in gen~ patcher (visual) mode. MAX errors with "The delay() operator is not supported in GenExpr; use the Delay.read and Delay.write instead." Multiple reads from the same Delay at different positions are allowed (e.g., dual-tap pitch shifter)
- `Buffer` and `Data` for sample data access
- Gen~ operates at sample rate -- every operation runs once per sample
- No conditional branching cost -- both branches always execute (SIMD-friendly)
- Variables used inside `if`/`else` blocks must be initialized before the block, otherwise GenExpr errors with "not defined"
- Codebox objects embed GenExpr in `.maxpat` patches; `.gendsp` files are standalone Gen~ patchers

## Declaration ordering

**Declaration ordering**: ALL declarations (`Param`, `History`, `Delay`, `Buffer`, `Data`) MUST appear before ANY expressions or assignments. gen~ will refuse to compile code with declarations after expressions. The `add_gen()` method auto-reorders declarations, but always write code with declarations at the top: Params first, then Delay, then History, then Buffer/Data, then all expressions

**Functions come first.** A user function definition (`name(args) { ... }`) goes before every declaration and statement: the codebox order is functions, then declarations, then statements. This is the form every shipped Cycling '74 codebox with functions uses (gen.maxhelp, jit.gl.material) and the Max user guide's rule ("functions must be declared before all statements"). `validate_genexpr` reports a function after a statement as an **error** and a function after declarations only as a **warning**; it judges statement order outside function bodies. `reorder_genexpr_declarations` (used by `add_gen`) emits functions, then declarations, then statements, never hoists a Param above a function, and leaves the C74 form byte-identical. [code + bundle evidence; the error case is not yet reproduced in MAX].

## Setting Param values from MAX

**Setting Param values from MAX:** send `param_name $1` messages to the gen~ inlet (NO `@` prefix). `@param_name $1` is attribute syntax and does NOT work with gen~ -- gen~ matches the first symbol against Param names directly. Use `attrui` connected to gen~ for an auto-generated all-params interface.

## Waveguide loop filters

**Waveguide loop filters:** resonant filters (Q >= ~1.5) go POST-LOOP (radiation/output path), never inside the feedback loop — an in-loop resonance competes with the bore's self-excited mode and pitch locks/jumps to the filter fc; no phase compensation fixes it. This includes "source-side" filters between a driver nonlinearity and the delay-line injection. Low-Q (Q <= ~1) filters may stay in-loop but must subtract analytic **phase delay** (-phi(w)/w) — never group delay (overshoots 3x+ for resonant sections) — from the target period. Onepole (b = 1-a): `pd_samples = atan(b*sin(w) / (1 - b*cos(w))) / max(w, 0.0001)`. For biquads, evaluate B(e^jw)/A(e^jw) as complex numbers, take the atan2 phase difference, unwrap past -pi, clamp compensation to a sane range (e.g. [0, 64] samples), and share coefficients between the filter and the comp block (full derivation below).

### Derivation

Two distinct rules for filters and gen~ waveguide bore loops. Know which one applies before adding a filter to the feedback path.

#### Rule 1 — Resonant (Q > ~1) filters go POST-LOOP

A resonant filter inside the feedback loop competes with the bore's self-excited mode. The loop locks onto whichever resonance has higher Q × gain, not onto freq_mod. No amount of phase-delay compensation fixes this — it's a mode-competition problem, not a phase-shift problem.

**Symptom:** sweeping the filter's fc causes the output fundamental to jump to the filter's fc, or to subharmonics, or to stable-but-wrong octaves. Python simulation reveals factor-of-N pitch jumps, not smooth detuning.

**Fix:** apply the filter POST-LOOP to `bore_return` (or whatever the bore output wavelet is). The loop sees the raw bore signal; the listener hears the filtered version. No tuning coupling.

Physical analog: bell radiation = how the pressure wave couples to the outside air. Bell reflection = how the pressure wave bounces back into the bore. These are different transfer functions even though they share physics — model them separately.

#### Rule 2 — Non-resonant in-loop LPFs need phase-delay (NOT group-delay) compensation

An onepole / low-Q filter in the feedback path can stay in-loop safely, but its phase delay lengthens the round trip and shifts pitch as its coefficient sweeps. Subtract analytic **phase delay** (−φ(ω)/ω) from the target period. Never group delay — for resonant sections group delay overshoots phase delay by 3× or more.

**Onepole LPF** (y = y_prev + a·(x − y_prev), b = 1−a):
```
pd_samples = atan(b*sin(w) / (1 - b*cos(w))) / max(w, 0.0001)
```

**Biquad** — evaluate B(e^jw)/A(e^jw) as complex numbers, take atan2, subtract:
```
PB_re = b0 + b1*cos(w) + b2*cos(2w);  PB_im = -(b1*sin(w) + b2*sin(2w))
PA_re = 1  + a1*cos(w) + a2*cos(2w);  PA_im = -(a1*sin(w) + a2*sin(2w))
phi_H = atan2(PB_im, PB_re) - atan2(PA_im, PA_re)
if (phi_H > 0.01) phi_H -= TWOPI   // up to 2 unwraps for stable 2nd-order
pd_samples = -phi_H / max(w, 0.0001)
```

#### Why

Four iterations on bassoon-model:
- **v0.3.1**: added a low-Q bore_damp onepole in the reflection path; needed onepole phase-delay compensation (worked).
- **v0.4.0/0.4.1**: replaced bell onepole with Q=2.5 biquad in the loop; even with correct phase-delay compensation, pitch jumped wildly as bell_bright swept (bore locked onto biquad's 500 Hz resonance instead of freq_mod). Group-delay form (v0.4.0) was also wrong, but even the fixed phase-delay form (v0.4.1) couldn't rescue an in-loop high-Q filter.
- **v0.4.2**: moved biquad out of the loop as a post-loop radiation filter. Python simulation confirmed bit-exact pitch stability across the bell_bright sweep at every target freq.
- **v0.5.0/0.5.1**: same trap on the reed side — placed Q=1-6 reed-channel BPF between reed LUT and bore injection (`bore_in_s = reed_filt + cone_return`). Sweeping reed_res_freq pulled the fundamental instead of coloring timbre. Fix (v0.5.1): bore injection reverts to dry reed_sig; reed_filt is summed into the bell biquad input (`rad_in = bore_return + reed_filt`) so the reed honk colors radiation only. Third confirmation that "source-side" filters between a driver nonlinearity and a waveguide still count as in-loop if the filter output feeds the delay line — not just filters in the reflection path.

#### How to apply

1. **Q heuristic:** Q ≤ ~1 can live in-loop with phase-delay compensation. Q ≥ ~1.5 should go post-loop.
2. **Pre-flight with a Python simulation** before committing: implement the waveguide loop in numpy, sweep the new filter's controlling Param across its full range at a few target freqs, measure the output fundamental via autocorrelation or FFT. If pitch moves more than a few cents across the sweep, the architecture is wrong.
3. **In-loop compensation checklist:** share filter coefficients between the phase-comp block and the filter step (single source of truth); unwrap atan2 when total H phase drops past −π; clamp final compensation to a sane range (e.g., [0, 64] samples).
4. **Post-loop filters** don't need any compensation — they're not in the resonance path.

## mc.gen~ via add_gen() + rename

**mc.gen~ via `add_gen()` + rename** (confirmed working, ji-harmonizer v0.1.2): build with `add_gen(code, ...)`, then set the parent box's `name` and `text` to `"mc.gen~"` — the embedded gen patcher serialization is identical. The mc wrapper auto-adapts instance count to the connected mc signal; a mono signal into an mc.gen~ inlet broadcasts to all instances; bare `param $1` messages into inlet 0 set the Param on all instances uniformly.

## Pre-flight any new in-loop waveguide filter

**Pre-flight any new in-loop waveguide filter with a numpy simulation** before committing: sweep the filter's controlling Param across its full range at several target freqs and measure the output fundamental (autocorrelation/FFT). If pitch moves more than a few cents across the sweep, the architecture is wrong. Post-loop filters need no compensation.

The in-repo simulator and its verdicts are documented in max-dsp-agent SKILL.md "## DSP Pre-Flight Simulation".

## In-loop saturation

**In-loop saturation: normalize by the drive gain, never by `1/tanh(drive)`.** `tanh(x*g)/tanh(g)` preserves full-scale peaks but multiplies the small-signal (linear) region by ~`g`, making effective loop gain `feedback * g / tanh(g)` — over unity at every setting (1.25x even at g=1) and guaranteeing runaway feedback. Use `tanh(x*g)/g` inside feedback loops: small-signal loop gain equals `feedback` exactly, so `feedback < 1` always decays; higher drive naturally trades repeat loudness for grit. (Found in stereo-feedback-delay v0.1.0, fixed v0.1.1.)

## No local aliases in Param-only expressions

**No local aliases in Param-only expressions.** gen~ hoists expressions whose inputs are only Params/constants out of the per-sample body; a loop-local alias like `sr = samplerate;` or `RING = 1344000;` is not visible there and compile fails with `use of undeclared identifier 'sr'` (plus cascading `maxb_NN` errors). Write `samplerate` and literal constants directly in such expressions (kicksynth pattern: `max(decay * 0.001 * samplerate, 1)`). Also prefer range tests (`x > 0.5 && x < 1.5`) over `==` in `if` — gen~ warns on it. (reverse-delay v0.2.1)

## Hoisted temps can be emitted out of order

**Hoisted temps can be emitted out of order — de-hoist any Param-only setup chain.** gen~ hoists Param/constant-only statements out of the sample loop; on some Max 9 builds the hoisted temps are emitted before their dependencies (`use of undeclared identifier 'maxb_NN'` on a friend's Max 9; `'gmax_raw'` on 9.1.5 after rewriting `max()` as an abs identity — the rewrite only moved the failure). Which statements break varies by build, so a patch that compiles locally can still fail elsewhere. Fix that works: declare `History one(1);` (never written, always 1.0 — runtime state) and compute `srs = samplerate * one;` plus `k_<param> = <param> * one;` once at the top of the per-sample body, then use only `srs`/`k_*` downstream. Nothing is Param-only, so nothing is hoisted (reverse-delay v0.3.3, confirmed compiling on 9.1.5). Cost is a handful of flops per sample. Simple leaf expressions (`pow(10, makeup_db / 20)`) have never failed; chains of dependent hoisted values (sizes derived from other sizes) are the risk.

## Built-in constant names

**Never use GenExpr built-in constant names as variable names** (`e`, `pi`, `twopi`, `halfpi`, `invpi`, `ln2`, `ln10`, `log10e`, `log2e`, `sqrt2`, `sqrt1_2`, `degtorad`, `radtodeg`, `phi`, and every upper-case alias: `E`, `PI`, `TWOPI`, `HALFPI`, `INVPI`, `LN2`, `LN10`, `LOG10E`, `LOG2E`, `SQRT2`, `SQRT1_2`, `DEGTORAD`, `RADTODEG`, `PHI`; `genexpr_parse.BUILTIN_CONSTANTS`, which the linter and the dsp_sim interpreter both use). Assigning to them does not create a local — the constant wins silently, no compile error. sample-layers v0.3.0 used `e` as the master-envelope ramp variable: `env = e` pinned the envelope at 2.718, `e*e` became a constant ~7.4x gain, and the on/off gate passed audio permanently. Renamed to `ev` in v0.3.1.

## Codebox safe-construct rules

**Codebox safe-construct rules** (learned from spectraldetector v0.1.x, which failed with a generic `dsp.gen: ... failed to compile genpatcher` Lua error and no codebox-specific message; fixed in v0.2.0, confirmed working in MAX):
- **Spaces only, NEVER tab characters** in codebox code strings. The failing codebox was the only one in the repo containing tabs; all working codeboxes are pure spaces. Prime suspect for the generic compile failure. Enforcement (Q22 locked decision): a tab in generated or edited code is a validator **error**; tab lines already present in a loaded codebox are one **warning** (74 of 146 shipped C74 codeboxes contain tabs and compile). `validate_genexpr(code, db, *, original=...)` makes the split: lines found verbatim in `original` warn, new tab lines error, and `original=None` (generated code) errors on every tab. `validate_patch(..., original=loaded)`, the save gate (baseline as `original`) and `validate_code_file` (disk file = loaded; `loaded=False` for code just generated) pass it.
- **No `else if` chains** — use nested `else { if ... }` or sequential guarded ifs. No working codebox in the repo uses `else if`; plain `if`/`else` is proven fine.
- **`peek`/`poke` always with explicit channel arg**: `peek(buf, idx, 0)`, `poke(buf, val, idx, 0)`. All confirmed-working codeboxes use these arities.
- **For loops: single, non-nested, CONSTANT bounds** (`for (i = 0; i < 600; i += 1)`), with a variable inner guard (`if (i < win) { ... }`) when the effective range is runtime-dependent. No confirmed-working codebox uses variable loop bounds or nested loops (the two patches that did — scala-synth, spectraldetector v0.1.x — both failed to compile).
- **Amortize heavy scans across samples** instead of bursting inside one sample: keep a `History` cursor (e.g. one autocorrelation lag evaluated per sample) and publish the result when the cursor wraps. Same average CPU as a per-hop burst, no CPU spike, and it avoids the nested-loop pattern entirely.
- Caveat: v0.2.0 fixed tabs + loops + else in one pass, so causes are not individually isolated — treat the full set as the proven-safe pattern. A minimal bisect codebox is the next diagnostic step if a codebox ever fails with this generic error again.

## `.gendsp` edits and codebox inlets

`write_gendsp` on an existing `.gendsp` never shrinks ports from auto-detected counts: surplus `in N` / `out N` boxes are removed only when `num_inputs` / `num_outputs` are passed explicitly. Unchanged code is a true no-op. A codebox with no inputs keeps an existing `numinlets` of 0 or 1 (MAX-resaved files store 0) and never gains a spurious `in 1`; a new 0-input codebox is written with `numinlets: 1`, the shape MAX's own help patches use. `generate_gendsp` writes codebox `numinlets: max(1, n_in)`.

## `// smoke:` directive (dsp_sim)

A `// smoke:` comment line in a codebox overrides the port kinds the dsp_sim smoke test infers from the host patch, for standalone `.gendsp` files and patterns with no host: `// smoke: control out2 trigger in1 in3=phasor:2` (`control outN`, `trigger inN`, `inN=SPEC`). GenExpr ignores it as a comment. Syntax and port inference: `src/maxpat/dsp_sim/README.md`.

## Max 9.2 compiler fixes

**Max 9.2's Gen compiler fixes do NOT retire any rule above.** The 9.2 release notes describe fixes to dead-code elimination, constant folding, variable collapsing and aliasing, and an improved `require` — plausibly the cause of some hoisting/aliasing failures listed here — but no rule in this section has been re-tested on 9.2, and patches must still compile on collaborators' older 9.x builds. Every workaround (de-hoisting via `History one(1)`, no local aliases in Param-only expressions, the codebox safe-construct set, constant-name avoidance, declaration ordering) stays in force until it is individually re-verified in MAX and that result is recorded here.

**Max 9.2.1 retires nothing either** (release notes only, [notes]). Its fix for the `gen.codebox~` nested-loop compile regression does NOT relax the single, non-nested `for` loop rule: the rule predates 9.2, patches must still compile on older 9.x builds, and the fix has not been tested here. The `cycle` phase-wrapping fix (with a `Buffer` / `Data`), the `Buffer` lock leak inside GenExpr functions and the Gen Define reference-file fix touch no rule in this file.
