#!/usr/bin/env python3
"""Generate performancepatchtest.maxpat — Performance patch for instrument + live electronics.

Architecture:
  - All subpatchers communicate via named send~/receive~ buses (no signal inlets/outlets needed)
  - Mixer gain~/meter~ objects live in main patcher for presentation mode visibility
  - Cue system uses coll + unpack to route parameters via send/receive

Audio buses (send~/receive~):
  live-input    : adc~ mono input
  proc-out      : post-EQ/comp processed signal
  delay-ret     : feedback delay return
  dist-ret      : distortion return
  detune-ret    : detune (freq shift) return
  sfplay-ret    : summed soundfile playback

Control buses (send/receive):
  next-cue         : bang to advance cue
  cue-number       : current cue number display
  delay-send-lvl   : delay effect send level (0.-1.)
  dist-send-lvl    : distortion effect send level
  detune-send-lvl  : detune effect send level
  delay-time       : delay time in ms
  delay-fb         : delay feedback amount (0.-0.95)
  dist-drive       : overdrive~ drive factor
  detune-amt       : freqshift~ Hz offset
  sfplay-N-trigger : soundfile trigger (filename or "none")
"""

import sys
sys.path.insert(0, ".")

from pathlib import Path
from src.maxpat import Patcher, write_patch
from src.maxpat.patcher import Box
from src.maxpat.db_lookup import ObjectDatabase
from src.maxpat.sizing import calculate_box_size
from src.maxpat.defaults import FONT_NAME, FONT_SIZE

OUTPUT = Path("patches/performancepatchtest/generated/performancepatchtest.maxpat")


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def make_sfplay_stereo(patcher, x=0.0, y=0.0):
    """Create sfplay~ 2 with correct 3 outlets (L, R, done-bang).
    DB reports only 2 outlets; stereo mode adds an extra audio outlet.
    """
    box = Box.__new__(Box)
    box_id = patcher._gen_id()
    box.name = "sfplay~"
    box.args = ["2"]
    box.id = box_id
    box.maxclass = "newobj"
    box.text = "sfplay~ 2"
    box.numinlets = 2
    box.numoutlets = 3
    box.outlettype = ["signal", "signal", "bang"]
    w, h = calculate_box_size("sfplay~ 2", "newobj")
    box.patching_rect = [x, y, w, h]
    box.fontname = FONT_NAME
    box.fontsize = FONT_SIZE
    box.presentation = False
    box.presentation_rect = None
    box.extra_attrs = {}
    box._inner_patcher = None
    box._saved_object_attributes = None
    box._bpatcher_attrs = None
    patcher.boxes.append(box)
    return box


def smooth_receive(patcher, bus_name, ramp_ms="50"):
    """Create: receive <bus> → message '$1 <ramp>' → line~ — returns line~ box."""
    rcv = patcher.add_box("receive", [bus_name])
    msg = patcher.add_message(f"$1 {ramp_ms}")
    ln = patcher.add_box("line~")
    patcher.add_connection(rcv, 0, msg, 0)
    patcher.add_connection(msg, 0, ln, 0)
    return ln


# ---------------------------------------------------------------------------
# Build
# ---------------------------------------------------------------------------

db = ObjectDatabase()
main = Patcher(db=db)
main.props["rect"] = [85, 104, 900, 750]
main.props["openinpresentation"] = 1

# ===== TOP: Audio Input =====
main.add_comment("PERFORMANCE PATCH", x=30, y=15)
main.add_comment("Audio buses via send~/receive~ — see subpatchers for details", x=30, y=35)

adc = main.add_box("adc~", ["1"], x=200, y=60)
snd_live = main.add_box("send~", ["live-input"], x=200, y=100)
main.add_connection(adc, 0, snd_live, 0)


# ===========================================================================
# p input-processing  (EQ → 3-band multiband compressor)
# ===========================================================================
ip_box, ip = main.add_subpatcher("input-processing", inlets=0, outlets=0, x=30, y=150)

rcv_live = ip.add_box("receive~", ["live-input"])

