"""Generate FDNVerb.maxpat -- 8-line FDN reverb in gen~.

Main patch with:
- Audio I/O (ezadc~ / ezdac~)
- gen~ with embedded FDN reverb codebox (Hadamard mixing matrix)
- 12 parameter controls via attrui bound to gen~ Params
- Safety gain (*~ 0.5) and meters
"""

import json
import sys
from pathlib import Path

sys.path.insert(0, '/Users/taylorbrook/Dev/MAX')
from src.maxpat import Patcher, ObjectDatabase, validate_patch, has_blocking_errors

db = ObjectDatabase()
p = Patcher(db=db)
p.props["rect"] = [100.0, 100.0, 1050.0, 850.0]

# ============================================================
# GenExpr code -- 8-line FDN reverb
# ============================================================

GENEXPR_CODE = """\
// FDNVerb -- 8-Line FDN Reverb
// Feedback Delay Network with Hadamard mixing matrix

// === PARAMETERS ===
Param decay(2, min=0.1, max=30);
Param predelay(20, min=0, max=500);
Param damping(0.5, min=0, max=1);
Param size(0.5, min=0, max=1);
Param diffusion(0.7, min=0, max=1);
Param drywet(0.5, min=0, max=1);
Param modrate(0.5, min=0.01, max=10);
Param moddepth(0.2, min=0, max=1);
Param eq_low(0, min=-12, max=12);
Param eq_high(0, min=-12, max=12);
Param bloom(0.5, min=0, max=1);
Param freeze(0, min=0, max=1);

// === INPUT ===
dry_L = in1;
dry_R = in2;
mono_in = (dry_L + dry_R) * 0.5;

// === PRE-DELAY ===
Delay predly(24000);
predly.write(mono_in);
pd_samps = max(predelay * 0.001 * samplerate, 1);
pd_out = predly.read(pd_samps);

// === INPUT DIFFUSION ===
// 4 allpass stages; diffusion controls coefficient
diff_g = diffusion * 0.6;

Delay ap1d(512);
ap1_rd = ap1d.read(142);
ap1_v = pd_out - diff_g * ap1_rd;
ap1_y = diff_g * ap1_v + ap1_rd;
ap1d.write(ap1_v);

Delay ap2d(512);
ap2_rd = ap2d.read(107);
ap2_v = ap1_y - diff_g * ap2_rd;
ap2_y = diff_g * ap2_v + ap2_rd;
ap2d.write(ap2_v);

Delay ap3d(512);
ap3_rd = ap3d.read(379);
ap3_v = ap2_y - diff_g * ap3_rd;
ap3_y = diff_g * ap3_v + ap3_rd;
ap3d.write(ap3_v);

Delay ap4d(512);
ap4_rd = ap4d.read(277);
ap4_v = ap3_y - diff_g * ap4_rd;
ap4_y = diff_g * ap4_v + ap4_rd;
ap4d.write(ap4_v);

// Bloom crossfade: direct vs diffused input
fdn_in = pd_out + bloom * (ap4_y - pd_out);

// === FDN CORE ===
// 8 delay lines with prime-ratio base times (ms)
// Size scales delay times: 0.3x (small) to 2.5x (large)
sm = 0.3 + size * 2.2;
sr_ms = 0.001 * samplerate;
t0 = 29.7 * sr_ms * sm;
t1 = 37.1 * sr_ms * sm;
t2 = 41.1 * sr_ms * sm;
t3 = 43.7 * sr_ms * sm;
t4 = 53.0 * sr_ms * sm;
t5 = 59.3 * sr_ms * sm;
t6 = 71.9 * sr_ms * sm;
t7 = 83.0 * sr_ms * sm;

// LFO modulation (8 phases spread evenly)
History ph(0);
new_ph = wrap(ph + modrate / samplerate, 0, 1);
ph = new_ph;
md = moddepth * 16;
l0 = sin(new_ph * TWOPI) * md;
l1 = sin((new_ph + 0.125) * TWOPI) * md;
l2 = sin((new_ph + 0.25) * TWOPI) * md;
l3 = sin((new_ph + 0.375) * TWOPI) * md;
l4 = sin((new_ph + 0.5) * TWOPI) * md;
l5 = sin((new_ph + 0.625) * TWOPI) * md;
l6 = sin((new_ph + 0.75) * TWOPI) * md;
l7 = sin((new_ph + 0.875) * TWOPI) * md;

// Modulated delay times (clamped >= 1 sample)
dt0 = max(t0 + l0, 1);
dt1 = max(t1 + l1, 1);
dt2 = max(t2 + l2, 1);
dt3 = max(t3 + l3, 1);
dt4 = max(t4 + l4, 1);
dt5 = max(t5 + l5, 1);
dt6 = max(t6 + l6, 1);
dt7 = max(t7 + l7, 1);

// Feedback gains from RT60 decay time
rt = max(decay, 0.1);
frz = freeze > 0.5;
df = -3.0 / (samplerate * rt);
g0 = frz ? 1.0 : pow(10, dt0 * df);
g1 = frz ? 1.0 : pow(10, dt1 * df);
g2 = frz ? 1.0 : pow(10, dt2 * df);
g3 = frz ? 1.0 : pow(10, dt3 * df);
g4 = frz ? 1.0 : pow(10, dt4 * df);
g5 = frz ? 1.0 : pow(10, dt5 * df);
g6 = frz ? 1.0 : pow(10, dt6 * df);
g7 = frz ? 1.0 : pow(10, dt7 * df);

// Bloom gain shaping: shorter delays quieter at high bloom
g0 = g0 * (1 - bloom * 0.7);
g1 = g1 * (1 - bloom * 0.6);
g2 = g2 * (1 - bloom * 0.5);
g3 = g3 * (1 - bloom * 0.4);
g4 = g4 * (1 - bloom * 0.3);
g5 = g5 * (1 - bloom * 0.2);
g6 = g6 * (1 - bloom * 0.1);

// 8 FDN delay lines
Delay fd0(16384);
Delay fd1(16384);
Delay fd2(16384);
Delay fd3(16384);
Delay fd4(16384);
Delay fd5(16384);
Delay fd6(16384);
Delay fd7(16384);

r0 = fd0.read(dt0);
r1 = fd1.read(dt1);
r2 = fd2.read(dt2);
r3 = fd3.read(dt3);
r4 = fd4.read(dt4);
r5 = fd5.read(dt5);
r6 = fd6.read(dt6);
r7 = fd7.read(dt7);

// Damping: one-pole LPF in feedback path
History hd0(0);
History hd1(0);
History hd2(0);
History hd3(0);
History hd4(0);
History hd5(0);
History hd6(0);
History hd7(0);
dc = damping;
f0 = r0 * (1 - dc) + hd0 * dc;
f1 = r1 * (1 - dc) + hd1 * dc;
f2 = r2 * (1 - dc) + hd2 * dc;
f3 = r3 * (1 - dc) + hd3 * dc;
f4 = r4 * (1 - dc) + hd4 * dc;
f5 = r5 * (1 - dc) + hd5 * dc;
f6 = r6 * (1 - dc) + hd6 * dc;
f7 = r7 * (1 - dc) + hd7 * dc;
hd0 = f0;
hd1 = f1;
hd2 = f2;
hd3 = f3;
hd4 = f4;
hd5 = f5;
hd6 = f6;
hd7 = f7;

// Apply feedback gains
f0 = f0 * g0;
f1 = f1 * g1;
f2 = f2 * g2;
f3 = f3 * g3;
f4 = f4 * g4;
f5 = f5 * g5;
f6 = f6 * g6;
f7 = f7 * g7;

// Hadamard 8x8 butterfly mixing matrix
// Stage 1
a0 = f0 + f4; a4 = f0 - f4;
a1 = f1 + f5; a5 = f1 - f5;
a2 = f2 + f6; a6 = f2 - f6;
a3 = f3 + f7; a7 = f3 - f7;
// Stage 2
b0 = a0 + a2; b2 = a0 - a2;
b1 = a1 + a3; b3 = a1 - a3;
b4 = a4 + a6; b6 = a4 - a6;
b5 = a5 + a7; b7 = a5 - a7;
// Stage 3
c0 = b0 + b1; c1 = b0 - b1;
c2 = b2 + b3; c3 = b2 - b3;
c4 = b4 + b5; c5 = b4 - b5;
c6 = b6 + b7; c7 = b6 - b7;
// Normalize (1/sqrt(8))
sc = 0.35355339;
c0 = c0 * sc; c1 = c1 * sc;
c2 = c2 * sc; c3 = c3 * sc;
c4 = c4 * sc; c5 = c5 * sc;
c6 = c6 * sc; c7 = c7 * sc;

// Write to delays (mute input when frozen)
inp = frz ? 0 : fdn_in;
fd0.write(c0 + inp);
fd1.write(c1 + inp);
fd2.write(c2 + inp);
fd3.write(c3 + inp);
fd4.write(c4 + inp);
fd5.write(c5 + inp);
fd6.write(c6 + inp);
fd7.write(c7 + inp);

// === OUTPUT ===
// Stereo from FDN (even taps left, odd taps right)
wet_L = (r0 + r2 + r4 + r6) * 0.25;
wet_R = (r1 + r3 + r5 + r7) * 0.25;

// DC blocker
History dcx0(0);
History dcy0(0);
History dcx1(0);
History dcy1(0);
w0 = wet_L - dcx0 + 0.995 * dcy0;
dcx0 = wet_L;
dcy0 = w0;
wet_L = w0;
w1 = wet_R - dcx1 + 0.995 * dcy1;
dcx1 = wet_R;
dcy1 = w1;
wet_R = w1;

// Output EQ: low shelf (200 Hz)
History lsl(0);
History lsr(0);
lc = 1 - exp(-TWOPI * 200 / samplerate);
lsl = lsl + lc * (wet_L - lsl);
lsr = lsr + lc * (wet_R - lsr);
lg = pow(10, eq_low / 20);
wet_L = wet_L + (lg - 1) * lsl;
wet_R = wet_R + (lg - 1) * lsr;

// Output EQ: high shelf (4 kHz)
History hsl(0);
History hsr(0);
hc = 1 - exp(-TWOPI * 4000 / samplerate);
hsl = hsl + hc * (wet_L - hsl);
hsr = hsr + hc * (wet_R - hsr);
hg = pow(10, eq_high / 20);
wet_L = wet_L + (hg - 1) * (wet_L - hsl);
wet_R = wet_R + (hg - 1) * (wet_R - hsr);

// Dry/wet mix
out1 = dry_L * (1 - drywet) + wet_L * drywet;
out2 = dry_R * (1 - drywet) + wet_R * drywet;
"""

