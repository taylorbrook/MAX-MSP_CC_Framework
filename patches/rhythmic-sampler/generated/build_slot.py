#!/usr/bin/env python3
"""Build slot.maxpat -- rhythmic sampler slot bpatcher.

This is a single slot (1 of 8) instantiated as a bpatcher in the main patch.
Uses #1/#2 argument substitution for buffer name and send name.

Parent bpatcher passes args like: ["slot-1", "slot-1-out"]
  #1 = buffer/groove/info/waveform name (e.g., "slot-1")
  #2 = send~ destination name (e.g., "slot-1-out")

IMPORTANT: #N must be standalone tokens, never embedded in compound strings.
"""

import json
import sys
from pathlib import Path
sys.path.insert(0, '/Users/taylorbrook/Dev/MAX')

from src.maxpat import Patcher, ObjectDatabase
from src.maxpat.layout import apply_layout, _apply_presentation_layout
from src.maxpat.validation import validate_patch, has_blocking_errors

db = ObjectDatabase()
p = Patcher(db=db)
p.props["openinpresentation"] = 1

# ============================================================================
# AUDIO OBJECTS
# ============================================================================

# Buffer and playback
buffer = p.add_box('buffer~', ['#1'], x=50, y=500)
groove = p.add_box('groove~', ['#1'], x=200, y=550)
info = p.add_box('info~', ['#1'], x=400, y=500)
waveform = p.add_box('waveform~', ['#1'], x=200, y=50)

# Filter chain: svf~ -> selector~ (choose filter type)
svf = p.add_box('svf~', [], x=200, y=650)
selector = p.add_box('selector~', ['4'], x=200, y=730)

# Degrade effect
degrade = p.add_box('degrade~', [], x=200, y=800)

# Envelope and volume
env_mult = p.add_box('*~', [], x=200, y=870)       # envelope * signal
vol_mult = p.add_box('*~', [], x=200, y=940)       # volume * signal

# Envelope line~
env_line = p.add_box('line~', [], x=50, y=870)

# Output send
send_out = p.add_box('send~', ['#2'], x=200, y=1010)

# Pitch: sig~ for rate control
pitch_sig = p.add_box('sig~', [], x=50, y=550)

# Filter cutoff sig~
cutoff_sig = p.add_box('sig~', [], x=350, y=620)

# Filter resonance sig~
reso_sig = p.add_box('sig~', [], x=450, y=620)

# Degrade sample rate sig~
degrade_sr_sig = p.add_box('sig~', [], x=350, y=770)

# Degrade bit depth sig~ (via loadbang init)
degrade_bd_sig = p.add_box('sig~', [], x=450, y=770)

# Volume sig~
vol_sig = p.add_box('sig~', [], x=350, y=940)

# Meter for level display
meter = p.add_box('meter~', [], x=350, y=1010)

# Buffer name message for js engine (triggered on file load and init)
setbuf_msg = p.add_message('setbuffer #1', x=400, y=560)

# Waveform refresh message (triggered when buffer~ finishes loading a file)
set_buf_name_msg = p.add_message('set #1', x=300, y=560)

# ============================================================================
# SEQUENCER CHAIN
# ============================================================================

# Clock input
recv_tick = p.add_box('receive', ['tick'], x=50, y=150)

# Step counter (0-15)
counter = p.add_box('counter', ['0', '15'], x=50, y=200)

# Fan-out trigger: outlet 1 fires first (step -> js), outlet 0 fires second (step -> multislider)
trig_seq = p.add_box('trigger', ['i', 'i'], x=50, y=260)

# JS engine for slice computation (3 inlets, 2 outlets)
js_engine, _ = p.add_js('slot-engine.js', code=None, num_inlets=3, num_outlets=2)

# Prepend fetchindex for multislider
prepend_fetch = p.add_box('prepend', ['fetchindex'], x=200, y=310)

# Multislider for step pattern
mslider = p.add_box('multislider', [], x=200, y=380)

# Split: velocities 1-127 trigger, 0 is silent
split_vel = p.add_box('split', ['1', '127'], x=200, y=450)

# Velocity trigger: outlet 1 (f) fires first, outlet 0 (b) fires second
trig_vel = p.add_box('trigger', ['b', 'f'], x=200, y=510)

# Velocity scaling: / 127. to normalize 0-1
vel_div = p.add_box('/', ['127.'], x=350, y=510)

