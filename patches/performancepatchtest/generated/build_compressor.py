#!/usr/bin/env python3
"""Generate comp-band.maxpat and update p input-processing in performancepatchtest.maxpat."""

import json

# ─── Helpers ───

def box(id_, maxclass, numinlets, numoutlets, outlettype, prect, text=None, extra=None):
    b = {
        "fontname": "Arial",
        "fontsize": 12.0,
        "id": id_,
        "maxclass": maxclass,
        "numinlets": numinlets,
        "numoutlets": numoutlets,
        "outlettype": outlettype,
        "patching_rect": prect,
    }
    if text:
        b["text"] = text
    if extra:
        b.update(extra)
    return {"box": b}

def dial_box(id_, prect, pres_rect, varname=None):
    b = {
        "maxclass": "dial",
        "id": id_,
        "numinlets": 1,
        "numoutlets": 1,
        "outlettype": [""],
        "patching_rect": prect,
        "parameter_enable": 0,
        "presentation": 1,
        "presentation_rect": pres_rect,
    }
    if varname:
        b["varname"] = varname
    return {"box": b}

def flonum_box(id_, prect, pres_rect):
    return {"box": {
        "maxclass": "flonum",
        "fontname": "Arial",
        "fontsize": 9.0,
        "id": id_,
        "numinlets": 1,
        "numoutlets": 2,
        "outlettype": ["", "bang"],
        "patching_rect": prect,
        "parameter_enable": 0,
        "presentation": 1,
        "presentation_rect": pres_rect,
        "numdecimalplaces": 1,
        "triangle": 0,
    }}

def comment_box(id_, prect, text, pres_rect=None, fontsize=12.0):
    b = {
        "fontname": "Arial",
        "fontsize": fontsize,
        "maxclass": "comment",
        "id": id_,
        "numinlets": 1,
        "numoutlets": 0,
        "patching_rect": prect,
        "text": text,
    }
    if pres_rect:
        b["presentation"] = 1
        b["presentation_rect"] = pres_rect
    return {"box": b}

def line(src_id, src_out, dst_id, dst_in, midpoints=None):
    l = {
        "source": [src_id, src_out],
        "destination": [dst_id, dst_in],
    }
    if midpoints:
        l["midpoints"] = midpoints
    return {"patchline": l}


# ═══════════════════════════════════════════════════════════════════
# 1. comp-band.maxpat
# ═══════════════════════════════════════════════════════════════════

