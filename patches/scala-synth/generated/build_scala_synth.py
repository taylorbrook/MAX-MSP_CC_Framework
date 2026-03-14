#!/usr/bin/env python3
"""Build scala-synth: main patch, voice patch, and JS files.

Generates:
  - scala-synth-voice.maxpat  (poly~ voice with gen~ additive engine)
  - scala-synth.maxpat         (main patch with full UI)
  - scala-parser.js            (Scala .scl file parser)
  - partial-display.js         (partial amplitude visualization)
"""

import json
import sys
from pathlib import Path

sys.path.insert(0, '/Users/taylorbrook/Dev/MAX')

from src.maxpat import Patcher, ObjectDatabase, write_patch, write_js
from src.maxpat.patcher import Box
from src.maxpat.sizing import calculate_box_size
from src.maxpat.defaults import FONT_NAME, FONT_SIZE

db = ObjectDatabase()
BASE = Path('/Users/taylorbrook/Dev/MAX/patches/scala-synth/generated')


def manual_box(patcher, name, text, numinlets, numoutlets, outlettype, x=0, y=0):
    """Create a box bypassing database lookup."""
    box_id = patcher._gen_id()
    box = Box.__new__(Box)
    box.name = name
    box.args = []
    box.id = box_id
    box.maxclass = "newobj"
    box.text = text
    box.numinlets = numinlets
    box.numoutlets = numoutlets
    box.outlettype = outlettype
    w, h = calculate_box_size(text, "newobj")
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


def debug_meter(patcher, x=0, y=0):
    """Add a meter~ for visual signal level monitoring."""
    box_id = patcher._gen_id()
    box = Box.__new__(Box)
    box.name = 'meter~'
    box.args = []
    box.id = box_id
    box.maxclass = 'meter~'
    box.text = ''
    box.numinlets = 1
    box.numoutlets = 1
    box.outlettype = ['float']
    box.patching_rect = [x, y, 20, 80]
    box.fontname = FONT_NAME
    box.fontsize = FONT_SIZE
    box.presentation = False
    box.presentation_rect = None
    box.extra_attrs = {'parameter_enable': 0}
    box._inner_patcher = None
    box._saved_object_attributes = None
    box._bpatcher_attrs = None
    patcher.boxes.append(box)
    return box


def debug_number_tilde(patcher, x=0, y=0):
    """Add a number~ in display mode for signal value monitoring."""
    box_id = patcher._gen_id()
    box = Box.__new__(Box)
    box.name = 'number~'
    box.args = []
    box.id = box_id
    box.maxclass = 'number~'
    box.text = ''
    box.numinlets = 2
    box.numoutlets = 2
    box.outlettype = ['signal', 'float']
    box.patching_rect = [x, y, 56, 22]
    box.fontname = FONT_NAME
    box.fontsize = FONT_SIZE
    box.presentation = False
    box.presentation_rect = None
    box.extra_attrs = {'mode': 2, 'sig': 0.0, 'fontface': 0}
    box._inner_patcher = None
    box._saved_object_attributes = None
    box._bpatcher_attrs = None
    patcher.boxes.append(box)
    return box


def debug_ezdac(patcher, x=0, y=0):
    """Add an ezdac~ (clickable DSP toggle + audio output)."""
    box_id = patcher._gen_id()
    box = Box.__new__(Box)
    box.name = 'ezdac~'
    box.args = []
    box.id = box_id
    box.maxclass = 'ezdac~'
    box.text = ''
    box.numinlets = 2
    box.numoutlets = 0
    box.outlettype = []
    box.patching_rect = [x, y, 45, 45]
    box.fontname = FONT_NAME
    box.fontsize = FONT_SIZE
    box.presentation = False
    box.presentation_rect = None
    box.extra_attrs = {'parameter_enable': 0}
    box._inner_patcher = None
    box._saved_object_attributes = None
    box._bpatcher_attrs = None
    patcher.boxes.append(box)
    return box


# ============================================================================
# GEN~ CODE: Additive synthesis engine
# ============================================================================

GENEXPR_CODE = r"""
Param num_partials(8, min=1, max=32);
Param tilt(1.0, min=0, max=3);
Param stretch(1.0, min=0.5, max=2);
Param even_odd(0.5, min=0, max=1);
Param drift_amt(0.0, min=0, max=1);

Data phases(32);
History drift_clock(0);

freq = in1;
sum = 0;
sr = samplerate;

drift_clock = wrap(drift_clock + 1.0 / sr, 0, 1000);

if (freq > 0) {
    for (i = 0; i < 32; i = i + 1) {
        n = i + 1;

        if (n <= num_partials) {
            partial_freq = freq * pow(n, stretch);
            phase_inc = partial_freq / sr;

            drift_val = sin(drift_clock * TWOPI * 0.3 + n * 2.17) * drift_amt * 0.003;
            phase_inc = phase_inc * (1 + drift_val);

            phase = peek(phases, i);
            phase = phase + phase_inc;
            phase = wrap(phase, 0, 1);
            poke(phases, phase, i);

            amp = 1.0 / pow(n, tilt);

            if (n > 1) {
                is_even = (n % 2 == 0);
                if (is_even) {
                    amp = amp * clamp(even_odd * 2, 0, 1);
                } else {
                    amp = amp * clamp((1 - even_odd) * 2, 0, 1);
                }
            }

            sum = sum + sin(phase * TWOPI) * amp;
        } else {
            poke(phases, 0, i);
        }
    }

    sum = sum / sqrt(num_partials);
}

out1 = sum;
""".strip()