# Pack envelope params: velocity, attack, decay
env_pack = p.add_box('pack', ['f', 'f', 'f'], x=300, y=570)

# Envelope message: "$1 $2, 0. $3" -> line~
env_msg = p.add_message('$1 $2, 0. $3', x=300, y=640)

# Start playback message
start_msg = p.add_message('startloop', x=100, y=570)

# Loop enable message
loop_msg = p.add_message('loop 1', x=500, y=1100)

# ============================================================================
# CONTROLS (UI)
# ============================================================================

# File load button + message
load_btn = p.add_box('button', [], x=500, y=50)
load_msg = p.add_message('read', x=500, y=100)

# Number of slices
num_slices = p.add_box('number', [], x=600, y=50)

# Pitch dial + expr + sig~
pitch_dial = p.add_box('dial', [], x=500, y=200)
pitch_expr = p.add_box('expr', ['pow(2.\\,', '$f1', '/', '12.)'], x=500, y=280)

# Filter cutoff dial + scale
cutoff_dial = p.add_box('dial', [], x=600, y=200)
cutoff_scale = p.add_box('scale', ['0', '127', '20.', '20000.'], x=600, y=280)

# Filter resonance dial + scale
reso_dial = p.add_box('dial', [], x=700, y=200)
reso_scale = p.add_box('scale', ['0', '127', '0.', '1.'], x=700, y=280)

# Filter type umenu
filter_umenu = p.add_box('umenu', [], x=800, y=200)

# +1 for selector~ (0=mute, 1=LP, 2=HP, 3=BP, 4=Notch)
filter_plus = p.add_box('+', ['1'], x=800, y=280)

# Degrade (sample rate) dial + scale
degrade_dial = p.add_box('dial', [], x=900, y=200)
degrade_scale = p.add_box('scale', ['0', '127', '0.1', '1.'], x=900, y=280)

# Volume dial + scale
vol_dial = p.add_box('dial', [], x=1000, y=200)
vol_scale = p.add_box('scale', ['0', '127', '0.', '1.'], x=1000, y=280)

# Attack dial (ms)
atk_dial = p.add_box('dial', [], x=500, y=400)

# Decay dial (ms)
dec_dial = p.add_box('dial', [], x=600, y=400)

# ============================================================================
# INIT CHAIN (loadbang)
# ============================================================================

loadbang = p.add_box('loadbang', [], x=700, y=900)
init_trig = p.add_box('trigger', ['b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b'], x=700, y=960)

# Init messages (fired right-to-left: out 9 fires first, out 0 fires last)
init_loop = p.add_message('loop 1', x=1100, y=1020)
init_slices = p.add_message('16', x=1030, y=1020)
init_atk = p.add_message('5', x=960, y=1020)
init_dec = p.add_message('300', x=890, y=1020)
init_bitdepth = p.add_message('24.', x=820, y=1020)
init_pitch = p.add_message('0', x=750, y=1020)
init_vol = p.add_message('100', x=680, y=1020)
init_cutoff = p.add_message('127', x=610, y=1020)
init_degrade_sr = p.add_message('127', x=540, y=1020)
init_setbuf = p.add_message('setbuffer #1', x=400, y=1020)

# ============================================================================
# SIGNAL CHAIN CONNECTIONS
# ============================================================================

# Pitch -> groove rate
p.add_connection(pitch_sig, 0, groove, 0)        # sig~ -> groove~ inlet 0 (rate)

# groove -> svf -> selector -> degrade -> env_mult -> vol_mult -> send_out
p.add_connection(groove, 0, svf, 0)              # groove~ out 0 -> svf~ in 0
p.add_connection(svf, 0, selector, 1)            # svf~ LP out -> selector~ in 1
p.add_connection(svf, 1, selector, 2)            # svf~ HP out -> selector~ in 2
p.add_connection(svf, 2, selector, 3)            # svf~ BP out -> selector~ in 3
p.add_connection(svf, 3, selector, 4)            # svf~ Notch out -> selector~ in 4
p.add_connection(selector, 0, degrade, 0)        # selector~ out -> degrade~ in 0
p.add_connection(degrade, 0, env_mult, 0)        # degrade~ out -> *~ in 0 (envelope)
p.add_connection(env_line, 0, env_mult, 1)       # line~ out -> *~ in 1 (envelope)
p.add_connection(env_mult, 0, vol_mult, 0)       # *~ out -> *~ in 0 (volume)
p.add_connection(vol_sig, 0, vol_mult, 1)        # vol sig~ -> *~ in 1 (volume)
p.add_connection(vol_mult, 0, send_out, 0)       # *~ out -> send~ slot-#1-out

