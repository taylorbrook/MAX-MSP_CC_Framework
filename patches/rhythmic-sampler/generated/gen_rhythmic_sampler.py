"""Generate the main rhythmic-sampler.maxpat file.

Top-level patch with:
- Master transport/clock (BPM, play/stop, metro -> send tick)
- 8 bpatcher instances of slot.maxpat
- Audio mixer (receive~ per slot -> volume -> sum chain -> gain~ -> dac~)
- Presentation mode layout
"""

import json
import sys
from pathlib import Path

sys.path.insert(0, '/Users/taylorbrook/Dev/MAX')
from src.maxpat import Patcher, ObjectDatabase, validate_patch, has_blocking_errors
from src.maxpat.layout import apply_layout

db = ObjectDatabase()
p = Patcher(db=db)

# Enable presentation mode
p.props["openinpresentation"] = 1
# Set patcher window rect (x, y, w, h)
p.props["rect"] = [100.0, 100.0, 1700.0, 1200.0]

# We'll store desired presentation_rect values separately, then apply them
# AFTER the layout engine runs (since it overwrites presentation_rect).
presentation_rects: dict[str, list[float]] = {}

def set_presentation(box, rect):
    """Mark a box for presentation mode and store its desired rect."""
    box.presentation = True
    presentation_rects[box.id] = rect


# ==========================================================================
# MASTER TRANSPORT SECTION
# ==========================================================================

# Title comment
title = p.add_comment('RHYTHMIC SAMPLER', x=10, y=10)
set_presentation(title, [10, 10, 200, 30])
title.extra_attrs["fontsize"] = 18
title.extra_attrs["fontface"] = 1  # bold

# BPM label
bpm_label = p.add_comment('BPM', x=10, y=50)
set_presentation(bpm_label, [10, 50, 60, 20])
bpm_label.extra_attrs["fontsize"] = 12

# BPM number box (default 120)
bpm_num = p.add_box('number', x=75, y=45)
set_presentation(bpm_num, [75, 45, 60, 25])

# Play/Stop toggle
play_toggle = p.add_box('toggle', x=150, y=45)
set_presentation(play_toggle, [150, 45, 30, 30])

# PLAY label
play_label = p.add_comment('PLAY', x=190, y=50)
set_presentation(play_label, [200, 50, 60, 20])

# expr to convert BPM to ms per 16th note: 60000 / BPM / 4
bpm_expr = p.add_box('expr', ['60000./$f1/4.'], x=75, y=90)

# metro (in0: on/off, in1: interval ms)
metro = p.add_box('metro', ['125'], x=150, y=130)

# send tick
send_tick = p.add_box('send', ['tick'], x=150, y=170)

# --- Transport connections ---
# BPM number -> expr (inlet 0)
p.add_connection(bpm_num, 0, bpm_expr, 0)
# expr -> metro (inlet 1: set interval)
p.add_connection(bpm_expr, 0, metro, 1)
# toggle -> metro (inlet 0: on/off)
p.add_connection(play_toggle, 0, metro, 0)
# metro -> send tick
p.add_connection(metro, 0, send_tick, 0)

# ==========================================================================
# INIT CHAIN
# ==========================================================================

loadbang = p.add_box('loadbang', x=75, y=0)

# trigger b b: outlet 1 fires first (rightmost), then outlet 0
init_trigger = p.add_box('trigger', ['b', 'b'], x=75, y=20)

# Message "120" for default BPM
init_bpm_msg = p.add_message('120', x=10, y=35)

# loadbang -> trigger
p.add_connection(loadbang, 0, init_trigger, 0)
# trigger outlet 1 (fires first) -> "120" message
p.add_connection(init_trigger, 1, init_bpm_msg, 0)
# "120" message -> BPM number
p.add_connection(init_bpm_msg, 0, bpm_num, 0)

# ==========================================================================
# 8 SLOT BPATCHERS
# ==========================================================================

# Presentation layout: 2 rows of 4
pres_slot_x = [10, 420, 830, 1240]
pres_y_row1 = 90
pres_y_row2 = 500

# Patching layout: 2 rows of 4
patch_y_row1 = 200
patch_y_row2 = 620

bpatchers = []

for i in range(8):
    slot_num = i + 1
    row = 0 if i < 4 else 1
    col = i % 4

    x_pos = pres_slot_x[col]
    y_pos = patch_y_row1 if row == 0 else patch_y_row2
    pres_y = pres_y_row1 if row == 0 else pres_y_row2

    bp = p.add_bpatcher(
        filename='slot.maxpat',
        args=[str(slot_num)],
        x=x_pos,
        y=y_pos,
        width=400,
        height=400,
        numinlets=0,
        numoutlets=0,
    )
    set_presentation(bp, [pres_slot_x[col], pres_y, 400, 400])
    bpatchers.append(bp)


# ==========================================================================
# MIXER SECTION (global gain only, no per-slot volume)
# ==========================================================================

mixer_y_base = 1050  # Below the bpatchers in patching mode

# --- receive~ per slot (direct to sum chain) ---
slot_receives = []