# ============================================================================
# JAVASCRIPT: Scala .scl file parser
# ============================================================================

SCALA_PARSER_JS = r"""
// scala-parser.js -- Parses Scala .scl files, writes MIDI-to-freq table to buffer~
// Inlets: 0 = bang (init 12-TET) or read <path>
// Outlets: 0 = scale name (symbol), 1 = num degrees (int)

inlets = 1;
outlets = 2;

var buf = new Buffer("scala-tuning");
var base_freq = 261.6255653;
var base_note = 60;
var scale_name = "12-TET";
var ratios = [];

function read(path) {
    var f = new File(path, "r");
    if (!f.isopen) {
        post("scala-parser: could not open " + path + "\n");
        return;
    }
    var lines = [];
    while (f.position < f.eof) {
        var line = f.readline();
        if (line !== null) lines.push(line);
    }
    f.close();
    parse_scl(lines);
    build_table();
}

function parse_scl(lines) {
    ratios = [];
    var header_done = false;
    var num_notes = 0;
    var count = 0;

    for (var i = 0; i < lines.length; i++) {
        var line = lines[i].trim();
        if (line.length === 0 || line.charAt(0) === '!') continue;

        if (!header_done) {
            scale_name = line;
            header_done = true;
            continue;
        }
        if (num_notes === 0) {
            num_notes = parseInt(line);
            continue;
        }
        if (count < num_notes) {
            var ratio = parse_pitch(line);
            if (ratio > 0) {
                ratios.push(ratio);
                count++;
            }
        }
    }
}

function parse_pitch(line) {
    var token = line.split(/\s+/)[0];
    if (token.indexOf('.') >= 0 && token.indexOf('/') < 0) {
        return Math.pow(2, parseFloat(token) / 1200);
    } else if (token.indexOf('/') >= 0) {
        var frac = token.split('/');
        return parseFloat(frac[0]) / parseFloat(frac[1]);
    } else {
        var val = parseInt(token);
        if (val > 24) return Math.pow(2, val / 1200);
        return val;
    }
}

function build_table() {
    var num_degrees = ratios.length;
    if (num_degrees === 0) {
        for (var i = 0; i < 128; i++) {
            buf.poke(1, i, 440 * Math.pow(2, (i - 69) / 12));
        }
        outlet(0, "12-TET");
        outlet(1, 12);
        return;
    }

    var period = ratios[num_degrees - 1];
    for (var midi = 0; midi < 128; midi++) {
        var degree_offset = midi - base_note;
        var periods_from_base, degree_in_scale;

        if (degree_offset >= 0) {
            periods_from_base = Math.floor(degree_offset / num_degrees);
            degree_in_scale = degree_offset % num_degrees;
        } else {
            periods_from_base = -Math.ceil(-degree_offset / num_degrees);
            degree_in_scale = ((degree_offset % num_degrees) + num_degrees) % num_degrees;
        }

        var ratio = (degree_in_scale === 0) ? 1.0 : ratios[degree_in_scale - 1];
        var freq = base_freq * Math.pow(period, periods_from_base) * ratio;
        buf.poke(1, midi, freq);
    }

    outlet(0, scale_name);
    outlet(1, num_degrees);
}

function bang() {
    build_table();
}

function msg_float(v) {
    if (inlet === 0) {
        base_freq = v;
        if (ratios.length > 0) build_table();
    }
}
""".strip()


# ============================================================================
# JAVASCRIPT: Partial amplitude display
# ============================================================================

PARTIAL_DISPLAY_JS = r"""
// partial-display.js -- Computes partial amplitudes for multislider
// Inlets: 0 = num_partials (int), 1 = tilt (float), 2 = even_odd (float)
// Outlet 0: list of 32 amplitude values

inlets = 3;
outlets = 1;

var num_partials = 8;
var tilt = 1.0;
var even_odd = 0.5;

function msg_int(v) {
    if (inlet === 0) {
        num_partials = Math.max(1, Math.min(32, v));
        compute();
    }
}

function msg_float(v) {
    if (inlet === 1) {
        tilt = v;
        compute();
    } else if (inlet === 2) {
        even_odd = v;
        compute();
    }
}

function bang() { compute(); }

function compute() {
    var amps = [];
    for (var i = 0; i < 32; i++) {
        var n = i + 1;
        if (n > num_partials) {
            amps.push(0);
        } else {
            var amp = 1.0 / Math.pow(n, tilt);
            if (n > 1) {
                var is_even = (n % 2 === 0);
                if (is_even) {
                    amp *= Math.min(1, Math.max(0, even_odd * 2));
                } else {
                    amp *= Math.min(1, Math.max(0, (1 - even_odd) * 2));
                }
            }
            amps.push(amp);
        }
    }
    outlet(0, amps);
}

function loadbang() { compute(); }
""".strip()


# ============================================================================
# VOICE PATCH: scala-synth-voice.maxpat
# ============================================================================