# ============================================================
# Title & instructions
# ============================================================

title = p.add_comment('FDNVerb -- 8-Line FDN Reverb', x=50, y=20)
title.extra_attrs["fontsize"] = 16
title.extra_attrs["fontface"] = 1

hint = p.add_comment('Click ezdac~ to enable audio. Use attrui boxes to adjust gen~ params.', x=50, y=45)

# ============================================================
# Audio input
# ============================================================

adc = p.add_box('ezadc~', x=50, y=75)

# ============================================================
# gen~ with FDN codebox
# ============================================================

gen_box, gen_inner = p.add_gen(
    GENEXPR_CODE,
    num_inputs=2,
    num_outputs=2,
    x=250,
    y=400,
)

# Fix gen~ serialization: maxclass must be "newobj" so text field is included
gen_box.maxclass = "newobj"

# Set correct classnamespace for gen~ inner patcher
gen_inner.props["classnamespace"] = "dsp.gen"

# Connect audio input -> gen~
p.add_connection(adc, 0, gen_box, 0)  # L
p.add_connection(adc, 1, gen_box, 1)  # R

# ============================================================
# Parameter controls via attrui (3 rows x 4 columns)
# Each attrui is bound to a gen~ Param attribute
# ============================================================

param_names = [
    # (param_name, row, col)
    ("decay",     0, 0),
    ("predelay",  0, 1),
    ("size",      0, 2),
    ("diffusion", 0, 3),
    ("damping",   1, 0),
    ("modrate",   1, 1),
    ("moddepth",  1, 2),
    ("bloom",     1, 3),
    ("eq_low",    2, 0),
    ("eq_high",   2, 1),
    ("drywet",    2, 2),
    ("freeze",    2, 3),
]

