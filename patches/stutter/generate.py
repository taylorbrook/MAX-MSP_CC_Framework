"""Generate stutter effect patch."""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from src.maxpat import (
    Patcher, _apply_auto_styling,
    save_patch_roundtrip, validate_patch,
)
from src.maxpat.hooks import write_gendsp
from src.maxpat.project import update_status

BASE = Path(__file__).resolve().parent
OUT = BASE / "generated"

# ================================================================
# GenExpr: Stutter Engine (dual-voice crossfade)
# 2 inputs (L, R), 4 outputs (L, R, slice_start_norm, slice_end_norm)
# ================================================================
STUTTER_CODE = """\
Param stutter_active(0, min=0, max=1);
Param bpm(120, min=20, max=300);
Param division(3, min=0, max=18);
Param slice_length(1, min=0.1, max=1);
Param pitch(1, min=0.5, max=2);
Param reverse(0, min=0, max=1);
Param chaos_amount(0, min=0, max=1);
Param feedback(0, min=0, max=0.95);
Param dry_wet(0.5, min=0, max=1);

Buffer buf("stutter_buf");
Data div_factors(19);

History write_pos(0);
History phase_A(0);
History anchor_A(0);
History slen_A(22050);
History rate_A(1);
History phase_B(0);
History anchor_B(0);
History slen_B(22050);
History rate_B(1);
History env_A(1);
History env_B(0);
History active_voice(0);
History prev_div(-1);
History prev_rev(-1);
History prev_active(-1);
History ch_off(0);
History ch_lscale(1);
History ch_roff(0);
History fb_L(0);
History fb_R(0);
History smooth_act(0);
History init_done(0);

// Initialize division factor lookup table
if (init_done < 0.5) {
    poke(div_factors, 1.0, 0, 0);
    poke(div_factors, 0.6667, 1, 0);
    poke(div_factors, 1.5, 2, 0);
    poke(div_factors, 2.0, 3, 0);
    poke(div_factors, 1.3333, 4, 0);
    poke(div_factors, 3.0, 5, 0);
    poke(div_factors, 4.0, 6, 0);
    poke(div_factors, 2.6667, 7, 0);
    poke(div_factors, 6.0, 8, 0);
    poke(div_factors, 8.0, 9, 0);
    poke(div_factors, 5.3333, 10, 0);
    poke(div_factors, 12.0, 11, 0);
    poke(div_factors, 16.0, 12, 0);
    poke(div_factors, 1.25, 13, 0);
    poke(div_factors, 2.5, 14, 0);
    poke(div_factors, 5.0, 15, 0);
    poke(div_factors, 1.75, 16, 0);
    poke(div_factors, 3.5, 17, 0);
    poke(div_factors, 7.0, 18, 0);
    init_done = 1;
}

x_L = in1;
x_R = in2;
sr = samplerate;
buf_len = dim(buf);

// Crossfade ~5ms
fade_samps = 0.005 * sr;
fade_inc = 1.0 / max(fade_samps, 1);

// Current slice params from BPM + division
div_idx = clamp(floor(division), 0, 18);
factor = peek(div_factors, div_idx, 0);
base_slice = sr * 60.0 / max(bpm, 20) / max(factor, 0.01);
cur_slen = clamp(base_slice * slice_length, 64, buf_len);

cur_rate = pitch;
if (reverse > 0.5) {
    cur_rate = -cur_rate;
}

// Write to circular buffer with feedback
w_L = x_L + feedback * fb_L;
w_R = x_R + feedback * fb_R;
poke(buf, clamp(w_L, -1, 1), write_pos, 0);
poke(buf, clamp(w_R, -1, 1), write_pos, 1);
new_wp = write_pos + 1;
if (new_wp >= buf_len) {
    new_wp = 0;
}
write_pos = new_wp;

// Detect parameter changes for voice swap
swap = 0;
cur_d = floor(division);
cur_r = floor(reverse);
cur_a = floor(stutter_active);
if (cur_d != floor(prev_div)) { swap = 1; }
if (cur_r != floor(prev_rev)) { swap = 1; }
if (cur_a != floor(prev_active)) { swap = 1; }
prev_div = division;
prev_rev = reverse;
prev_active = stutter_active;

// Check loop wrap on active voice
if (swap < 0.5) {
    if (active_voice < 0.5) {
        if (rate_A >= 0 && phase_A >= slen_A) { swap = 1; }
        if (rate_A < 0 && phase_A <= 0) { swap = 1; }
    } else {
        if (rate_B >= 0 && phase_B >= slen_B) { swap = 1; }
        if (rate_B < 0 && phase_B <= 0) { swap = 1; }
    }
}

// Latch chaos values on swap
if (swap > 0.5) {
    ch_off = noise() * 0.5;
    ch_lscale = 0.5 + abs(noise()) * 1.5;
    ch_roff = noise() * 0.5;
}

// Compute blended slice params (rhythmic / chaotic)
rhy_anch = write_pos - cur_slen;
if (rhy_anch < 0) {
    rhy_anch = rhy_anch + buf_len;
}
ch_anch = write_pos + ch_off * buf_len;
ch_sl = cur_slen * ch_lscale;
ch_rt = cur_rate + ch_roff;

new_anch = mix(rhy_anch, ch_anch, chaos_amount);
new_sl = mix(cur_slen, ch_sl, chaos_amount);
new_rt = mix(cur_rate, ch_rt, chaos_amount);
new_anch = wrap(new_anch, 0, buf_len);
new_sl = clamp(new_sl, 64, buf_len);

// Execute voice swap
if (swap > 0.5) {
    ip = 0;
    if (new_rt < 0) {
        ip = new_sl;
    }
    if (active_voice < 0.5) {
        active_voice = 1;
        anchor_B = new_anch;
        slen_B = new_sl;
        rate_B = new_rt;
        phase_B = ip;
    } else {
        active_voice = 0;
        anchor_A = new_anch;
        slen_A = new_sl;
        rate_A = new_rt;
        phase_A = ip;
    }
}

// Update crossfade envelopes
if (active_voice < 0.5) {
    env_A = min(env_A + fade_inc, 1);
    env_B = max(env_B - fade_inc, 0);
} else {
    env_B = min(env_B + fade_inc, 1);
    env_A = max(env_A - fade_inc, 0);
}

// Read from buffer
rp_A = wrap(anchor_A + phase_A, 0, buf_len);
sA_L = peek(buf, rp_A, 0);
sA_R = peek(buf, rp_A, 1);
rp_B = wrap(anchor_B + phase_B, 0, buf_len);
sB_L = peek(buf, rp_B, 0);
sB_R = peek(buf, rp_B, 1);

// Advance phases
phase_A = phase_A + rate_A;
phase_B = phase_B + rate_B;
phase_A = clamp(phase_A, -slen_A * 0.1, slen_A * 1.1);
phase_B = clamp(phase_B, -slen_B * 0.1, slen_B * 1.1);

// Mix voices
stut_L = sA_L * env_A + sB_L * env_B;
stut_R = sA_R * env_A + sB_R * env_B;

// Smooth stutter_active toggle to prevent clicks (~5ms ramp)
act_target = stutter_active > 0.5 ? 1 : 0;
if (smooth_act < act_target) {
    smooth_act = min(smooth_act + fade_inc, act_target);
} else {
    smooth_act = max(smooth_act - fade_inc, act_target);
}

// Dry/wet output with smoothed activation
wet_L = mix(x_L, stut_L, dry_wet);
wet_R = mix(x_R, stut_R, dry_wet);
out_L = mix(x_L, wet_L, smooth_act);
out_R = mix(x_R, wet_R, smooth_act);

fb_L = stut_L;
fb_R = stut_R;

out1 = out_L;
out2 = out_R;

// Display outputs (normalized 0-1 for waveform~ selection)
d_anch = active_voice < 0.5 ? anchor_A : anchor_B;
d_slen = active_voice < 0.5 ? slen_A : slen_B;
out3 = d_anch / max(buf_len, 1);
out4 = wrap(d_anch + d_slen, 0, buf_len) / max(buf_len, 1);"""