def build_voice():
    """Build the poly~ voice patch with additive gen~ engine.

    Signal chain:
      in 1 (MIDI note) -> peek~ scala-tuning -> sig~ -> gen~ additive engine
      -> *~ (ADSR envelope) -> *~ (velocity) -> out~ 1
    """
    v = Patcher(db=db)

    # --- Poly~ voice inputs with format descriptions ---
    in_note = manual_box(v, 'in', 'in 1', 1, 1, [''])
    in_note._saved_object_attributes = {
        "attr_comment": "MIDI note number (0-127 int)",
        "c": ""
    }
    in_vel = manual_box(v, 'in', 'in 2', 1, 1, [''])
    in_vel._saved_object_attributes = {
        "attr_comment": "Velocity (0-127 int, 0=note-off)",
        "c": ""
    }

    # ---- STAGE 1: Frequency Lookup ----
    v.add_comment('--- STAGE 1: MIDI note -> Hz via peek~ scala-tuning buffer ---')
    peek_freq = v.add_box('peek~', ['scala-tuning'])
    sig_freq = v.add_box('sig~')

    # DEBUG: show frequency values
    dbg_freq_float = debug_number_tilde(v)
    v.add_comment('DEBUG: freq from peek~ (Hz, expect ~262 for C4/note 60)')
    dbg_freq_sig = debug_number_tilde(v)
    v.add_comment('DEBUG: freq signal entering gen~ (should match above)')

    # ---- STAGE 2: Additive Synthesis ----
    v.add_comment('--- STAGE 2: Gen~ additive synthesis (codebox, 1-32 partials) ---')
    gen_box, _ = v.add_gen(GENEXPR_CODE, num_inputs=1, num_outputs=1)

    # DEBUG: monitor gen~ output
    dbg_gen_meter = debug_meter(v)
    dbg_gen_num = debug_number_tilde(v)
    v.add_comment('DEBUG: gen~ output level -- if ZERO here, gen~ is the problem')

    # ---- STAGE 3: ADSR Envelope ----
    v.add_comment('--- STAGE 3: ADSR envelope (triggered by velocity) ---')
    adsr = v.add_box('adsr~')
    dbg_adsr_meter = debug_meter(v)
    v.add_comment('DEBUG: ADSR level -- should rise on note-on, fall on note-off')

    mult_env = v.add_box('*~')
    v.add_comment('gen~ output * ADSR envelope')

    # ---- STAGE 3b: Velocity ----
    v.add_comment('--- STAGE 3b: Velocity processing ---')
    trig_vel = v.add_box('trigger', ['f', 'f'])
    split_vel = v.add_box('split', ['1', '127'])
    vel_scale = v.add_box('scale', ['0', '127', '0.', '1.'])
    vel_sig = v.add_box('sig~')
    v.add_comment('trigger fires R-to-L: out1->adsr~(gate), out0->split->scale->sig~')

    # ---- STAGE 4: Velocity Scaling ----
    v.add_comment('--- STAGE 4: Apply velocity ---')
    mult_vel = v.add_box('*~')
    v.add_comment('(gen~ * ADSR) * velocity_normalized')

    # ---- STAGE 5: Final Output ----
    v.add_comment('--- STAGE 5: Voice output ---')
    dbg_out_meter = debug_meter(v)
    dbg_out_num = debug_number_tilde(v)
    v.add_comment('DEBUG: final voice output -- if ZERO here but gen~ is nonzero, check ADSR/vel')

    out_sig = manual_box(v, 'out~', 'out~ 1', 1, 0, [])
    out_sig._saved_object_attributes = {
        "attr_comment": "Audio signal out (gen~ * ADSR * velocity)",
        "c": ""
    }

    # --- ADSR parameter receives ---
    v.add_comment('--- ADSR params via send/receive (atk ms, dec ms, sus 0-1, rel ms) ---')
    recv_atk = v.add_box('receive', ['scala-atk'])
    recv_dec = v.add_box('receive', ['scala-dec'])
    recv_sus = v.add_box('receive', ['scala-sus'])
    recv_rel = v.add_box('receive', ['scala-rel'])

    # --- Gen~ parameter receives + prepends ---
    v.add_comment('--- Gen~ params via send/receive (prepend param_name value -> gen~) ---')
    gen_params = [
        ('scala-partials', 'num_partials'),
        ('scala-tilt', 'tilt'),
        ('scala-stretch', 'stretch'),
        ('scala-evenodd', 'even_odd'),
        ('scala-drift', 'drift_amt'),
    ]
    recv_gen = []
    prep_gen = []
    for recv_name, param_name in gen_params:
        r = v.add_box('receive', [recv_name])
        p = v.add_box('prepend', [param_name])
        recv_gen.append(r)
        prep_gen.append(p)

    # === SIGNAL CHAIN CONNECTIONS ===
    v.add_connection(in_note, 0, peek_freq, 0)          # note num -> peek~ index
    v.add_connection(peek_freq, 0, dbg_freq_float, 0)   # DEBUG: show freq float
    v.add_connection(peek_freq, 0, sig_freq, 0)         # freq float -> sig~
    v.add_connection(sig_freq, 0, dbg_freq_sig, 0)      # DEBUG: show freq signal
    v.add_connection(sig_freq, 0, gen_box, 0)           # freq signal -> gen~

    v.add_connection(gen_box, 0, dbg_gen_meter, 0)      # DEBUG: gen~ output meter
    v.add_connection(gen_box, 0, dbg_gen_num, 0)        # DEBUG: gen~ output value
    v.add_connection(gen_box, 0, mult_env, 0)           # gen~ out -> *~ env in 0

    v.add_connection(adsr, 0, dbg_adsr_meter, 0)        # DEBUG: ADSR meter
    v.add_connection(adsr, 0, mult_env, 1)              # adsr~ -> *~ env in 1

    v.add_connection(mult_env, 0, mult_vel, 0)          # env'd signal -> *~ vel in 0
    v.add_connection(vel_sig, 0, mult_vel, 1)           # vel signal -> *~ vel in 1

    v.add_connection(mult_vel, 0, dbg_out_meter, 0)     # DEBUG: final output meter
    v.add_connection(mult_vel, 0, dbg_out_num, 0)       # DEBUG: final output value
    v.add_connection(mult_vel, 0, out_sig, 0)           # final -> out~ 1

    # === VELOCITY ROUTING ===
    # trigger fires right (out 1) first, left (out 0) second
    v.add_connection(in_vel, 0, trig_vel, 0)            # vel -> trigger
    v.add_connection(trig_vel, 1, adsr, 0)              # vel -> adsr~ (trigger/release)
    v.add_connection(trig_vel, 0, split_vel, 0)         # vel -> split 1 127
    v.add_connection(split_vel, 0, vel_scale, 0)        # vel 1-127 -> scale
    v.add_connection(vel_scale, 0, vel_sig, 0)          # normalized -> sig~

    # === ADSR PARAMS ===
    v.add_connection(recv_atk, 0, adsr, 1)
    v.add_connection(recv_dec, 0, adsr, 2)
    v.add_connection(recv_sus, 0, adsr, 3)
    v.add_connection(recv_rel, 0, adsr, 4)

    # === GEN~ PARAMS ===
    for r, p in zip(recv_gen, prep_gen):
        v.add_connection(r, 0, p, 0)
        v.add_connection(p, 0, gen_box, 0)

    return v


