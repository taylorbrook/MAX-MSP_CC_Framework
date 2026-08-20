{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 0,
            "revision": 0,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            85.0,
            104.0,
            1945.0,
            766.0
        ],
        "bglocked": 0,
        "openinpresentation": 0,
        "default_fontsize": 12.0,
        "default_fontface": 0,
        "default_fontname": "Arial",
        "gridonopen": 1,
        "gridsize": [
            15.0,
            15.0
        ],
        "gridsnaponopen": 1,
        "objectsnaponopen": 1,
        "statusbarvisible": 2,
        "toolbarvisible": 1,
        "lefttoolbarpinned": 0,
        "toptoolbarpinned": 0,
        "righttoolbarpinned": 0,
        "bottomtoolbarpinned": 0,
        "toolbars_unpinned_last_save": 0,
        "tallnewobj": 0,
        "boxanimatetime": 200,
        "enablehscroll": 1,
        "enablevscroll": 1,
        "devicewidth": 0.0,
        "description": "",
        "digest": "",
        "tags": "",
        "style": "",
        "subpatcher_template": "",
        "assistshowspatchername": 0,
        "boxes": [
            {
                "box": {
                    "maxclass": "panel",
                    "id": "obj-48",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        990.0,
                        30.0,
                        480,
                        320
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        8.0,
                        8.0,
                        468.0,
                        318.0
                    ],
                    "background": 1,
                    "ignoreclick": 1,
                    "border": 0,
                    "rounded": 7,
                    "mode": 0,
                    "bgfillcolor": {
                        "type": "gradient",
                        "color1": [
                            0.94,
                            0.94,
                            0.96,
                            1.0
                        ],
                        "color2": [
                            0.88,
                            0.89,
                            0.92,
                            1.0
                        ],
                        "color": [
                            0.94,
                            0.94,
                            0.96,
                            1.0
                        ],
                        "angle": 270.0,
                        "proportion": 0.39,
                        "autogradient": 0
                    }
                }
            },
            {
                "box": {
                    "maxclass": "number",
                    "id": "obj-32",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        915.0,
                        240.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        200.0,
                        268.0,
                        48.0,
                        20.0
                    ],
                    "numdecimalplaces": 2,
                    "ignoreclick": 1
                }
            },
            {
                "box": {
                    "maxclass": "number",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        795.0,
                        240.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        110.0,
                        268.0,
                        48.0,
                        20.0
                    ],
                    "numdecimalplaces": 2,
                    "ignoreclick": 1
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-30",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        630.0,
                        240.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        268.0,
                        48.0,
                        20.0
                    ],
                    "numdecimalplaces": 2,
                    "ignoreclick": 1
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        285.0,
                        30.0,
                        64.0,
                        22.0
                    ],
                    "text": "adc~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "playlist~",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        30.0,
                        150,
                        60
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        200.0,
                        46.0,
                        260.0,
                        70.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        165.0,
                        75.0,
                        100,
                        22
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        80.0,
                        46.0,
                        110.0,
                        22.0
                    ],
                    "items": [
                        "Live Input",
                        ",",
                        "File Player"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-4",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        165.0,
                        105.0,
                        37.0,
                        22.0
                    ],
                    "text": "+ 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-5",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        105.0,
                        195.0,
                        160.0,
                        22.0
                    ],
                    "text": "selector~ 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        270.0,
                        195.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        80.0,
                        82.0,
                        110.0,
                        13.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        435.0,
                        435.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 0,
                            "revision": 0,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [
                            100.0,
                            100.0,
                            600.0,
                            450.0
                        ],
                        "bglocked": 0,
                        "openinpresentation": 0,
                        "default_fontsize": 12.0,
                        "default_fontface": 0,
                        "default_fontname": "Arial",
                        "gridonopen": 1,
                        "gridsize": [
                            15.0,
                            15.0
                        ],
                        "gridsnaponopen": 1,
                        "objectsnaponopen": 1,
                        "statusbarvisible": 2,
                        "toolbarvisible": 1,
                        "lefttoolbarpinned": 0,
                        "toptoolbarpinned": 0,
                        "righttoolbarpinned": 0,
                        "bottomtoolbarpinned": 0,
                        "toolbars_unpinned_last_save": 0,
                        "tallnewobj": 0,
                        "boxanimatetime": 200,
                        "enablehscroll": 1,
                        "enablevscroll": 1,
                        "devicewidth": 0.0,
                        "description": "",
                        "digest": "",
                        "tags": "",
                        "style": "",
                        "subpatcher_template": "",
                        "assistshowspatchername": 0,
                        "boxes": [
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-1",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "codebox",
                                    "id": "obj-2",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        400.0,
                                        200.0
                                    ],
                                    "parameter_enable": 0,
                                    "code": "Param thresh(0.7, min=0.5, max=0.95);\nParam hyst(0.15, min=0.05, max=0.3);\nParam smoothms(350, min=50, max=1000);\nParam floorlin(0.003, min=0.0002, max=0.1);\nHistory hp1x(0);\nHistory hp1y(0);\nHistory hp2x(0);\nHistory hp2y(0);\nHistory hp3x(0);\nHistory hp3y(0);\nHistory wpos(0);\nHistory hopcount(0);\nHistory rawpitch(0);\nHistory smoothed(0);\nHistory st(0);\nHistory rmsq(0);\nData ring(2048);\n\n// 3-stage onepole highpass at 70 Hz: strips DC/rumble so low-weighted\n// noise (pink/brown) cannot fake periodicity (validated in numpy sim)\nhpa = exp(-439.823 / samplerate);\nx = in1;\ny1 = x - hp1x + hpa * hp1y;\nhp1x = x;\nhp1y = y1;\ny2 = y1 - hp2x + hpa * hp2y;\nhp2x = y1;\nhp2y = y2;\ny3 = y2 - hp3x + hpa * hp3y;\nhp3x = y2;\nhp3y = y3;\n\n// input level (RMS, ~50 ms) for the silence gate\nrc = exp(-1.0 / (0.05 * samplerate));\nrmsq = rmsq * rc + (y3 * y3) * (1.0 - rc);\n\n// ring-buffer write\npoke(ring, y3, wpos);\nw = wpos;\nwpos = wrap(wpos + 1, 0, 2048);\n\n// lag range: 80 Hz floor .. 2 kHz ceiling\nmaxlag = min(floor(samplerate / 80.0), 1000);\nminlag = max(floor(samplerate / 2000.0), 8);\nwin = min(maxlag, 2048 - maxlag);\n\n// NSDF sweep once per 512-sample hop (~11.6 ms @ 44.1k)\nhopcount = hopcount + 1;\nrunsweep = 0;\nif (hopcount >= 512) {\n\thopcount = 0;\n\trunsweep = 1;\n}\nbest = 0.0;\nea = 0.0;\neb = 0.0;\nif (runsweep > 0) {\n\tfor (i = 0; i < win; i += 1) {\n\t\tva = peek(ring, wrap(w - i, 0, 2048));\n\t\tea = ea + va * va;\n\t}\n\tfor (i = 0; i < win; i += 1) {\n\t\tvb = peek(ring, wrap(w - minlag - i, 0, 2048));\n\t\teb = eb + vb * vb;\n\t}\n\tfor (lag = minlag; lag <= maxlag; lag += 1) {\n\t\tr = 0.0;\n\t\tfor (i = 0; i < win; i += 1) {\n\t\t\tr = r + peek(ring, wrap(w - i, 0, 2048)) * peek(ring, wrap(w - i - lag, 0, 2048));\n\t\t}\n\t\tm = ea + eb;\n\t\tv = 0.0;\n\t\tif (m > 0.000000001) {\n\t\t\tv = 2.0 * r / m;\n\t\t}\n\t\tif (v > best) {\n\t\t\tbest = v;\n\t\t}\n\t\t// slide lagged-window energy back one sample for the next lag\n\t\tvout = peek(ring, wrap(w - lag, 0, 2048));\n\t\tvin = peek(ring, wrap(w - lag - win, 0, 2048));\n\t\teb = eb + vin * vin - vout * vout;\n\t}\n\trawpitch = best;\n}\n\n// smoothed pitchedness (time constant = smoothms)\nsc = exp(-1.0 / (smoothms * 0.001 * samplerate));\nsmoothed = smoothed * sc + rawpitch * (1.0 - sc);\n\n// 3-state decision with hysteresis: 0 silent, 1 noise, 2 pitch\ns = st;\nif (sqrt(rmsq) < floorlin) {\n\ts = 0;\n} else if (smoothed > thresh) {\n\ts = 2;\n} else if (smoothed < thresh - hyst) {\n\ts = 1;\n} else if (s == 0) {\n\ts = 1;\n}\nst = s;\n\nout1 = smoothed;\nout2 = s;",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        30.0,
                                        300.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        405.0,
                                        300.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "source": [
                                        "obj-1",
                                        0
                                    ],
                                    "destination": [
                                        "obj-2",
                                        0
                                    ],
                                    "midpoints": [
                                        45.0,
                                        63.5,
                                        230.0,
                                        63.5
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-2",
                                        0
                                    ],
                                    "destination": [
                                        "obj-3",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-2",
                                        1
                                    ],
                                    "destination": [
                                        "obj-4",
                                        0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0,
                        "bgcolor": [
                            0.9,
                            0.9,
                            0.9,
                            1.0
                        ]
                    }
                }
            },
            {
                "box": {
                    "maxclass": "gain~",
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        165.0,
                        240.0,
                        22.0,
                        140.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        400.0,
                        216.0,
                        24.0,
                        90.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-9",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        150.0,
                        405.0,
                        44.0,
                        22.0
                    ],
                    "text": "dac~",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-10",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        450.0,
                        480.0,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        540.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        398.0,
                        176.0,
                        62.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "slider",
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        570.0,
                        150,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        110.0,
                        176.0,
                        280.0,
                        20.0
                    ],
                    "floatoutput": 1,
                    "min": 0.0,
                    "size": 1.0,
                    "orientation": 1,
                    "ignoreclick": 1
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-13",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        555.0,
                        480.0,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        585.0,
                        525.0,
                        58.0,
                        22.0
                    ],
                    "text": "change",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        555.0,
                        570.0,
                        107.0,
                        22.0
                    ],
                    "text": "trigger i i i",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        555.0,
                        615.0,
                        100.0,
                        22.0
                    ],
                    "text": "select 0 1 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-17",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        570.0,
                        645.0,
                        86.0,
                        22.0
                    ],
                    "text": "set SILENT",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-18",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        675.0,
                        645.0,
                        79.0,
                        22.0
                    ],
                    "text": "set NOISE",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-19",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        765.0,
                        645.0,
                        79.0,
                        22.0
                    ],
                    "text": "set PITCH",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-20",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        630.0,
                        690.0,
                        150,
                        36
                    ],
                    "text": "SILENT",
                    "fontname": "Arial",
                    "fontsize": 24.0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        128.0,
                        180.0,
                        36.0
                    ],
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "number",
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        675.0,
                        615.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        200.0,
                        136.0,
                        50.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        735.0,
                        615.0,
                        149.0,
                        22.0
                    ],
                    "text": "send detector-state",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-23",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        540.0,
                        180.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        220.0,
                        48.0,
                        48.0
                    ],
                    "floatoutput": 1,
                    "min": 0.5,
                    "size": 0.45
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-24",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        540.0,
                        240.0,
                        79.0,
                        22.0
                    ],
                    "text": "thresh $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        690.0,
                        180.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        110.0,
                        220.0,
                        48.0,
                        48.0
                    ],
                    "min": 50,
                    "size": 951
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-26",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        690.0,
                        240.0,
                        93.0,
                        22.0
                    ],
                    "text": "smoothms $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        855.0,
                        180.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        200.0,
                        220.0,
                        48.0,
                        48.0
                    ],
                    "min": -70,
                    "size": 41
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-28",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        855.0,
                        240.0,
                        51.0,
                        22.0
                    ],
                    "text": "dbtoa",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-29",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        825.0,
                        405.0,
                        93.0,
                        22.0
                    ],
                    "text": "floorlin $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-33",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        72.0,
                        22.0
                    ],
                    "text": "loadbang",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "bgcolor": [
                        0.85,
                        0.92,
                        0.85,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-34",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        105.0,
                        121.0,
                        22.0
                    ],
                    "text": "trigger b b b b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-35",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        150.0,
                        40.0,
                        22.0
                    ],
                    "text": "1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-36",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        90.0,
                        150.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.7",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-37",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        150.0,
                        40.0,
                        22.0
                    ],
                    "text": "350",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-38",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        195.0,
                        150.0,
                        40.0,
                        22.0
                    ],
                    "text": "-50",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-39",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        990.0,
                        375.0,
                        331.0,
                        20.0
                    ],
                    "text": "SPECTRAL DETECTOR -- sustained pitch vs noise",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-40",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        270.0,
                        75.0,
                        107.0,
                        20.0
                    ],
                    "text": "source select",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-41",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        285.0,
                        195.0,
                        93.0,
                        20.0
                    ],
                    "text": "input level",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        195.0,
                        570.0,
                        121.0,
                        20.0
                    ],
                    "text": "pitchedness 0-1",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-43",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        735.0,
                        615.0,
                        261.0,
                        20.0
                    ],
                    "text": "state: 0 silent / 1 noise / 2 pitch",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-44",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        585.0,
                        180.0,
                        79.0,
                        20.0
                    ],
                    "text": "threshold",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-45",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        735.0,
                        180.0,
                        100.0,
                        20.0
                    ],
                    "text": "smoothing ms",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-46",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        900.0,
                        180.0,
                        72.0,
                        20.0
                    ],
                    "text": "floor dB",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-47",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        195.0,
                        240.0,
                        65.0,
                        20.0
                    ],
                    "text": "monitor",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-49",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1770.0,
                        30.0,
                        135.0,
                        20.0
                    ],
                    "text": "SPECTRAL DETECTOR",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        16.0,
                        220.0,
                        24.0
                    ],
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-50",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1770.0,
                        75.0,
                        58.0,
                        20.0
                    ],
                    "text": "Source",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        48.0,
                        60.0,
                        18.0
                    ],
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-51",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1770.0,
                        135.0,
                        51.0,
                        20.0
                    ],
                    "text": "Input",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        80.0,
                        60.0,
                        18.0
                    ],
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-52",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1770.0,
                        180.0,
                        93.0,
                        20.0
                    ],
                    "text": "Pitchedness",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        176.0,
                        90.0,
                        18.0
                    ],
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-53",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1770.0,
                        225.0,
                        79.0,
                        20.0
                    ],
                    "text": "Threshold",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        288.0,
                        70.0,
                        18.0
                    ],
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-54",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1770.0,
                        285.0,
                        79.0,
                        20.0
                    ],
                    "text": "Smooth ms",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        106.0,
                        288.0,
                        76.0,
                        18.0
                    ],
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-55",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1770.0,
                        330.0,
                        72.0,
                        20.0
                    ],
                    "text": "Floor dB",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        196.0,
                        288.0,
                        70.0,
                        18.0
                    ],
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-56",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1770.0,
                        375.0,
                        65.0,
                        20.0
                    ],
                    "text": "Monitor",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        380.0,
                        288.0,
                        60.0,
                        18.0
                    ],
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        0
                    ],
                    "destination": [
                        "obj-4",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-4",
                        0
                    ],
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        183.5,
                        97.0,
                        159.0,
                        97.0,
                        159.0,
                        135.0,
                        159.0,
                        142.0,
                        138.0,
                        142.0,
                        138.0,
                        180.0,
                        138.0,
                        142.0,
                        127.0,
                        142.0,
                        127.0,
                        180.0,
                        112.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-1",
                        0
                    ],
                    "destination": [
                        "obj-5",
                        1
                    ],
                    "midpoints": [
                        292.0,
                        22.0,
                        278.0,
                        22.0,
                        278.0,
                        98.0,
                        278.0,
                        67.0,
                        273.0,
                        67.0,
                        273.0,
                        105.0,
                        273.0,
                        67.0,
                        262.0,
                        67.0,
                        262.0,
                        103.0,
                        262.0,
                        97.0,
                        210.0,
                        97.0,
                        210.0,
                        135.0,
                        210.0,
                        142.0,
                        243.0,
                        142.0,
                        243.0,
                        180.0,
                        243.0,
                        187.0,
                        262.0,
                        187.0,
                        262.0,
                        303.0,
                        262.0,
                        187.0,
                        277.0,
                        187.0,
                        277.0,
                        223.0,
                        185.0,
                        223.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-2",
                        0
                    ],
                    "destination": [
                        "obj-5",
                        2
                    ],
                    "midpoints": [
                        127.0,
                        67.0,
                        157.0,
                        67.0,
                        157.0,
                        105.0,
                        157.0,
                        97.0,
                        210.0,
                        97.0,
                        210.0,
                        135.0,
                        210.0,
                        97.0,
                        159.0,
                        97.0,
                        159.0,
                        135.0,
                        159.0,
                        142.0,
                        138.0,
                        142.0,
                        138.0,
                        180.0,
                        138.0,
                        142.0,
                        183.0,
                        142.0,
                        183.0,
                        180.0,
                        183.0,
                        142.0,
                        187.0,
                        142.0,
                        187.0,
                        180.0,
                        258.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-5",
                        0
                    ],
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        185.0,
                        187.0,
                        277.0,
                        187.0,
                        277.0,
                        223.0,
                        277.5,
                        223.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-5",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        185.0,
                        187.0,
                        293.0,
                        187.0,
                        293.0,
                        303.0,
                        293.0,
                        187.0,
                        386.0,
                        187.0,
                        386.0,
                        223.0,
                        386.0,
                        232.0,
                        195.0,
                        232.0,
                        195.0,
                        388.0,
                        195.0,
                        232.0,
                        268.0,
                        232.0,
                        268.0,
                        268.0,
                        268.0,
                        397.0,
                        202.0,
                        397.0,
                        202.0,
                        435.0,
                        495.5,
                        435.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-5",
                        0
                    ],
                    "destination": [
                        "obj-8",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        0
                    ],
                    "destination": [
                        "obj-9",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        0
                    ],
                    "destination": [
                        "obj-9",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-7",
                        0
                    ],
                    "destination": [
                        "obj-10",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-10",
                        0
                    ],
                    "destination": [
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        500.0,
                        521.0,
                        55.0,
                        521.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-11",
                        0
                    ],
                    "destination": [
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        566.0,
                        105.0,
                        566.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-7",
                        1
                    ],
                    "destination": [
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        549.0,
                        472.0,
                        558.0,
                        472.0,
                        558.0,
                        510.0,
                        562.0,
                        510.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-13",
                        0
                    ],
                    "destination": [
                        "obj-14",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-14",
                        0
                    ],
                    "destination": [
                        "obj-15",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-15",
                        0
                    ],
                    "destination": [
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        562.0,
                        603.5,
                        605.0,
                        603.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-15",
                        1
                    ],
                    "destination": [
                        "obj-21",
                        0
                    ],
                    "midpoints": [
                        608.5,
                        607.0,
                        663.0,
                        607.0,
                        663.0,
                        645.0,
                        700.0,
                        645.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-15",
                        2
                    ],
                    "destination": [
                        "obj-22",
                        0
                    ],
                    "midpoints": [
                        655.0,
                        607.0,
                        663.0,
                        607.0,
                        663.0,
                        645.0,
                        663.0,
                        607.0,
                        733.0,
                        607.0,
                        733.0,
                        645.0,
                        733.0,
                        607.0,
                        727.0,
                        607.0,
                        727.0,
                        643.0,
                        809.5,
                        643.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-16",
                        0
                    ],
                    "destination": [
                        "obj-17",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-16",
                        1
                    ],
                    "destination": [
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        590.6666666666666,
                        607.0,
                        667.0,
                        607.0,
                        667.0,
                        645.0,
                        667.0,
                        637.0,
                        664.0,
                        637.0,
                        664.0,
                        675.0,
                        682.0,
                        675.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-16",
                        2
                    ],
                    "destination": [
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        619.3333333333334,
                        607.0,
                        667.0,
                        607.0,
                        667.0,
                        645.0,
                        667.0,
                        607.0,
                        727.0,
                        607.0,
                        727.0,
                        645.0,
                        727.0,
                        607.0,
                        727.0,
                        607.0,
                        727.0,
                        643.0,
                        727.0,
                        637.0,
                        664.0,
                        637.0,
                        664.0,
                        675.0,
                        664.0,
                        637.0,
                        667.0,
                        637.0,
                        667.0,
                        675.0,
                        772.0,
                        675.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-17",
                        0
                    ],
                    "destination": [
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        613.0,
                        637.0,
                        667.0,
                        637.0,
                        667.0,
                        675.0,
                        705.0,
                        675.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-18",
                        0
                    ],
                    "destination": [
                        "obj-20",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-19",
                        0
                    ],
                    "destination": [
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        804.5,
                        637.0,
                        762.0,
                        637.0,
                        762.0,
                        675.0,
                        705.0,
                        675.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-23",
                        0
                    ],
                    "destination": [
                        "obj-24",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-25",
                        0
                    ],
                    "destination": [
                        "obj-26",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-27",
                        0
                    ],
                    "destination": [
                        "obj-28",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-28",
                        0
                    ],
                    "destination": [
                        "obj-29",
                        0
                    ],
                    "midpoints": [
                        880.5,
                        232.0,
                        843.0,
                        232.0,
                        843.0,
                        288.0,
                        832.0,
                        288.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-24",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        579.5,
                        348.5,
                        495.5,
                        348.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-26",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        736.5,
                        232.0,
                        622.0,
                        232.0,
                        622.0,
                        288.0,
                        622.0,
                        232.0,
                        627.0,
                        232.0,
                        627.0,
                        270.0,
                        495.5,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-29",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        871.5,
                        431.0,
                        495.5,
                        431.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-23",
                        0
                    ],
                    "destination": [
                        "obj-30",
                        0
                    ],
                    "midpoints": [
                        560.0,
                        232.0,
                        627.0,
                        232.0,
                        627.0,
                        270.0,
                        650.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-25",
                        0
                    ],
                    "destination": [
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        710.0,
                        232.0,
                        791.0,
                        232.0,
                        791.0,
                        270.0,
                        815.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-27",
                        0
                    ],
                    "destination": [
                        "obj-32",
                        0
                    ],
                    "midpoints": [
                        875.0,
                        232.0,
                        914.0,
                        232.0,
                        914.0,
                        270.0,
                        935.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-33",
                        0
                    ],
                    "destination": [
                        "obj-34",
                        0
                    ],
                    "midpoints": [
                        66.0,
                        78.5,
                        90.5,
                        78.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-34",
                        0
                    ],
                    "destination": [
                        "obj-35",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-34",
                        1
                    ],
                    "destination": [
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        72.66666666666666,
                        142.0,
                        78.0,
                        142.0,
                        78.0,
                        180.0,
                        97.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-34",
                        2
                    ],
                    "destination": [
                        "obj-37",
                        0
                    ],
                    "midpoints": [
                        108.33333333333333,
                        142.0,
                        138.0,
                        142.0,
                        138.0,
                        180.0,
                        142.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-34",
                        3
                    ],
                    "destination": [
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        144.0,
                        97.0,
                        157.0,
                        97.0,
                        157.0,
                        135.0,
                        157.0,
                        142.0,
                        183.0,
                        142.0,
                        183.0,
                        180.0,
                        202.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-35",
                        0
                    ],
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        50.0,
                        142.0,
                        82.0,
                        142.0,
                        82.0,
                        180.0,
                        112.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-36",
                        0
                    ],
                    "destination": [
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        110.0,
                        142.0,
                        183.0,
                        142.0,
                        183.0,
                        180.0,
                        183.0,
                        142.0,
                        243.0,
                        142.0,
                        243.0,
                        180.0,
                        560.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-37",
                        0
                    ],
                    "destination": [
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        155.0,
                        142.0,
                        243.0,
                        142.0,
                        243.0,
                        180.0,
                        243.0,
                        172.0,
                        532.0,
                        172.0,
                        532.0,
                        228.0,
                        532.0,
                        172.0,
                        577.0,
                        172.0,
                        577.0,
                        208.0,
                        710.0,
                        208.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-38",
                        0
                    ],
                    "destination": [
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        215.0,
                        172.0,
                        532.0,
                        172.0,
                        532.0,
                        228.0,
                        532.0,
                        172.0,
                        682.0,
                        172.0,
                        682.0,
                        228.0,
                        682.0,
                        172.0,
                        577.0,
                        172.0,
                        577.0,
                        208.0,
                        577.0,
                        172.0,
                        727.0,
                        172.0,
                        727.0,
                        208.0,
                        875.0,
                        208.0
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0,
        "editing_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ],
        "locked_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ]
    }
}