# -- Parametric EQ: filtergraph~ → cascade~ --
ip.add_comment("--- PARAMETRIC EQ ---")
fg = ip.add_box("filtergraph~")
casc = ip.add_box("cascade~")
ip.add_connection(rcv_live, 0, casc, 0)       # audio → cascade~ inlet 0
ip.add_connection(fg, 0, casc, 1)              # coefficients → cascade~ inlet 1 (cold)

# -- 3-Band Multiband Compressor --
ip.add_comment("--- 3-BAND MULTIBAND COMPRESSOR ---")

# Low / mid+high split at 300 Hz
svf_lo = ip.add_box("svf~", ["300", "0.5"])
ip.add_connection(casc, 0, svf_lo, 0)

# Low band → compress
comp_lo = ip.add_box("omx.comp~")
ip.add_connection(svf_lo, 0, comp_lo, 0)       # LP (outlet 0)

# Mid / high split at 3000 Hz
svf_hi = ip.add_box("svf~", ["3000", "0.5"])
ip.add_connection(svf_lo, 1, svf_hi, 0)        # HP of low crossover (outlet 1)

comp_mid = ip.add_box("omx.comp~")
ip.add_connection(svf_hi, 0, comp_mid, 0)       # LP of high crossover → mid

comp_hi = ip.add_box("omx.comp~")
ip.add_connection(svf_hi, 1, comp_hi, 0)        # HP of high crossover → high

# Sum bands
sum1 = ip.add_box("+~")
ip.add_connection(comp_lo, 0, sum1, 0)
ip.add_connection(comp_mid, 0, sum1, 1)
sum2 = ip.add_box("+~")
ip.add_connection(sum1, 0, sum2, 0)
ip.add_connection(comp_hi, 0, sum2, 1)

# Output processed signal
snd_proc = ip.add_box("send~", ["proc-out"])
ip.add_connection(sum2, 0, snd_proc, 0)


# ===========================================================================
# p cue-system  (coll-based cue list + MIDI trigger)
# ===========================================================================
cue_box, cue = main.add_subpatcher("cue-system", inlets=0, outlets=0, x=200, y=150)

# -- MIDI Trigger --
cue.add_comment("--- MIDI TRIGGER (note 64 = next cue) ---")
ni = cue.add_box("notein")
sn = cue.add_box("stripnote")
cue.add_connection(ni, 1, sn, 1)               # velocity → cold inlet FIRST
cue.add_connection(ni, 0, sn, 0)               # pitch → hot inlet
sel64 = cue.add_box("select", ["64"])
cue.add_connection(sn, 0, sel64, 0)

# -- Manual Trigger --
cue.add_comment("--- MANUAL TRIGGER ---")
rcv_next = cue.add_box("receive", ["next-cue"])

# -- Counter --
cntr = cue.add_box("counter", ["0", "1", "99"])
cue.add_connection(sel64, 0, cntr, 0)           # MIDI trigger → increment
cue.add_connection(rcv_next, 0, cntr, 0)        # manual trigger → increment

# Broadcast cue number
snd_cue_num = cue.add_box("send", ["cue-number"])
cue.add_connection(cntr, 0, snd_cue_num, 0)

# -- Cue Data --
cue.add_comment("--- CUE DATA (coll) ---")
cue_coll = cue.add_box("coll", ["cue-data"])
cue.add_connection(cntr, 0, cue_coll, 0)

# Loadbang → read cue file
lb = cue.add_box("loadbang")
read_msg = cue.add_message("read cue-data.txt")
cue.add_connection(lb, 0, read_msg, 0)
cue.add_connection(read_msg, 0, cue_coll, 0)

# -- Unpack & Route Parameters --
cue.add_comment("delay_send dist_send det_send del_time del_fb dist_drv det_amt sf1 sf2 sf3")
unp = cue.add_box("unpack", ["f", "f", "f", "f", "f", "f", "f", "s", "s", "s"])
cue.add_connection(cue_coll, 0, unp, 0)