# ============================================================================
# MAIN PATCH: scala-synth.maxpat
# ============================================================================

def build_main():
    """Build the main patch with full UI and presentation mode."""
    p = Patcher(db=db)
    p.props["openinpresentation"] = 1

    # ==================================================================
    # MIDI INPUT
    # ==================================================================
    # BUG FIX: removed stripnote -- it was blocking note-offs (vel=0),
    # preventing ADSR release. notein fires R-to-L (vel before note),
    # so pack gets vel in cold inlet first, then note in hot inlet.
    p.add_comment('--- MIDI INPUT: notein -> pack -> prepend midinote -> poly~ ---')
    notein_box = p.add_box('notein')
    pack_midi = p.add_box('pack', ['i', 'i'])
    prepend_midi = p.add_box('prepend', ['midinote'])

    # DEBUG: show MIDI note and velocity values
    dbg_note_num = p.add_box('number')
    dbg_vel_num = p.add_box('number')
    p.add_comment('DEBUG: MIDI note (left) and velocity (right)')

    # DEBUG: print messages going to poly~
    dbg_print = p.add_box('print', ['scala-midi'])
    p.add_comment('DEBUG: check Max console for "scala-midi: midinote <note> <vel>"')

    # poly~ (manual: DB has 1in/0out but loaded voice gives 2in/2out)
    poly_box = manual_box(p, 'poly~',
                          'poly~ scala-synth-voice 16 @steal 1',
                          1, 2, ['signal', ''])

    # DEBUG: manual test note buttons (click to test without MIDI controller)
    test_note_on = p.add_message('midinote 60 100')
    test_note_off = p.add_message('midinote 60 0')
    test_note_on_btn = p.add_box('button')
    test_note_off_btn = p.add_box('button')
    p.add_comment('DEBUG: Click buttons to send test note on/off to poly~')
    p.add_comment('Left=note on (C4 vel 100), Right=note off (C4 vel 0)')

    # MIDI connections: notein -> pack -> prepend -> poly~
    # notein fires R-to-L: outlet 1 (vel) before outlet 0 (note)
    p.add_connection(notein_box, 1, pack_midi, 1)       # vel -> pack cold (first)
    p.add_connection(notein_box, 0, pack_midi, 0)       # note -> pack hot (triggers)
    p.add_connection(pack_midi, 0, prepend_midi, 0)
    p.add_connection(prepend_midi, 0, poly_box, 0)

    # DEBUG connections
    p.add_connection(notein_box, 0, dbg_note_num, 0)    # show note number
    p.add_connection(notein_box, 1, dbg_vel_num, 0)     # show velocity
    p.add_connection(prepend_midi, 0, dbg_print, 0)     # print to console

    # Test note button connections
    p.add_connection(test_note_on_btn, 0, test_note_on, 0)
    p.add_connection(test_note_off_btn, 0, test_note_off, 0)
    p.add_connection(test_note_on, 0, poly_box, 0)
    p.add_connection(test_note_off, 0, poly_box, 0)

    # ==================================================================
    # FILE LOADING
    # ==================================================================
    load_btn = p.add_box('button')
    opendialog_box = manual_box(p, 'opendialog', 'opendialog .scl',
                                1, 1, [''])
    prepend_read = p.add_box('prepend', ['read'])
    dropfile_box = p.add_box('dropfile')

    js_parser, _ = p.add_js('scala-parser.js', num_inlets=1, num_outlets=2)
    buffer_tuning = p.add_box('buffer~', ['scala-tuning'])

    # Scale info display
    scale_name_msg = p.add_message('12-TET')
    prepend_set_name = p.add_box('prepend', ['set'])
    degrees_display = p.add_box('number')

    # File loading connections
    p.add_connection(load_btn, 0, opendialog_box, 0)
    p.add_connection(opendialog_box, 0, prepend_read, 0)
    p.add_connection(dropfile_box, 0, prepend_read, 0)
    p.add_connection(prepend_read, 0, js_parser, 0)

    # Scale info display connections
    p.add_connection(js_parser, 0, prepend_set_name, 0)  # name -> prepend set
    p.add_connection(prepend_set_name, 0, scale_name_msg, 0)  # set name -> msg
    p.add_connection(js_parser, 1, degrees_display, 0)    # degrees -> number

    # ==================================================================
    # SYNTH PARAMETER CONTROLS (send to voices via send/receive)
    # ==================================================================

    # Partials: number box (integer 1-32)
    partials_num = p.add_box('number')
    partials_num.extra_attrs['minimum'] = 1
    partials_num.extra_attrs['maximum'] = 32
    send_partials = p.add_box('send', ['scala-partials'])
    p.add_connection(partials_num, 0, send_partials, 0)

    # Dial-based synth params: name, send_name, scale_args
    synth_dial_params = [
        ('tilt',    'scala-tilt',    ['0', '127', '0.', '3.']),
        ('stretch', 'scala-stretch', ['0', '127', '0.5', '2.']),
        ('evenodd', 'scala-evenodd', ['0', '127', '0.', '1.']),
        ('drift',   'scala-drift',   ['0', '127', '0.', '1.']),
    ]

    dials = {}
    scales = {}
    for name, send_name, scale_args in synth_dial_params:
        d = p.add_box('dial')
        s = p.add_box('scale', scale_args)
        snd = p.add_box('send', [send_name])
        p.add_connection(d, 0, s, 0)
        p.add_connection(s, 0, snd, 0)
        dials[name] = d
        scales[name] = s

    # ADSR params
    adsr_dial_params = [
        ('atk', 'scala-atk', ['0', '127', '1.', '2000.']),
        ('dec', 'scala-dec', ['0', '127', '1.', '2000.']),
        ('sus', 'scala-sus', ['0', '127', '0.', '1.']),
        ('rel', 'scala-rel', ['0', '127', '1.', '5000.']),
    ]

    for name, send_name, scale_args in adsr_dial_params:
        d = p.add_box('dial')
        s = p.add_box('scale', scale_args)
        snd = p.add_box('send', [send_name])
        p.add_connection(d, 0, s, 0)
        p.add_connection(s, 0, snd, 0)
        dials[name] = d
        scales[name] = s

    # Volume (main patch only, no send to voices)
    vol_dial = p.add_box('dial')
    vol_scale = p.add_box('scale', ['0', '127', '0.', '1.'])
    vol_sig = p.add_box('sig~')
    p.add_connection(vol_dial, 0, vol_scale, 0)
    p.add_connection(vol_scale, 0, vol_sig, 0)
    dials['vol'] = vol_dial
    scales['vol'] = vol_scale

    # ==================================================================
    # OUTPUT SECTION
    # ==================================================================
    p.add_comment('--- OUTPUT: poly~ -> *~ master vol -> ezdac~ ---')
    master_vol = p.add_box('*~')
    ezdac_box = debug_ezdac(p)
    level_meter = p.add_box('levelmeter~')
    spectro = p.add_box('spectroscope~')

    # DEBUG: meter after poly~ (before master volume)
    dbg_poly_meter = debug_meter(p)
    p.add_comment('DEBUG: poly~ raw output level (if zero, no signal from voices)')

    # DEBUG: meter after master volume
    dbg_master_meter = debug_meter(p)
    p.add_comment('DEBUG: master output level (if zero but poly~ meter shows signal, check volume)')

    p.add_connection(poly_box, 0, dbg_poly_meter, 0)  # DEBUG: poly~ meter
    p.add_connection(poly_box, 0, master_vol, 0)      # poly~ sig -> *~
    p.add_connection(vol_sig, 0, master_vol, 1)        # vol sig -> *~
    p.add_connection(master_vol, 0, dbg_master_meter, 0)  # DEBUG: master meter
    p.add_connection(master_vol, 0, ezdac_box, 0)      # -> ezdac~ L
    p.add_connection(master_vol, 0, ezdac_box, 1)      # -> ezdac~ R
    p.add_connection(master_vol, 0, level_meter, 0)
    p.add_connection(master_vol, 0, spectro, 0)

    # ==================================================================
    # TEST TONE (bypass synth to verify audio output works)
    # ==================================================================
    p.add_comment('--- TEST TONE: toggle on to hear 440Hz sine ---')
    p.add_comment('If you hear this but not the synth, problem is in poly~/voice')
    test_toggle = p.add_box('toggle')
    test_cycle = p.add_box('cycle~', ['440'])
    test_gain = p.add_box('*~')
    test_vol_msg = p.add_message('0.1')
    test_vol_sig = p.add_box('sig~')
    test_meter = debug_meter(p)
    test_lbl = p.add_comment('TEST TONE')

    p.add_connection(test_toggle, 0, test_vol_msg, 0)
    p.add_connection(test_vol_msg, 0, test_vol_sig, 0)
    p.add_connection(test_cycle, 0, test_gain, 0)       # cycle~ -> *~
    p.add_connection(test_vol_sig, 0, test_gain, 1)     # 0 or 0.1 -> *~
    p.add_connection(test_gain, 0, test_meter, 0)       # DEBUG: test meter
    p.add_connection(test_gain, 0, ezdac_box, 0)        # -> ezdac~ L
    p.add_connection(test_gain, 0, ezdac_box, 1)        # -> ezdac~ R

    # ==================================================================
    # GEN~ ISOLATION TEST
    # ==================================================================
    p.add_comment('--- GEN~ TEST: test additive engine outside poly~ ---')
    p.add_comment('Enter frequency, toggle on to hear. Tests gen~ codebox directly.')
    gen_test_freq = p.add_box('number')
    gen_test_freq.extra_attrs['minimum'] = 20
    gen_test_freq.extra_attrs['maximum'] = 2000
    gen_test_sig = p.add_box('sig~')
    gen_test_box, _ = p.add_gen(GENEXPR_CODE, num_inputs=1, num_outputs=1)
    gen_test_gain = p.add_box('*~')
    gen_test_toggle = p.add_box('toggle')
    gen_test_vol_msg = p.add_message('0.1')
    gen_test_vol_sig = p.add_box('sig~')
    gen_test_meter = debug_meter(p)
    gen_test_num = debug_number_tilde(p)
    gen_test_lbl = p.add_comment('GEN~ TEST')
    gen_test_freq_lbl = p.add_comment('Freq (Hz):')
    p.add_comment('DEBUG: gen~ test meter -- if this shows level, gen~ codebox works')

    # Init test freq to 440 (connected from loadbang in init chain below)

    p.add_connection(gen_test_freq, 0, gen_test_sig, 0)
    p.add_connection(gen_test_sig, 0, gen_test_box, 0)
    p.add_connection(gen_test_box, 0, gen_test_meter, 0)
    p.add_connection(gen_test_box, 0, gen_test_num, 0)
    p.add_connection(gen_test_box, 0, gen_test_gain, 0)
    p.add_connection(gen_test_toggle, 0, gen_test_vol_msg, 0)
    p.add_connection(gen_test_vol_msg, 0, gen_test_vol_sig, 0)
    p.add_connection(gen_test_vol_sig, 0, gen_test_gain, 1)
    p.add_connection(gen_test_gain, 0, ezdac_box, 0)
    p.add_connection(gen_test_gain, 0, ezdac_box, 1)

    # ==================================================================
    # PARTIAL DISPLAY
    # ==================================================================
    js_partial, _ = p.add_js('partial-display.js',
                             num_inlets=3, num_outlets=1)
    partial_ms = p.add_box('multislider')
    partial_ms.extra_attrs['size'] = 32
    partial_ms.extra_attrs['setminmax'] = [0.0, 1.0]
    partial_ms.extra_attrs['setstyle'] = 1

    # Connect param sources to partial display js
    p.add_connection(partials_num, 0, js_partial, 0)
    p.add_connection(scales['tilt'], 0, js_partial, 1)
    p.add_connection(scales['evenodd'], 0, js_partial, 2)
    p.add_connection(js_partial, 0, partial_ms, 0)

    # ==================================================================
    # LABELS (comments)
    # ==================================================================
    title_lbl = p.add_comment('SCALA SYNTH')
    file_lbl = p.add_comment('Load .scl:')
    partials_lbl = p.add_comment('PARTIALS')
    tilt_lbl = p.add_comment('TILT')
    stretch_lbl = p.add_comment('STRETCH')
    evenodd_lbl = p.add_comment('EVEN/ODD')
    drift_lbl = p.add_comment('DRIFT')
    atk_lbl = p.add_comment('ATTACK')
    dec_lbl = p.add_comment('DECAY')
    sus_lbl = p.add_comment('SUSTAIN')
    rel_lbl = p.add_comment('RELEASE')
    vol_lbl = p.add_comment('VOLUME')
    partial_disp_lbl = p.add_comment('Partial Amplitudes')
    spectro_lbl = p.add_comment('Spectrum')
    scale_lbl = p.add_comment('Scale:')
    deg_lbl = p.add_comment('Degrees:')

    # ==================================================================
    # INIT CHAIN (loadbang -> trigger -> defaults)
    # ==================================================================
    loadbang = p.add_box('loadbang')
    init_trig = p.add_box('trigger',
                          ['b', 'b', 'b', 'b', 'b', 'b', 'b',
                           'b', 'b', 'b', 'b', 'b', 'b'])

    # Init messages (right-to-left firing order)
    init_test_freq = p.add_message('440')             # out 12 (1st) - gen~ test freq
    init_buf = p.add_message('sizeinsamps 128')       # out 11
    init_vol = p.add_message('100')                   # out 10
    init_rel = p.add_message('15')                    # out 9
    init_sus = p.add_message('90')                    # out 8
    init_dec = p.add_message('30')                    # out 7
    init_atk = p.add_message('5')                     # out 6
    init_drift = p.add_message('0')                   # out 5
    init_evenodd = p.add_message('64')                # out 4
    init_stretch = p.add_message('42')                # out 3
    init_tilt = p.add_message('43')                   # out 2
    init_partials = p.add_message('8')                # out 1
    init_js = p.add_message('bang')                   # out 0 (last)

    p.add_connection(loadbang, 0, init_trig, 0)

    # out 12 -> gen~ test freq init
    p.add_connection(init_trig, 12, init_test_freq, 0)
    p.add_connection(init_test_freq, 0, gen_test_freq, 0)

    # out 11 -> buffer size
    p.add_connection(init_trig, 11, init_buf, 0)
    p.add_connection(init_buf, 0, buffer_tuning, 0)

    # out 10 -> volume dial
    p.add_connection(init_trig, 10, init_vol, 0)
    p.add_connection(init_vol, 0, vol_dial, 0)

    # out 9 -> release dial
    p.add_connection(init_trig, 9, init_rel, 0)
    p.add_connection(init_rel, 0, dials['rel'], 0)

    # out 8 -> sustain dial
    p.add_connection(init_trig, 8, init_sus, 0)
    p.add_connection(init_sus, 0, dials['sus'], 0)

    # out 7 -> decay dial
    p.add_connection(init_trig, 7, init_dec, 0)
    p.add_connection(init_dec, 0, dials['dec'], 0)

    # out 6 -> attack dial
    p.add_connection(init_trig, 6, init_atk, 0)
    p.add_connection(init_atk, 0, dials['atk'], 0)

    # out 5 -> drift dial
    p.add_connection(init_trig, 5, init_drift, 0)
    p.add_connection(init_drift, 0, dials['drift'], 0)

    # out 4 -> even/odd dial
    p.add_connection(init_trig, 4, init_evenodd, 0)
    p.add_connection(init_evenodd, 0, dials['evenodd'], 0)

    # out 3 -> stretch dial
    p.add_connection(init_trig, 3, init_stretch, 0)
    p.add_connection(init_stretch, 0, dials['stretch'], 0)

    # out 2 -> tilt dial
    p.add_connection(init_trig, 2, init_tilt, 0)
    p.add_connection(init_tilt, 0, dials['tilt'], 0)

    # out 1 -> partials number
    p.add_connection(init_trig, 1, init_partials, 0)
    p.add_connection(init_partials, 0, partials_num, 0)

    # out 0 -> js init (fires last, buffer is ready)
    p.add_connection(init_trig, 0, init_js, 0)
    p.add_connection(init_js, 0, js_parser, 0)

    # ==================================================================
    # PRESENTATION MODE LAYOUT
    # ==================================================================
    # Column positions (5 columns of 110px each)
    cx = [15, 125, 235, 345, 455]
    dial_off = 30  # center 50px dial in 110px column

    # --- Title ---
    title_lbl.presentation = True
    title_lbl.presentation_rect = [15, 5, 200, 28]
    title_lbl.extra_attrs['fontsize'] = 20.0
    title_lbl.extra_attrs['fontface'] = 1  # bold

    # --- File loading row (y=38) ---
    file_lbl.presentation = True
    file_lbl.presentation_rect = [15, 40, 65, 18]

    load_btn.presentation = True
    load_btn.presentation_rect = [82, 38, 24, 24]

    dropfile_box.presentation = True
    dropfile_box.presentation_rect = [112, 38, 100, 24]

    scale_lbl.presentation = True
    scale_lbl.presentation_rect = [220, 40, 40, 18]

    scale_name_msg.presentation = True
    scale_name_msg.presentation_rect = [262, 38, 120, 22]

    deg_lbl.presentation = True
    deg_lbl.presentation_rect = [390, 40, 55, 18]

    degrees_display.presentation = True
    degrees_display.presentation_rect = [448, 38, 40, 22]

    # --- Synth param labels (y=72) ---
    partials_lbl.presentation = True
    partials_lbl.presentation_rect = [cx[0] + 20, 72, 70, 16]

    tilt_lbl.presentation = True
    tilt_lbl.presentation_rect = [cx[1] + 35, 72, 40, 16]

    stretch_lbl.presentation = True
    stretch_lbl.presentation_rect = [cx[2] + 25, 72, 60, 16]

    evenodd_lbl.presentation = True
    evenodd_lbl.presentation_rect = [cx[3] + 22, 72, 65, 16]

    drift_lbl.presentation = True
    drift_lbl.presentation_rect = [cx[4] + 32, 72, 45, 16]

    # --- Synth param controls (y=90) ---
    partials_num.presentation = True
    partials_num.presentation_rect = [cx[0] + 25, 92, 55, 22]

    dials['tilt'].presentation = True
    dials['tilt'].presentation_rect = [cx[1] + dial_off, 90, 50, 50]

    dials['stretch'].presentation = True
    dials['stretch'].presentation_rect = [cx[2] + dial_off, 90, 50, 50]

    dials['evenodd'].presentation = True
    dials['evenodd'].presentation_rect = [cx[3] + dial_off, 90, 50, 50]

    dials['drift'].presentation = True
    dials['drift'].presentation_rect = [cx[4] + dial_off, 90, 50, 50]

    # --- ADSR labels (y=150) ---
    atk_lbl.presentation = True
    atk_lbl.presentation_rect = [cx[0] + 25, 150, 55, 16]

    dec_lbl.presentation = True
    dec_lbl.presentation_rect = [cx[1] + 30, 150, 50, 16]

    sus_lbl.presentation = True
    sus_lbl.presentation_rect = [cx[2] + 22, 150, 65, 16]

    rel_lbl.presentation = True
    rel_lbl.presentation_rect = [cx[3] + 22, 150, 60, 16]

    vol_lbl.presentation = True
    vol_lbl.presentation_rect = [cx[4] + 25, 150, 55, 16]

    # --- ADSR + volume controls (y=168) ---
    dials['atk'].presentation = True
    dials['atk'].presentation_rect = [cx[0] + dial_off, 168, 50, 50]

    dials['dec'].presentation = True
    dials['dec'].presentation_rect = [cx[1] + dial_off, 168, 50, 50]

    dials['sus'].presentation = True
    dials['sus'].presentation_rect = [cx[2] + dial_off, 168, 50, 50]

    dials['rel'].presentation = True
    dials['rel'].presentation_rect = [cx[3] + dial_off, 168, 50, 50]

    vol_dial.presentation = True
    vol_dial.presentation_rect = [cx[4] + dial_off, 168, 50, 50]

    # Level meter beside volume
    level_meter.presentation = True
    level_meter.presentation_rect = [cx[4] + dial_off + 55, 168, 20, 50]

    # --- Partial display (y=230) ---
    partial_disp_lbl.presentation = True
    partial_disp_lbl.presentation_rect = [15, 228, 120, 16]

    partial_ms.presentation = True
    partial_ms.presentation_rect = [15, 246, 550, 75]

    # --- Spectroscope (y=328) ---
    spectro_lbl.presentation = True
    spectro_lbl.presentation_rect = [15, 326, 80, 16]

    spectro.presentation = True
    spectro.presentation_rect = [15, 344, 550, 120]

    # --- ezdac~ toggle (y=475) ---
    ezdac_box.presentation = True
    ezdac_box.presentation_rect = [15, 475, 45, 45]

    dsp_lbl = p.add_comment('DSP ON/OFF')
    dsp_lbl.presentation = True
    dsp_lbl.presentation_rect = [65, 488, 70, 18]

    # --- Debug meters (y=475) ---
    dbg_poly_meter.presentation = True
    dbg_poly_meter.presentation_rect = [160, 475, 16, 45]

    poly_meter_lbl = p.add_comment('poly~')
    poly_meter_lbl.presentation = True
    poly_meter_lbl.presentation_rect = [148, 522, 40, 16]

    dbg_master_meter.presentation = True
    dbg_master_meter.presentation_rect = [200, 475, 16, 45]

    master_meter_lbl = p.add_comment('master')
    master_meter_lbl.presentation = True
    master_meter_lbl.presentation_rect = [186, 522, 45, 16]

    # --- Test note buttons (y=475) ---
    test_note_lbl = p.add_comment('TEST NOTE:')
    test_note_lbl.presentation = True
    test_note_lbl.presentation_rect = [250, 488, 72, 18]

    test_note_on_btn.presentation = True
    test_note_on_btn.presentation_rect = [325, 483, 24, 24]

    note_on_lbl = p.add_comment('ON')
    note_on_lbl.presentation = True
    note_on_lbl.presentation_rect = [328, 509, 20, 16]

    test_note_off_btn.presentation = True
    test_note_off_btn.presentation_rect = [355, 483, 24, 24]

    note_off_lbl = p.add_comment('OFF')
    note_off_lbl.presentation = True
    note_off_lbl.presentation_rect = [354, 509, 25, 16]

    # --- Test tone toggle (y=475) ---
    test_lbl.presentation = True
    test_lbl.presentation_rect = [400, 488, 72, 18]

    test_toggle.presentation = True
    test_toggle.presentation_rect = [475, 483, 24, 24]

    test_meter.presentation = True
    test_meter.presentation_rect = [505, 475, 16, 45]

    # --- Gen~ test (y=540) ---
    gen_test_lbl.presentation = True
    gen_test_lbl.presentation_rect = [15, 545, 72, 18]

    gen_test_freq_lbl.presentation = True
    gen_test_freq_lbl.presentation_rect = [90, 545, 65, 18]

    gen_test_freq.presentation = True
    gen_test_freq.presentation_rect = [155, 543, 55, 22]

    gen_test_toggle.presentation = True
    gen_test_toggle.presentation_rect = [220, 543, 24, 24]

    gen_test_meter.presentation = True
    gen_test_meter.presentation_rect = [250, 535, 16, 45]

    gen_test_num.presentation = True
    gen_test_num.presentation_rect = [272, 543, 56, 22]

    return p


# ============================================================================
# MAIN
# ============================================================================

if __name__ == "__main__":
    print("Building scala-synth...")

    # Write JS files
    print("  Writing scala-parser.js...")
    results = write_js(SCALA_PARSER_JS, BASE / 'scala-parser.js')
    for r in results:
        print(f"    {r}")

    print("  Writing partial-display.js...")
    results = write_js(PARTIAL_DISPLAY_JS, BASE / 'partial-display.js')
    for r in results:
        print(f"    {r}")

    # Build and write voice patch
    print("  Building scala-synth-voice.maxpat...")
    voice = build_voice()
    results = write_patch(voice, BASE / 'scala-synth-voice.maxpat')
    for r in results:
        print(f"    {r}")

    # Build and write main patch
    print("  Building scala-synth.maxpat...")
    main = build_main()
    results = write_patch(main, BASE / 'scala-synth.maxpat')
    for r in results:
        print(f"    {r}")

    print("\nDone! Files written to:")
    print(f"  {BASE / 'scala-synth.maxpat'}")
    print(f"  {BASE / 'scala-synth-voice.maxpat'}")
    print(f"  {BASE / 'scala-parser.js'}")
    print(f"  {BASE / 'partial-display.js'}")
