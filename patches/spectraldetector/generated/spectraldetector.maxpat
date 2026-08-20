{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 5,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            34.0,
            104.0,
            1333.0,
            826.0
        ],
        "boxes": [
            {
                "box": {
                    "angle": 270.0,
                    "background": 1,
                    "grad1": [
                        0.19215686274509805,
                        0.19215686274509805,
                        0.25882352941176473,
                        1.0
                    ],
                    "grad2": [
                        0.17647058823529413,
                        0.2549019607843137,
                        0.4627450980392157,
                        1.0
                    ],
                    "id": "obj-51",
                    "maxclass": "panel",
                    "mode": 1,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        960.0,
                        30.0,
                        480.0,
                        320.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        8.0,
                        8.0,
                        468.0,
                        318.0
                    ],
                    "proportion": 0.39,
                    "rounded": 7
                }
            },
            {
                "box": {
                    "id": "obj-32",
                    "ignoreclick": 1,
                    "maxclass": "number",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        885.0,
                        405.0,
                        40.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        200.0,
                        268.0,
                        48.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-31",
                    "ignoreclick": 1,
                    "maxclass": "number",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        765.0,
                        405.0,
                        40.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        110.0,
                        268.0,
                        48.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-30",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        600.0,
                        405.0,
                        40.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        268.0,
                        48.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        285.0,
                        30.0,
                        64.0,
                        22.0
                    ],
                    "text": "adc~"
                }
            },
            {
                "box": {
                    "data": {
                        "clips": []
                    },
                    "id": "obj-2",
                    "maxclass": "playlist~",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 5,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "",
                        "dictionary"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1900.0,
                        30.0,
                        150.0,
                        60.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        200.0,
                        46.0,
                        260.0,
                        70.0
                    ],
                    "quality": 0,
                    "saved_attribute_attributes": {
                        "candicane2": {
                            "expression": ""
                        },
                        "candicane3": {
                            "expression": ""
                        },
                        "candicane4": {
                            "expression": ""
                        },
                        "candicane5": {
                            "expression": ""
                        },
                        "candicane6": {
                            "expression": ""
                        },
                        "candicane7": {
                            "expression": ""
                        },
                        "candicane8": {
                            "expression": ""
                        }
                    }
                }
            },
            {
                "box": {
                    "id": "obj-3",
                    "items": [
                        "Live Input",
                        ",",
                        "File Player"
                    ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        165.0,
                        75.0,
                        100.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        80.0,
                        46.0,
                        110.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        165.0,
                        105.0,
                        37.0,
                        22.0
                    ],
                    "text": "+ 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "newobj",
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
                    "text": "selector~ 2"
                }
            },
            {
                "box": {
                    "id": "obj-6",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        270.0,
                        195.0,
                        15.0,
                        100.0
                    ],
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 5,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "dsp.gen",
                        "rect": [
                            100.0,
                            100.0,
                            600.0,
                            450.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "newobj",
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
                                    "text": "in 1"
                                }
                            },
                            {
                                "box": {
                                    "code": "Param thresh(0.7, min=0.5, max=0.95);\nParam hyst(0.15, min=0.05, max=0.3);\nParam smoothms(350, min=50, max=1000);\nParam floorlin(0.003, min=0.0002, max=0.1);\nHistory hp1x(0);\nHistory hp1y(0);\nHistory hp2x(0);\nHistory hp2y(0);\nHistory hp3x(0);\nHistory hp3y(0);\nHistory wpos(0);\nHistory lagcur(0);\nHistory bestrun(0);\nHistory rawpitch(0);\nHistory smoothed(0);\nHistory st(0);\nHistory rmsq(0);\nData ring(2048);\n\n// 3-stage 70 Hz onepole highpass: DC/rumble guard so low-weighted noise\n// cannot fake periodicity (validated in numpy simulation)\nhpa = exp(-439.823 / samplerate);\nx = in1;\ny1 = x - hp1x + hpa * hp1y;\nhp1x = x;\nhp1y = y1;\ny2 = y1 - hp2x + hpa * hp2y;\nhp2x = y1;\nhp2y = y2;\ny3 = y2 - hp3x + hpa * hp3y;\nhp3x = y2;\nhp3y = y3;\n\n// input RMS (about 50 ms) for the silence gate\nrc = exp(-1.0 / (0.05 * samplerate));\nrmsq = rmsq * rc + y3 * y3 * (1.0 - rc);\n\n// ring-buffer write\npoke(ring, y3, wpos, 0);\nw = wpos;\nwpos = wrap(wpos + 1.0, 0.0, 2048.0);\n\n// lag range 80 Hz .. 2 kHz, capped so window + lag fits the ring\nmaxlag = min(floor(samplerate / 80.0), 600.0);\nminlag = max(floor(samplerate / 2000.0), 8.0);\nwin = maxlag;\n\n// amortized NSDF: evaluate ONE lag per sample; a full sweep over the lag\n// range completes every (maxlag - minlag) samples (~12 ms) and publishes\n// the running peak as the raw pitchedness value\nlg = lagcur;\nif (lg < minlag) {\n    lg = minlag;\n}\nra = 0.0;\nea = 0.0;\neb = 0.0;\nfor (i = 0; i < 600; i += 1) {\n    if (i < win) {\n        va = peek(ring, wrap(w - i, 0.0, 2048.0), 0);\n        vb = peek(ring, wrap(w - i - lg, 0.0, 2048.0), 0);\n        ra = ra + va * vb;\n        ea = ea + va * va;\n        eb = eb + vb * vb;\n    }\n}\nnv = 0.0;\nden = ea + eb;\nif (den > 0.000000001) {\n    nv = 2.0 * ra / den;\n}\nif (nv > bestrun) {\n    bestrun = nv;\n}\nnextlag = lg + 1.0;\nif (nextlag > maxlag) {\n    rawpitch = bestrun;\n    bestrun = 0.0;\n    nextlag = minlag;\n}\nlagcur = nextlag;\n\n// smoothed pitchedness (time constant = smoothms)\nsc = exp(-1.0 / (smoothms * 0.001 * samplerate));\nsmoothed = smoothed * sc + rawpitch * (1.0 - sc);\n\n// 3-state decision with hysteresis: 0 silent, 1 noise, 2 pitch\ns = st;\ngate = sqrt(rmsq);\nif (gate < floorlin) {\n    s = 0.0;\n}\nif (gate >= floorlin) {\n    if (smoothed > thresh) {\n        s = 2.0;\n    }\n    if (smoothed < thresh - hyst) {\n        s = 1.0;\n    }\n    if (s == 0.0) {\n        s = 1.0;\n    }\n}\nst = s;\n\nout1 = smoothed;\nout2 = s;",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "codebox",
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
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        300.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        405.0,
                                        300.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 2"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-2",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        63.5,
                                        39.5,
                                        63.5
                                    ],
                                    "source": [
                                        "obj-1",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-3",
                                        0
                                    ],
                                    "source": [
                                        "obj-2",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-4",
                                        0
                                    ],
                                    "source": [
                                        "obj-2",
                                        1
                                    ]
                                }
                            }
                        ],
                        "bgcolor": [
                            0.9,
                            0.9,
                            0.9,
                            1.0
                        ]
                    },
                    "patching_rect": [
                        120.0,
                        495.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "id": "obj-8",
                    "maxclass": "gain~",
                    "multichannelvariant": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        165.0,
                        240.0,
                        22.0,
                        140.0
                    ],
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
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-9",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        150.0,
                        405.0,
                        44.0,
                        22.0
                    ],
                    "text": "dac~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-10",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        135.0,
                        540.0,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-11",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        30.0,
                        600.0,
                        50.0,
                        22.0
                    ],
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
                    "floatoutput": 1,
                    "id": "obj-12",
                    "ignoreclick": 1,
                    "maxclass": "slider",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "orientation": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        30.0,
                        630.0,
                        150.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        110.0,
                        176.0,
                        280.0,
                        20.0
                    ],
                    "size": 1.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-13",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        240.0,
                        540.0,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-14",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        270.0,
                        585.0,
                        58.0,
                        22.0
                    ],
                    "text": "change"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        240.0,
                        630.0,
                        107.0,
                        22.0
                    ],
                    "text": "trigger i i i"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-16",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang",
                        ""
                    ],
                    "patching_rect": [
                        240.0,
                        675.0,
                        100.0,
                        22.0
                    ],
                    "text": "select 0 1 2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-17",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        255.0,
                        705.0,
                        86.0,
                        22.0
                    ],
                    "text": "set SILENT"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-18",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        360.0,
                        705.0,
                        79.0,
                        22.0
                    ],
                    "text": "set NOISE"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-19",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        450.0,
                        705.0,
                        79.0,
                        22.0
                    ],
                    "text": "set PITCH"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 24.0,
                    "id": "obj-20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        315.0,
                        750.0,
                        150.0,
                        33.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        128.0,
                        180.0,
                        33.0
                    ],
                    "text": "SILENT",
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
                    "id": "obj-21",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        360.0,
                        675.0,
                        50.0,
                        22.0
                    ],
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        420.0,
                        675.0,
                        149.0,
                        22.0
                    ],
                    "text": "send detector-state"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-23",
                    "maxclass": "dial",
                    "min": 0.5,
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        495.0,
                        180.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        220.0,
                        48.0,
                        48.0
                    ],
                    "size": 1.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        510.0,
                        405.0,
                        79.0,
                        22.0
                    ],
                    "text": "thresh $1"
                }
            },
            {
                "box": {
                    "id": "obj-25",
                    "maxclass": "dial",
                    "min": 50.0,
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        600.0,
                        180.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        110.0,
                        220.0,
                        48.0,
                        48.0
                    ],
                    "size": 951.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-26",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        660.0,
                        405.0,
                        93.0,
                        22.0
                    ],
                    "text": "smoothms $1"
                }
            },
            {
                "box": {
                    "id": "obj-27",
                    "maxclass": "dial",
                    "min": -70.0,
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        720.0,
                        180.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        200.0,
                        220.0,
                        48.0,
                        48.0
                    ],
                    "size": 41.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-28",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        810.0,
                        405.0,
                        51.0,
                        22.0
                    ],
                    "text": "dbtoa"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-29",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        795.0,
                        465.0,
                        93.0,
                        22.0
                    ],
                    "text": "floorlin $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-33",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        495.0,
                        240.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger f f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-34",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        600.0,
                        240.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger i i"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-35",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        720.0,
                        240.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger i i"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.85,
                        0.92,
                        0.85,
                        1.0
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-36",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        72.0,
                        22.0
                    ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-37",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        30.0,
                        105.0,
                        121.0,
                        22.0
                    ],
                    "text": "trigger b b b b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-38",
                    "maxclass": "message",
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
                    "text": "1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "message",
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
                    "text": "0.7"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-40",
                    "maxclass": "message",
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
                    "text": "350"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-41",
                    "maxclass": "message",
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
                    "text": "-50"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-42",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        960.0,
                        375.0,
                        331.0,
                        20.0
                    ],
                    "text": "SPECTRAL DETECTOR -- sustained pitch vs noise",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-43",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        270.0,
                        75.0,
                        107.0,
                        20.0
                    ],
                    "text": "source select",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-44",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        285.0,
                        195.0,
                        93.0,
                        20.0
                    ],
                    "text": "input level",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-45",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        195.0,
                        630.0,
                        121.0,
                        20.0
                    ],
                    "text": "pitchedness 0-1",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-46",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        420.0,
                        675.0,
                        261.0,
                        20.0
                    ],
                    "text": "state: 0 silent / 1 noise / 2 pitch",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-47",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        555.0,
                        180.0,
                        79.0,
                        20.0
                    ],
                    "text": "threshold",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-48",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        660.0,
                        180.0,
                        100.0,
                        20.0
                    ],
                    "text": "smoothing ms",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-49",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        765.0,
                        180.0,
                        72.0,
                        20.0
                    ],
                    "text": "floor dB",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-50",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        195.0,
                        240.0,
                        65.0,
                        20.0
                    ],
                    "text": "monitor",
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
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-52",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1740.0,
                        30.0,
                        185.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        16.0,
                        220.0,
                        24.0
                    ],
                    "text": "SPECTRAL DETECTOR",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-53",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1740.0,
                        75.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        48.0,
                        60.0,
                        20.0
                    ],
                    "text": "Source",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-54",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1740.0,
                        135.0,
                        51.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        80.0,
                        60.0,
                        20.0
                    ],
                    "text": "Input",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-55",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1740.0,
                        180.0,
                        93.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        176.0,
                        90.0,
                        20.0
                    ],
                    "text": "Pitchedness",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-56",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1740.0,
                        225.0,
                        79.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        288.0,
                        70.0,
                        20.0
                    ],
                    "text": "Threshold",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-57",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1740.0,
                        285.0,
                        79.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        106.0,
                        288.0,
                        76.0,
                        20.0
                    ],
                    "text": "Smooth ms",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-58",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1740.0,
                        330.0,
                        72.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        196.0,
                        288.0,
                        70.0,
                        20.0
                    ],
                    "text": "Floor dB",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-59",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1740.0,
                        375.0,
                        65.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        380.0,
                        288.0,
                        60.0,
                        20.0
                    ],
                    "text": "Monitor",
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
                    "destination": [
                        "obj-5",
                        1
                    ],
                    "midpoints": [
                        294.5,
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
                    ],
                    "source": [
                        "obj-1",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        144.5,
                        581.0,
                        39.5,
                        581.0
                    ],
                    "source": [
                        "obj-10",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        626.0,
                        39.5,
                        626.0
                    ],
                    "source": [
                        "obj-11",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-14",
                        0
                    ],
                    "source": [
                        "obj-13",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        279.5,
                        622.0,
                        324.0,
                        622.0,
                        324.0,
                        658.0,
                        249.5,
                        658.0
                    ],
                    "source": [
                        "obj-14",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        249.5,
                        622.0,
                        324.0,
                        622.0,
                        324.0,
                        658.0,
                        249.5,
                        658.0
                    ],
                    "source": [
                        "obj-15",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-21",
                        0
                    ],
                    "midpoints": [
                        293.5,
                        622.0,
                        324.0,
                        622.0,
                        324.0,
                        658.0,
                        324.0,
                        667.0,
                        348.0,
                        667.0,
                        348.0,
                        705.0,
                        369.5,
                        705.0
                    ],
                    "source": [
                        "obj-15",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-22",
                        0
                    ],
                    "midpoints": [
                        337.5,
                        667.0,
                        348.0,
                        667.0,
                        348.0,
                        705.0,
                        348.0,
                        667.0,
                        418.0,
                        667.0,
                        418.0,
                        705.0,
                        418.0,
                        667.0,
                        412.0,
                        667.0,
                        412.0,
                        703.0,
                        429.5,
                        703.0
                    ],
                    "source": [
                        "obj-15",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-17",
                        0
                    ],
                    "source": [
                        "obj-16",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        276.5,
                        667.0,
                        352.0,
                        667.0,
                        352.0,
                        705.0,
                        352.0,
                        697.0,
                        349.0,
                        697.0,
                        349.0,
                        735.0,
                        369.5,
                        735.0
                    ],
                    "source": [
                        "obj-16",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        303.5,
                        667.0,
                        352.0,
                        667.0,
                        352.0,
                        705.0,
                        352.0,
                        667.0,
                        412.0,
                        667.0,
                        412.0,
                        705.0,
                        412.0,
                        667.0,
                        412.0,
                        667.0,
                        412.0,
                        703.0,
                        412.0,
                        697.0,
                        349.0,
                        697.0,
                        349.0,
                        735.0,
                        349.0,
                        697.0,
                        352.0,
                        697.0,
                        352.0,
                        735.0,
                        459.5,
                        735.0
                    ],
                    "source": [
                        "obj-16",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        264.5,
                        697.0,
                        352.0,
                        697.0,
                        352.0,
                        735.0,
                        324.5,
                        735.0
                    ],
                    "source": [
                        "obj-17",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-20",
                        0
                    ],
                    "source": [
                        "obj-18",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        459.5,
                        697.0,
                        447.0,
                        697.0,
                        447.0,
                        735.0,
                        324.5,
                        735.0
                    ],
                    "source": [
                        "obj-19",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-5",
                        2
                    ],
                    "midpoints": [
                        1909.5,
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
                        255.5,
                        180.0
                    ],
                    "source": [
                        "obj-2",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-33",
                        0
                    ],
                    "midpoints": [
                        504.5,
                        230.0,
                        504.5,
                        230.0
                    ],
                    "source": [
                        "obj-23",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        519.5,
                        397.0,
                        202.0,
                        397.0,
                        202.0,
                        435.0,
                        129.5,
                        435.0
                    ],
                    "source": [
                        "obj-24",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-34",
                        0
                    ],
                    "midpoints": [
                        609.5,
                        230.0,
                        609.5,
                        230.0
                    ],
                    "source": [
                        "obj-25",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        669.5,
                        397.0,
                        592.0,
                        397.0,
                        592.0,
                        453.0,
                        592.0,
                        397.0,
                        202.0,
                        397.0,
                        202.0,
                        435.0,
                        202.0,
                        397.0,
                        502.0,
                        397.0,
                        502.0,
                        435.0,
                        129.5,
                        435.0
                    ],
                    "source": [
                        "obj-26",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        729.5,
                        230.0,
                        729.5,
                        230.0
                    ],
                    "source": [
                        "obj-27",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-29",
                        0
                    ],
                    "midpoints": [
                        819.5,
                        397.0,
                        813.0,
                        397.0,
                        813.0,
                        453.0,
                        804.5,
                        453.0
                    ],
                    "source": [
                        "obj-28",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        804.5,
                        491.0,
                        129.5,
                        491.0
                    ],
                    "source": [
                        "obj-29",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "source": [
                        "obj-3",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-24",
                        0
                    ],
                    "source": [
                        "obj-33",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-30",
                        0
                    ],
                    "midpoints": [
                        578.5,
                        232.0,
                        592.0,
                        232.0,
                        592.0,
                        270.0,
                        592.0,
                        397.0,
                        597.0,
                        397.0,
                        597.0,
                        435.0,
                        609.5,
                        435.0
                    ],
                    "source": [
                        "obj-33",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        609.5,
                        397.0,
                        648.0,
                        397.0,
                        648.0,
                        453.0,
                        669.5,
                        453.0
                    ],
                    "source": [
                        "obj-34",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        683.5,
                        232.0,
                        712.0,
                        232.0,
                        712.0,
                        270.0,
                        712.0,
                        397.0,
                        761.0,
                        397.0,
                        761.0,
                        435.0,
                        774.5,
                        435.0
                    ],
                    "source": [
                        "obj-34",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-28",
                        0
                    ],
                    "midpoints": [
                        729.5,
                        397.0,
                        757.0,
                        397.0,
                        757.0,
                        453.0,
                        757.0,
                        397.0,
                        761.0,
                        397.0,
                        761.0,
                        435.0,
                        819.5,
                        435.0
                    ],
                    "source": [
                        "obj-35",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-32",
                        0
                    ],
                    "midpoints": [
                        803.5,
                        397.0,
                        813.0,
                        397.0,
                        813.0,
                        453.0,
                        813.0,
                        397.0,
                        869.0,
                        397.0,
                        869.0,
                        435.0,
                        894.5,
                        435.0
                    ],
                    "source": [
                        "obj-35",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-37",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        78.5,
                        39.5,
                        78.5
                    ],
                    "source": [
                        "obj-36",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-38",
                        0
                    ],
                    "source": [
                        "obj-37",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-39",
                        0
                    ],
                    "midpoints": [
                        73.5,
                        142.0,
                        78.0,
                        142.0,
                        78.0,
                        180.0,
                        99.5,
                        180.0
                    ],
                    "source": [
                        "obj-37",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-40",
                        0
                    ],
                    "midpoints": [
                        107.5,
                        142.0,
                        138.0,
                        142.0,
                        138.0,
                        180.0,
                        144.5,
                        180.0
                    ],
                    "source": [
                        "obj-37",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-41",
                        0
                    ],
                    "midpoints": [
                        141.5,
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
                        204.5,
                        180.0
                    ],
                    "source": [
                        "obj-37",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        142.0,
                        82.0,
                        142.0,
                        82.0,
                        180.0,
                        114.5,
                        180.0
                    ],
                    "source": [
                        "obj-38",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        99.5,
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
                        504.5,
                        180.0
                    ],
                    "source": [
                        "obj-39",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        174.5,
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
                        114.5,
                        180.0
                    ],
                    "source": [
                        "obj-4",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        144.5,
                        142.0,
                        243.0,
                        142.0,
                        243.0,
                        180.0,
                        243.0,
                        172.0,
                        487.0,
                        172.0,
                        487.0,
                        228.0,
                        487.0,
                        172.0,
                        547.0,
                        172.0,
                        547.0,
                        208.0,
                        609.5,
                        208.0
                    ],
                    "source": [
                        "obj-40",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        204.5,
                        172.0,
                        487.0,
                        172.0,
                        487.0,
                        228.0,
                        487.0,
                        172.0,
                        592.0,
                        172.0,
                        592.0,
                        228.0,
                        592.0,
                        172.0,
                        547.0,
                        172.0,
                        547.0,
                        208.0,
                        547.0,
                        172.0,
                        652.0,
                        172.0,
                        652.0,
                        208.0,
                        729.5,
                        208.0
                    ],
                    "source": [
                        "obj-41",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        114.5,
                        187.0,
                        277.0,
                        187.0,
                        277.0,
                        223.0,
                        279.0,
                        223.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-5",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        114.5,
                        232.0,
                        195.0,
                        232.0,
                        195.0,
                        388.0,
                        195.0,
                        397.0,
                        202.0,
                        397.0,
                        202.0,
                        435.0,
                        129.5,
                        435.0
                    ],
                    "order": 2,
                    "source": [
                        "obj-5",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-8",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-5",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-10",
                        0
                    ],
                    "source": [
                        "obj-7",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        231.5,
                        532.0,
                        243.0,
                        532.0,
                        243.0,
                        570.0,
                        249.5,
                        570.0
                    ],
                    "source": [
                        "obj-7",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-9",
                        1
                    ],
                    "order": 0,
                    "source": [
                        "obj-8",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-9",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-8",
                        0
                    ]
                }
            }
        ],
        "autosave": 0,
        "editing_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ]
    }
}