send_names = [
    "delay-send-lvl", "dist-send-lvl", "detune-send-lvl",
    "delay-time", "delay-fb", "dist-drive", "detune-amt",
    "sfplay-1-trigger", "sfplay-2-trigger", "sfplay-3-trigger",
]
for i, sname in enumerate(send_names):
    s = cue.add_box("send", [sname])
    cue.add_connection(unp, i, s, 0)


# ===========================================================================
# p feedback-delay
# ===========================================================================
dly_box, dly = main.add_subpatcher("feedback-delay", inlets=0, outlets=0, x=400, y=150)
dly.add_comment("--- FEEDBACK DELAY ---")

rcv_proc_d = dly.add_box("receive~", ["proc-out"])

# Send level (smoothed)
ln_dsl = smooth_receive(dly, "delay-send-lvl")
mul_send_d = dly.add_box("*~")
dly.add_connection(rcv_proc_d, 0, mul_send_d, 0)
dly.add_connection(ln_dsl, 0, mul_send_d, 1)

# Input + feedback sum → tapin~
mix_in = dly.add_box("+~")
dly.add_connection(mul_send_d, 0, mix_in, 0)

tapin = dly.add_box("tapin~", ["5000"])
dly.add_connection(mix_in, 0, tapin, 0)

tapout = dly.add_box("tapout~", ["500"])
dly.add_connection(tapin, 0, tapout, 0)

# Delay time from cue (float → tapout~ inlet 0)
rcv_dt = dly.add_box("receive", ["delay-time"])
dly.add_connection(rcv_dt, 0, tapout, 0)

# Feedback path (smoothed)
ln_fb = smooth_receive(dly, "delay-fb")
mul_fb = dly.add_box("*~")
dly.add_connection(tapout, 0, mul_fb, 0)
dly.add_connection(ln_fb, 0, mul_fb, 1)
dly.add_connection(mul_fb, 0, mix_in, 1)        # feedback → sum

# Output
snd_delay_ret = dly.add_box("send~", ["delay-ret"])
dly.add_connection(tapout, 0, snd_delay_ret, 0)


# ===========================================================================
# p distortion
# ===========================================================================
dist_box, dist = main.add_subpatcher("distortion", inlets=0, outlets=0, x=550, y=150)
dist.add_comment("--- DISTORTION (overdrive~) ---")

rcv_proc_dist = dist.add_box("receive~", ["proc-out"])

# Send level (smoothed)
ln_dsl2 = smooth_receive(dist, "dist-send-lvl")
mul_send_dist = dist.add_box("*~")
dist.add_connection(rcv_proc_dist, 0, mul_send_dist, 0)
dist.add_connection(ln_dsl2, 0, mul_send_dist, 1)

# Overdrive
od = dist.add_box("overdrive~", ["1."])
dist.add_connection(mul_send_dist, 0, od, 0)

# Drive from cue
rcv_dd = dist.add_box("receive", ["dist-drive"])
dist.add_connection(rcv_dd, 0, od, 1)

# Output
snd_dist_ret = dist.add_box("send~", ["dist-ret"])
dist.add_connection(od, 0, snd_dist_ret, 0)


# ===========================================================================
# p detune  (frequency shifter)
# ===========================================================================
det_box, det = main.add_subpatcher("detune", inlets=0, outlets=0, x=700, y=150)
det.add_comment("--- DETUNE (freqshift~) ---")

rcv_proc_det = det.add_box("receive~", ["proc-out"])

# Send level (smoothed)
ln_dsl3 = smooth_receive(det, "detune-send-lvl")
mul_send_det = det.add_box("*~")
det.add_connection(rcv_proc_det, 0, mul_send_det, 0)
det.add_connection(ln_dsl3, 0, mul_send_det, 1)

# Frequency shift
fshift = det.add_box("freqshift~", ["5."])
det.add_connection(mul_send_det, 0, fshift, 0)

# Shift amount from cue
rcv_da = det.add_box("receive", ["detune-amt"])
det.add_connection(rcv_da, 0, fshift, 1)

# Output (positive sideband, outlet 0)
snd_det_ret = det.add_box("send~", ["detune-ret"])
det.add_connection(fshift, 0, snd_det_ret, 0)