# Filter controls -> sig~ -> svf~
p.add_connection(cutoff_sig, 0, svf, 1)          # cutoff sig~ -> svf~ in 1 (cutoff)
p.add_connection(reso_sig, 0, svf, 2)            # reso sig~ -> svf~ in 2 (resonance)

# Degrade controls -> sig~ -> degrade~
p.add_connection(degrade_sr_sig, 0, degrade, 1)  # degrade SR sig~ -> degrade~ in 1
p.add_connection(degrade_bd_sig, 0, degrade, 2)  # degrade BD sig~ -> degrade~ in 2

# Meter
p.add_connection(vol_mult, 0, meter, 0)          # vol output -> meter~

# ============================================================================
# SEQUENCER CONNECTIONS
# ============================================================================

# Clock -> counter -> trigger
p.add_connection(recv_tick, 0, counter, 0)       # receive tick -> counter in 0
p.add_connection(counter, 0, trig_seq, 0)        # counter out 0 -> trigger in 0

# Trigger outlet 1 (fires FIRST) -> js inlet 0 (set slice positions before trigger)
p.add_connection(trig_seq, 1, js_engine, 0)      # trigger out 1 -> js in 0

# Trigger outlet 0 (fires SECOND) -> prepend fetchindex -> multislider
p.add_connection(trig_seq, 0, prepend_fetch, 0)  # trigger out 0 -> prepend in 0
p.add_connection(prepend_fetch, 0, mslider, 0)   # prepend out 0 -> multislider in 0

# JS outputs -> groove~ start/end
p.add_connection(js_engine, 0, groove, 1)        # js out 0 (start ms) -> groove~ in 1
p.add_connection(js_engine, 1, groove, 2)        # js out 1 (end ms) -> groove~ in 2

# Multislider -> split -> velocity trigger
p.add_connection(mslider, 0, split_vel, 0)       # multislider out 0 -> split in 0
p.add_connection(split_vel, 0, trig_vel, 0)      # split out 0 (in range) -> trigger in 0

# Velocity trigger: out 1 (f) fires first -> vel scaling -> pack
p.add_connection(trig_vel, 1, vel_div, 0)        # trigger out 1 (f) -> / 127. in 0
p.add_connection(vel_div, 0, env_pack, 0)        # / out -> pack in 0 (velocity, hot)

# Velocity trigger: out 0 (b) fires second -> startloop
p.add_connection(trig_vel, 0, start_msg, 0)      # trigger out 0 (b) -> message "startloop"
p.add_connection(start_msg, 0, groove, 0)        # startloop -> groove~ in 0

# Attack/Decay dials -> pack inlets (cold)
p.add_connection(atk_dial, 0, env_pack, 1)       # attack dial -> pack in 1 (cold)
p.add_connection(dec_dial, 0, env_pack, 2)       # decay dial -> pack in 2 (cold)

# Pack -> envelope message -> line~
p.add_connection(env_pack, 0, env_msg, 0)        # pack out -> message in 0
p.add_connection(env_msg, 0, env_line, 0)        # message out -> line~ in 0

# ============================================================================
# CONTROL CONNECTIONS
# ============================================================================

# File load
p.add_connection(load_btn, 0, load_msg, 0)       # button -> "read"
p.add_connection(load_msg, 0, buffer, 0)          # "read" -> buffer~

# Num slices -> js inlet 2
p.add_connection(num_slices, 0, js_engine, 2)     # number -> js in 2

# Buffer done loading -> refresh waveform display and update js engine
p.add_connection(buffer, 1, set_buf_name_msg, 0)  # buffer~ done (right outlet) -> "set slot-#1"
p.add_connection(buffer, 1, setbuf_msg, 0)        # buffer~ done (right outlet) -> "setbuffer slot-#1"
p.add_connection(set_buf_name_msg, 0, waveform, 0) # "set slot-#1" -> waveform~ in 0
p.add_connection(setbuf_msg, 0, js_engine, 1)     # setbuffer -> js in 1 (buffer name)

# Pitch control: dial -> expr -> sig~
p.add_connection(pitch_dial, 0, pitch_expr, 0)    # pitch dial -> expr in 0
p.add_connection(pitch_expr, 0, pitch_sig, 0)     # expr out -> sig~ in 0