def build_comp_band():
    boxes = []
    lines = []

    # ── Signal path ──
    boxes.append({"box": {
        "maxclass": "inlet",
        "id": "obj-1",
        "numinlets": 0,
        "numoutlets": 1,
        "outlettype": ["signal"],
        "patching_rect": [30, 30, 30, 30],
        "comment": "Signal Input",
    }})
    boxes.append(box("obj-2", "newobj", 1, 1,
                      ["signal"],
                      [30, 70, 200, 22],
                      "gen~ @gen comp-engine.gendsp"))
    boxes.append({"box": {
        "maxclass": "outlet",
        "id": "obj-3",
        "numinlets": 1,
        "numoutlets": 0,
        "outlettype": [],
        "patching_rect": [30, 460, 30, 30],
        "comment": "Signal Output",
    }})
    boxes.append({"box": {
        "maxclass": "meter~",
        "id": "obj-4",
        "numinlets": 1,
        "numoutlets": 1,
        "outlettype": ["float"],
        "patching_rect": [200, 70, 80, 18],
        "parameter_enable": 0,
        "presentation": 1,
        "presentation_rect": [5, 164, 140, 16],
    }})

    lines.append(line("obj-1", 0, "obj-2", 0))    # inlet → gen~ compressor
    lines.append(line("obj-2", 0, "obj-3", 0))    # gen~ compressor → outlet
    lines.append(line("obj-2", 0, "obj-4", 0))    # gen~ compressor → meter~

    # ── Band label ──
    boxes.append(comment_box("obj-10", [200, 30, 100, 20], "#1", [5, 2, 140, 16]))

    # ── Defaults: loadbang → trigger → messages → dials ──
    # Neutral settings: thresh=0 (no compression), ratio=0 (→1:1), gain=64 (→0dB),
    # atk=13 (→~10ms), rel=12 (→~100ms)
    boxes.append(box("obj-30", "newobj", 1, 1, ["bang"],
                      [300, 30, 72, 22], "loadbang"))
    boxes.append(box("obj-31", "newobj", 1, 5,
                      ["bang", "bang", "bang", "bang", "bang"],
                      [300, 60, 100, 22], "trigger b b b b b"))
    lines.append(line("obj-30", 0, "obj-31", 0))

    default_vals = [
        # (msg_id, value, trigger_outlet, target_dial_id, msg_x)
        ("obj-32", "127", 4, "obj-5",  300),   # thresh=127 → 0dB (no compression)
        ("obj-33", "0",   3, "obj-6",  350),   # ratio=0 → 1:1
        ("obj-34", "64",  2, "obj-7",  400),   # gain=64 → 0dB
        ("obj-35", "13",  1, "obj-8",  300),   # atk=13 → ~10ms
        ("obj-36", "12",  0, "obj-9",  350),   # rel=12 → ~100ms
    ]
    for msg_id, val, trig_out, dial_id, mx in default_vals:
        y = 95 if trig_out >= 2 else 130
        boxes.append(box(msg_id, "message", 2, 1, [""],
                          [mx, y, 30, 22], val))
        lines.append(line("obj-31", trig_out, msg_id, 0))
        lines.append(line(msg_id, 0, dial_id, 0))

    # ── autopattr for state persistence ──
    boxes.append(box("obj-45", "newobj", 1, 4,
                      ["", "", "", ""],
                      [300, 170, 140, 22], "autopattr @autoname 1"))

    # ── Parameter controls ──
    # Presentation layout:
    #   y=2  h=16: Band label
    #   y=20 h=12: Row 1 labels (Thresh, Ratio, Gain)
    #   y=34 h=40: Row 1 dials
    #   y=76 h=14: Row 1 readouts
    #   y=94 h=12: Row 2 labels (Atk, Rel)
    #   y=108 h=40: Row 2 dials
    #   y=150 h=14: Row 2 readouts
    #   y=164 h=16: Meter
    # Total: ~182px

    params = [
        # (label, dial_id, varname, scale_id, prepend_id, flonum_id,
        #  scale_text, msg_name, col, row)
        ("Thresh", "obj-5",  "thresh", "obj-16", "obj-17", "obj-40",
         "scale 0 127 -60. 0.",   "range",      0, 0),
        ("Ratio",  "obj-6",  "ratio",  "obj-18", "obj-19", "obj-41",
         "scale 0 127 1. 20.",    "ratio",      1, 0),
        ("Gain",   "obj-7",  "gain",   "obj-24", "obj-25", "obj-42",
         "scale 0 127 -12. 12.",  "smoothGain", 2, 0),
        ("Atk",    "obj-8",  "atk",    "obj-20", "obj-21", "obj-43",
         "scale 0 127 0.1 100.",  "attack",     0, 1),
        ("Rel",    "obj-9",  "rel",    "obj-22", "obj-23", "obj-44",
         "scale 0 127 10. 1000.", "release",    1, 1),
    ]

    for (label, dial_id, varname, scale_id, prep_id, fnum_id,
         scale_text, msg, col, row) in params:
        # Patching positions
        px = 30 + col * 120
        py_base = 200 + row * 160

        # Presentation positions
        pres_x = 5 + col * 47
        pres_y_label = 20 + row * 74
        pres_y_dial = 34 + row * 74
        pres_y_readout = 76 + row * 74

        # Label (presentation)
        lbl_id = f"{dial_id}-lbl"
        boxes.append(comment_box(lbl_id, [px, py_base, 50, 18], label,
                                  [pres_x, pres_y_label, 42, 12], fontsize=10.0))

        # Dial (presentation, with varname for pattr)
        boxes.append(dial_box(dial_id, [px, py_base + 18, 40, 40],
                               [pres_x, pres_y_dial, 40, 40], varname=varname))

        # Scale
        boxes.append(box(scale_id, "newobj", 6, 1, [""],
                          [px, py_base + 65, 140, 22], scale_text))

        # Flonum readout (presentation)
        boxes.append(flonum_box(fnum_id, [px + 50, py_base + 65, 55, 18],
                                 [pres_x, pres_y_readout, 42, 14]))

        # Prepend
        boxes.append(box(prep_id, "newobj", 1, 1, [""],
                          [px, py_base + 95, 110, 22], f"prepend {msg}"))

        # Connections: dial → scale → prepend → gen~ compressor
        #                              scale → flonum (readout)
        lines.append(line(dial_id, 0, scale_id, 0))
        lines.append(line(scale_id, 0, prep_id, 0))
        lines.append(line(scale_id, 0, fnum_id, 0))
        lines.append(line(prep_id, 0, "obj-2", 0))

    patch = {
        "patcher": {
            "fileversion": 1,
            "appversion": {"major": 9, "minor": 1, "revision": 2,
                           "architecture": "x64", "modernui": 1},
            "classnamespace": "box",
            "rect": [100, 100, 550, 600],
            "openinpresentation": 1,
            "boxes": boxes,
            "lines": lines,
        }
    }
    return patch


# ═══════════════════════════════════════════════════════════════════
# 2. Replace p input-processing subpatcher
# ═══════════════════════════════════════════════════════════════════

