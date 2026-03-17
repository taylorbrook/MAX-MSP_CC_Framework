"""Generate stutter effect patch."""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from src.maxpat import (
    Patcher, _apply_auto_styling, apply_layout,
    save_patch_roundtrip, validate_patch,
)
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

// Compute blended slice params (rhythmic ↔ chaotic)
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

// Dry/wet output
act = stutter_active > 0.5;
out_L = act ? mix(x_L, stut_L, dry_wet) : x_L;
out_R = act ? mix(x_R, stut_R, dry_wet) : x_R;

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
    p = Patcher()

    # ===== NON-AUDIO =====
    buf = p.add_box("buffer~", ["stutter_buf", "4000", "2"])
    lb = p.add_box("loadbang")
    start_msg = p.add_message("startwindow")

    # ===== INPUT STAGE =====
    adc = p.add_box("adc~")
    sfplay = p.add_box("sfplay~", ["2"])
    sfplay.numoutlets = 3
    sfplay.outlettype = ["signal", "signal", ""]
    sfplay.extra_attrs["loop"] = 1

    sel_L = p.add_box("selector~", ["2"])
    sel_R = p.add_box("selector~", ["2"])

    # ===== GEN~ =====
    gen_stut, _ = p.add_gen(STUTTER_CODE, 2, 4)
    gen_lim, _ = p.add_gen(LIMITER_CODE, 2, 2)

    # ===== OUTPUT =====
    dac = p.add_box("dac~")

    # ===== DISPLAY =====
    wf = p.add_box("waveform~")
    wf.extra_attrs["buffername"] = "stutter_buf"
    wf.patching_rect[2] = 300.0
    wf.patching_rect[3] = 80.0

    snap_s = p.add_box("snapshot~", ["50"])
    snap_s.extra_attrs["active"] = 1
    snap_e = p.add_box("snapshot~", ["50"])
    snap_e.extra_attrs["active"] = 1
    mul_s = p.add_box("*", ["4000."])
    mul_e = p.add_box("*", ["4000."])

    # ===== METERS =====
    in_meter = p.add_box("meter~")
    out_meter = p.add_box("meter~")

    # ===== FILE LOADING =====
    open_btn = p.add_box("textbutton")
    open_btn.extra_attrs["text"] = "Open File"
    open_btn.extra_attrs["mode"] = 0
    opendlg = p.add_box("opendialog")
    file_trig = p.add_box("trigger", ["b", "s"])
    open_prep = p.add_box("prepend", ["open"])
    play_msg = p.add_message("1")

    # ===== UI CONTROLS =====

    # Stutter toggle + LED
    stut_tog = p.add_box("toggle")
    stut_prep = p.add_box("prepend", ["stutter_active"])
    activity_led = p.add_box("led")
    activity_led.extra_attrs["oncolor"] = [0.2, 0.9, 0.2, 1.0]

    # Input source toggle
    in_tog = p.add_box("toggle")
    in_add = p.add_box("+", ["1"])

    # BPM
    bpm_dial = p.add_box("dial")
    bpm_dial.extra_attrs["size"] = 281
    bpm_sc = p.add_box("scale", ["0", "280", "20.", "300."])
    bpm_prep = p.add_box("prepend", ["bpm"])

    # Division
    div_items = []
    for d in DIVISIONS:
        if div_items:
            div_items.append(",")
        div_items.append(d)
    div_menu = p.add_box("umenu")
    div_menu.extra_attrs["items"] = div_items
    div_prep = p.add_box("prepend", ["division"])

    # Slice length
    sl_dial = p.add_box("dial")
    sl_dial.extra_attrs["size"] = 128
    sl_sc = p.add_box("scale", ["0", "127", "0.1", "1."])
    sl_prep = p.add_box("prepend", ["slice_length"])

    # Pitch
    pit_dial = p.add_box("dial")
    pit_dial.extra_attrs["size"] = 128
    pit_sc = p.add_box("scale", ["0", "127", "0.5", "2."])
    pit_prep = p.add_box("prepend", ["pitch"])

    # Reverse
    rev_tog = p.add_box("toggle")
    rev_prep = p.add_box("prepend", ["reverse"])

    # Chaos amount
    ch_dial = p.add_box("dial")
    ch_dial.extra_attrs["size"] = 128
    ch_sc = p.add_box("scale", ["0", "127", "0.", "1."])
    ch_prep = p.add_box("prepend", ["chaos_amount"])

    # Feedback
    fb_dial = p.add_box("dial")
    fb_dial.extra_attrs["size"] = 128
    fb_sc = p.add_box("scale", ["0", "127", "0.", "0.95"])
    fb_prep = p.add_box("prepend", ["feedback"])

    # Dry/wet
    dw_dial = p.add_box("dial")
    dw_dial.extra_attrs["size"] = 128
    dw_sc = p.add_box("scale", ["0", "127", "0.", "1."])
    dw_prep = p.add_box("prepend", ["dry_wet"])

    # ===== PRESENTATION LABELS =====
    def plabel(text, px, py, pw=None):
        c = p.add_comment(text)
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

    # Selectors → gen~ stutter
    p.add_connection(sel_L, 0, gen_stut, 0)
    p.add_connection(sel_R, 0, gen_stut, 1)
    p.add_connection(sel_L, 0, in_meter, 0)

    # Gen~ stutter → limiter
    p.add_connection(gen_stut, 0, gen_lim, 0)
    p.add_connection(gen_stut, 1, gen_lim, 1)

    # Display: gen~ position → waveform~ selection
    p.add_connection(gen_stut, 2, snap_s, 0)
    p.add_connection(gen_stut, 3, snap_e, 0)
    p.add_connection(snap_s, 0, mul_s, 0)
    p.add_connection(snap_e, 0, mul_e, 0)
    p.add_connection(mul_s, 0, wf, 2)
    p.add_connection(mul_e, 0, wf, 3)

    # Limiter → output
    p.add_connection(gen_lim, 0, dac, 0)
    p.add_connection(gen_lim, 1, dac, 1)
    p.add_connection(gen_lim, 0, out_meter, 0)

    # File loading: textbutton → opendialog → trigger → sfplay~
    p.add_connection(open_btn, 0, opendlg, 0)
    p.add_connection(opendlg, 0, file_trig, 0)
    p.add_connection(file_trig, 1, open_prep, 0)   # s (path) fires first
    p.add_connection(file_trig, 0, play_msg, 0)     # b (bang) fires second
    p.add_connection(open_prep, 0, sfplay, 0)
    p.add_connection(play_msg, 0, sfplay, 0)

    # Param controls → gen~ stutter (all to inlet 0)
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

    # ============================================================
    # PRESENTATION MODE
    # ============================================================
    p.props["openinpresentation"] = 1
    p.props["rect"] = [85.0, 104.0, 700.0, 500.0]

    # Top row: toggles + file open
    stut_tog.presentation = True
    stut_tog.presentation_rect = [15.0, 15.0, 30.0, 30.0]
    activity_led.presentation = True
    activity_led.presentation_rect = [55.0, 20.0, 20.0, 20.0]
    in_tog.presentation = True
    in_tog.presentation_rect = [430.0, 15.0, 30.0, 30.0]
    open_btn.presentation = True
    open_btn.presentation_rect = [480.0, 17.0, 90.0, 26.0]

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

    # Control row 2: Chaos, Feedback, Dry/Wet
    ch_dial.presentation = True
    ch_dial.presentation_rect = [100.0, 295.0, 60.0, 60.0]
    fb_dial.presentation = True
    fb_dial.presentation_rect = [280.0, 295.0, 60.0, 60.0]
    dw_dial.presentation = True
    dw_dial.presentation_rect = [460.0, 295.0, 60.0, 60.0]

    # Meters
    in_meter.presentation = True
    in_meter.presentation_rect = [30.0, 415.0, 200.0, 20.0]
    out_meter.presentation = True
    out_meter.presentation_rect = [450.0, 415.0, 200.0, 20.0]

    # ============================================================
    # STYLE, LAYOUT, VALIDATE, SAVE
    # ============================================================
    _apply_auto_styling(p)
    apply_layout(p)

    patch_dict = p.to_dict()
    errors = validate_patch(patch_dict)
    for e in errors:
        print(f"  [{e.level}] {e.message}")

    save_patch_roundtrip(patch_dict, OUT / "stutter.maxpat")
    print(f"Saved {OUT / 'stutter.maxpat'}")

    update_status(BASE, stage="build", progress="initial build complete")


if __name__ == "__main__":
    build()