# Filter cutoff: dial -> scale -> sig~
p.add_connection(cutoff_dial, 0, cutoff_scale, 0) # cutoff dial -> scale in 0
p.add_connection(cutoff_scale, 0, cutoff_sig, 0)  # scale out -> sig~ in 0

# Filter resonance: dial -> scale -> sig~
p.add_connection(reso_dial, 0, reso_scale, 0)     # reso dial -> scale in 0
p.add_connection(reso_scale, 0, reso_sig, 0)      # scale out -> sig~ in 0

# Filter type: umenu -> +1 -> selector~ inlet 0
p.add_connection(filter_umenu, 0, filter_plus, 0) # umenu -> + 1 in 0
p.add_connection(filter_plus, 0, selector, 0)     # + 1 out -> selector~ in 0

# Degrade: dial -> scale -> sig~
p.add_connection(degrade_dial, 0, degrade_scale, 0)
p.add_connection(degrade_scale, 0, degrade_sr_sig, 0)

# Volume: dial -> scale -> sig~
p.add_connection(vol_dial, 0, vol_scale, 0)
p.add_connection(vol_scale, 0, vol_sig, 0)

# ============================================================================
# INIT CHAIN CONNECTIONS (loadbang -> trigger b b b b b)
# Right to left: out4 fires first, out0 fires last
# ============================================================================

p.add_connection(loadbang, 0, init_trig, 0)

# out 9 (fires 1st): loop 1 -> groove~
p.add_connection(init_trig, 9, init_loop, 0)
p.add_connection(init_loop, 0, groove, 0)

# out 8 (fires 2nd): 16 -> num_slices number -> js inlet 2
p.add_connection(init_trig, 8, init_slices, 0)
p.add_connection(init_slices, 0, num_slices, 0)

# out 7 (fires 3rd): 5 -> attack dial
p.add_connection(init_trig, 7, init_atk, 0)
p.add_connection(init_atk, 0, atk_dial, 0)

# out 6 (fires 4th): 300 -> decay dial
p.add_connection(init_trig, 6, init_dec, 0)
p.add_connection(init_dec, 0, dec_dial, 0)

# out 5 (fires 5th): 24. -> degrade bit depth sig~
p.add_connection(init_trig, 5, init_bitdepth, 0)
p.add_connection(init_bitdepth, 0, degrade_bd_sig, 0)

# out 4 (fires 6th): 0 -> pitch dial (0 semitones = rate 1.0)
p.add_connection(init_trig, 4, init_pitch, 0)
p.add_connection(init_pitch, 0, pitch_dial, 0)

# out 3 (fires 7th): 100 -> volume dial (~78% volume)
p.add_connection(init_trig, 3, init_vol, 0)
p.add_connection(init_vol, 0, vol_dial, 0)

# out 2 (fires 8th): 127 -> cutoff dial (20kHz = wide open)
p.add_connection(init_trig, 2, init_cutoff, 0)
p.add_connection(init_cutoff, 0, cutoff_dial, 0)

# out 1 (fires 9th): 127 -> degrade SR dial (no degradation)
p.add_connection(init_trig, 1, init_degrade_sr, 0)
p.add_connection(init_degrade_sr, 0, degrade_dial, 0)

# out 0 (fires 10th/last): setbuffer slot-#1 -> js engine
p.add_connection(init_trig, 0, init_setbuf, 0)
p.add_connection(init_setbuf, 0, js_engine, 1)

# ============================================================================
# PRESENTATION MODE LABELS (added to patcher before layout)
# ============================================================================

pitch_lbl = p.add_comment('Pitch', x=500, y=170)
cutoff_lbl = p.add_comment('Cutoff', x=600, y=170)
reso_lbl = p.add_comment('Reso', x=700, y=170)
type_lbl = p.add_comment('Type', x=800, y=170)
degrade_lbl = p.add_comment('Degrd', x=900, y=170)
vol_lbl = p.add_comment('Vol', x=1000, y=170)
atk_lbl = p.add_comment('Atk', x=500, y=380)
dec_lbl = p.add_comment('Dec', x=600, y=380)
step_lbl = p.add_comment('Step Pattern', x=200, y=470)

# Multislider extra attrs (set before layout)
mslider.extra_attrs['size'] = 16
mslider.extra_attrs['setminmax'] = [0.0, 127.0]
mslider.extra_attrs['setstyle'] = 1  # bar style

