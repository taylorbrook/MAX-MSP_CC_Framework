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
            1199.0,
            490.0
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
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        585.0,
                        30.0,
                        480,
                        170
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        10.0,
                        480.0,
                        170.0
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
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        45.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        90.0,
                        75.0,
                        52.0,
                        23.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-2",
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
                    "text": "scale 0 127 0. 1.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        45.0,
                        120.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger b f",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-4",
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
                    "text": "prepend vel",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "button",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        110.0,
                        30.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0,
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
                    "maxclass": "newobj",
                    "id": "obj-6",
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
                    "text": "click~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        180.0,
                        30.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        170.0,
                        62.0,
                        48.0,
                        48.0
                    ],
                    "floatoutput": 1,
                    "size": 1.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-8",
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
                    "text": "prepend randomness",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        30.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        265.0,
                        62.0,
                        48.0,
                        48.0
                    ],
                    "floatoutput": 1,
                    "size": 1.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-10",
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
                    "text": "prepend bassiness",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        640.0,
                        40.0,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 0.3",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        765.0,
                        40.0,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        890.0,
                        40.0,
                        128.0,
                        22.0
                    ],
                    "text": "loadmess set 100",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1043.0,
                        40.0,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 120",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        195.0,
                        195.0,
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
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        400.0,
                                        200.0
                                    ],
                                    "parameter_enable": 0,
                                    "code": "Param bassiness(0.5, min=0, max=1);\nParam randomness(0.3, min=0, max=1);\nParam vel(0.79, min=0, max=1);\nHistory prevtrig(0);\nHistory kickph(0);\nHistory bodyph(0);\nHistory kickenv(0);\nHistory bodyenv(0);\nHistory clickenv(0);\nHistory sweepenv(0);\nHistory lpstate(0);\nHistory kcoef(0);\nHistory bcoef(0);\nHistory ccoef(0);\nHistory scoef(0);\nHistory swmul(2);\nHistory clklvl(0.35);\nHistory clkcoef(0.5);\nHistory velamp(0);\n\ntrg = 0.;\nif (in1 > 0.5) {\n    if (prevtrig <= 0.5) {\n        trg = 1.;\n    }\n}\nprevtrig = in1;\n\nrdec = 0.;\nrswp = 0.;\nratk = 0.;\ntkick = 0.;\ntbody = 0.;\nbright = 0.;\nif (trg > 0.5) {\n    rdec = noise() * randomness;\n    rswp = noise() * randomness;\n    ratk = noise() * randomness;\n    tkick = (0.14 + 0.36 * bassiness) * (1. + 0.55 * rdec);\n    tkick = max(tkick, 0.03);\n    tbody = (0.05 + 0.09 * bassiness) * (1. + 0.4 * rdec);\n    tbody = max(tbody, 0.015);\n    kcoef = exp(-1. / (tkick * samplerate));\n    bcoef = exp(-1. / (tbody * samplerate));\n    ccoef = exp(-1. / (0.006 * samplerate));\n    scoef = exp(-1. / (0.045 * samplerate));\n    swmul = 2. * (1. + 0.6 * rswp);\n    swmul = max(swmul, 0.2);\n    clklvl = 0.35 * (1. + 0.6 * ratk) * (0.6 + 0.4 * vel);\n    clklvl = max(clklvl, 0.);\n    bright = 0.12 + 0.45 * (1. - bassiness) + 0.15 * vel + 0.25 * ratk;\n    clkcoef = clamp(bright, 0.02, 0.9);\n    velamp = vel * vel;\n    kickph = 0.;\n    bodyph = 0.;\n    kickenv = 1.;\n    bodyenv = 1.;\n    clickenv = 1.;\n    sweepenv = 1.;\n}\n\nbasef = 90. - 50. * bassiness;\nkfreq = basef * (1. + swmul * sweepenv * sweepenv);\nbfreq = basef * 2.7;\n\nkickph = wrap(kickph + kfreq / samplerate, 0., 1.);\nbodyph = wrap(bodyph + bfreq / samplerate, 0., 1.);\n\nnz = noise() * clickenv;\nlpstate = lpstate + clkcoef * (nz - lpstate);\n\nsig = sin(kickph * twopi) * kickenv * kickenv * 0.95;\nsig = sig + sin(bodyph * twopi) * bodyenv * bodyenv * 0.28;\nsig = sig + lpstate * clklvl;\n\nhard = 1. + 1.2 * bassiness;\nout1 = tanh(sig * hard) * velamp * 0.85;\n\nkickenv = kickenv * kcoef;\nbodyenv = bodyenv * bcoef;\nclickenv = clickenv * ccoef;\nsweepenv = sweepenv * scoef;\n",
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
                                        210.0,
                                        300.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 1",
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
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        255.0,
                        240.0,
                        22.0,
                        140.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        370.0,
                        40.0,
                        24.0,
                        120.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        270.0,
                        240.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        400.0,
                        40.0,
                        14.0,
                        120.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "ezdac~",
                    "id": "obj-18",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        225.0,
                        405.0,
                        45.0,
                        45.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        430.0,
                        55.0,
                        45.0,
                        45.0
                    ],
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
                    "maxclass": "comment",
                    "id": "obj-20",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        585.0,
                        225.0,
                        51.0,
                        20.0
                    ],
                    "text": "KNOCK",
                    "fontname": "Arial",
                    "fontsize": 18.0,
                    "presentation": 1,
                    "presentation_rect": [
                        25.0,
                        20.0,
                        90.0,
                        29.0
                    ],
                    "fontface": 1,
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
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        585.0,
                        285.0,
                        40.0,
                        20.0
                    ],
                    "text": "hit",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        35.0,
                        108.0,
                        40.0,
                        20.0
                    ],
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
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        585.0,
                        330.0,
                        72.0,
                        20.0
                    ],
                    "text": "velocity",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        88.0,
                        108.0,
                        60.0,
                        20.0
                    ],
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
                    "id": "obj-23",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        585.0,
                        375.0,
                        86.0,
                        20.0
                    ],
                    "text": "randomness",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        158.0,
                        115.0,
                        78.0,
                        20.0
                    ],
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
                    "id": "obj-24",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1080.0,
                        30.0,
                        79.0,
                        20.0
                    ],
                    "text": "bassiness",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        258.0,
                        115.0,
                        68.0,
                        20.0
                    ],
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
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1080.0,
                        75.0,
                        58.0,
                        20.0
                    ],
                    "text": "output",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        370.0,
                        165.0,
                        60.0,
                        20.0
                    ],
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
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
                        "obj-3",
                        1
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        138.5,
                        157.0,
                        187.0,
                        157.0,
                        187.0,
                        195.0,
                        255.5,
                        195.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        0
                    ],
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        52.0,
                        157.0,
                        82.0,
                        157.0,
                        82.0,
                        195.0,
                        224.0,
                        195.0
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
                        192.0,
                        22.0,
                        228.0,
                        22.0,
                        228.0,
                        78.0,
                        228.0,
                        22.0,
                        202.0,
                        22.0,
                        202.0,
                        60.0,
                        202.0,
                        67.0,
                        172.0,
                        67.0,
                        172.0,
                        105.0,
                        172.0,
                        157.0,
                        195.0,
                        157.0,
                        195.0,
                        195.0,
                        224.0,
                        195.0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        200.0,
                        72.5,
                        251.0,
                        72.5
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        251.0,
                        157.0,
                        261.0,
                        157.0,
                        261.0,
                        195.0,
                        255.5,
                        195.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-9",
                        0
                    ],
                    "destination": [
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        350.0,
                        72.5,
                        397.5,
                        72.5
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        397.5,
                        67.0,
                        330.0,
                        67.0,
                        330.0,
                        105.0,
                        330.0,
                        157.0,
                        261.0,
                        157.0,
                        261.0,
                        195.0,
                        255.5,
                        195.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        380.0,
                        22.0,
                        212.0,
                        22.0,
                        212.0,
                        62.0,
                        212.0,
                        22.0,
                        322.0,
                        22.0,
                        322.0,
                        78.0,
                        322.0,
                        22.0,
                        318.0,
                        22.0,
                        318.0,
                        60.0,
                        200.0,
                        60.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-12",
                        0
                    ],
                    "destination": [
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        485.0,
                        22.0,
                        438.0,
                        22.0,
                        438.0,
                        60.0,
                        350.0,
                        60.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        94.0,
                        48.5,
                        55.0,
                        48.5
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
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        260.0,
                        67.0,
                        330.0,
                        67.0,
                        330.0,
                        105.0,
                        330.0,
                        157.0,
                        261.0,
                        157.0,
                        261.0,
                        195.0,
                        261.0,
                        187.0,
                        324.0,
                        187.0,
                        324.0,
                        225.0,
                        324.0,
                        232.0,
                        262.0,
                        232.0,
                        262.0,
                        348.0,
                        266.0,
                        348.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-6",
                        0
                    ],
                    "destination": [
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        224.0,
                        191.0,
                        255.5,
                        191.0
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
                        255.5,
                        232.0,
                        262.0,
                        232.0,
                        262.0,
                        348.0,
                        266.0,
                        348.0
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
                    ],
                    "midpoints": [
                        292.0,
                        385.0,
                        292.0,
                        232.0,
                        277.5,
                        232.0
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
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        262.0,
                        392.5,
                        232.0,
                        392.5
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
                        "obj-18",
                        1
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