COL_SPACING = 210
ROW_HEIGHT = 40
PARAM_X0 = 50
PARAM_Y0 = 130

# Section headers
p.add_comment('REVERB', x=PARAM_X0, y=PARAM_Y0 - 18)
p.add_comment('MODULATION', x=PARAM_X0, y=PARAM_Y0 + ROW_HEIGHT - 18)
p.add_comment('EQ / MIX', x=PARAM_X0, y=PARAM_Y0 + 2 * ROW_HEIGHT - 18)

for name, row, col in param_names:
    x = PARAM_X0 + col * COL_SPACING
    y = PARAM_Y0 + row * ROW_HEIGHT

    au = p.add_box('attrui', x=x, y=y)
    au.extra_attrs["attr"] = name
    au.extra_attrs["text_width"] = 80.0
    au.patching_rect[2] = 200.0  # wider box for name + value

    # attrui outlet -> gen~ inlet 0 (sets Param via attribute message)
    p.add_connection(au, 0, gen_box, 0)

# ============================================================
# Output chain
# ============================================================

out_y = 470

# Labels
p.add_comment('L', x=250, y=out_y - 15)
p.add_comment('R', x=400, y=out_y - 15)

# Safety gain
gain_L = p.add_box('*~', ['0.5'], x=250, y=out_y)
gain_R = p.add_box('*~', ['0.5'], x=400, y=out_y)

