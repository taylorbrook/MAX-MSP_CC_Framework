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
            640.0,
            480.0
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
                    "maxclass": "comment",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        15,
                        640,
                        24.0
                    ],
                    "text": "terrain-osc  --  live wave-terrain oscillator: orbit gen~ -> jit.peek~ terrain -> dcblock + tanh",
                    "fontname": "Arial",
                    "fontsize": 13.0,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
                        1.0
                    ],
                    "bgcolor": [
                        0.88,
                        0.9,
                        0.95,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        665,
                        15,
                        58.0,
                        20.0
                    ],
                    "text": "v0.2.0",
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
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        48,
                        680,
                        48
                    ],
                    "text": "in1 Hz (signal/float) | in2 param messages: shape rx ry rot cx cy lobes lobeamt zoomk zoomlo drive. out1 audio | out2 orbit x | out3 orbit y (0-1). Reads plane 0 of the named jit.matrix 'terrain' (1 float32 256 256) with normalized coords. Not bandlimited: host inside poly~ @up 2 (4 = HQ).",
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
                    "maxclass": "inlet",
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        15.0,
                        120.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Frequency Hz (signal or float)"
                }
            },
            {
                "box": {
                    "maxclass": "inlet",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        195.0,
                        120.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Param messages: <name> <value> (shape rx ry rot cx cy lobes lobeamt zoomk zoomlo drive)"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        195.0,
                        165.0,
                        101.0,
                        22.0
                    ],
                    "text": "route drive",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        195.0,
                        210.0,
                        107.0,
                        22.0
                    ],
                    "text": "prepend drive",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        240,
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
                                        50.0,
                                        20.0,
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
                                        50.0,
                                        80.0,
                                        400.0,
                                        200.0
                                    ],
                                    "parameter_enable": 0,
                                    "code": "// terrain-osc orbit: Hz in -> normalized (x, y) matrix coords out\n// shape: 0 ellipse, 1 epitrochoid, 2 squarcle (range tests, never ==)\nParam shape(0, min=0, max=2);\nParam rx(0.3, min=0, max=0.5);\nParam ry(0.3, min=0, max=0.5);\nParam rot(0, min=0, max=1);\nParam cx(0.5, min=0, max=1);\nParam cy(0.5, min=0, max=1);\nParam lobes(3, min=1, max=16);\nParam lobeamt(0.4, min=0, max=1);\nParam zoomk(4000, min=20, max=20000);\nParam zoomlo(0.05, min=0.01, max=1);\nHistory phb(0);\nf = max(in1, 0.);\nph = wrap(phb + f / samplerate, 0., 1.);\nphb = ph;\nth = ph * twopi;\n// pitch-scaled terrain zoom: orbit shrinks above zoomk Hz so the terrain's\n// spatial frequency scales down with pitch (terrain mip substitute)\nzoom = clamp(zoomk / max(f, 1.), zoomlo, 1.);\nux = cos(th);\nuy = sin(th);\nif (shape > 0.5 && shape < 1.5) {\n    ux = (cos(th) + lobeamt * cos(lobes * th)) / (1. + lobeamt);\n    uy = (sin(th) + lobeamt * sin(lobes * th)) / (1. + lobeamt);\n}\nif (shape > 1.5) {\n    ux = sign(cos(th)) * pow(abs(cos(th)), 0.5);\n    uy = sign(sin(th)) * pow(abs(sin(th)), 0.5);\n}\nxr = ux * cos(rot * twopi) - uy * sin(rot * twopi);\nyr = ux * sin(rot * twopi) + uy * cos(rot * twopi);\n// keep the orbit inside the matrix (jit.peek~ @normalize 1 coords)\nout1 = clamp(cx + rx * zoom * xr, 0.02, 0.98);\nout2 = clamp(cy + ry * zoom * yr, 0.02, 0.98);\n",
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
                                        50.0,
                                        320.0,
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
                                        130.0,
                                        320.0,
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
                                        65.0,
                                        61.0,
                                        250.0,
                                        61.0
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
                                    ],
                                    "midpoints": [
                                        443.0,
                                        300.0,
                                        145.0,
                                        300.0
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
                    "maxclass": "newobj",
                    "id": "obj-9",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        15.0,
                        285.0,
                        324.0,
                        22.0
                    ],
                    "text": "jit.peek~ terrain 2 0 @interp 1 @normalize 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-10",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        340,
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
                                        50.0,
                                        20.0,
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
                                        50.0,
                                        80.0,
                                        400.0,
                                        200.0
                                    ],
                                    "parameter_enable": 0,
                                    "code": "// terrain-osc shaper: dc removal + tanh drive\nParam drive(1.5, min=0.1, max=10);\nout1 = tanh(dcblock(in1) * drive);\n",
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
                                        50.0,
                                        320.0,
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
                                        65.0,
                                        61.0,
                                        250.0,
                                        61.0
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
                                    ],
                                    "midpoints": [
                                        250.0,
                                        300.0,
                                        65.0,
                                        300.0
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
                    "maxclass": "outlet",
                    "id": "obj-11",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15.0,
                        405.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Oscillator signal"
                }
            },
            {
                "box": {
                    "maxclass": "outlet",
                    "id": "obj-12",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        195.0,
                        405.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Orbit x 0-1 (signal)"
                }
            },
            {
                "box": {
                    "maxclass": "outlet",
                    "id": "obj-13",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        330.0,
                        405.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Orbit y 0-1 (signal)"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        150,
                        240,
                        420,
                        34
                    ],
                    "text": "orbit codebox: phase acc, shape select, rotation, radius *= clamp(zoomk/f, zoomlo, 1), clamp 0.02-0.98",
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
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        330,
                        290,
                        220,
                        20.0
                    ],
                    "text": "reads x,y -> plane 0, bilinear",
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
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        150,
                        340,
                        240,
                        20.0
                    ],
                    "text": "gen~: tanh(dcblock(in1) * drive)",
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
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        330,
                        155,
                        340,
                        34
                    ],
                    "text": "drive -> shaper gen~; everything else -> orbit gen~ Params",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                        "obj-4",
                        0
                    ],
                    "destination": [
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        30.0,
                        195.0,
                        75.5,
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
                        210.0,
                        157.5,
                        245.5,
                        157.5
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        202.0,
                        198.5,
                        248.5,
                        198.5
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
                    ],
                    "midpoints": [
                        248.5,
                        232.0,
                        144.0,
                        232.0,
                        144.0,
                        270.0,
                        144.0,
                        232.0,
                        142.0,
                        232.0,
                        142.0,
                        282.0,
                        142.0,
                        277.0,
                        7.0,
                        277.0,
                        7.0,
                        315.0,
                        7.0,
                        332.0,
                        142.0,
                        332.0,
                        142.0,
                        368.0,
                        75.5,
                        368.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-6",
                        1
                    ],
                    "destination": [
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        289.0,
                        202.0,
                        187.0,
                        202.0,
                        187.0,
                        240.0,
                        187.0,
                        232.0,
                        142.0,
                        232.0,
                        142.0,
                        282.0,
                        75.5,
                        282.0
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
                        1
                    ],
                    "destination": [
                        "obj-9",
                        1
                    ],
                    "midpoints": [
                        129.0,
                        232.0,
                        142.0,
                        232.0,
                        142.0,
                        282.0,
                        332.0,
                        282.0
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
                        22.0,
                        323.5,
                        75.5,
                        323.5
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
                        75.5,
                        383.5,
                        22.0,
                        383.5
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        22.0,
                        232.0,
                        142.0,
                        232.0,
                        142.0,
                        282.0,
                        142.0,
                        277.0,
                        7.0,
                        277.0,
                        7.0,
                        315.0,
                        7.0,
                        332.0,
                        144.0,
                        332.0,
                        144.0,
                        370.0,
                        144.0,
                        332.0,
                        142.0,
                        332.0,
                        142.0,
                        368.0,
                        142.0,
                        397.0,
                        53.0,
                        397.0,
                        53.0,
                        443.0,
                        202.0,
                        443.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        1
                    ],
                    "destination": [
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        129.0,
                        232.0,
                        142.0,
                        232.0,
                        142.0,
                        282.0,
                        142.0,
                        277.0,
                        347.0,
                        277.0,
                        347.0,
                        315.0,
                        347.0,
                        282.0,
                        322.0,
                        282.0,
                        322.0,
                        318.0,
                        322.0,
                        332.0,
                        144.0,
                        332.0,
                        144.0,
                        370.0,
                        144.0,
                        332.0,
                        142.0,
                        332.0,
                        142.0,
                        368.0,
                        142.0,
                        397.0,
                        233.0,
                        397.0,
                        233.0,
                        443.0,
                        337.0,
                        443.0
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0,
        "bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ],
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