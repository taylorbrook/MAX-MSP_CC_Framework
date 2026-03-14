#!/usr/bin/env python3
"""Build kicksynth Phase 5: Presets + polished layout.

Layout matches manual cleanup. Adds preset umenu with 808/909/Techno/Trap styles.
"""

import sys
sys.path.insert(0, '.')

from src.maxpat import Patcher, write_patch, ObjectDatabase
from src.maxpat.patcher import Box
from src.maxpat.defaults import FONT_NAME, FONT_SIZE, FONTFACE_BOLD

db = ObjectDatabase()
p = Patcher(db=db)

p.props["openinpresentation"] = 1
p.props["rect"] = [34.0, 104.0, 1333.0, 580.0]

LABEL_COLOR = [0.08, 0.08, 0.12, 1.0]

# ============================================================
# HELPERS
# ============================================================

def set_pres(box, x, y, w=None, h=None):
    box.presentation = True
    pw = w if w is not None else box.patching_rect[2]
    ph = h if h is not None else box.patching_rect[3]
    box.presentation_rect = [float(x), float(y), float(pw), float(ph)]

def pres_panel(x, y, w, h):
    panel = p.add_panel(0, 0, w, h)
    set_pres(panel, x, y, w, h)
    return panel

def pres_title(text, x, y, w=80):
    c = p.add_comment(text)
    c.fontsize = 11.0
    c.extra_attrs["fontface"] = FONTFACE_BOLD
    c.extra_attrs["textcolor"] = [0.05, 0.05, 0.15, 1.0]
    set_pres(c, x, y, w, 19)
    return c

def pres_label(text, x, y, w=68, h=20, bold=False):
    c = p.add_comment(text)
    c.extra_attrs["textcolor"] = list(LABEL_COLOR)
    if bold:
        c.extra_attrs["fontface"] = FONTFACE_BOLD
    set_pres(c, x, y, w, h)
    return c

def add_param(label_text, param_name, default_val, gen_target, lx, ly, lw=68, nw=52):
    lm = p.add_box("loadmess", [default_val])
    fnum = p.add_box("flonum")
    fnum.extra_attrs["varname"] = param_name  # scripting name for pattrstorage
    lbl = p.add_comment(label_text)
    lbl.extra_attrs["textcolor"] = list(LABEL_COLOR)
    prep = p.add_box("prepend", [param_name])
    p.add_connection(lm, 0, fnum, 0)
    p.add_connection(fnum, 0, prep, 0)
    p.add_connection(prep, 0, gen_target, 0)
    set_pres(lbl, lx, ly, lw, 20)
    set_pres(fnum, lx + lw + 2, ly - 2, nw, 22)
    return (fnum, prep)

# ============================================================
# PANELS (matching manual cleanup layout)
# ============================================================

pres_panel(5, 28, 67, 250)      # TRIGGER
pres_panel(78, 28, 162, 250)    # BODY
pres_panel(245, 28, 230, 118)   # PITCH ENV
pres_panel(245, 151, 230, 127)  # AMP ENV
pres_panel(480, 28, 137, 118)   # SUB
pres_panel(480, 152, 137, 126)  # NOISE
pres_panel(623, 28, 155, 118)   # CLICK
pres_panel(623, 152, 155, 126)  # KICK SYNTH logo
pres_panel(787, 28, 163, 250)   # MASTER
pres_panel(5, 283, 945, 128)    # OUTPUT

# ============================================================
# TRIGGER
# ============================================================

pres_title("TRIGGER", 9, 43, 59)

btn = p.add_box("button")
set_pres(btn, 13, 67, 50, 50)
p.add_annotation("click or MIDI", target=btn)

notein_obj = p.add_box("notein")
stripnote_obj = p.add_box("stripnote")
trig_b = p.add_box("trigger", ["b"])
click_obj = p.add_box("click~")

