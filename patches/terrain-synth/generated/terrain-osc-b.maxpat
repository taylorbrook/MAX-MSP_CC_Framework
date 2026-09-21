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
                        760,
                        24.0
                    ],
                    "text": "terrain-osc-b v0.5 (slot B twin of terrain-osc.maxpat -- keep the codebox in sync)  --  live wave-terrain oscillator, one gen~ codebox reading buffer~ terrainbufB (256x256 row-major)",
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
                        15,
                        48,
                        760,
                        62
                    ],
                    "text": "in1 Hz (signal/float) | in2 x mod | in3 y mod | in4 radius mod (signals, 0 = none) | in5 param messages | in6 rotation mod (signal, turns, adds to rot) | params: shape (0 ellipse 1 epitrochoid 2 squarcle 3 lissajous 4 rose 5 hypotrochoid 6 spiral 7 polygon) rx ry rot cx cy lobes lobeamt zoomk zoomlo fb drive. out1 audio | out2 orbit x | out3 orbit y (0-1). Terrain lives in buffer~ terrainbufB (idx = y*256 + x), written from jit.matrix terrain by the host's matrix2buffer bridge. fb = trajectory feedback (last output nudges the orbit centre). Not bandlimited: host inside poly~ @up 2 (4 = HQ) or mc.gen~ per voice.",
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
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        15,
                        125,
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
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        120,
                        125,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Orbit x modulation (signal, adds to cx)"
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
                        225,
                        125,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Orbit y modulation (signal, adds to cy)"
                }
            },
            {
                "box": {
                    "maxclass": "inlet",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        330,
                        125,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Orbit radius modulation (signal, multiplies, 0 = none)"
                }
            },
            {
                "box": {
                    "maxclass": "inlet",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        435,
                        125,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Param messages: <name> <value>"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-8",
                    "numinlets": 5,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        180,
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
                                    "maxclass": "newobj",
                                    "id": "obj-2",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 3",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-4",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        290.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 4",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "codebox",
                                    "id": "obj-5",
                                    "numinlets": 5,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
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
                                    "code": "// terrain-osc-b v0.5: live wave-terrain oscillator in one codebox\n// terrain = buffer~ terrainbufB, 256x256 float32 row-major (idx = y*256 + x), filled by jit.buffer~\n// in1 Hz | in2 x mod (signal, adds to cx) | in3 y mod (adds to cy) | in4 radius mod (multiplies, 0 = none)\n// in5 rotation mod (signal, turns, adds to rot)\nBuffer terrain(\"terrainbufB\");\nParam shape(0, min=0, max=7);\nParam rx(0.3, min=0, max=0.5);\nParam ry(0.3, min=0, max=0.5);\nParam rot(0, min=0, max=1);\nParam cx(0.5, min=0, max=1);\nParam cy(0.5, min=0, max=1);\nParam lobes(3, min=1, max=16);\nParam lobeamt(0.4, min=0, max=1);\nParam zoomk(4000, min=20, max=20000);\nParam zoomlo(0.05, min=0.01, max=1);\nParam fb(0, min=-1, max=1);\nParam drive(1.5, min=0.1, max=10);\nHistory phb(0);\nHistory yprev(0);\nHistory one(1);\nf = max(in1, 0.);\nph = wrap(phb + f / samplerate, 0., 1.);\nphb = ph;\nth = ph * twopi;\n// pitch-scaled zoom (terrain mip substitute) times the radius-mod input\nzoom = clamp(zoomk / max(f, 1.), zoomlo, 1.) * (1. + in4);\n// shape: 0 ellipse, 1 epitrochoid, 2 squarcle, 3 lissajous, 4 rose, 5 hypotrochoid, 6 spiral, 7 polygon\n// (range tests, never ==). c1 / s1 / cl / sl are shared by every shape; LOBES / LOBE AMT mean, per shape:\n// epitrochoid + hypotrochoid: epicycle rate / size | lissajous: y rate / phase 0-90 deg | rose: petals / depth\n// spiral: turns per cycle / inward depth (pitch = LOBES * f at depth 0) | polygon: sides (rounded, >= 3) / circle -> polygon\nc1 = cos(th);\ns1 = sin(th);\ncl = cos(lobes * th);\nsl = sin(lobes * th);\n// kl = lobes through a History so the polygon setup chain is never hoisted as Param-only\nkl = lobes * one;\npn = max(floor(kl + 0.5), 3.);\nseg = twopi / pn;\npa = th - seg * floor(th / seg);\nrr = 1.;\nux = c1;\nuy = s1;\nif (shape > 0.5 && shape < 1.5) {\n    ux = (c1 + lobeamt * cl) / (1. + lobeamt);\n    uy = (s1 + lobeamt * sl) / (1. + lobeamt);\n}\nif (shape > 1.5 && shape < 2.5) {\n    ux = sign(c1) * pow(abs(c1), 0.5);\n    uy = sign(s1) * pow(abs(s1), 0.5);\n}\nif (shape > 2.5 && shape < 3.5) {\n    uy = sin(lobes * th + lobeamt * 1.5707963);\n}\nif (shape > 3.5 && shape < 4.5) {\n    rr = (1. - lobeamt) + lobeamt * cl;\n    ux = rr * c1;\n    uy = rr * s1;\n}\nif (shape > 4.5 && shape < 5.5) {\n    ux = (c1 + lobeamt * cl) / (1. + lobeamt);\n    uy = (s1 - lobeamt * sl) / (1. + lobeamt);\n}\nif (shape > 5.5 && shape < 6.5) {\n    rr = 1. - lobeamt * (0.5 - 0.5 * c1);\n    ux = rr * cl;\n    uy = rr * sl;\n}\nif (shape > 6.5) {\n    rr = 1. + lobeamt * (cos(pi / pn) / cos(pa - pi / pn) - 1.);\n    ux = rr * c1;\n    uy = rr * s1;\n}\n// rotation = rot Param + in5 (turns); one cos / sin pair per sample\nrotm = (rot + in5) * twopi;\nrc = cos(rotm);\nrs = sin(rotm);\nxr = ux * rc - uy * rs;\nyr = ux * rs + uy * rc;\n// trajectory feedback: the previous (pre-drive) output nudges the orbit centre\nfbx = fb * 0.25 * yprev;\nx = clamp(cx + in2 + fbx + rx * zoom * xr, 0., 1.);\ny = clamp(cy + in3 + fbx + ry * zoom * yr, 0., 1.);\n// bilinear read of the 256x256 terrain\npx = x * 255.;\npy = y * 255.;\nx0 = floor(px);\ny0 = floor(py);\nx1 = min(x0 + 1., 255.);\ny1 = min(y0 + 1., 255.);\nfx = px - x0;\nfy = py - y0;\na00 = peek(terrain, y0 * 256. + x0, 0);\na01 = peek(terrain, y0 * 256. + x1, 0);\na10 = peek(terrain, y1 * 256. + x0, 0);\na11 = peek(terrain, y1 * 256. + x1, 0);\nv = dcblock(mix(mix(a00, a01, fx), mix(a10, a11, fx), fy));\nyprev = clamp(v, -1., 1.);\nout1 = tanh(v * drive);\nout2 = x;\nout3 = y;\n",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
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
                                    "id": "obj-7",
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
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-8",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        210.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 3",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-9",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 5",
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
                                        "obj-5",
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
                                        "obj-5",
                                        1
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
                                        "obj-5",
                                        2
                                    ],
                                    "midpoints": [
                                        225.0,
                                        61.0,
                                        250.0,
                                        61.0
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
                                        3
                                    ],
                                    "midpoints": [
                                        305.0,
                                        61.0,
                                        346.5,
                                        61.0
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
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-5",
                                        1
                                    ],
                                    "destination": [
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        250.0,
                                        312.0,
                                        202.0,
                                        312.0,
                                        202.0,
                                        350.0,
                                        145.0,
                                        350.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-5",
                                        2
                                    ],
                                    "destination": [
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        443.0,
                                        300.0,
                                        225.0,
                                        300.0
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
                                        "obj-5",
                                        4
                                    ],
                                    "midpoints": [
                                        385.0,
                                        61.0,
                                        443.0,
                                        61.0
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
                    "id": "obj-9",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        250,
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
                    "id": "obj-10",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        200,
                        250,
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
                    "id": "obj-11",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        330,
                        250,
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
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        150,
                        180,
                        560,
                        34
                    ],
                    "text": "codebox: phase acc -> shape/rotation -> zoom*(1+in4) -> +feedback -> clamp 0-1 -> bilinear peek x4 -> dcblock -> tanh(drive)",
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
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        540,
                        125,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Orbit rotation modulation (signal, turns, adds to rot)"
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
                        "obj-8",
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
                        "obj-8",
                        1
                    ],
                    "midpoints": [
                        135.0,
                        117.0,
                        53.0,
                        117.0,
                        53.0,
                        163.0,
                        48.75,
                        163.0
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
                        2
                    ],
                    "midpoints": [
                        240.0,
                        117.0,
                        158.0,
                        117.0,
                        158.0,
                        163.0,
                        158.0,
                        172.0,
                        142.0,
                        172.0,
                        142.0,
                        222.0,
                        75.5,
                        222.0
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
                        "obj-8",
                        3
                    ],
                    "midpoints": [
                        345.0,
                        117.0,
                        158.0,
                        117.0,
                        158.0,
                        163.0,
                        158.0,
                        117.0,
                        217.0,
                        117.0,
                        217.0,
                        163.0,
                        217.0,
                        172.0,
                        142.0,
                        172.0,
                        142.0,
                        222.0,
                        102.25,
                        222.0
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
                        450.0,
                        117.0,
                        53.0,
                        117.0,
                        53.0,
                        163.0,
                        53.0,
                        117.0,
                        158.0,
                        117.0,
                        158.0,
                        163.0,
                        158.0,
                        117.0,
                        217.0,
                        117.0,
                        217.0,
                        163.0,
                        217.0,
                        117.0,
                        322.0,
                        117.0,
                        322.0,
                        163.0,
                        322.0,
                        172.0,
                        142.0,
                        172.0,
                        142.0,
                        222.0,
                        22.0,
                        222.0
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
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        75.5,
                        172.0,
                        142.0,
                        172.0,
                        142.0,
                        222.0,
                        207.0,
                        222.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        2
                    ],
                    "destination": [
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        129.0,
                        172.0,
                        142.0,
                        172.0,
                        142.0,
                        222.0,
                        142.0,
                        242.0,
                        238.0,
                        242.0,
                        238.0,
                        288.0,
                        337.0,
                        288.0
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
                        "obj-8",
                        4
                    ],
                    "midpoints": [
                        555.0,
                        117.0,
                        158.0,
                        117.0,
                        158.0,
                        163.0,
                        158.0,
                        117.0,
                        263.0,
                        117.0,
                        263.0,
                        163.0,
                        263.0,
                        117.0,
                        322.0,
                        117.0,
                        322.0,
                        163.0,
                        322.0,
                        117.0,
                        427.0,
                        117.0,
                        427.0,
                        163.0,
                        427.0,
                        172.0,
                        142.0,
                        172.0,
                        142.0,
                        222.0,
                        129.0,
                        222.0
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