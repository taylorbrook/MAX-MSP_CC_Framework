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
            85.0,
            104.0,
            807.0,
            515.0
        ],
        "boxes": [
            {
                "box": {
                    "angle": 270.0,
                    "background": 1,
                    "grad1": [
                        0.20784313725490197,
                        0.20784313725490197,
                        0.3254901960784314,
                        1.0
                    ],
                    "grad2": [
                        0.4745098039215686,
                        0.5647058823529412,
                        0.8156862745098039,
                        1.0
                    ],
                    "id": "obj-19",
                    "maxclass": "panel",
                    "mode": 1,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        585.0,
                        30.0,
                        144.0,
                        134.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        10.0,
                        439.0,
                        170.0
                    ],
                    "proportion": 0.39,
                    "rounded": 7
                }
            },
            {
                "box": {
                    "id": "obj-1",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        30.0,
                        45.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        90.0,
                        75.0,
                        52.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        75.0,
                        135.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        "float"
                    ],
                    "patching_rect": [
                        30.0,
                        107.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger b f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        90.0,
                        165.0,
                        97.0,
                        22.0
                    ],
                    "text": "prepend vel"
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        212.0,
                        119.0,
                        41.0,
                        41.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        35.0,
                        70.0,
                        32.0,
                        32.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        195.0,
                        165.0,
                        58.0,
                        22.0
                    ],
                    "text": "click~"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-7",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        180.0,
                        30.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        170.0,
                        62.0,
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
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        180.0,
                        75.0,
                        142.0,
                        22.0
                    ],
                    "text": "prepend randomness"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-9",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        330.0,
                        30.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        253.0,
                        62.0,
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
                    "id": "obj-10",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        75.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend bassiness"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-11",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        593.0,
                        39.0,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 0.3"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        593.0,
                        72.0,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 0.5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-13",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        593.0,
                        103.0,
                        128.0,
                        22.0
                    ],
                    "text": "loadmess set 100"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-14",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        593.0,
                        133.0,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 120"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
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
                                    "code": "Param bassiness(0.5, min=0, max=1);\nParam randomness(0.3, min=0, max=1);\nParam vel(0.79, min=0, max=1);\nHistory prevtrig(0);\nHistory kickph(0);\nHistory bodyph(0);\nHistory tapph(0);\nHistory kickenv(0);\nHistory bodyenv(0);\nHistory clickenv(0);\nHistory tapenv(0);\nHistory sweepenv(0);\nHistory lpstate(0);\nHistory kcoef(0);\nHistory bcoef(0);\nHistory ccoef(0);\nHistory tcoef(0);\nHistory scoef(0);\nHistory swmul(2);\nHistory clklvl(0.6);\nHistory clkcoef(0.5);\nHistory velamp(0);\nHistory freqmul(1);\nHistory tapfreq(1400);\nHistory taplvl(0.5);\n\ntrg = 0.;\nif (in1 > 0.5) {\n    if (prevtrig <= 0.5) {\n        trg = 1.;\n    }\n}\nprevtrig = in1;\n\nrdec = 0.;\nrswp = 0.;\nratk = 0.;\nrpit = 0.;\nrtap = 0.;\ntkick = 0.;\ntbody = 0.;\nbright = 0.;\nif (trg > 0.5) {\n    rdec = noise() * randomness;\n    rswp = noise() * randomness;\n    ratk = noise() * randomness;\n    rpit = noise() * randomness;\n    rtap = noise() * randomness;\n    tkick = (0.5 + 0.4 * bassiness) * (1. + 1.1 * rdec);\n    tkick = max(tkick, 0.04);\n    tbody = (0.14 + 0.1 * bassiness) * (1. + 0.9 * rdec);\n    tbody = max(tbody, 0.02);\n    kcoef = exp(-1. / (tkick * samplerate));\n    bcoef = exp(-1. / (tbody * samplerate));\n    ccoef = exp(-1. / (0.004 * samplerate));\n    tcoef = exp(-1. / (0.012 * samplerate));\n    scoef = exp(-1. / (0.045 * samplerate));\n    swmul = 2. * (1. + 1.4 * rswp);\n    swmul = max(swmul, 0.15);\n    clklvl = 0.6 * (1. + 1.1 * ratk) * (0.6 + 0.4 * vel);\n    clklvl = max(clklvl, 0.);\n    bright = 0.45 + 0.25 * vel + 0.4 * ratk;\n    clkcoef = clamp(bright, 0.05, 0.98);\n    freqmul = 1. + 0.35 * rpit;\n    freqmul = clamp(freqmul, 0.5, 1.8);\n    tapfreq = 1400. * (1. + 0.5 * rtap);\n    tapfreq = clamp(tapfreq, 500., 2600.);\n    taplvl = 0.5 * (0.5 + 0.5 * vel) * (1. + 0.8 * ratk);\n    taplvl = max(taplvl, 0.);\n    velamp = vel * vel;\n    kickph = 0.;\n    bodyph = 0.;\n    tapph = 0.;\n    kickenv = 1.;\n    bodyenv = 1.;\n    clickenv = 1.;\n    tapenv = 1.;\n    sweepenv = 1.;\n}\n\nbasef = (40. - 18. * bassiness) * freqmul;\nkfreq = basef * (1. + swmul * sweepenv * sweepenv);\nbfreq = basef * 2.7;\n\nkickph = wrap(kickph + kfreq / samplerate, 0., 1.);\nbodyph = wrap(bodyph + bfreq / samplerate, 0., 1.);\ntapph = wrap(tapph + tapfreq / samplerate, 0., 1.);\n\nnz = noise() * clickenv;\nlpstate = lpstate + clkcoef * (nz - lpstate);\n\nsig = sin(kickph * twopi) * kickenv * kickenv * 0.95;\nsig = sig + sin(bodyph * twopi) * bodyenv * bodyenv * 0.28;\nsig = sig + sin(tapph * twopi) * tapenv * tapenv * taplvl;\nsig = sig + lpstate * clklvl;\n\nhard = 2.2 + 1.3 * bassiness;\nout1 = tanh(sig * hard) * velamp * 0.85;\n\nkickenv = kickenv * kcoef;\nbodyenv = bodyenv * bcoef;\nclickenv = clickenv * ccoef;\ntapenv = tapenv * tcoef;\nsweepenv = sweepenv * scoef;\n",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "codebox",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
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
                                        210.0,
                                        300.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 1"
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
                        195.0,
                        195.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "id": "obj-16",
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
                        237.0,
                        240.0,
                        28.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        327.0,
                        26.0,
                        24.0,
                        120.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-17",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        270.0,
                        240.0,
                        15.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        357.0,
                        26.0,
                        14.0,
                        120.0
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
                    "id": "obj-18",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        225.0,
                        405.0,
                        45.0,
                        45.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        390.0,
                        63.5,
                        45.0,
                        45.0
                    ]
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 18.0,
                    "id": "obj-20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        585.0,
                        176.0,
                        74.0,
                        27.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25.0,
                        20.0,
                        90.0,
                        27.0
                    ],
                    "text": "KNOCK",
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-21",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        585.0,
                        212.0,
                        40.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        35.0,
                        108.0,
                        40.0,
                        20.0
                    ],
                    "text": "hit",
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        586.0,
                        242.0,
                        72.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        88.0,
                        108.0,
                        60.0,
                        20.0
                    ],
                    "text": "velocity",
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-23",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        586.0,
                        271.0,
                        86.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        158.0,
                        115.0,
                        78.0,
                        20.0
                    ],
                    "text": "randomness",
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        671.0,
                        176.0,
                        79.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        246.0,
                        115.0,
                        68.0,
                        20.0
                    ],
                    "text": "bassiness",
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-25",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        671.0,
                        212.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        327.0,
                        151.0,
                        44.0,
                        20.0
                    ],
                    "text": "output",
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-26",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        550.0,
                        10.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.1.0",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        69.0,
                        39.5,
                        69.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        339.5,
                        180.0,
                        255.0,
                        180.0,
                        255.0,
                        192.0,
                        204.5,
                        192.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        602.5,
                        63.0,
                        477.0,
                        63.0,
                        477.0,
                        15.0,
                        189.5,
                        15.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        602.5,
                        96.0,
                        477.0,
                        96.0,
                        477.0,
                        27.0,
                        339.5,
                        27.0
                    ],
                    "source": [
                        "obj-12",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        602.5,
                        126.0,
                        477.0,
                        126.0,
                        477.0,
                        15.0,
                        39.5,
                        15.0
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
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        602.5,
                        156.0,
                        327.0,
                        156.0,
                        327.0,
                        237.0,
                        246.5,
                        237.0
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
                        204.5,
                        237.0,
                        246.5,
                        237.0
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
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        246.5,
                        351.0,
                        297.0,
                        351.0,
                        297.0,
                        237.0,
                        279.0,
                        237.0
                    ],
                    "order": 0,
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
                        1
                    ],
                    "midpoints": [
                        246.5,
                        390.0,
                        260.5,
                        390.0
                    ],
                    "order": 1,
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
                        246.5,
                        390.0,
                        234.5,
                        390.0
                    ],
                    "order": 2,
                    "source": [
                        "obj-16",
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
                    "midpoints": [
                        39.5,
                        99.0,
                        39.5,
                        99.0
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
                    "midpoints": [
                        113.5,
                        150.0,
                        99.5,
                        150.0
                    ],
                    "source": [
                        "obj-3",
                        1
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
                        39.5,
                        150.0,
                        201.0,
                        150.0,
                        201.0,
                        162.0,
                        204.5,
                        162.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        99.5,
                        198.0,
                        192.0,
                        198.0,
                        192.0,
                        192.0,
                        204.5,
                        192.0
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
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        221.5,
                        162.0,
                        204.5,
                        162.0
                    ],
                    "source": [
                        "obj-5",
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
                        204.5,
                        189.0,
                        204.5,
                        189.0
                    ],
                    "source": [
                        "obj-6",
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
                    "midpoints": [
                        189.5,
                        72.0,
                        189.5,
                        72.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        189.5,
                        192.0,
                        204.5,
                        192.0
                    ],
                    "source": [
                        "obj-8",
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
                    "midpoints": [
                        339.5,
                        72.0,
                        339.5,
                        72.0
                    ],
                    "source": [
                        "obj-9",
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