p.add_connection(notein_obj, 0, stripnote_obj, 0)
p.add_connection(notein_obj, 1, stripnote_obj, 1)
p.add_connection(stripnote_obj, 0, trig_b, 0)
p.add_connection(trig_b, 0, click_obj, 0)
p.add_connection(btn, 0, click_obj, 0)

# Preset umenu (in trigger panel, below button)
umenu = p.add_box("umenu")
umenu.extra_attrs["items"] = ["Default", ",", "808", ",", "909", ",", "Techno", ",", "Trap"]
set_pres(umenu, 9, 130, 57, 22)

# ============================================================
# GEN~ KICK ENGINE
# ============================================================

kick_code = """\
Param pitch_start(300, min=50, max=1000);
Param pitch_end(50, min=20, max=200);
Param pitch_decay(30, min=1, max=500);
Param amp_decay(200, min=10, max=2000);
Param pitch_curve(0.3, min=0.01, max=1);
Param amp_curve(0.15, min=0.01, max=1);
Param body_level(1, min=0, max=1);
Param click_level(0.5, min=0, max=1);
Param click_decay(2, min=0.1, max=20);
Param click_tone(3000, min=200, max=12000);
Param sub_level(0.5, min=0, max=1);
Param sub_decay(300, min=10, max=2000);
Param noise_level(0.3, min=0, max=1);
Param noise_decay(5, min=0.5, max=100);
Param noise_tone(4000, min=200, max=12000);

History phase(0);
History pitch_env(0);
History amp_env(0);
History prev_trig(0);
History click_env(0);
History click_lp(0);
History sub_phase(0);
History sub_env(0);
History noise_env(0);
History noise_lp(0);

trig = in1;
trig_on = (trig > 0) && (prev_trig <= 0);
prev_trig = trig;

if (trig_on) {
    pitch_env = 1.0;
    amp_env = 1.0;
    click_env = 1.0;
    sub_env = 1.0;
    noise_env = 1.0;
    phase = 0;
    sub_phase = 0;
}

pitch_samples = max(pitch_decay * 0.001 * samplerate, 1);
pitch_coeff = exp(-1.0 / (pitch_samples * pitch_curve));
pitch_env *= pitch_coeff;
amp_samples = max(amp_decay * 0.001 * samplerate, 1);
amp_coeff = exp(-1.0 / (amp_samples * amp_curve));
amp_env *= amp_coeff;
freq = pitch_end + (pitch_start - pitch_end) * pitch_env;
phase += freq / samplerate;
phase -= floor(phase);
body = sin(phase * TWOPI) * amp_env * body_level;

click_samples = max(click_decay * 0.001 * samplerate, 1);
click_coeff = exp(-1.0 / click_samples);
click_env *= click_coeff;
click_alpha = min(TWOPI * click_tone / samplerate, 1);
click_noise = noise();
click_lp = click_lp + click_alpha * (click_noise - click_lp);
click_out = (trig_on + click_lp * click_env) * click_level;

sub_samples = max(sub_decay * 0.001 * samplerate, 1);
sub_coeff = exp(-1.0 / sub_samples);
sub_env *= sub_coeff;
sub_phase += pitch_end / samplerate;
sub_phase -= floor(sub_phase);
sub = sin(sub_phase * TWOPI) * sub_env * sub_level;

noise_samples = max(noise_decay * 0.001 * samplerate, 1);
noise_coeff = exp(-1.0 / noise_samples);
noise_env *= noise_coeff;
noise_alpha = min(TWOPI * noise_tone / samplerate, 1);
noise_raw = noise();
noise_lp = noise_lp + noise_alpha * (noise_raw - noise_lp);
noise_out = noise_lp * noise_env * noise_level;

out1 = body + click_out + sub + noise_out;
"""

kick_gen, _ = p.add_gen(kick_code, num_inputs=1, num_outputs=1)
p.add_connection(click_obj, 0, kick_gen, 0)