for i in range(8):
    slot_num = i + 1
    x_offset = 10 + i * 200
    recv = p.add_box('receive~', [f'slot-{slot_num}-out'], x=x_offset, y=mixer_y_base)
    slot_receives.append(recv)

# --- Sum chain: cascade of +~ objects ---
sum_x = 10
sum_y_base = mixer_y_base + 60

# First +~: slot1 + slot2
plus_1_2 = p.add_box('+~', x=sum_x, y=sum_y_base)
p.add_connection(slot_receives[0], 0, plus_1_2, 0)
p.add_connection(slot_receives[1], 0, plus_1_2, 1)

# Chain remaining slots
prev_sum = plus_1_2
for i in range(2, 8):
    new_plus = p.add_box('+~', x=sum_x + (i - 1) * 100, y=sum_y_base + (i - 1) * 30)
    p.add_connection(prev_sum, 0, new_plus, 0)
    p.add_connection(slot_receives[i], 0, new_plus, 1)
    prev_sum = new_plus

# Safety gain: *~ 0.3
safety_gain = p.add_box('*~', ['0.3'], x=sum_x + 700, y=sum_y_base + 210)
p.add_connection(prev_sum, 0, safety_gain, 0)

# Master gain~ (global volume control for all slots)
master_gain = p.add_box('gain~', x=sum_x + 700, y=sum_y_base + 260)
set_presentation(master_gain, [10, 910, 200, 50])
p.add_connection(safety_gain, 0, master_gain, 0)

# dac~ (2 inlets: left, right)
dac = p.add_box('dac~', x=sum_x + 700, y=sum_y_base + 330)

# gain~ outlet 0 -> dac~ inlet 0 (left) and inlet 1 (right) [mono to stereo]
p.add_connection(master_gain, 0, dac, 0)  # left
p.add_connection(master_gain, 0, dac, 1)  # right

# Master meter~ for level monitoring
master_meter = p.add_box('meter~', x=sum_x + 800, y=sum_y_base + 260)
set_presentation(master_meter, [220, 910, 100, 50])
p.add_connection(master_gain, 0, master_meter, 0)

# Master label
master_label = p.add_comment('MASTER', x=sum_x + 700, y=sum_y_base + 240)
set_presentation(master_label, [10, 895, 80, 15])
master_label.extra_attrs["fontsize"] = 11
master_label.extra_attrs["fontface"] = 1  # bold

# ==========================================================================
# DAC toggle (on/off button for audio)
# ==========================================================================

dac_toggle = p.add_box('toggle', x=sum_x + 700, y=sum_y_base + 300)
set_presentation(dac_toggle, [10, 1020, 25, 25])

# "startwindow" / "stop" messages for dac~
dac_start_msg = p.add_message('startwindow', x=sum_x + 740, y=sum_y_base + 300)
dac_stop_msg = p.add_message('stop', x=sum_x + 830, y=sum_y_base + 300)

# toggle -> select 0: outlet 0 = matched (off), outlet 1 = unmatched (on)
dac_sel = p.add_box('select', ['0'], x=sum_x + 700, y=sum_y_base + 310)

p.add_connection(dac_toggle, 0, dac_sel, 0)
p.add_connection(dac_sel, 0, dac_stop_msg, 0)     # matched 0 -> stop
p.add_connection(dac_sel, 1, dac_start_msg, 0)     # unmatched -> startwindow
p.add_connection(dac_start_msg, 0, dac, 0)
p.add_connection(dac_stop_msg, 0, dac, 0)

# Audio on/off label
audio_label = p.add_comment('Audio On/Off', x=sum_x + 700, y=sum_y_base + 285)
set_presentation(audio_label, [40, 1025, 80, 15])
audio_label.extra_attrs["fontsize"] = 10


# ==========================================================================
# WRITE PATCH (manual pipeline to preserve presentation_rect)
# ==========================================================================

output_path = '/Users/taylorbrook/Dev/MAX/patches/rhythmic-sampler/generated/rhythmic-sampler.maxpat'

# Step 1: Apply layout engine (this will reposition patching_rect and
# overwrite presentation_rect via _apply_presentation_layout)
apply_layout(p)

# Step 2: Restore our desired presentation_rect values
box_map = {b.id: b for b in p.boxes}
for box_id, rect in presentation_rects.items():
    if box_id in box_map:
        box_map[box_id].presentation_rect = rect

# Step 3: Serialize to dict
patch_dict = p.to_dict()

# Step 4: Validate
results = validate_patch(patch_dict, db=p.db)

# Step 5: Print validation results
print(f"Validation results: {len(results)}")
for r in results:
    print(f"  {r}")

# Check for blocking errors
blocking = [r for r in results if r.level == "error" and not r.auto_fixed]
if blocking:
    print("\nBLOCKING ERRORS:")
    for r in blocking:
        print(f"  {r}")
    sys.exit(1)

# Step 6: Write to disk
output = Path(output_path)
output.parent.mkdir(parents=True, exist_ok=True)
output.write_text(json.dumps(patch_dict, indent=2))

print(f"\nPatch written to: {output_path}")
print("Done!")
