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
            1096.0,
            821.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "id": "obj-1",
                    "maxclass": "dropfile",
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
                    "presentation": 1,
                    "presentation_rect": [
                        6.0,
                        24.0,
                        180.0,
                        64.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-30",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        795.0,
                        30.0,
                        121.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        96.0,
                        6.0,
                        108.0,
                        18.0
                    ],
                    "text": "drop audio file",
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
                    "angle": 270.0,
                    "background": 1,
                    "grad1": [
                        0.1803921568627451,
                        0.1803921568627451,
                        0.43529411764705883,
                        1.0
                    ],
                    "grad2": [
                        0.3411764705882353,
                        0.4745098039215686,
                        0.8313725490196079,
                        1.0
                    ],
                    "id": "obj-29",
                    "maxclass": "panel",
                    "mode": 1,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        795.0,
                        75.0,
                        210.0,
                        150.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        0.0,
                        210.0,
                        170.0
                    ],
                    "proportion": 0.39,
                    "rounded": 7
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
                        165.0,
                        195.0,
                        121.0,
                        22.0
                    ],
                    "text": "prepend replace"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "bang"
                    ],
                    "patching_rect": [
                        150.0,
                        240.0,
                        147.0,
                        22.0
                    ],
                    "text": "buffer~ #1"
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
                        "bang"
                    ],
                    "patching_rect": [
                        270.0,
                        270.0,
                        37.0,
                        22.0
                    ],
                    "text": "t b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 10,
                    "outlettype": [
                        "float",
                        "list",
                        "float",
                        "float",
                        "float",
                        "float",
                        "float",
                        "",
                        "int",
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        315.0,
                        258.43748474121094,
                        22.0
                    ],
                    "text": "info~ #1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "message",
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
                    "text": "filesr $1"
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        435.0,
                        225.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        8.0,
                        96.0,
                        45.0,
                        45.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-10",
                    "maxclass": "newobj",
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
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-11",
                    "maxclass": "message",
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
                    "text": "gain $1"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-12",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        585.0,
                        240.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        104.0,
                        55.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-13",
                    "maxclass": "message",
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
                    "text": "minlen $1"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-14",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        675.0,
                        240.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        135.0,
                        104.0,
                        55.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-15",
                    "maxclass": "message",
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
                    "text": "maxlen $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-16",
                    "maxclass": "newobj",
                    "numinlets": 0,
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
                    "text": "r grain-taper"
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
                        189.5,
                        150.0,
                        72.0,
                        22.0
                    ],
                    "text": "taper $1"
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
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        270.0,
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
                    "id": "obj-19",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 7,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        285.0,
                        150.0,
                        121.0,
                        22.0
                    ],
                    "text": "t b b b b b b b"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360.0,
                        240.0,
                        44.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        7.0,
                        4.0,
                        80.0,
                        20.0
                    ],
                    "text": "#1",
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
                    "id": "obj-21",
                    "maxclass": "message",
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
                    "text": "set #1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "message",
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
                    "text": "buf #1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-23",
                    "maxclass": "message",
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
                    "text": "8000"
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
                        570.0,
                        195.0,
                        44.0,
                        22.0
                    ],
                    "text": "3000"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-25",
                    "maxclass": "message",
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
                    "text": "100"
                }
            },
            {
                "box": {
                    "comment": "Grain Output Left",
                    "id": "obj-27",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        390.0,
                        450.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "comment": "Grain Output Right",
                    "id": "obj-28",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        495.0,
                        450.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-31",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        795.0,
                        255.0,
                        44.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        14.0,
                        142.0,
                        40.0,
                        18.0
                    ],
                    "text": "gain",
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
                    "fontsize": 10.0,
                    "id": "obj-32",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        795.0,
                        315.0,
                        58.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        86.0,
                        55.0,
                        18.0
                    ],
                    "text": "min ms",
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
                    "fontsize": 10.0,
                    "id": "obj-33",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        795.0,
                        360.0,
                        58.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        135.0,
                        86.0,
                        55.0,
                        18.0
                    ],
                    "text": "max ms",
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
                    "buffername": "#1",
                    "id": "obj-34",
                    "maxclass": "waveform~",
                    "numinlets": 5,
                    "numoutlets": 6,
                    "outlettype": [
                        "float",
                        "float",
                        "float",
                        "float",
                        "list",
                        ""
                    ],
                    "patching_rect": [
                        480.0,
                        555.0,
                        79.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        6.0,
                        24.0,
                        180.0,
                        64.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-35",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        480.0,
                        510.0,
                        58.0,
                        22.0
                    ],
                    "text": "set #1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-36",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        555.0,
                        645.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.5"
                }
            },
            {
                "box": {
                    "id": "obj-37",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        555.0,
                        705.0,
                        15.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        190.0,
                        24.0,
                        14.0,
                        64.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-38",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "signal",
                        "signal",
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
                                        50.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 1"
                                }
                            },
                            {
                                "box": {
                                    "code": "Buffer buf;\nParam minlen(3000, min=100, max=60000);\nParam maxlen(8000, min=100, max=60000);\nParam gain(0.8, min=0, max=1);\nParam taper(500, min=10, max=5000);\nParam filesr(44100, min=8000, max=192000);\nParam on(0, min=0, max=1);\nParam active(1, min=0, max=1);\nHistory pos(0);\nHistory len(0);\nHistory start(0);\nHistory gl(0.70710678);\nHistory gr(0.70710678);\nHistory g(0);\n\nrate = filesr / samplerate;\nframes = dim(buf);\ng = g + 0.0005 * (gain - g);\ngate = on * active;\nr1 = 0;\nr2 = 0;\nr3 = 0;\nnewlen = 0;\nmaxstart = 0;\npanpos = 0;\nT = 0;\nenv = 1;\nidx = 0;\ni0 = 0;\nfrac = 0;\ns0 = 0;\ns1 = 0;\ns = 0;\nout1 = 0;\nout2 = 0;\nout3 = 0;\nout4 = 0;\nif (frames > 0) {\n    if (pos >= len) {\n        if (gate > 0.5) {\n            r1 = abs(noise());\n            r2 = abs(noise());\n            r3 = abs(noise());\n            newlen = (minlen + r1 * (maxlen - minlen)) * samplerate * 0.001;\n            newlen = max(newlen, 64);\n            maxstart = frames - newlen * rate;\n            if (maxstart < 0) {\n                maxstart = 0;\n            }\n            start = r2 * maxstart;\n            len = newlen;\n            pos = 0;\n            panpos = r3;\n            gl = cos(panpos * halfpi);\n            gr = sin(panpos * halfpi);\n        }\n    }\n    out3 = start / filesr * 1000;\n    out4 = (start + len * rate) / filesr * 1000;\n    if (pos < len) {\n        T = taper * samplerate * 0.001;\n        T = min(T, len * 0.5);\n        T = max(T, 1);\n        if (gate < 0.5) {\n            if (pos < T) {\n                pos = len - pos;\n            } else {\n                if (pos < len - T) {\n                    pos = len - T;\n                }\n            }\n        }\n        if (pos < T) {\n            env = 0.5 * (1 - cos(pi * pos / T));\n        } else {\n            if (pos > len - T) {\n                env = 0.5 * (1 - cos(pi * (len - pos) / T));\n            }\n        }\n        idx = start + pos * rate;\n        i0 = floor(idx);\n        frac = idx - i0;\n        s0 = peek(buf, i0, 0);\n        s1 = peek(buf, i0 + 1, 0);\n        s = s0 + frac * (s1 - s0);\n        out1 = s * env * gl * g;\n        out2 = s * env * gr * g;\n        pos = pos + 1;\n    }\n}\n",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "codebox",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        80.0,
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
                                        50.0,
                                        320.0,
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
                                        130.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        210.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 3"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-6",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        290.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 4"
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
                                        59.5,
                                        61.0,
                                        59.5,
                                        61.0
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
                                    "midpoints": [
                                        186.5,
                                        300.0,
                                        139.5,
                                        300.0
                                    ],
                                    "source": [
                                        "obj-2",
                                        1
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
                                        313.5,
                                        312.0,
                                        282.0,
                                        312.0,
                                        282.0,
                                        350.0,
                                        219.5,
                                        350.0
                                    ],
                                    "source": [
                                        "obj-2",
                                        2
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
                                        440.5,
                                        300.0,
                                        299.5,
                                        300.0
                                    ],
                                    "source": [
                                        "obj-2",
                                        3
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
                        390.0,
                        405.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        645.0,
                        465.0,
                        107.0,
                        22.0
                    ],
                    "text": "snapshot~ 100"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-40",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        570.0,
                        510.0,
                        107.0,
                        22.0
                    ],
                    "text": "snapshot~ 100"
                }
            },
            {
                "box": {
                    "maxclass": "inlet",
                    "id": "obj-41",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        435,
                        30,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "slot on/off (0/1)"
                }
            },
            {
                "box": {
                    "maxclass": "inlet",
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        510,
                        30,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "slot gain (0. - 1.)"
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-43",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        435,
                        90,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        138.0,
                        24.0,
                        24.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-44",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        435,
                        135,
                        79.0,
                        22.0
                    ],
                    "text": "active $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        465,
                        93,
                        72.0,
                        20.0
                    ],
                    "text": "on / off",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        98.0,
                        141.0,
                        60.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-46",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        510.0,
                        360.0,
                        149.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0. 127.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-47",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        150,
                        93.0,
                        22.0
                    ],
                    "text": "r layers-on",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-48",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        190,
                        51.0,
                        22.0
                    ],
                    "text": "on $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-49",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        735,
                        150,
                        40.0,
                        22.0
                    ],
                    "text": "1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        180.0,
                        174.5,
                        180.0
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
                        444.5,
                        312.0,
                        474.5,
                        312.0
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        474.5,
                        390.0,
                        399.5,
                        390.0
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
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        594.5,
                        264.0,
                        594.5,
                        264.0
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        594.5,
                        390.0,
                        399.5,
                        390.0
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
                        684.5,
                        264.0,
                        684.5,
                        264.0
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        684.5,
                        390.0,
                        399.5,
                        390.0
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
                        159.5,
                        135.0,
                        199.0,
                        135.0
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        199.0,
                        183.0,
                        345.0,
                        183.0,
                        345.0,
                        300.0,
                        420.0,
                        300.0,
                        420.0,
                        390.0,
                        399.5,
                        390.0
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
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        279.5,
                        135.0,
                        294.5,
                        135.0
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
                        "obj-21",
                        0
                    ],
                    "midpoints": [
                        364.9,
                        189.0,
                        369.5,
                        189.0
                    ],
                    "source": [
                        "obj-19",
                        4
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
                        347.3,
                        174.0,
                        444.5,
                        174.0
                    ],
                    "source": [
                        "obj-19",
                        3
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
                        329.7,
                        174.0,
                        519.5,
                        174.0
                    ],
                    "source": [
                        "obj-19",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-24",
                        0
                    ],
                    "midpoints": [
                        312.1,
                        192.0,
                        579.5,
                        192.0
                    ],
                    "source": [
                        "obj-19",
                        1
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
                        294.5,
                        183.0,
                        345.0,
                        183.0,
                        345.0,
                        300.0,
                        420.0,
                        300.0,
                        420.0,
                        348.0,
                        600.0,
                        348.0,
                        600.0,
                        297.0,
                        624.5,
                        297.0
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
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        382.5,
                        174.0,
                        420.0,
                        174.0,
                        420.0,
                        390.0,
                        375.0,
                        390.0,
                        375.0,
                        495.0,
                        489.5,
                        495.0
                    ],
                    "source": [
                        "obj-19",
                        5
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
                        369.5,
                        219.0,
                        369.5,
                        219.0
                    ],
                    "source": [
                        "obj-21",
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
                    "midpoints": [
                        444.5,
                        219.0,
                        420.0,
                        219.0,
                        420.0,
                        390.0,
                        399.5,
                        390.0
                    ],
                    "source": [
                        "obj-22",
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
                    "midpoints": [
                        519.5,
                        237.0,
                        684.5,
                        237.0
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        579.5,
                        237.0,
                        594.5,
                        237.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        624.5,
                        327.0,
                        570.0,
                        327.0,
                        570.0,
                        228.0,
                        477.0,
                        228.0,
                        477.0,
                        222.0,
                        444.5,
                        222.0
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
                        "obj-34",
                        0
                    ],
                    "midpoints": [
                        489.5,
                        534.0,
                        489.5,
                        534.0
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
                        "obj-37",
                        0
                    ],
                    "midpoints": [
                        564.5,
                        669.0,
                        564.0,
                        669.0
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
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        399.5,
                        429.0,
                        399.5,
                        429.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-38",
                        0
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
                        433.5,
                        447.0,
                        504.5,
                        447.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-38",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        433.5,
                        630.0,
                        564.5,
                        630.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-38",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        399.5,
                        438.0,
                        465.0,
                        438.0,
                        465.0,
                        630.0,
                        564.5,
                        630.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-38",
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
                        501.5,
                        429.0,
                        654.5,
                        429.0
                    ],
                    "source": [
                        "obj-38",
                        3
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
                        467.5,
                        495.0,
                        579.5,
                        495.0
                    ],
                    "source": [
                        "obj-38",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-34",
                        3
                    ],
                    "midpoints": [
                        654.5,
                        489.0,
                        549.0,
                        489.0,
                        549.0,
                        552.0,
                        534.5,
                        552.0
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
                        219.0,
                        162.0,
                        219.0,
                        162.0,
                        237.0,
                        159.5,
                        237.0
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
                        "obj-34",
                        2
                    ],
                    "midpoints": [
                        579.5,
                        552.0,
                        519.5,
                        552.0
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
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        287.5,
                        264.0,
                        279.5,
                        264.0
                    ],
                    "source": [
                        "obj-5",
                        1
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
                        279.5,
                        294.0,
                        159.5,
                        294.0
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
                        159.5,
                        339.0,
                        159.5,
                        339.0
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        159.5,
                        402.0,
                        399.5,
                        402.0
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
                        444.5,
                        267.0,
                        444.5,
                        267.0
                    ],
                    "source": [
                        "obj-9",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-41",
                        0
                    ],
                    "destination": [
                        "obj-43",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        0
                    ],
                    "destination": [
                        "obj-44",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-44",
                        0
                    ],
                    "destination": [
                        "obj-38",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-42",
                        0
                    ],
                    "destination": [
                        "obj-46",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-46",
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
                        "obj-47",
                        0
                    ],
                    "destination": [
                        "obj-48",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-48",
                        0
                    ],
                    "destination": [
                        "obj-38",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-19",
                        6
                    ],
                    "destination": [
                        "obj-49",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-49",
                        0
                    ],
                    "destination": [
                        "obj-43",
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