# ============================================================
# GEN~ MASTER CHAIN
# ============================================================

master_code = """\
Param drive(1, min=1, max=20);
Param hp_freq(30, min=20, max=200);
Param eq_low_freq(80, min=40, max=200);
Param eq_low_gain(0, min=-12, max=12);
Param eq_mid_freq(300, min=100, max=800);
Param eq_mid_gain(0, min=-12, max=12);
Param lim_ceil(0, min=-20, max=0);
Param lim_release(10, min=1, max=100);

History hp_s1(0);
History hp_s2(0);
History ls_s1(0);
History ls_s2(0);
History pk_s1(0);
History pk_s2(0);
History peak_env(0);

sig = in1;

tanh_drive = tanh(drive);
sig = tanh(drive * sig) / max(tanh_drive, 0.001);

w0_hp = TWOPI * hp_freq / samplerate;
sin_hp = sin(w0_hp);
cos_hp = cos(w0_hp);
alpha_hp = sin_hp / 1.4142;
hp_b0 = (1 + cos_hp) * 0.5 / (1 + alpha_hp);
hp_b1 = -(1 + cos_hp) / (1 + alpha_hp);
hp_b2 = (1 + cos_hp) * 0.5 / (1 + alpha_hp);
hp_a1 = -2 * cos_hp / (1 + alpha_hp);
hp_a2 = (1 - alpha_hp) / (1 + alpha_hp);
hp_y = hp_b0 * sig + hp_s1;
hp_s1 = hp_b1 * sig - hp_a1 * hp_y + hp_s2;
hp_s2 = hp_b2 * sig - hp_a2 * hp_y;
sig = hp_y;

ls_A = pow(10, eq_low_gain / 40);
w0_ls = TWOPI * eq_low_freq / samplerate;
sin_ls = sin(w0_ls);
cos_ls = cos(w0_ls);
sqrt_ls = sqrt(max(ls_A, 0.001));
alpha_ls = sin_ls / 1.4142;
ls_a0 = (ls_A+1) + (ls_A-1)*cos_ls + 2*sqrt_ls*alpha_ls;
ls_b0 = ls_A * ((ls_A+1) - (ls_A-1)*cos_ls + 2*sqrt_ls*alpha_ls) / ls_a0;
ls_b1 = 2*ls_A * ((ls_A-1) - (ls_A+1)*cos_ls) / ls_a0;
ls_b2 = ls_A * ((ls_A+1) - (ls_A-1)*cos_ls - 2*sqrt_ls*alpha_ls) / ls_a0;
ls_a1 = -2 * ((ls_A-1) + (ls_A+1)*cos_ls) / ls_a0;
ls_a2 = ((ls_A+1) + (ls_A-1)*cos_ls - 2*sqrt_ls*alpha_ls) / ls_a0;
ls_y = ls_b0 * sig + ls_s1;
ls_s1 = ls_b1 * sig - ls_a1 * ls_y + ls_s2;
ls_s2 = ls_b2 * sig - ls_a2 * ls_y;
sig = ls_y;

pk_A = pow(10, eq_mid_gain / 40);
w0_pk = TWOPI * eq_mid_freq / samplerate;
sin_pk = sin(w0_pk);
cos_pk = cos(w0_pk);
alpha_pk = sin_pk * 0.5;
pk_a0 = 1 + alpha_pk / max(pk_A, 0.001);
pk_b0 = (1 + alpha_pk * pk_A) / pk_a0;
pk_b1 = (-2 * cos_pk) / pk_a0;
pk_b2 = (1 - alpha_pk * pk_A) / pk_a0;
pk_a1 = (-2 * cos_pk) / pk_a0;
pk_a2 = (1 - alpha_pk / max(pk_A, 0.001)) / pk_a0;
pk_y = pk_b0 * sig + pk_s1;
pk_s1 = pk_b1 * sig - pk_a1 * pk_y + pk_s2;
pk_s2 = pk_b2 * sig - pk_a2 * pk_y;
sig = pk_y;

lim_thresh = pow(10, lim_ceil / 20);
rel_coeff = exp(-1.0 / max(lim_release * 0.001 * samplerate, 1));
abs_sig = abs(sig);
if (abs_sig > peak_env) {
    peak_env = abs_sig;
} else {
    peak_env = abs_sig + rel_coeff * (peak_env - abs_sig);
}
lim_gain = (peak_env > lim_thresh) ? lim_thresh / peak_env : 1;
out1 = sig * lim_gain;
"""

