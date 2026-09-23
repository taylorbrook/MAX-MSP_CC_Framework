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
            820.0,
            330.0
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
                        790,
                        20
                    ],
                    "text": "terrain-cheby v0.1  --  Chebyshev bandlimited terrain core: sum c[m][n] T_m(x) T_n(y) over the terrain-osc orbit (alias-free for the ellipse shape)",
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
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        40,
                        790,
                        48
                    ],
                    "text": "args: (1) coefficient offset in buffer~ chebcoef (A = 0, B = 64) | (2) orbit param send name (tsyn-osc / tsyn-oscB; shape + lobes steer the order limiter).  in1 orbit x | in2 orbit y | in3 Hz | in4 mode 0-1  ->  out1 audio. All signals.",
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
                        95,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Orbit x 0-1 (signal, terrain-osc outlet 2)"
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
                        95,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Orbit y 0-1 (signal, terrain-osc outlet 3)"
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
                        95,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Frequency Hz (signal)"
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
                        95,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Mode 0 terrain / 1 cheby (signal; 0 skips the sum)"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        435,
                        100,
                        65.0,
                        22.0
                    ],
                    "text": "sig~ #1",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        560,
                        60,
                        86.0,
                        22.0
                    ],
                    "text": "receive #2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        560,
                        95,
                        135.0,
                        22.0
                    ],
                    "text": "route shape lobes",
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
                        ""
                    ],
                    "patching_rect": [
                        560,
                        130,
                        107.0,
                        22.0
                    ],
                    "text": "prepend shape",
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
                        680,
                        130,
                        107.0,
                        22.0
                    ],
                    "text": "prepend lobes",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-12",
                    "numinlets": 5,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        175,
                        450,
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
                                    "maxclass": "newobj",
                                    "id": "obj-5",
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
                            },
                            {
                                "box": {
                                    "maxclass": "codebox",
                                    "id": "obj-6",
                                    "numinlets": 5,
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
                                    "code": "// terrain-cheby v0.1: Chebyshev bandlimited terrain core\n// terrain(x, y) = sum over m, n < 8 of c[m][n] * T_m(x) * T_n(y); an elliptical orbit makes this a finite\n// harmonic sum (highest partial = m + n), so it cannot alias as long as that partial stays under Nyquist\n// in1 orbit x 0-1 | in2 orbit y 0-1 (terrain-osc out 2 / 3) | in3 Hz | in4 mode 0-1 (0 = skip the sum)\n// in5 coefficient offset in buffer~ chebcoef (slot A = 0, slot B = 64), idx = offset + m * 8 + n\n// two flat constant-bound loops, no nested loops, no else-if, peek / poke with explicit channel\nParam shape(0, min=0, max=10);\nParam lobes(3, min=1, max=16);\nHistory cur(0);\nBuffer coef(\"chebcoef\");\nData tx(8);\nData ty(8);\nData wd(16);\nData cs(64);\nData ce(64);\nxs = clamp(in1 * 2. - 1., -1., 1.);\nys = clamp(in2 * 2. - 1., -1., 1.);\nf = max(in3, 0.);\nnact = 0.;\nif (in4 > 0.0005) {\n    nact = 64.;\n}\n// highest partial of one orbit coordinate (integer LOBES): f ellipse | f * lobes epitrochoid, lissajous,\n// hypotrochoid | f * (lobes + 1) rose, spiral. Squarcle (2) and polygon (7) are never bandlimited.\nfh = f;\nif (shape > 0.5 && shape < 1.5) {\n    fh = f * lobes;\n}\nif (shape > 2.5 && shape < 3.5) {\n    fh = f * lobes;\n}\nif (shape > 4.5 && shape < 5.5) {\n    fh = f * lobes;\n}\nif (shape > 3.5 && shape < 4.5) {\n    fh = f * (lobes + 1.);\n}\nif (shape > 5.5 && shape < 6.5) {\n    fh = f * (lobes + 1.);\n}\n// limacon is a degree-2 trig polynomial | butterfly: partials > 1 % reach 6 f (5 f at LOBE AMT 0; O-Strata's\n// nominal 4 f aliased) | superellipse is not bandlimited (nominal f, like squarcle / polygon)\nif (shape > 8.5 && shape < 9.5) {\n    fh = f * 2.;\n}\nif (shape > 9.5) {\n    fh = f * 6.;\n}\n// order limiter: a degree-d term fades out between 0.9 and 1.0 of min(0.45 sr, 21.6 kHz)\nfr = fh / min(0.45 * samplerate, 21600.);\n// loop 1: limiter gains per total degree + Chebyshev recurrence T(k+1) = 2 x T(k) - T(k-1) into Data\nt0x = 1.;\nt1x = xs;\nt2x = 0.;\nt0y = 1.;\nt1y = ys;\nt2y = 0.;\npoke(tx, 1., 0, 0);\npoke(tx, xs, 1, 0);\npoke(ty, 1., 0, 0);\npoke(ty, ys, 1, 0);\nfor (i = 0; i < 16; i += 1) {\n    poke(wd, clamp((1. - i * fr) * 10., 0., 1.), i, 0);\n    if (i > 1.5 && i < 7.5) {\n        t2x = 2. * xs * t1x - t0x;\n        t2y = 2. * ys * t1y - t0y;\n        poke(tx, t2x, i, 0);\n        poke(ty, t2y, i, 0);\n        t0x = t1x;\n        t1x = t2x;\n        t0y = t1y;\n        t1y = t2y;\n    }\n}\n// History cursor: one coefficient per sample is smoothed (no clicks on preset / brightness moves)\n// and multiplied by its limiter gain; the whole table refreshes every 64 samples\nk = cur;\nkm = floor(k * 0.125);\nc_s = peek(cs, k, 0);\nc_s = c_s + 0.06 * (peek(coef, in5 + k, 0) - c_s);\npoke(cs, c_s, k, 0);\npoke(ce, c_s * peek(wd, k - km * 7., 0), k, 0);\ncur = wrap(k + 1., 0., 64.);\n// loop 2: flattened N * N sum, row m = x order, column n = y order\nacc = 0.;\nm = 0.;\nn = 0.;\nfor (j = 0; j < 64; j += 1) {\n    if (j < nact) {\n        acc = acc + peek(ce, j, 0) * peek(tx, m, 0) * peek(ty, n, 0);\n    }\n    n = n + 1.;\n    if (n > 7.5) {\n        n = 0.;\n        m = m + 1.;\n    }\n}\n// dcblock is linear; no tanh here (a waveshaper would undo the band limit)\nout1 = dcblock(acc);\n",
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
                                        "obj-6",
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
                                        "obj-6",
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
                                        "obj-6",
                                        2
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
                                        "obj-6",
                                        3
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
                                        4
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
                    "id": "obj-13",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        230,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Chebyshev core (signal, within -1..1)"
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
                        "obj-12",
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
                        "obj-12",
                        1
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
                        "obj-12",
                        2
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
                        "obj-12",
                        3
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
                        "obj-12",
                        4
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
                        "obj-9",
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
                        "obj-9",
                        1
                    ],
                    "destination": [
                        "obj-11",
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
                        "obj-12",
                        0
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
                        "obj-13",
                        0
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