# ================================================================
# GenExpr: Brickwall Limiter (stereo linked)
# 2 inputs (L, R), 2 outputs (L, R)
# ================================================================
LIMITER_CODE = """\
Param threshold(0.95, min=0.1, max=1);
History env(0);

x_L = in1;
x_R = in2;
sr = samplerate;

// Release ~50ms
rel = exp(-1.0 / (0.05 * sr));

// Peak detection (linked stereo)
pk = max(abs(x_L), abs(x_R));

// Envelope: instant attack, slow release
if (pk > env) {
    env = pk;
} else {
    env = pk + rel * (env - pk);
}

// Gain reduction
gain = 1.0;
if (env > threshold) {
    gain = threshold / max(env, 0.0001);
}

out1 = x_L * gain;
out2 = x_R * gain;"""

# Division labels for umenu
DIVISIONS = [
    "1/4", "1/4.", "1/4T",
    "1/8", "1/8.", "1/8T",
    "1/16", "1/16.", "1/16T",
    "1/32", "1/32.", "1/32T",
    "1/64",
    "1/4Q", "1/8Q", "1/16Q",
    "1/4S", "1/8S", "1/16S",
]


def build():
    # --- Write standalone .gendsp files ---
    write_gendsp(STUTTER_CODE, OUT / "stutter-engine.gendsp", 2, 4)
    write_gendsp(LIMITER_CODE, OUT / "brickwall-limiter.gendsp", 2, 2)
    print("Wrote stutter-engine.gendsp")
    print("Wrote brickwall-limiter.gendsp")

    p = Patcher()

    # ============================================================
    # COLUMN 1 (x=30): Audio signal chain
    # ============================================================

    buf = p.add_box("buffer~", ["stutter_buf", "4000", "2"], x=30, y=45)

    lb = p.add_box("loadbang", x=220, y=40)
    start_msg = p.add_message("startwindow", x=220, y=67)

    adc = p.add_box("adc~", x=30, y=110)
    sfplay = p.add_box("sfplay~", ["2"], x=200, y=110)
    sfplay.numoutlets = 3
    sfplay.outlettype = ["signal", "signal", ""]
    sfplay.extra_attrs["loop"] = 1

    # Loop toggle for soundfile mode (default ON)
    loop_tog = p.add_box("toggle", x=590, y=110)
    loop_prep = p.add_box("prepend", ["loop"], x=590, y=140)
    loop_init = p.add_box("loadmess", ["1"], x=590, y=85)

    sel_L = p.add_box("selector~", ["2"], x=30, y=165)
    sel_R = p.add_box("selector~", ["2"], x=200, y=165)

    # meter~ is 15x100 tall — position to right of selectors, clear of gen~
    in_meter = p.add_box("meter~", x=370, y=165)

    # gen~ references external .gendsp files
    gen_stut = p.add_box("gen~", ["stutter-engine"], x=30, y=270)
    gen_stut.numinlets = 2
    gen_stut.numoutlets = 4
    gen_stut.outlettype = ["signal"] * 4

    gen_lim = p.add_box("gen~", ["brickwall-limiter"], x=30, y=345)
    gen_lim.numinlets = 2
    gen_lim.numoutlets = 2
    gen_lim.outlettype = ["signal"] * 2

    dac = p.add_box("dac~", x=30, y=405)
    out_meter = p.add_box("meter~", x=200, y=345)

    # ============================================================
    # COLUMN 2 (x=420): Display + file loading
    # ============================================================

    # File loading
    open_btn = p.add_box("textbutton", x=420, y=45)
    open_btn.extra_attrs["text"] = "Open File"
    open_btn.extra_attrs["mode"] = 0
    opendlg = p.add_box("opendialog", x=420, y=70)
    file_trig = p.add_box("trigger", ["b", "s"], x=420, y=100)
    open_prep = p.add_box("prepend", ["open"], x=420, y=130)
    play_msg = p.add_message("1", x=530, y=130)

    # Input source switch
    in_tog = p.add_box("toggle", x=420, y=165)
    in_add = p.add_box("+", ["1"], x=420, y=195)

    # Waveform display chain
    snap_s = p.add_box("snapshot~", ["50"], x=420, y=270)
    snap_s.extra_attrs["active"] = 1
    snap_e = p.add_box("snapshot~", ["50"], x=530, y=270)
    snap_e.extra_attrs["active"] = 1
    mul_s = p.add_box("*", ["4000."], x=420, y=300)
    mul_e = p.add_box("*", ["4000."], x=530, y=300)

    wf = p.add_box("waveform~", x=420, y=340)
    wf.extra_attrs["buffername"] = "stutter_buf"
    wf.patching_rect[2] = 200.0
    wf.patching_rect[3] = 80.0

    # ============================================================
    # COLUMNS 3-5 (x=660, 860, 1060): Parameter controls
    # ============================================================
    CX1, CX2, CX3 = 660, 860, 1060  # control column x positions
    FX1, FX2, FX3 = 780, 980, 1180  # flonum x positions (+120)

    # -- Stutter on/off --
    stut_tog = p.add_box("toggle", x=CX1, y=45)
    stut_prep = p.add_box("prepend", ["stutter_active"], x=CX1, y=75)
    activity_led = p.add_box("led", x=CX1 + 40, y=45)
    activity_led.extra_attrs["oncolor"] = [0.2, 0.9, 0.2, 1.0]

    # -- BPM (col 3, row 1) --
    bpm_dial = p.add_box("dial", x=CX1, y=110)
    bpm_dial.extra_attrs["size"] = 281
    bpm_sc = p.add_box("scale", ["0", "280", "20.", "300."], x=CX1, y=170)
    bpm_prep = p.add_box("prepend", ["bpm"], x=CX1, y=197)

    # -- Division (col 3, row 2) --
    div_items = []
    for d in DIVISIONS:
        if div_items:
            div_items.append(",")
        div_items.append(d)
    div_menu = p.add_box("umenu", x=CX1, y=235)
    div_menu.extra_attrs["items"] = div_items
    div_prep = p.add_box("prepend", ["division"], x=CX1, y=262)

    # -- Slice (col 3, row 3) --
    sl_dial = p.add_box("dial", x=CX1, y=300)
    sl_dial.extra_attrs["size"] = 128
    sl_sc = p.add_box("scale", ["0", "127", "0.1", "1."], x=CX1, y=360)
    sl_prep = p.add_box("prepend", ["slice_length"], x=CX1, y=387)

    # -- Pitch (col 4, row 1) --
    pit_dial = p.add_box("dial", x=CX2, y=110)
    pit_dial.extra_attrs["size"] = 128
    pit_sc = p.add_box("scale", ["0", "127", "0.5", "2."], x=CX2, y=170)
    pit_prep = p.add_box("prepend", ["pitch"], x=CX2, y=197)

    # -- Reverse (col 4, row 2) --
    rev_tog = p.add_box("toggle", x=CX2, y=235)
    rev_prep = p.add_box("prepend", ["reverse"], x=CX2, y=262)

    # -- Chaos (col 4, row 3) --
    ch_dial = p.add_box("dial", x=CX2, y=300)
    ch_dial.extra_attrs["size"] = 128
    ch_sc = p.add_box("scale", ["0", "127", "0.", "1."], x=CX2, y=360)
    ch_prep = p.add_box("prepend", ["chaos_amount"], x=CX2, y=387)

    # -- Feedback (col 5, row 1) --
    fb_dial = p.add_box("dial", x=CX3, y=110)
    fb_dial.extra_attrs["size"] = 128
    fb_sc = p.add_box("scale", ["0", "127", "0.", "0.95"], x=CX3, y=170)
    fb_prep = p.add_box("prepend", ["feedback"], x=CX3, y=197)

    # -- Dry/Wet (col 5, row 3) --
    dw_dial = p.add_box("dial", x=CX3, y=300)
    dw_dial.extra_attrs["size"] = 128
    dw_sc = p.add_box("scale", ["0", "127", "0.", "1."], x=CX3, y=360)
    dw_prep = p.add_box("prepend", ["dry_wet"], x=CX3, y=387)

    # ===== VALUE READOUTS (flonum, display-only) =====
    def make_readout(decimals, x, y):
        fn = p.add_box("flonum", x=x, y=y)
        fn.extra_attrs["cantchange"] = 1
        fn.extra_attrs["numdecimalplaces"] = decimals
        fn.extra_attrs["triangle"] = 0
        fn.extra_attrs["bordercolor"] = [0.5, 0.5, 0.5, 0.0]
        return fn

    bpm_num = make_readout(0, FX1, 170)
    sl_num = make_readout(2, FX1, 360)
    pit_num = make_readout(2, FX2, 170)
    ch_num = make_readout(2, FX2, 360)
    fb_num = make_readout(2, FX3, 170)
    dw_num = make_readout(2, FX3, 360)

    # ===== DIAL DEFAULTS (init from gen~ Param values) =====
    bpm_init = p.add_box("loadmess", ["100"], x=CX1, y=90)
    div_init = p.add_box("loadmess", ["3"], x=CX1, y=215)
    sl_init = p.add_box("loadmess", ["127"], x=CX1, y=280)
    pit_init = p.add_box("loadmess", ["42"], x=CX2, y=90)
    dw_init = p.add_box("loadmess", ["64"], x=CX3, y=280)

    # ===== SECTION LABELS (patching mode) =====
    p.add_section_header("SIGNAL CHAIN", x=30, y=15)
    p.add_section_header("DISPLAY", x=420, y=15)
    p.add_section_header("CONTROLS", x=660, y=15)

    # ===== PRESENTATION LABELS (patching pos offscreen at x=1400) =====
    label_y = [40]  # mutable counter for stacking labels offscreen

    def plabel(text, px, py, pw=None):
        c = p.add_comment(text, x=1400, y=label_y[0])
        label_y[0] += 20
        c.presentation = True
        c.presentation_rect = [px, py, pw or len(text) * 7 + 10, 18]
        c.extra_attrs["textjustification"] = 1
        return c

    plabel("STUTTER", 5, 0, 58)
    plabel("INPUT", 380, 0, 48)
    plabel("BPM", 45, 240, 40)
    plabel("Division", 145, 225, 70)
    plabel("Slice", 290, 240, 45)
    plabel("Pitch", 390, 240, 45)
    plabel("Rev", 495, 225, 35)
    plabel("Chaos", 105, 360, 50)
    plabel("Feedback", 275, 360, 70)
    plabel("Dry/Wet", 460, 360, 60)
    plabel("IN", 120, 435, 25)
    plabel("OUT", 540, 435, 30)
    plabel("Loop", 585, 0, 40)

    # ============================================================
    # CONNECTIONS
    # ============================================================

    # Init: auto-start audio
    p.add_connection(lb, 0, start_msg, 0)
    p.add_connection(start_msg, 0, dac, 0)

    # Input routing (stereo selectors)
    p.add_connection(adc, 0, sel_L, 1)
    p.add_connection(adc, 1, sel_R, 1)
    p.add_connection(sfplay, 0, sel_L, 2)
    p.add_connection(sfplay, 1, sel_R, 2)
    p.add_connection(in_tog, 0, in_add, 0)
    p.add_connection(in_add, 0, sel_L, 0)
    p.add_connection(in_add, 0, sel_R, 0)

    # Selectors -> gen~ stutter
    p.add_connection(sel_L, 0, gen_stut, 0)
    p.add_connection(sel_R, 0, gen_stut, 1)
    p.add_connection(sel_L, 0, in_meter, 0)

    # Gen~ stutter -> limiter
    p.add_connection(gen_stut, 0, gen_lim, 0)
    p.add_connection(gen_stut, 1, gen_lim, 1)

    # Display: gen~ position -> waveform~ selection
    p.add_connection(gen_stut, 2, snap_s, 0)
    p.add_connection(gen_stut, 3, snap_e, 0)
    p.add_connection(snap_s, 0, mul_s, 0)
    p.add_connection(snap_e, 0, mul_e, 0)
    p.add_connection(mul_s, 0, wf, 2)
    p.add_connection(mul_e, 0, wf, 3)

    # Limiter -> output
    p.add_connection(gen_lim, 0, dac, 0)
    p.add_connection(gen_lim, 1, dac, 1)
    p.add_connection(gen_lim, 0, out_meter, 0)

    # File loading: textbutton -> opendialog -> trigger -> sfplay~
    p.add_connection(open_btn, 0, opendlg, 0)
    p.add_connection(opendlg, 0, file_trig, 0)
    p.add_connection(file_trig, 1, open_prep, 0)   # s (path) fires first
    p.add_connection(file_trig, 0, play_msg, 0)     # b (bang) fires second
    p.add_connection(open_prep, 0, sfplay, 0)
    p.add_connection(play_msg, 0, sfplay, 0)

    # Param controls -> gen~ stutter (all to inlet 0)
    p.add_connection(stut_tog, 0, stut_prep, 0)
    p.add_connection(stut_prep, 0, gen_stut, 0)
    p.add_connection(stut_tog, 0, activity_led, 0)

    p.add_connection(bpm_dial, 0, bpm_sc, 0)
    p.add_connection(bpm_sc, 0, bpm_prep, 0)
    p.add_connection(bpm_prep, 0, gen_stut, 0)

    p.add_connection(div_menu, 0, div_prep, 0)
    p.add_connection(div_prep, 0, gen_stut, 0)

    p.add_connection(sl_dial, 0, sl_sc, 0)
    p.add_connection(sl_sc, 0, sl_prep, 0)
    p.add_connection(sl_prep, 0, gen_stut, 0)

    p.add_connection(pit_dial, 0, pit_sc, 0)
    p.add_connection(pit_sc, 0, pit_prep, 0)
    p.add_connection(pit_prep, 0, gen_stut, 0)

    p.add_connection(rev_tog, 0, rev_prep, 0)
    p.add_connection(rev_prep, 0, gen_stut, 0)

    p.add_connection(ch_dial, 0, ch_sc, 0)
    p.add_connection(ch_sc, 0, ch_prep, 0)
    p.add_connection(ch_prep, 0, gen_stut, 0)

    p.add_connection(fb_dial, 0, fb_sc, 0)
    p.add_connection(fb_sc, 0, fb_prep, 0)
    p.add_connection(fb_prep, 0, gen_stut, 0)

    p.add_connection(dw_dial, 0, dw_sc, 0)
    p.add_connection(dw_sc, 0, dw_prep, 0)
    p.add_connection(dw_prep, 0, gen_stut, 0)

    # Value readouts (scale output -> flonum display)
    p.add_connection(bpm_sc, 0, bpm_num, 0)
    p.add_connection(sl_sc, 0, sl_num, 0)
    p.add_connection(pit_sc, 0, pit_num, 0)
    p.add_connection(ch_sc, 0, ch_num, 0)
    p.add_connection(fb_sc, 0, fb_num, 0)
    p.add_connection(dw_sc, 0, dw_num, 0)

    # Dial initialization (loadmess -> dials on patch load)
    p.add_connection(bpm_init, 0, bpm_dial, 0)
    p.add_connection(div_init, 0, div_menu, 0)
    p.add_connection(sl_init, 0, sl_dial, 0)
    p.add_connection(pit_init, 0, pit_dial, 0)
    p.add_connection(dw_init, 0, dw_dial, 0)

    # Loop toggle -> sfplay~
    p.add_connection(loop_init, 0, loop_tog, 0)
    p.add_connection(loop_tog, 0, loop_prep, 0)
    p.add_connection(loop_prep, 0, sfplay, 0)

    # ============================================================
    # PRESENTATION MODE
    # ============================================================
    p.props["openinpresentation"] = 1
    p.props["rect"] = [50.0, 80.0, 1300.0, 520.0]

    # Top row: toggles + file open
    stut_tog.presentation = True
    stut_tog.presentation_rect = [15.0, 15.0, 30.0, 30.0]
    activity_led.presentation = True
    activity_led.presentation_rect = [55.0, 20.0, 20.0, 20.0]
    in_tog.presentation = True
    in_tog.presentation_rect = [430.0, 15.0, 30.0, 30.0]
    open_btn.presentation = True
    open_btn.presentation_rect = [480.0, 17.0, 90.0, 26.0]
    loop_tog.presentation = True
    loop_tog.presentation_rect = [590.0, 17.0, 26.0, 26.0]

    # Waveform display
    wf.presentation = True
    wf.presentation_rect = [15.0, 55.0, 670.0, 100.0]

    # Control row 1: BPM, Division, Slice, Pitch, Reverse
    bpm_dial.presentation = True
    bpm_dial.presentation_rect = [35.0, 175.0, 60.0, 60.0]
    div_menu.presentation = True
    div_menu.presentation_rect = [135.0, 195.0, 110.0, 22.0]
    sl_dial.presentation = True
    sl_dial.presentation_rect = [280.0, 175.0, 60.0, 60.0]
    pit_dial.presentation = True
    pit_dial.presentation_rect = [380.0, 175.0, 60.0, 60.0]
    rev_tog.presentation = True
    rev_tog.presentation_rect = [495.0, 190.0, 30.0, 30.0]

    # Row 1 readouts
    bpm_num.presentation = True
    bpm_num.presentation_rect = [35.0, 258.0, 55.0, 22.0]
    sl_num.presentation = True
    sl_num.presentation_rect = [283.0, 258.0, 55.0, 22.0]
    pit_num.presentation = True
    pit_num.presentation_rect = [383.0, 258.0, 55.0, 22.0]

    # Control row 2: Chaos, Feedback, Dry/Wet
    ch_dial.presentation = True
    ch_dial.presentation_rect = [100.0, 295.0, 60.0, 60.0]
    fb_dial.presentation = True
    fb_dial.presentation_rect = [280.0, 295.0, 60.0, 60.0]
    dw_dial.presentation = True
    dw_dial.presentation_rect = [460.0, 295.0, 60.0, 60.0]

    # Row 2 readouts
    ch_num.presentation = True
    ch_num.presentation_rect = [103.0, 378.0, 55.0, 22.0]
    fb_num.presentation = True
    fb_num.presentation_rect = [283.0, 378.0, 55.0, 22.0]
    dw_num.presentation = True
    dw_num.presentation_rect = [463.0, 378.0, 55.0, 22.0]

    # Meters
    in_meter.presentation = True
    in_meter.presentation_rect = [30.0, 415.0, 200.0, 20.0]
    out_meter.presentation = True
    out_meter.presentation_rect = [450.0, 415.0, 200.0, 20.0]

    # ============================================================
    # STYLE, VALIDATE, SAVE
    # ============================================================
    _apply_auto_styling(p)
    # No apply_layout() -- positions are set explicitly above

    patch_dict = p.to_dict()
    errors = validate_patch(patch_dict)
    for e in errors:
        print(f"  [{e.level}] {e.message}")

    save_patch_roundtrip(patch_dict, OUT / "stutter.maxpat")
    print(f"Saved {OUT / 'stutter.maxpat'}")

    update_status(BASE, stage="build", progress="v2 - clean layout + external gendsp")


if __name__ == "__main__":
    build()