master_gen, _ = p.add_gen(master_code, num_inputs=1, num_outputs=1)
p.add_connection(kick_gen, 0, master_gen, 0)

# ============================================================
# PRESET JS
# ============================================================

preset_js, _ = p.add_js("presets.js", num_inlets=1, num_outlets=2)
p.add_connection(umenu, 0, preset_js, 0)
# preset_js outlets connect to route objects below (NOT directly to gen~)

# ============================================================
# ENVELOPE DISPLAY
# ============================================================

env_js, _ = p.add_js("env-display.js", num_inlets=1, num_outlets=2)

pitch_func = p.add_box("function")
pitch_func.extra_attrs["mode"] = 0
set_pres(pitch_func, 250, 50, 220, 100)

amp_func = p.add_box("function")
amp_func.extra_attrs["mode"] = 0
set_pres(amp_func, 250, 168, 220, 100)

p.add_connection(env_js, 0, pitch_func, 0)
p.add_connection(env_js, 1, amp_func, 0)

pres_label("PITCH ENVELOPE", 253, 33, 130, 20, bold=True)
pres_label("AMP ENVELOPE", 253, 156, 130, 20, bold=True)

# ============================================================
# PARAMETERS (positions match manual cleanup)
# Preset recall flows: preset_js -> route -> flonum -> prepend -> gen~
# This ensures flonums always show the current value.
# ============================================================

# Collect flonums in param-name order for route connections
kick_flonums = []   # (param_name, flonum_box)
master_flonums = [] # (param_name, flonum_box)

# -- BODY --
pres_title("BODY", 95, 43, 80)

body_defs = [
    ("Start Hz",   "pitch_start", "300",  95, 67),
    ("End Hz",     "pitch_end",   "50",   95, 91),
    ("P.Decay ms", "pitch_decay", "30",   95, 115),
    ("A.Decay ms", "amp_decay",   "200",  95, 139),
    ("P.Curve",    "pitch_curve", "0.3",  95, 163),
    ("A.Curve",    "amp_curve",   "0.15", 95, 187),
    ("Level",      "body_level",  "1",    95, 211),
]
for label, pname, val, lx, ly in body_defs:
    fnum, prep = add_param(label, pname, val, kick_gen, lx, ly, 68, 52)
    p.add_connection(prep, 0, env_js, 0)
    kick_flonums.append((pname, fnum))

# -- SUB --
pres_title("SUB", 488, 43, 80)

sub_defs = [
    ("Level",    "sub_level", "0.5", 488, 65),
    ("Decay ms", "sub_decay", "300", 488, 86),
]
for label, pname, val, lx, ly in sub_defs:
    fnum, prep = add_param(label, pname, val, kick_gen, lx, ly, 62, 50)
    kick_flonums.append((pname, fnum))

# -- NOISE --
pres_title("NOISE", 488, 164, 80)

noise_defs = [
    ("Level",    "noise_level", "0.3",  488, 186),
    ("Decay ms", "noise_decay", "5",    488, 208),
    ("Tone Hz",  "noise_tone",  "4000", 488, 228),
]
for label, pname, val, lx, ly in noise_defs:
    fnum, prep = add_param(label, pname, val, kick_gen, lx, ly, 62, 50)
    kick_flonums.append((pname, fnum))