# ===========================================================================
# p soundfile-player  (3× stereo sfplay~ → mono sum)
# ===========================================================================
sfp_box, sfp = main.add_subpatcher("soundfile-player", inlets=0, outlets=0, x=30, y=250)
sfp.add_comment("--- 3x STEREO SOUNDFILE PLAYER ---")

mono_outs = []
for n in range(1, 4):
    sfp.add_comment(f"--- Player {n} ---")
    rcv_trig = sfp.add_box("receive", [f"sfplay-{n}-trigger"])
    rt = sfp.add_box("route", ["none"])
    sfp.add_connection(rcv_trig, 0, rt, 0)

    # Unmatched (outlet 1) → trigger b s
    trig = sfp.add_box("trigger", ["b", "s"])
    sfp.add_connection(rt, 1, trig, 0)

    # Symbol fires first (right-to-left) → prepend open → sfplay~
    prep = sfp.add_box("prepend", ["open"])
    sfp.add_connection(trig, 1, prep, 0)

    sf = make_sfplay_stereo(sfp)
    sfp.add_connection(prep, 0, sf, 0)

    # Bang fires second → message "1" → sfplay~ (start playback)
    play_msg = sfp.add_message("1")
    sfp.add_connection(trig, 0, play_msg, 0)
    sfp.add_connection(play_msg, 0, sf, 0)

    # Stereo → mono: (L + R) * 0.5
    s_add = sfp.add_box("+~")
    sfp.add_connection(sf, 0, s_add, 0)          # L
    sfp.add_connection(sf, 1, s_add, 1)           # R
    s_half = sfp.add_box("*~", ["0.5"])
    sfp.add_connection(s_add, 0, s_half, 0)
    mono_outs.append(s_half)

# Sum 3 mono players
sfp.add_comment("--- Sum Players ---")
sum_p1 = sfp.add_box("+~")
sfp.add_connection(mono_outs[0], 0, sum_p1, 0)
sfp.add_connection(mono_outs[1], 0, sum_p1, 1)
sum_p2 = sfp.add_box("+~")
sfp.add_connection(sum_p1, 0, sum_p2, 0)
sfp.add_connection(mono_outs[2], 0, sum_p2, 1)

snd_sfplay = sfp.add_box("send~", ["sfplay-ret"])
sfp.add_connection(sum_p2, 0, snd_sfplay, 0)


# ===========================================================================
# MIXER  (in main patcher for presentation mode visibility)
# ===========================================================================
main.add_comment("========== MIXER ==========", x=30, y=330)

# ---- Channel data: (bus_name, label) ----
channels = [
    ("proc-out",   "DRY"),
    ("delay-ret",  "DELAY"),
    ("dist-ret",   "DIST"),
    ("detune-ret", "DETUNE"),
    ("sfplay-ret", "FILES"),
]

# Track presentation objects — we'll set their rects AFTER apply_layout
pres_objects = []  # list of (box, [x, y, w, h])

gain_boxes = []
for i, (bus, label) in enumerate(channels):
    cx = 30 + i * 130   # patching-mode x

    rcv = main.add_box("receive~", [bus], x=cx, y=360)
    g = main.add_box("gain~", x=cx, y=400)
    m = main.add_box("meter~", x=cx + 55, y=400)
    main.add_connection(rcv, 0, g, 0)
    main.add_connection(g, 0, m, 0)

    g.presentation = True
    m.presentation = True

    # Channel label
    lbl = main.add_comment(label, x=cx, y=345)
    lbl.presentation = True

    # Presentation rects computed below after layout
    pres_objects.append(("gain", i, g))
    pres_objects.append(("meter", i, m))
    pres_objects.append(("label", i, lbl))

    gain_boxes.append(g)

# ---- Sum channels ----
prev = None
for i, g in enumerate(gain_boxes):
    if i == 0:
        prev = g
        continue
    s = main.add_box("+~", x=200, y=480 + i * 30)
    main.add_connection(prev if i == 1 else prev, 0, s, 0)
    main.add_connection(g, 0, s, 1)
    prev = s

# ---- Master ----
main.add_comment("--- MASTER ---", x=350, y=540)

