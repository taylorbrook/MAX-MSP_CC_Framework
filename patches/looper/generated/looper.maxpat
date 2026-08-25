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
            1695.0,
            527.0
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
                    "id": "obj-46",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1215.0,
                        30.0,
                        440,
                        86
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        226.0,
                        440.0,
                        86.0
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
                    "maxclass": "panel",
                    "id": "obj-45",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1215.0,
                        150.0,
                        440,
                        66
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        34.0,
                        440.0,
                        66.0
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
                    "maxclass": "flonum",
                    "id": "obj-40",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        240.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        36.0,
                        272.0,
                        44.0,
                        18.0
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
                        30.0,
                        30.0,
                        64.0,
                        22.0
                    ],
                    "text": "adc~ 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        180.0,
                        300.0,
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
                                    "code": "Buffer loopbuf;\nParam state(0, min=0, max=4);\nParam feedback(1, min=0, max=1);\nHistory writepos(0);\nHistory playpos(0);\nHistory looplen(0);\nHistory recgain(0);\nHistory outgain(0);\nHistory prevstate(0);\n\nx = in1;\nbufsize = dim(loopbuf);\nrc = exp(-1.0 / (0.01 * samplerate));\nst = state;\nps = prevstate;\nfb = min(max(feedback, 0.0), 1.0);\n\nif (ps == 1 && st != 1) {\n    looplen = writepos;\n    playpos = 0;\n}\nif (ps == 4 && st == 2) {\n    playpos = 0;\n}\nif (ps != 0 && st == 0) {\n    writepos = 0;\n    playpos = 0;\n    looplen = 0;\n}\nif (ps == 0 && st == 1) {\n    writepos = 0;\n    playpos = 0;\n}\n\nrectarget = 0.0;\nif (st == 1) {\n    rectarget = 1.0;\n}\nif (st == 3) {\n    rectarget = 1.0;\n}\nouttarget = 0.0;\nif (st == 2) {\n    outtarget = 1.0;\n}\nif (st == 3) {\n    outtarget = 1.0;\n}\nrecgain = rectarget + rc * (recgain - rectarget);\noutgain = outtarget + rc * (outgain - outtarget);\nwr = recgain;\n\nif (st == 1 && writepos < bufsize) {\n    poke(loopbuf, x * wr, writepos, 0);\n    writepos = writepos + 1;\n}\n\nplaying = 0;\nif (st != 1 && looplen > 0) {\n    playing = 1;\n}\nexisting = 0.0;\nif (playing == 1) {\n    existing = peek(loopbuf, playpos, 0);\n}\ny = existing * outgain;\nnewval = 0.0;\nif (playing == 1 && wr > 0.0005) {\n    newval = existing * (1.0 - wr + wr * fb) + x * wr;\n    poke(loopbuf, newval, playpos, 0);\n}\nadv = 0;\nif (playing == 1 && st == 2) {\n    adv = 1;\n}\nif (playing == 1 && st == 3) {\n    adv = 1;\n}\nif (adv == 1) {\n    playpos = playpos + 1;\n}\nif (playpos >= looplen && looplen > 0) {\n    playpos = 0;\n}\nprevstate = st;\nout1 = y;\nout2 = looplen;\n",
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
                    "maxclass": "newobj",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        495.0,
                        150.0,
                        177.0,
                        22.0
                    ],
                    "text": "buffer~ loopbuf 30000 1",
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
                        "signal"
                    ],
                    "patching_rect": [
                        345.0,
                        345.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~ safe-gain",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-5",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        375.0,
                        390.0,
                        72.0,
                        22.0
                    ],
                    "text": "dac~ 1 2",
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
                    "maxclass": "meter~",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        105.0,
                        30.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        175.0,
                        240.0,
                        260.0,
                        14.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        480.0,
                        345.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        175.0,
                        264.0,
                        260.0,
                        14.0
                    ]
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
                        195.0,
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
                    "maxclass": "message",
                    "id": "obj-9",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        195.0,
                        75.0,
                        72.0,
                        22.0
                    ],
                    "text": "gain 0.8",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-10",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        390.0,
                        120.0,
                        93.0,
                        22.0
                    ],
                    "text": "p transport",
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
                            400.0,
                            300.0
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
                                    "maxclass": "inlet",
                                    "id": "obj-1",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Main button bang"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-2",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Stop bang"
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
                                        120.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Clear bang"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-4",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        225.0,
                                        120.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "State (0 empty / 1 rec / 2 play / 3 dub / 4 stop)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-5",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        120.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "int",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        120.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "int",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 6,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        120.0,
                                        128.0,
                                        22.0
                                    ],
                                    "text": "select 0 1 2 3 4",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-8",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        435.0,
                                        120.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "select 2 3",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-9",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        390.0,
                                        120.0,
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
                                    "id": "obj-10",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        120.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-11",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        120.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "3",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-12",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        120.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "4",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-13",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        75.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "0",
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
                                        540.0,
                                        120.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "trigger i i i",
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
                                    ],
                                    "midpoints": [
                                        45.0,
                                        22.0,
                                        113.0,
                                        22.0,
                                        113.0,
                                        68.0,
                                        113.0,
                                        22.0,
                                        158.0,
                                        22.0,
                                        158.0,
                                        68.0,
                                        158.0,
                                        67.0,
                                        123.0,
                                        67.0,
                                        123.0,
                                        105.0,
                                        123.0,
                                        112.0,
                                        263.0,
                                        112.0,
                                        263.0,
                                        158.0,
                                        263.0,
                                        112.0,
                                        166.0,
                                        112.0,
                                        166.0,
                                        150.0,
                                        166.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        382.0,
                                        112.0,
                                        382.0,
                                        150.0,
                                        382.0,
                                        112.0,
                                        228.0,
                                        112.0,
                                        228.0,
                                        150.0,
                                        228.0,
                                        112.0,
                                        318.0,
                                        112.0,
                                        318.0,
                                        150.0,
                                        318.0,
                                        112.0,
                                        378.0,
                                        112.0,
                                        378.0,
                                        150.0,
                                        378.0,
                                        112.0,
                                        532.0,
                                        112.0,
                                        532.0,
                                        150.0,
                                        667.0,
                                        150.0
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
                                        678.5,
                                        112.0,
                                        263.0,
                                        112.0,
                                        263.0,
                                        158.0,
                                        263.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        382.0,
                                        112.0,
                                        382.0,
                                        150.0,
                                        382.0,
                                        112.0,
                                        228.0,
                                        112.0,
                                        228.0,
                                        150.0,
                                        228.0,
                                        112.0,
                                        318.0,
                                        112.0,
                                        318.0,
                                        150.0,
                                        318.0,
                                        112.0,
                                        378.0,
                                        112.0,
                                        378.0,
                                        150.0,
                                        378.0,
                                        112.0,
                                        532.0,
                                        112.0,
                                        532.0,
                                        150.0,
                                        94.0,
                                        150.0
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
                                        "obj-9",
                                        0
                                    ],
                                    "midpoints": [
                                        37.0,
                                        112.0,
                                        217.0,
                                        112.0,
                                        217.0,
                                        158.0,
                                        217.0,
                                        112.0,
                                        228.0,
                                        112.0,
                                        228.0,
                                        150.0,
                                        228.0,
                                        112.0,
                                        262.0,
                                        112.0,
                                        262.0,
                                        150.0,
                                        262.0,
                                        112.0,
                                        322.0,
                                        112.0,
                                        322.0,
                                        150.0,
                                        397.0,
                                        150.0
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
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        59.8,
                                        131.0,
                                        187.0,
                                        131.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-7",
                                        2
                                    ],
                                    "destination": [
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        82.6,
                                        112.0,
                                        217.0,
                                        112.0,
                                        217.0,
                                        158.0,
                                        217.0,
                                        112.0,
                                        172.0,
                                        112.0,
                                        172.0,
                                        150.0,
                                        277.0,
                                        150.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-7",
                                        3
                                    ],
                                    "destination": [
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        105.4,
                                        131.0,
                                        187.0,
                                        131.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-7",
                                        4
                                    ],
                                    "destination": [
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        128.2,
                                        131.0,
                                        187.0,
                                        131.0
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
                                        0
                                    ],
                                    "midpoints": [
                                        90.0,
                                        22.0,
                                        158.0,
                                        22.0,
                                        158.0,
                                        68.0,
                                        158.0,
                                        67.0,
                                        123.0,
                                        67.0,
                                        123.0,
                                        105.0,
                                        123.0,
                                        112.0,
                                        263.0,
                                        112.0,
                                        263.0,
                                        158.0,
                                        263.0,
                                        112.0,
                                        652.0,
                                        112.0,
                                        652.0,
                                        150.0,
                                        652.0,
                                        112.0,
                                        166.0,
                                        112.0,
                                        166.0,
                                        150.0,
                                        166.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        382.0,
                                        112.0,
                                        382.0,
                                        150.0,
                                        382.0,
                                        112.0,
                                        228.0,
                                        112.0,
                                        228.0,
                                        150.0,
                                        228.0,
                                        112.0,
                                        318.0,
                                        112.0,
                                        318.0,
                                        150.0,
                                        318.0,
                                        112.0,
                                        378.0,
                                        112.0,
                                        378.0,
                                        150.0,
                                        378.0,
                                        112.0,
                                        532.0,
                                        112.0,
                                        532.0,
                                        150.0,
                                        727.0,
                                        150.0
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
                                        0
                                    ],
                                    "midpoints": [
                                        738.5,
                                        112.0,
                                        652.0,
                                        112.0,
                                        652.0,
                                        150.0,
                                        652.0,
                                        112.0,
                                        655.0,
                                        112.0,
                                        655.0,
                                        150.0,
                                        478.0,
                                        150.0
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
                                        442.0,
                                        112.0,
                                        382.0,
                                        112.0,
                                        382.0,
                                        150.0,
                                        337.0,
                                        150.0
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
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        478.0,
                                        112.0,
                                        382.0,
                                        112.0,
                                        382.0,
                                        150.0,
                                        337.0,
                                        150.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        135.0,
                                        22.0,
                                        113.0,
                                        22.0,
                                        113.0,
                                        68.0,
                                        82.0,
                                        68.0
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
                                        "obj-14",
                                        0
                                    ],
                                    "midpoints": [
                                        410.0,
                                        112.0,
                                        529.0,
                                        112.0,
                                        529.0,
                                        150.0,
                                        593.5,
                                        150.0
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
                                        "obj-14",
                                        0
                                    ],
                                    "midpoints": [
                                        200.0,
                                        112.0,
                                        263.0,
                                        112.0,
                                        263.0,
                                        158.0,
                                        263.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        382.0,
                                        112.0,
                                        382.0,
                                        150.0,
                                        382.0,
                                        112.0,
                                        318.0,
                                        112.0,
                                        318.0,
                                        150.0,
                                        318.0,
                                        112.0,
                                        378.0,
                                        112.0,
                                        378.0,
                                        150.0,
                                        593.5,
                                        150.0
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
                                        "obj-14",
                                        0
                                    ],
                                    "midpoints": [
                                        290.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        438.0,
                                        112.0,
                                        438.0,
                                        150.0,
                                        438.0,
                                        112.0,
                                        378.0,
                                        112.0,
                                        378.0,
                                        150.0,
                                        593.5,
                                        150.0
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
                                        "obj-14",
                                        0
                                    ],
                                    "midpoints": [
                                        350.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        438.0,
                                        112.0,
                                        438.0,
                                        150.0,
                                        593.5,
                                        150.0
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
                                    ],
                                    "midpoints": [
                                        95.0,
                                        112.0,
                                        263.0,
                                        112.0,
                                        263.0,
                                        158.0,
                                        263.0,
                                        112.0,
                                        166.0,
                                        112.0,
                                        166.0,
                                        150.0,
                                        166.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        382.0,
                                        112.0,
                                        382.0,
                                        150.0,
                                        382.0,
                                        112.0,
                                        228.0,
                                        112.0,
                                        228.0,
                                        150.0,
                                        228.0,
                                        112.0,
                                        318.0,
                                        112.0,
                                        318.0,
                                        150.0,
                                        318.0,
                                        112.0,
                                        322.0,
                                        112.0,
                                        322.0,
                                        150.0,
                                        593.5,
                                        150.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-14",
                                        2
                                    ],
                                    "destination": [
                                        "obj-5",
                                        1
                                    ],
                                    "midpoints": [
                                        640.0,
                                        131.0,
                                        690.0,
                                        131.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-14",
                                        1
                                    ],
                                    "destination": [
                                        "obj-6",
                                        1
                                    ],
                                    "midpoints": [
                                        593.5,
                                        112.0,
                                        652.0,
                                        112.0,
                                        652.0,
                                        150.0,
                                        750.0,
                                        150.0
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
                                        "obj-4",
                                        0
                                    ],
                                    "midpoints": [
                                        547.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        382.0,
                                        112.0,
                                        382.0,
                                        150.0,
                                        382.0,
                                        112.0,
                                        318.0,
                                        112.0,
                                        318.0,
                                        150.0,
                                        318.0,
                                        112.0,
                                        378.0,
                                        112.0,
                                        378.0,
                                        150.0,
                                        232.0,
                                        150.0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0
                    },
                    "saved_object_attributes": {
                        "description": "",
                        "digest": "",
                        "globalpatchername": "",
                        "tags": ""
                    }
                }
            },
            {
                "box": {
                    "maxclass": "textbutton",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        285.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        42.0,
                        130.0,
                        50.0
                    ],
                    "text": "Loop",
                    "fontsize": 14.0
                }
            },
            {
                "box": {
                    "maxclass": "textbutton",
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        405.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        160.0,
                        42.0,
                        70.0,
                        50.0
                    ],
                    "text": "Stop",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "textbutton",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        510.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        240.0,
                        42.0,
                        70.0,
                        50.0
                    ],
                    "text": "Clear",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        480.0,
                        75.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger b b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-15",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        495.0,
                        120.0,
                        51.0,
                        22.0
                    ],
                    "text": "clear",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        375.0,
                        150.0,
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
                    "maxclass": "message",
                    "id": "obj-17",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        405.0,
                        195.0,
                        72.0,
                        22.0
                    ],
                    "text": "state $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-18",
                    "numinlets": 1,
                    "numoutlets": 6,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        491.0,
                        195.0,
                        128.0,
                        22.0
                    ],
                    "text": "select 0 1 2 3 4",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        720.0,
                        300.0,
                        51.0,
                        20.0
                    ],
                    "text": "EMPTY",
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "presentation": 1,
                    "presentation_rect": [
                        325.0,
                        56.0,
                        115.0,
                        24.0
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
                    "maxclass": "message",
                    "id": "obj-20",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        510.0,
                        240.0,
                        79.0,
                        22.0
                    ],
                    "text": "set EMPTY",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-21",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        240.0,
                        86.0,
                        22.0
                    ],
                    "text": "set RECORD",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-22",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        705.0,
                        240.0,
                        72.0,
                        22.0
                    ],
                    "text": "set PLAY",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-23",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        795.0,
                        240.0,
                        93.0,
                        22.0
                    ],
                    "text": "set OVERDUB",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        900.0,
                        240.0,
                        93.0,
                        22.0
                    ],
                    "text": "set STOPPED",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        630.0,
                        195.0,
                        86.0,
                        22.0
                    ],
                    "text": "select 1 3",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        1005.0,
                        240.0,
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
                    "maxclass": "newobj",
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1065.0,
                        240.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger b 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-28",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1080.0,
                        300.0,
                        86.0,
                        22.0
                    ],
                    "text": "qmetro 100",
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
                        1050.0,
                        345.0,
                        121.0,
                        22.0
                    ],
                    "text": "bufname loopbuf",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "waveform~",
                    "id": "obj-30",
                    "numinlets": 5,
                    "numoutlets": 6,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        750.0,
                        465.0,
                        79.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        108.0,
                        440.0,
                        110.0
                    ],
                    "buffername": "loopbuf"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        509.0,
                        345.0,
                        87.0,
                        22.0
                    ],
                    "text": "sampstoms~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-32",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        255.0,
                        390.0,
                        107.0,
                        22.0
                    ],
                    "text": "snapshot~ 100",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-33",
                    "numinlets": 7,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        509.0,
                        420.0,
                        233.0,
                        22.0
                    ],
                    "text": "expr ($f1 == 0.) * 30000. + $f1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-34",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        105.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        30.0,
                        234.0,
                        56.0,
                        56.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-35",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        150.0,
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
                    "id": "obj-36",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        45.0,
                        195.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger f f",
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
                        165.0,
                        240.0,
                        93.0,
                        22.0
                    ],
                    "text": "feedback $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-38",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        624.0,
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
                    "maxclass": "message",
                    "id": "obj-39",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        134.0,
                        75.0,
                        40.0,
                        22.0
                    ],
                    "text": "127",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        1215.0,
                        240.0,
                        58.0,
                        20.0
                    ],
                    "text": "LOOPER",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        8.0,
                        120.0,
                        24.0
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
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1215.0,
                        285.0,
                        72.0,
                        20.0
                    ],
                    "text": "FEEDBACK",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        22.0,
                        292.0,
                        72.0,
                        16.0
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
                    "id": "obj-43",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1215.0,
                        345.0,
                        40.0,
                        20.0
                    ],
                    "text": "IN",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        140.0,
                        240.0,
                        32.0,
                        16.0
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
                    "id": "obj-44",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1215.0,
                        390.0,
                        40.0,
                        20.0
                    ],
                    "text": "OUT",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        140.0,
                        264.0,
                        32.0,
                        16.0
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
                    ],
                    "midpoints": [
                        37.0,
                        22.0,
                        128.0,
                        22.0,
                        128.0,
                        138.0,
                        128.0,
                        22.0,
                        187.0,
                        22.0,
                        187.0,
                        60.0,
                        187.0,
                        22.0,
                        97.0,
                        22.0,
                        97.0,
                        60.0,
                        97.0,
                        67.0,
                        187.0,
                        67.0,
                        187.0,
                        105.0,
                        187.0,
                        67.0,
                        112.0,
                        67.0,
                        112.0,
                        105.0,
                        112.0,
                        97.0,
                        78.0,
                        97.0,
                        78.0,
                        153.0,
                        78.0,
                        142.0,
                        173.0,
                        142.0,
                        173.0,
                        180.0,
                        173.0,
                        187.0,
                        146.0,
                        187.0,
                        146.0,
                        225.0,
                        146.0,
                        232.0,
                        112.0,
                        232.0,
                        112.0,
                        288.0,
                        112.0,
                        232.0,
                        157.0,
                        232.0,
                        157.0,
                        270.0,
                        240.5,
                        270.0
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
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        127.0,
                        57.0,
                        127.0,
                        22.0,
                        112.5,
                        22.0
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        187.0,
                        337.0,
                        247.0,
                        337.0,
                        247.0,
                        375.0,
                        405.5,
                        375.0
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
                        405.5,
                        378.5,
                        382.0,
                        378.5
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
                        1
                    ],
                    "midpoints": [
                        405.5,
                        378.5,
                        440.0,
                        378.5
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        405.5,
                        356.0,
                        487.5,
                        356.0
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
                    ],
                    "midpoints": [
                        231.0,
                        63.5,
                        202.0,
                        63.5
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        231.0,
                        112.0,
                        382.0,
                        112.0,
                        382.0,
                        150.0,
                        382.0,
                        142.0,
                        367.0,
                        142.0,
                        367.0,
                        180.0,
                        367.0,
                        187.0,
                        397.0,
                        187.0,
                        397.0,
                        225.0,
                        397.0,
                        232.0,
                        266.0,
                        232.0,
                        266.0,
                        270.0,
                        266.0,
                        292.0,
                        309.0,
                        292.0,
                        309.0,
                        330.0,
                        309.0,
                        337.0,
                        350.0,
                        337.0,
                        350.0,
                        375.0,
                        405.5,
                        375.0
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
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        292.0,
                        22.0,
                        397.0,
                        22.0,
                        397.0,
                        58.0,
                        397.0,
                        58.0
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
                        "obj-10",
                        1
                    ],
                    "midpoints": [
                        412.0,
                        85.0,
                        436.5,
                        85.0
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
                        1
                    ],
                    "destination": [
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        566.0,
                        108.5,
                        502.0,
                        108.5
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
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        520.5,
                        146.0,
                        583.5,
                        146.0
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
                        "obj-10",
                        2
                    ],
                    "midpoints": [
                        487.0,
                        112.0,
                        487.0,
                        112.0,
                        487.0,
                        150.0,
                        476.0,
                        150.0
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
                        "obj-16",
                        0
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
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        475.0,
                        187.0,
                        472.0,
                        187.0,
                        472.0,
                        225.0,
                        412.0,
                        225.0
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
                        "obj-2",
                        0
                    ],
                    "midpoints": [
                        441.0,
                        232.0,
                        266.0,
                        232.0,
                        266.0,
                        270.0,
                        240.5,
                        270.0
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
                        428.5,
                        142.0,
                        487.0,
                        142.0,
                        487.0,
                        180.0,
                        487.0,
                        187.0,
                        485.0,
                        187.0,
                        485.0,
                        225.0,
                        544.0,
                        225.0
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
                    ],
                    "midpoints": [
                        487.0,
                        228.5,
                        517.0,
                        228.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-20",
                        0
                    ],
                    "destination": [
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        549.5,
                        232.0,
                        694.0,
                        232.0,
                        694.0,
                        270.0,
                        694.0,
                        232.0,
                        697.0,
                        232.0,
                        697.0,
                        270.0,
                        745.5,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-18",
                        1
                    ],
                    "destination": [
                        "obj-21",
                        0
                    ],
                    "midpoints": [
                        509.8,
                        232.0,
                        597.0,
                        232.0,
                        597.0,
                        270.0,
                        607.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-21",
                        0
                    ],
                    "destination": [
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        643.0,
                        232.0,
                        697.0,
                        232.0,
                        697.0,
                        270.0,
                        745.5,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-18",
                        2
                    ],
                    "destination": [
                        "obj-22",
                        0
                    ],
                    "midpoints": [
                        532.6,
                        187.0,
                        622.0,
                        187.0,
                        622.0,
                        225.0,
                        622.0,
                        232.0,
                        597.0,
                        232.0,
                        597.0,
                        270.0,
                        597.0,
                        232.0,
                        592.0,
                        232.0,
                        592.0,
                        270.0,
                        712.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-22",
                        0
                    ],
                    "destination": [
                        "obj-19",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-18",
                        3
                    ],
                    "destination": [
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        555.4,
                        187.0,
                        724.0,
                        187.0,
                        724.0,
                        225.0,
                        724.0,
                        232.0,
                        597.0,
                        232.0,
                        597.0,
                        270.0,
                        597.0,
                        232.0,
                        694.0,
                        232.0,
                        694.0,
                        270.0,
                        694.0,
                        232.0,
                        697.0,
                        232.0,
                        697.0,
                        270.0,
                        802.0,
                        270.0
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
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        841.5,
                        232.0,
                        785.0,
                        232.0,
                        785.0,
                        270.0,
                        745.5,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-18",
                        4
                    ],
                    "destination": [
                        "obj-24",
                        0
                    ],
                    "midpoints": [
                        578.2,
                        187.0,
                        724.0,
                        187.0,
                        724.0,
                        225.0,
                        724.0,
                        232.0,
                        597.0,
                        232.0,
                        597.0,
                        270.0,
                        597.0,
                        232.0,
                        694.0,
                        232.0,
                        694.0,
                        270.0,
                        694.0,
                        232.0,
                        785.0,
                        232.0,
                        785.0,
                        270.0,
                        785.0,
                        232.0,
                        787.0,
                        232.0,
                        787.0,
                        270.0,
                        907.0,
                        270.0
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
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        946.5,
                        232.0,
                        785.0,
                        232.0,
                        785.0,
                        270.0,
                        785.0,
                        232.0,
                        896.0,
                        232.0,
                        896.0,
                        270.0,
                        745.5,
                        270.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        382.0,
                        142.0,
                        487.0,
                        142.0,
                        487.0,
                        180.0,
                        487.0,
                        187.0,
                        485.0,
                        187.0,
                        485.0,
                        225.0,
                        485.0,
                        187.0,
                        472.0,
                        187.0,
                        472.0,
                        225.0,
                        673.0,
                        225.0
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
                    ],
                    "midpoints": [
                        637.0,
                        232.0,
                        694.0,
                        232.0,
                        694.0,
                        270.0,
                        694.0,
                        232.0,
                        785.0,
                        232.0,
                        785.0,
                        270.0,
                        785.0,
                        232.0,
                        787.0,
                        232.0,
                        787.0,
                        270.0,
                        787.0,
                        232.0,
                        892.0,
                        232.0,
                        892.0,
                        270.0,
                        1012.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-25",
                        1
                    ],
                    "destination": [
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        673.0,
                        232.0,
                        694.0,
                        232.0,
                        694.0,
                        270.0,
                        694.0,
                        232.0,
                        785.0,
                        232.0,
                        785.0,
                        270.0,
                        785.0,
                        232.0,
                        896.0,
                        232.0,
                        896.0,
                        270.0,
                        896.0,
                        232.0,
                        892.0,
                        232.0,
                        892.0,
                        270.0,
                        1012.0,
                        270.0
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
                        "obj-28",
                        0
                    ],
                    "midpoints": [
                        1025.0,
                        232.0,
                        1057.0,
                        232.0,
                        1057.0,
                        270.0,
                        1087.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-25",
                        2
                    ],
                    "destination": [
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        709.0,
                        232.0,
                        785.0,
                        232.0,
                        785.0,
                        270.0,
                        785.0,
                        232.0,
                        896.0,
                        232.0,
                        896.0,
                        270.0,
                        896.0,
                        232.0,
                        892.0,
                        232.0,
                        892.0,
                        270.0,
                        892.0,
                        232.0,
                        997.0,
                        232.0,
                        997.0,
                        270.0,
                        1111.5,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-27",
                        1
                    ],
                    "destination": [
                        "obj-28",
                        0
                    ],
                    "midpoints": [
                        1151.0,
                        281.0,
                        1087.0,
                        281.0
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
                        1123.0,
                        333.5,
                        1057.0,
                        333.5
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
                        "obj-29",
                        0
                    ],
                    "midpoints": [
                        1072.0,
                        292.0,
                        1072.0,
                        292.0,
                        1072.0,
                        330.0,
                        1057.0,
                        330.0
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
                        "obj-30",
                        0
                    ],
                    "midpoints": [
                        1110.5,
                        416.0,
                        757.0,
                        416.0
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
                        "obj-31",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-31",
                        0
                    ],
                    "destination": [
                        "obj-32",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-32",
                        0
                    ],
                    "destination": [
                        "obj-33",
                        0
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
                        "obj-30",
                        1
                    ],
                    "midpoints": [
                        416.5,
                        337.0,
                        503.0,
                        337.0,
                        503.0,
                        453.0,
                        773.25,
                        453.0
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
                        "obj-39",
                        0
                    ],
                    "midpoints": [
                        141.0,
                        22.0,
                        128.0,
                        22.0,
                        128.0,
                        138.0,
                        127.0,
                        138.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-39",
                        0
                    ],
                    "destination": [
                        "obj-34",
                        0
                    ],
                    "midpoints": [
                        140.0,
                        22.0,
                        97.0,
                        22.0,
                        97.0,
                        138.0,
                        50.0,
                        138.0
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
                        "obj-35",
                        0
                    ],
                    "destination": [
                        "obj-36",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-36",
                        1
                    ],
                    "destination": [
                        "obj-40",
                        0
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
                        "obj-37",
                        0
                    ],
                    "midpoints": [
                        52.0,
                        232.0,
                        112.0,
                        232.0,
                        112.0,
                        288.0,
                        172.0,
                        288.0
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
                        "obj-2",
                        0
                    ],
                    "midpoints": [
                        211.5,
                        281.0,
                        240.5,
                        281.0
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