# -- CLICK --
pres_title("CLICK", 638, 43, 80)

click_defs = [
    ("Level",    "click_level", "0.5",  638, 65),
    ("Decay ms", "click_decay", "2",    638, 86),
    ("Tone Hz",  "click_tone",  "3000", 638, 107),
]
for label, pname, val, lx, ly in click_defs:
    fnum, prep = add_param(label, pname, val, kick_gen, lx, ly, 62, 50)
    kick_flonums.append((pname, fnum))

# -- KICK SYNTH logo --
logo = p.add_comment("KICK\nSYNTH")
logo.fontsize = 16.0
logo.extra_attrs["fontface"] = FONTFACE_BOLD
logo.extra_attrs["textcolor"] = [0.35, 0.35, 0.5, 1.0]
set_pres(logo, 630, 176, 140, 60)

# -- MASTER --
pres_title("MASTER", 805, 43, 80)

master_defs = [
    ("Drive",       "drive",       "1",   805, 67),
    ("HP Hz",       "hp_freq",     "30",  805, 91),
    ("Lo Freq Hz",  "eq_low_freq", "80",  805, 115),
    ("Lo Gain dB",  "eq_low_gain", "0",   805, 139),
    ("Mid Freq Hz", "eq_mid_freq", "300", 805, 164),
    ("Mid Gain dB", "eq_mid_gain", "0",   805, 188),
    ("Ceiling dB",  "lim_ceil",    "0",   805, 212),
    ("Release ms",  "lim_release", "10",  805, 236),
]
for label, pname, val, lx, ly in master_defs:
    fnum, prep = add_param(label, pname, val, master_gen, lx, ly, 68, 52)
    master_flonums.append((pname, fnum))

# ============================================================
# PRESET ROUTING: preset_js -> route -> flonums
# Route splits named messages (e.g., "pitch_start 300") to the
# matching flonum. The flonum updates its display AND outputs
# the value through prepend -> gen~ as normal.
# ============================================================

# Kick params route
kick_route_args = [pname for pname, _ in kick_flonums]
kick_route = p.add_box("route", kick_route_args)
p.add_connection(preset_js, 0, kick_route, 0)
for i, (_, fnum) in enumerate(kick_flonums):
    p.add_connection(kick_route, i, fnum, 0)

# Master params route
master_route_args = [pname for pname, _ in master_flonums]
master_route = p.add_box("route", master_route_args)
p.add_connection(preset_js, 1, master_route, 0)
for i, (_, fnum) in enumerate(master_flonums):
    p.add_connection(master_route, i, fnum, 0)

# ============================================================
# USER PRESETS: pattrstorage + autopattr
# autopattr discovers all flonums by varname.
# pattrstorage saves/recalls snapshots of all param values.
# ============================================================

autopattr_obj = p.add_box("autopattr")
pattstorage = p.add_box("pattrstorage", ["kicksynth"])
# savemode 2 = save presets inside the .maxpat file
pattstorage.extra_attrs["saved_attribute_attributes"] = {
    "valueof": {
        "parameter_invisible": 1,
        "parameter_longname": "kicksynth",
        "parameter_shortname": "kicksynth",
        "parameter_type": 3,
    }
}

# Slot selector (number box, 1-32)
slot_num = p.add_box("number")
slot_num.extra_attrs["minimum"] = 1
slot_num.extra_attrs["maximum"] = 32
set_pres(slot_num, 9, 168, 57, 22)
pres_label("Slot", 9, 155, 57, 14)

# Recall button: bang -> int (outputs stored slot) -> prepend recall -> pattrstorage
recall_btn = p.add_box("button")
set_pres(recall_btn, 9, 196, 22, 22)
pres_label("Load", 33, 198, 35, 16)

recall_int = p.add_box("int")
p.add_connection(slot_num, 0, recall_int, 1)    # cold inlet: stores slot silently
p.add_connection(recall_btn, 0, recall_int, 0)  # hot inlet: bang outputs stored value