def build_input_processing():
    """Build the full p input-processing subpatcher content."""
    boxes = []
    lines = []

    # ── EQ section (unchanged) ──
    boxes.append(box("obj-1", "newobj", 1, 1, ["signal"],
                      [30, 30, 149, 22], "receive~ live-input"))
    boxes.append(comment_box("obj-2", [500, 30, 163, 20], "--- PARAMETRIC EQ ---"))
    boxes.append({"box": {
        "fontface": 0,
        "id": "obj-3",
        "maxclass": "filtergraph~",
        "nfilters": 1,
        "numinlets": 8,
        "numoutlets": 7,
        "outlettype": ["list", "float", "float", "float", "float", "list", "int"],
        "parameter_enable": 0,
        "patching_rect": [194, 30, 256, 128],
        "setfilter": [0, 5, 1, 0, 0, 40.0, 1.0, 2.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
    }})
    boxes.append(box("obj-4", "newobj", 2, 1, ["signal"],
                      [30, 74, 72, 22], "cascade~"))

    lines.append(line("obj-1", 0, "obj-4", 0))
    lines.append(line("obj-3", 0, "obj-4", 1))

    # ── Comment ──
    boxes.append(comment_box("obj-5", [500, 100, 280, 20],
                              "--- 4-BAND LR4 MULTIBAND COMPRESSOR ---"))

    # ── LR4 crossover (gen~) ──
    boxes.append(box("obj-6", "newobj", 1, 4,
                      ["signal", "signal", "signal", "signal"],
                      [30, 120, 260, 22],
                      "gen~ @gen crossover-4band.gendsp"))

    lines.append(line("obj-4", 0, "obj-6", 0))

    # ── Bpatchers (taller to fit readouts) ──
    bp_w, bp_h = 155, 185
    bp_y = 185
    bands = [
        ("obj-9",  "Low",    30),
        ("obj-10", "Lo-Mid", 200),
        ("obj-11", "Hi-Mid", 370),
        ("obj-12", "High",   540),
    ]
    for bp_id, label, bp_x in bands:
        boxes.append({"box": {
            "id": bp_id,
            "maxclass": "bpatcher",
            "name": "comp-band.maxpat",
            "args": [label],
            "numinlets": 1,
            "numoutlets": 1,
            "outlettype": ["signal"],
            "patching_rect": [bp_x, bp_y, bp_w, bp_h],
        }})

    # gen~ outlets → bpatchers (0=Low, 1=Lo-Mid, 2=Hi-Mid, 3=High)
    lines.append(line("obj-6", 0, "obj-9", 0))
    lines.append(line("obj-6", 1, "obj-10", 0))
    lines.append(line("obj-6", 2, "obj-11", 0))
    lines.append(line("obj-6", 3, "obj-12", 0))

    # ── Summing ──
    sum_y = bp_y + bp_h + 15
    boxes.append(box("obj-13", "newobj", 2, 1, ["signal"],
                      [115, sum_y, 40, 22], "+~"))
    boxes.append(box("obj-14", "newobj", 2, 1, ["signal"],
                      [455, sum_y, 40, 22], "+~"))
    boxes.append(box("obj-15", "newobj", 2, 1, ["signal"],
                      [285, sum_y + 35, 40, 22], "+~"))
    boxes.append(box("obj-16", "newobj", 1, 0, [],
                      [285, sum_y + 70, 114, 22], "send~ proc-out"))

    lines.append(line("obj-9",  0, "obj-13", 0))
    lines.append(line("obj-10", 0, "obj-13", 1))
    lines.append(line("obj-11", 0, "obj-14", 0))
    lines.append(line("obj-12", 0, "obj-14", 1))
    lines.append(line("obj-13", 0, "obj-15", 0))
    lines.append(line("obj-14", 0, "obj-15", 1))
    lines.append(line("obj-15", 0, "obj-16", 0))

    # ── pattrstorage for persisting bpatcher state ──
    boxes.append(box("obj-17", "newobj", 1, 1, [""],
                      [500, 120, 280, 22],
                      "pattrstorage comp-state @greedy 1 @autorestore 1 @savemode 2"))

    return {
        "fileversion": 1,
        "appversion": {"major": 9, "minor": 1, "revision": 2,
                       "architecture": "x64", "modernui": 1},
        "classnamespace": "box",
        "rect": [100, 100, 850, 550],
        "boxes": boxes,
        "lines": lines,
    }


# ═══════════════════════════════════════════════════════════════════
# Main
# ═══════════════════════════════════════════════════════════════════

if __name__ == "__main__":
    # 1. Write comp-band.maxpat
    comp = build_comp_band()
    with open("patches/performancepatchtest/generated/comp-band.maxpat", "w") as f:
        json.dump(comp, f, indent=4)
    print("Wrote comp-band.maxpat")

    # 2. Update input-processing subpatcher in main patch
    with open("patches/performancepatchtest/generated/performancepatchtest.maxpat") as f:
        main = json.load(f)

    for b in main["patcher"]["boxes"]:
        if b["box"].get("id") == "obj-5" and "patcher" in b["box"]:
            b["box"]["patcher"] = build_input_processing()
            print("Updated p input-processing subpatcher")
            break

    with open("patches/performancepatchtest/generated/performancepatchtest.maxpat", "w") as f:
        json.dump(main, f, indent=4)
    print("Wrote performancepatchtest.maxpat")