# Meters
meter_L = p.add_box('meter~', x=250, y=out_y + 40)
meter_R = p.add_box('meter~', x=400, y=out_y + 40)

# Output
dac = p.add_box('ezdac~', x=310, y=out_y + 90)

# gen~ -> gain
p.add_connection(gen_box, 0, gain_L, 0)
p.add_connection(gen_box, 1, gain_R, 0)

# gain -> meters
p.add_connection(gain_L, 0, meter_L, 0)
p.add_connection(gain_R, 0, meter_R, 0)

# gain -> dac
p.add_connection(gain_L, 0, dac, 0)
p.add_connection(gain_R, 0, dac, 1)

# ============================================================
# Write patch
# ============================================================

output_path = '/Users/taylorbrook/Dev/MAX/patches/FDNVerb/generated/FDNVerb.maxpat'

# Serialize (skip apply_layout for manual positioning)
patch_dict = p.to_dict()

# Validate
results = validate_patch(patch_dict, db=p.db)

print(f"Validation: {len(results)} results")
for r in results:
    print(f"  {r}")

blocking = [r for r in results if r.level == "error" and not r.auto_fixed]
if blocking:
    print("\nBLOCKING ERRORS:")
    for r in blocking:
        print(f"  {r}")
    sys.exit(1)

# Write to disk
output = Path(output_path)
output.parent.mkdir(parents=True, exist_ok=True)
output.write_text(json.dumps(patch_dict, indent=2))

print(f"\nPatch written to: {output_path}")
print("Done!")