# ============================================================================
# WRITE PATCH (manual pipeline to preserve presentation_rect values)
# ============================================================================

output_path = '/Users/taylorbrook/Dev/MAX/patches/rhythmic-sampler/generated/slot.maxpat'

print("Building slot.maxpat...")
print(f"  Objects: {len(p.boxes)}")
print(f"  Connections: {len(p.lines)}")

try:
    # Step 1: Apply layout (this positions patching_rect AND overwrites presentation_rect)
    apply_layout(p)

    # Step 2: NOW set the correct presentation_rect values (after layout is done)
    # This overrides what the layout engine computed.

    # Waveform display
    waveform.presentation = True
    waveform.presentation_rect = [0, 0, 400, 60]

    # Load button
    load_btn.presentation = True
    load_btn.presentation_rect = [5, 65, 50, 20]

    # Num slices
    num_slices.presentation = True
    num_slices.presentation_rect = [60, 65, 100, 20]

    # Pitch
    pitch_lbl.presentation = True
    pitch_lbl.presentation_rect = [5, 90, 55, 18]
    pitch_dial.presentation = True
    pitch_dial.presentation_rect = [5, 105, 55, 55]

    # Cutoff
    cutoff_lbl.presentation = True
    cutoff_lbl.presentation_rect = [65, 90, 55, 18]
    cutoff_dial.presentation = True
    cutoff_dial.presentation_rect = [65, 105, 55, 55]

    # Reso
    reso_lbl.presentation = True
    reso_lbl.presentation_rect = [125, 90, 55, 18]
    reso_dial.presentation = True
    reso_dial.presentation_rect = [125, 105, 55, 55]

    # Filter type
    type_lbl.presentation = True
    type_lbl.presentation_rect = [185, 90, 55, 18]
    filter_umenu.presentation = True
    filter_umenu.presentation_rect = [185, 105, 55, 20]

    # Degrade
    degrade_lbl.presentation = True
    degrade_lbl.presentation_rect = [245, 90, 55, 18]
    degrade_dial.presentation = True
    degrade_dial.presentation_rect = [245, 105, 55, 55]

    # Volume
    vol_lbl.presentation = True
    vol_lbl.presentation_rect = [305, 90, 55, 18]
    vol_dial.presentation = True
    vol_dial.presentation_rect = [305, 105, 55, 55]

    # Attack
    atk_lbl.presentation = True
    atk_lbl.presentation_rect = [5, 170, 55, 18]
    atk_dial.presentation = True
    atk_dial.presentation_rect = [5, 185, 55, 55]

    # Decay
    dec_lbl.presentation = True
    dec_lbl.presentation_rect = [65, 170, 55, 18]
    dec_dial.presentation = True
    dec_dial.presentation_rect = [65, 185, 55, 55]

    # Multislider (step pattern)
    mslider.presentation = True
    mslider.presentation_rect = [5, 250, 390, 80]

    # Step pattern label
    step_lbl.presentation = True
    step_lbl.presentation_rect = [5, 335, 390, 20]

    # Meter (vertical bar on right side to show audio activity)
    meter.presentation = True
    meter.presentation_rect = [375, 90, 20, 265]

    # Step 3: Serialize to dict
    patch_dict = p.to_dict()

    # Step 4: Validate
    results = validate_patch(patch_dict, db=p.db)

    # Step 5: Report and write
    errors = [r for r in results if r.level == 'error' and not r.auto_fixed]
    warnings = [r for r in results if r.level == 'warning']
    fixed = [r for r in results if r.auto_fixed]

    if errors:
        print(f"\n  BLOCKING ERRORS ({len(errors)}):")
        for r in errors:
            print(f"    - {r}")
        print("\nAborting due to blocking errors.")
        sys.exit(1)

    # Write the file
    output = Path(output_path)
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(patch_dict, indent=2))

    print(f"\nPatch written to: {output_path}")

    if fixed:
        print(f"\n  AUTO-FIXED ({len(fixed)}):")
        for r in fixed:
            print(f"    - {r}")
    if warnings:
        print(f"\n  WARNINGS ({len(warnings)}):")
        for r in warnings:
            print(f"    - {r}")

    if not errors and not warnings and not fixed:
        print("  No validation issues!")

    print("\nDone!")

except Exception as e:
    print(f"\nERROR: {e}")
    import traceback
    traceback.print_exc()
    sys.exit(1)
