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
            1045.0,
            520.0
        ],
        "bglocked": 0,
        "openinpresentation": 1,
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
                    "id": "obj-30",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        795.0,
                        30.0,
                        121.0,
                        20.0
                    ],
                    "text": "drop audio file",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        12.0,
                        29.0,
                        130.0,
                        17.0
                    ],
                    "ignoreclick": 1,
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
                    "maxclass": "panel",
                    "id": "obj-29",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        795.0,
                        75.0,
                        210,
                        150
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        0.0,
                        210.0,
                        150.0
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
                    "maxclass": "dropfile",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        100.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        6.0,
                        24.0,
                        198.0,
                        26.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        150.0,
                        51.0,
                        22.0
                    ],
                    "text": "t s s",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-3",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        195.0,
                        114.0,
                        22.0
                    ],
                    "text": "no file loaded",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        6.0,
                        54.0,
                        198.0,
                        20.0
                    ]
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
                        165.0,
                        195.0,
                        121.0,
                        22.0
                    ],
                    "text": "prepend replace",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        240.0,
                        147.0,
                        22.0
                    ],
                    "text": "buffer~ #1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        270.0,
                        270.0,
                        37.0,
                        22.0
                    ],
                    "text": "t b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 10,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        315.0,
                        258.43748474121094,
                        22.0
                    ],
                    "text": "info~ #1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-8",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        360.0,
                        79.0,
                        22.0
                    ],
                    "text": "filesr $1",
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
                        435.0,
                        225.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        8.0,
                        82.0,
                        45.0,
                        45.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-10",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        435.0,
                        275.0,
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
                    "maxclass": "message",
                    "id": "obj-11",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        465.0,
                        315.0,
                        65.0,
                        22.0
                    ],
                    "text": "gain $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        585.0,
                        240.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        90.0,
                        55.0,
                        22.0
                    ]
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
                        585.0,
                        270.0,
                        79.0,
                        22.0
                    ],
                    "text": "minlen $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        675.0,
                        240.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        135.0,
                        90.0,
                        55.0,
                        22.0
                    ]
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
                        675.0,
                        270.0,
                        79.0,
                        22.0
                    ],
                    "text": "maxlen $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        30.0,
                        107.0,
                        22.0
                    ],
                    "text": "r grain-taper",
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
                        195.0,
                        150.0,
                        72.0,
                        22.0
                    ],
                    "text": "taper $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-18",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        270.0,
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
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 5,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        285.0,
                        150.0,
                        93.0,
                        22.0
                    ],
                    "text": "t b b b b b",
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
                        360.0,
                        240.0,
                        44.0,
                        20.0
                    ],
                    "text": "slot",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        7.0,
                        4.0,
                        90.0,
                        18.0
                    ],
                    "fontface": 1,
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
                    "maxclass": "message",
                    "id": "obj-21",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        360.0,
                        195.0,
                        58.0,
                        22.0
                    ],
                    "text": "set #1",
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
                        435.0,
                        195.0,
                        58.0,
                        22.0
                    ],
                    "text": "buf #1",
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
                        510.0,
                        195.0,
                        44.0,
                        22.0
                    ],
                    "text": "8000",
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
                        570.0,
                        195.0,
                        44.0,
                        22.0
                    ],
                    "text": "3000",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-25",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        615.0,
                        302.0,
                        40.0,
                        22.0
                    ],
                    "text": "100",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-26",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        390.0,
                        405.0,
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
                                    "code": "Buffer buf;\nParam minlen(3000, min=100, max=60000);\nParam maxlen(8000, min=100, max=60000);\nParam gain(0.8, min=0, max=1);\nParam taper(500, min=10, max=5000);\nParam filesr(44100, min=8000, max=192000);\nHistory pos(0);\nHistory len(0);\nHistory start(0);\nHistory gl(0.70710678);\nHistory gr(0.70710678);\nHistory g(0);\n\nrate = filesr / samplerate;\nframes = dim(buf);\ng = g + 0.0005 * (gain - g);\nr1 = 0;\nr2 = 0;\nr3 = 0;\nnewlen = 0;\nmaxstart = 0;\npanpos = 0;\nT = 0;\nenv = 1;\nidx = 0;\ni0 = 0;\nfrac = 0;\ns0 = 0;\ns1 = 0;\ns = 0;\nout1 = 0;\nout2 = 0;\nif (frames > 0) {\n    if (pos >= len) {\n        r1 = abs(noise());\n        r2 = abs(noise());\n        r3 = abs(noise());\n        newlen = (minlen + r1 * (maxlen - minlen)) * samplerate * 0.001;\n        newlen = max(newlen, 64);\n        maxstart = frames - newlen * rate;\n        if (maxstart < 0) {\n            maxstart = 0;\n        }\n        start = r2 * maxstart;\n        len = newlen;\n        pos = 0;\n        panpos = r3;\n        gl = cos(panpos * halfpi);\n        gr = sin(panpos * halfpi);\n    }\n    T = taper * samplerate * 0.001;\n    T = min(T, len * 0.5);\n    T = max(T, 1);\n    if (pos < T) {\n        env = 0.5 * (1 - cos(pi * pos / T));\n    } else {\n        if (pos > len - T) {\n            env = 0.5 * (1 - cos(pi * (len - pos) / T));\n        }\n    }\n    idx = start + pos * rate;\n    i0 = floor(idx);\n    frac = idx - i0;\n    s0 = peek(buf, i0, 0);\n    s1 = peek(buf, i0 + 1, 0);\n    s = s0 + frac * (s1 - s0);\n    out1 = s * env * gl * g;\n    out2 = s * env * gr * g;\n    pos = pos + 1;\n}\n",
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
                    "maxclass": "outlet",
                    "id": "obj-27",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        390.0,
                        450.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Grain Output Left"
                }
            },
            {
                "box": {
                    "maxclass": "outlet",
                    "id": "obj-28",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        495.0,
                        450.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Grain Output Right"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        795.0,
                        255.0,
                        44.0,
                        20.0
                    ],
                    "text": "gain",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        14.0,
                        128.0,
                        40.0,
                        16.0
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
                    "id": "obj-32",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        795.0,
                        315.0,
                        58.0,
                        20.0
                    ],
                    "text": "min ms",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        72.0,
                        55.0,
                        16.0
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
                    "id": "obj-33",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        795.0,
                        360.0,
                        58.0,
                        20.0
                    ],
                    "text": "max ms",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        135.0,
                        72.0,
                        55.0,
                        16.0
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
                        1
                    ],
                    "destination": [
                        "obj-3",
                        1
                    ],
                    "midpoints": [
                        74.0,
                        183.5,
                        137.0,
                        183.5
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
                        37.0,
                        142.0,
                        187.0,
                        142.0,
                        187.0,
                        180.0,
                        187.0,
                        187.0,
                        152.0,
                        187.0,
                        152.0,
                        225.0,
                        225.5,
                        225.0
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
                        "obj-6",
                        0
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
                        "obj-10",
                        0
                    ],
                    "destination": [
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        502.5,
                        306.0,
                        472.0,
                        306.0
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
                        "obj-18",
                        0
                    ],
                    "destination": [
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        306.0,
                        101.0,
                        331.5,
                        101.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-19",
                        4
                    ],
                    "destination": [
                        "obj-21",
                        0
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
                        "obj-20",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-19",
                        3
                    ],
                    "destination": [
                        "obj-22",
                        0
                    ],
                    "midpoints": [
                        351.25,
                        187.0,
                        426.0,
                        187.0,
                        426.0,
                        225.0,
                        442.0,
                        225.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-19",
                        2
                    ],
                    "destination": [
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        331.5,
                        187.0,
                        426.0,
                        187.0,
                        426.0,
                        225.0,
                        426.0,
                        187.0,
                        427.0,
                        187.0,
                        427.0,
                        225.0,
                        517.0,
                        225.0
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
                        "obj-14",
                        0
                    ],
                    "midpoints": [
                        532.0,
                        187.0,
                        622.0,
                        187.0,
                        622.0,
                        225.0,
                        622.0,
                        232.0,
                        643.0,
                        232.0,
                        643.0,
                        270.0,
                        700.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-19",
                        1
                    ],
                    "destination": [
                        "obj-24",
                        0
                    ],
                    "midpoints": [
                        311.75,
                        187.0,
                        426.0,
                        187.0,
                        426.0,
                        225.0,
                        426.0,
                        187.0,
                        427.0,
                        187.0,
                        427.0,
                        225.0,
                        427.0,
                        187.0,
                        502.0,
                        187.0,
                        502.0,
                        225.0,
                        577.0,
                        225.0
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
                        "obj-12",
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        292.0,
                        187.0,
                        294.0,
                        187.0,
                        294.0,
                        225.0,
                        294.0,
                        187.0,
                        426.0,
                        187.0,
                        426.0,
                        225.0,
                        426.0,
                        187.0,
                        427.0,
                        187.0,
                        427.0,
                        225.0,
                        427.0,
                        187.0,
                        502.0,
                        187.0,
                        502.0,
                        225.0,
                        502.0,
                        187.0,
                        562.0,
                        187.0,
                        562.0,
                        225.0,
                        562.0,
                        217.0,
                        483.0,
                        217.0,
                        483.0,
                        273.0,
                        483.0,
                        232.0,
                        305.0,
                        232.0,
                        305.0,
                        270.0,
                        305.0,
                        232.0,
                        577.0,
                        232.0,
                        577.0,
                        270.0,
                        577.0,
                        232.0,
                        412.0,
                        232.0,
                        412.0,
                        268.0,
                        412.0,
                        262.0,
                        315.0,
                        262.0,
                        315.0,
                        300.0,
                        315.0,
                        262.0,
                        577.0,
                        262.0,
                        577.0,
                        300.0,
                        577.0,
                        267.0,
                        427.0,
                        267.0,
                        427.0,
                        305.0,
                        622.0,
                        305.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        1035.0,
                        329.0,
                        1035.0,
                        217.0,
                        455.0,
                        217.0
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
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        189.5,
                        393.5,
                        450.5,
                        393.5
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
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        497.5,
                        371.0,
                        450.5,
                        371.0
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
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        624.5,
                        267.0,
                        578.0,
                        267.0,
                        578.0,
                        305.0,
                        578.0,
                        294.0,
                        607.0,
                        294.0,
                        607.0,
                        332.0,
                        607.0,
                        307.0,
                        538.0,
                        307.0,
                        538.0,
                        345.0,
                        450.5,
                        345.0
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
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        714.5,
                        262.0,
                        577.0,
                        262.0,
                        577.0,
                        300.0,
                        577.0,
                        267.0,
                        578.0,
                        267.0,
                        578.0,
                        305.0,
                        578.0,
                        294.0,
                        607.0,
                        294.0,
                        607.0,
                        332.0,
                        607.0,
                        307.0,
                        538.0,
                        307.0,
                        538.0,
                        345.0,
                        450.5,
                        345.0
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
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        231.0,
                        142.0,
                        386.0,
                        142.0,
                        386.0,
                        180.0,
                        386.0,
                        187.0,
                        294.0,
                        187.0,
                        294.0,
                        225.0,
                        294.0,
                        187.0,
                        352.0,
                        187.0,
                        352.0,
                        225.0,
                        352.0,
                        187.0,
                        427.0,
                        187.0,
                        427.0,
                        225.0,
                        427.0,
                        217.0,
                        427.0,
                        217.0,
                        427.0,
                        273.0,
                        427.0,
                        232.0,
                        305.0,
                        232.0,
                        305.0,
                        270.0,
                        305.0,
                        232.0,
                        352.0,
                        232.0,
                        352.0,
                        268.0,
                        352.0,
                        262.0,
                        315.0,
                        262.0,
                        315.0,
                        300.0,
                        315.0,
                        267.0,
                        427.0,
                        267.0,
                        427.0,
                        305.0,
                        427.0,
                        307.0,
                        416.43748474121094,
                        307.0,
                        416.43748474121094,
                        345.0,
                        416.43748474121094,
                        352.0,
                        237.0,
                        352.0,
                        237.0,
                        390.0,
                        450.5,
                        390.0
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
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        464.0,
                        217.0,
                        483.0,
                        217.0,
                        483.0,
                        273.0,
                        483.0,
                        267.0,
                        427.0,
                        267.0,
                        427.0,
                        305.0,
                        427.0,
                        307.0,
                        457.0,
                        307.0,
                        457.0,
                        345.0,
                        450.5,
                        345.0
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
                        "obj-27",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-26",
                        1
                    ],
                    "destination": [
                        "obj-28",
                        0
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