recall_prep = p.add_box("prepend", ["recall"])
p.add_connection(recall_int, 0, recall_prep, 0)
p.add_connection(recall_prep, 0, pattstorage, 0)

# Store button: bang -> int (outputs stored slot) -> prepend store -> pattrstorage
store_btn = p.add_box("button")
set_pres(store_btn, 9, 222, 22, 22)
pres_label("Save", 33, 224, 35, 16)

store_int = p.add_box("int")
p.add_connection(slot_num, 0, store_int, 1)     # cold inlet: stores slot silently
p.add_connection(store_btn, 0, store_int, 0)    # hot inlet: bang outputs stored value

store_prep = p.add_box("prepend", ["store"])
p.add_connection(store_int, 0, store_prep, 0)
p.add_connection(store_prep, 0, pattstorage, 0)

# Write: save presets to external file
write_msg = p.add_message("writeagain")
set_pres(write_msg, 9, 250, 57, 22)
p.add_connection(write_msg, 0, pattstorage, 0)

# ============================================================
# OUTPUT (positions match manual cleanup)
# ============================================================

pres_label("OUTPUT", 13, 289, 52, 31, bold=True)

gain_obj = p.add_box("gain~")
set_pres(gain_obj, 13, 307, 52, 92)
p.add_connection(master_gen, 0, gain_obj, 0)

# live.scope~
scope = Box.__new__(Box)
scope.name = "live.scope~"
scope.args = []
scope.id = p._gen_id()
scope.maxclass = "live.scope~"
scope.text = ""
scope.numinlets = 2
scope.numoutlets = 0
scope.outlettype = []
scope.patching_rect = [0.0, 0.0, 280.0, 90.0]
scope.fontname = FONT_NAME
scope.fontsize = FONT_SIZE
scope.presentation = True
scope.presentation_rect = [78.0, 309.0, 280.0, 90.0]
scope.target_id = None
scope.extra_attrs = {"parameter_enable": 0, "calccount": 128}
scope._inner_patcher = None
scope._saved_object_attributes = None
scope._bpatcher_attrs = None
p.boxes.append(scope)
p.add_connection(gain_obj, 0, scope, 0)

# spectroscope~
spectro = p.add_box("spectroscope~")
set_pres(spectro, 388, 309, 280, 90)
p.add_connection(gain_obj, 0, spectro, 0)

# levelmeter~
lvlmeter = p.add_box("levelmeter~")
set_pres(lvlmeter, 692, 309, 179, 90)
p.add_connection(gain_obj, 0, lvlmeter, 0)

# ezdac~
dac = p.add_box("ezdac~")
set_pres(dac, 883, 333, 42, 42)
p.add_connection(gain_obj, 0, dac, 0)
p.add_connection(gain_obj, 0, dac, 1)

# ============================================================
# TITLE
# ============================================================

title = p.add_comment("KICKSYNTH")
title.fontsize = 14.0
title.extra_attrs["fontface"] = FONTFACE_BOLD
title.extra_attrs["textcolor"] = [0.05, 0.05, 0.15, 1.0]
set_pres(title, 10, 5, 150, 22)

# ============================================================
# GENERATE
# ============================================================
results = write_patch(p, "patches/kicksynth/generated/kicksynth.maxpat")

warnings = [r for r in results if r.level == "warning"]
errors = [r for r in results if r.level == "error"]

if errors:
    print(f"\nERRORS ({len(errors)}):")
    for r in errors:
        print(f"  - {r.message}")
if warnings:
    print(f"\nWARNINGS ({len(warnings)}):")
    for r in warnings:
        print(f"  - {r.message}")

print(f"\nGeneration complete: {len(errors)} errors, {len(warnings)} warnings")
print("Output: patches/kicksynth/generated/kicksynth.maxpat")