gain_master = main.add_box("gain~", x=350, y=570)
meter_master = main.add_box("meter~", x=410, y=570)
main.add_connection(prev, 0, gain_master, 0)
main.add_connection(gain_master, 0, meter_master, 0)

gain_master.presentation = True
meter_master.presentation = True

master_lbl = main.add_comment("MASTER", x=350, y=555)
master_lbl.presentation = True

pres_objects.append(("gain", 5, gain_master))
pres_objects.append(("meter", 5, meter_master))
pres_objects.append(("label", 5, master_lbl))

# ---- DAC (mono → dual-mono stereo) ----
dac = main.add_box("dac~", x=350, y=620)
main.add_connection(gain_master, 0, dac, 0)      # L
main.add_connection(gain_master, 0, dac, 1)      # R


# ===========================================================================
# CUE CONTROLS  (in main patcher for presentation mode)
# ===========================================================================
main.add_comment("--- CUE CONTROLS ---", x=600, y=345)

rcv_cue_num = main.add_box("receive", ["cue-number"], x=600, y=370)
cue_display = main.add_box("number", x=600, y=400)
main.add_connection(rcv_cue_num, 0, cue_display, 0)

next_btn = main.add_box("button", x=700, y=400)
snd_next_main = main.add_box("send", ["next-cue"], x=700, y=440)
main.add_connection(next_btn, 0, snd_next_main, 0)

cue_lbl = main.add_comment("CUE:", x=600, y=355)
next_lbl = main.add_comment("NEXT", x=700, y=385)
pres_title = main.add_comment("PERFORMANCE PATCH")

# Mark as presentation but don't set rects yet
for obj in [cue_lbl, cue_display, next_lbl, next_btn, pres_title]:
    obj.presentation = True

pres_objects.append(("cue_lbl", 0, cue_lbl))
pres_objects.append(("cue_num", 0, cue_display))
pres_objects.append(("next_lbl", 0, next_lbl))
pres_objects.append(("next_btn", 0, next_btn))
pres_objects.append(("title", 0, pres_title))


# ===========================================================================
# PRESENTATION LAYOUT
# ===========================================================================
# Set presentation_rect on all mixer/cue objects BEFORE write_patch runs.
# The layout engine now respects existing presentation_rect values.

STRIP_W = 100       # width per channel strip
FADER_W = 38        # gain~ fader width
FADER_H = 150       # gain~ fader height
METER_W = 22        # meter~ width
METER_H = 150       # meter~ height
LABEL_H = 22        # label height
PAD_X = 20          # left padding
PAD_Y = 10          # top padding
TITLE_H = 25        # title bar height
LABEL_Y = PAD_Y + TITLE_H
FADER_Y = LABEL_Y + LABEL_H + 5
CUE_Y = FADER_Y + FADER_H + 15

for kind, idx, box in pres_objects:
    strip_x = PAD_X + idx * STRIP_W

    if kind == "gain":
        box.presentation_rect = [strip_x, FADER_Y, FADER_W, FADER_H]
    elif kind == "meter":
        box.presentation_rect = [strip_x + FADER_W + 4, FADER_Y, METER_W, METER_H]
    elif kind == "label":
        box.presentation_rect = [strip_x, LABEL_Y, STRIP_W - 10, LABEL_H]
    elif kind == "cue_lbl":
        box.presentation_rect = [PAD_X, CUE_Y, 45, 24]
    elif kind == "cue_num":
        box.presentation_rect = [PAD_X + 50, CUE_Y, 60, 24]
    elif kind == "next_lbl":
        box.presentation_rect = [PAD_X + 130, CUE_Y, 50, 24]
    elif kind == "next_btn":
        box.presentation_rect = [PAD_X + 185, CUE_Y, 28, 28]
    elif kind == "title":
        box.presentation_rect = [PAD_X + 230, CUE_Y, 200, 22]


# ===========================================================================
# Write
# ===========================================================================
OUTPUT.parent.mkdir(parents=True, exist_ok=True)
write_patch(main, OUTPUT)
print(f"SUCCESS: {OUTPUT}")
