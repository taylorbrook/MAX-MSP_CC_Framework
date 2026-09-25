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
                    "maxclass": "flonum",
                    "id": "obj-60",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        740.0,
                        235.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        11.0,
                        110.0,
                        38.0,
                        17.0
                    ],
                    "numdecimalplaces": 2,
                    "ignoreclick": 1,
                    "bgcolor": [
                        0.0,
                        0.0,
                        0.0,
                        0.0
                    ],
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "triangle": 0,
                    "fontsize": 9.0
                }
            },
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
                        60.0
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
                        1700.0,
                        200.0,
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
                        1700.0,
                        30.0,
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
                        30.0,
                        315.0,
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
                        30.0,
                        350.0,
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
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        385.0,
                        51.0,
                        22.0
                    ],
                    "text": "t b b"
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
                        100.0,
                        420.0,
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
                        100.0,
                        455.0,
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
                        600.0,
                        105.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        8.0,
                        96.0,
                        45.0,
                        45.0
                    ],
                    "varname": "gain"
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
                        600.0,
                        160.0,
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
                        600.0,
                        235.0,
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
                        900.0,
                        65.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        104.0,
                        55.0,
                        22.0
                    ],
                    "varname": "minlen"
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
                        900.0,
                        100.0,
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
                        1030.0,
                        65.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        135.0,
                        104.0,
                        55.0,
                        22.0
                    ],
                    "varname": "maxlen"
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
                        1030.0,
                        100.0,
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
                        1160.0,
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
                        1160.0,
                        65.0,
                        72.0,
                        22.0
                    ],
                    "text": "taper $1"
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
                        250.0,
                        65.0,
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
                    "text": "slot",
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
                    "comment": "Grain Output Left",
                    "id": "obj-27",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        460.0,
                        640.0,
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
                        576.7,
                        640.0,
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
                        1700.0,
                        225.0,
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
                        1700.0,
                        250.0,
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
                        1700.0,
                        275.0,
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
                        900.0,
                        700.0,
                        180.0,
                        50.0
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
                    "id": "obj-36",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        360.0,
                        575.0,
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
                        360.0,
                        610.0,
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
                                    "code": "Buffer buf;\nParam minlen(3000, min=100, max=60000);\nParam maxlen(8000, min=100, max=60000);\nParam gain(0.8, min=0, max=1);\nParam taper(500, min=10, max=5000);\nParam filesr(44100, min=8000, max=192000);\nParam active(1, min=0, max=1);\nParam mute(0, min=0, max=1);\nHistory pos(0);\nHistory len(0);\nHistory start(0);\nHistory gl(0.70710678);\nHistory gr(0.70710678);\nHistory g(0);\nHistory duck(1);\nHistory mstop(1);\n\nrate = filesr / samplerate;\nframes = dim(buf);\nchans = channels(buf);\ng = g + 0.0005 * (gain - g);\nmenv = in1;\nskipin = 0;\nr1 = 0;\nr2 = 0;\nr3 = 0;\nnewlen = 0;\nmaxstart = 0;\npanpos = 0;\nT = 0;\nenv = 1;\nidx = 0;\ni0 = 0;\nfrac = 0;\ns0 = 0;\ns1 = 0;\nt0 = 0;\nt1 = 0;\ns = 0;\nout1 = 0;\nout2 = 0;\nout3 = 0;\nout4 = 0;\nif (menv > 0) {\n    skipin = mstop;\n    mstop = 0;\n} else {\n    mstop = 1;\n    pos = len;\n}\nif (mute > 0.5) {\n    duck = max(duck - 0.001, 0);\n    if (duck <= 0) {\n        pos = len;\n    }\n} else {\n    duck = min(duck + 0.001, 1);\n}\nif (frames > 0) {\n    if (pos >= len) {\n        if (menv > 0 && active > 0.5 && mute < 0.5) {\n            r1 = abs(noise());\n            r2 = abs(noise());\n            r3 = abs(noise());\n            newlen = (minlen + r1 * (maxlen - minlen)) * samplerate * 0.001;\n            newlen = min(newlen, frames / rate);\n            newlen = max(newlen, 64);\n            maxstart = frames - newlen * rate;\n            if (maxstart < 0) {\n                maxstart = 0;\n            }\n            start = r2 * maxstart;\n            len = newlen;\n            pos = 0;\n            if (skipin > 0.5) {\n                T = taper * samplerate * 0.001;\n                T = min(T, len * 0.5);\n                pos = max(T, 1);\n            }\n            panpos = r3;\n            gl = cos(panpos * halfpi);\n            gr = sin(panpos * halfpi);\n        }\n    }\n    if (pos < len) {\n        out3 = start / filesr * 1000;\n        out4 = (start + len * rate) / filesr * 1000;\n        T = taper * samplerate * 0.001;\n        T = min(T, len * 0.5);\n        T = max(T, 1);\n        if (active < 0.5) {\n            if (pos < T) {\n                pos = len - pos;\n            } else {\n                if (pos < len - T) {\n                    pos = len - T;\n                }\n            }\n        }\n        if (pos < T) {\n            env = 0.5 * (1 - cos(pi * pos / T));\n        } else {\n            if (pos > len - T) {\n                env = 0.5 * (1 - cos(pi * (len - pos) / T));\n            }\n        }\n        idx = start + pos * rate;\n        i0 = floor(idx);\n        frac = idx - i0;\n        s0 = peek(buf, i0, 0);\n        s1 = peek(buf, i0 + 1, 0);\n        s = s0 + frac * (s1 - s0);\n        if (chans > 1.5) {\n            t0 = peek(buf, i0, 1);\n            t1 = peek(buf, i0 + 1, 1);\n            s = 0.5 * (s + t0 + frac * (t1 - t0));\n        }\n        out1 = s * env * gl * g * duck;\n        out2 = s * env * gr * g * duck;\n        pos = pos + 1;\n    }\n}\n",
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
                        460.0,
                        520.0,
                        360.0,
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
                        810.0,
                        575.0,
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
                        693.3,
                        575.0,
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
                        460.0,
                        30.0,
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
                        600.0,
                        30.0,
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
                        460.0,
                        75.0,
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
                    ],
                    "varname": "active"
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
                        460.0,
                        115.0,
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
                        490.0,
                        78.0,
                        72.0,
                        20.0
                    ],
                    "text": "on / off",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        98.0,
                        142.0,
                        50.0,
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
                    "maxclass": "newobj",
                    "id": "obj-46",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        65.0,
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
                    "id": "obj-50",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1420.0,
                        30.0,
                        149.0,
                        22.0
                    ],
                    "text": "receive~ layers-env",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-51",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        105.0,
                        100.0,
                        22.0
                    ],
                    "text": "p audio-only",
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
                                        50.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "path or anything"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-2",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        50.0,
                                        250,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "path, only if it names an audio file"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        50,
                                        70,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "trigger a a b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-4",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        190,
                                        105,
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
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        100,
                                        105,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "tosymbol",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
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
                                        100,
                                        140,
                                        366.0,
                                        22.0
                                    ],
                                    "text": "regexp .+\\\\.(?i:aiff?|aifc|wave?|flac|mp3|m4a|caf)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-7",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        100,
                                        175,
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
                                    "id": "obj-8",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50,
                                        210,
                                        52.0,
                                        22.0
                                    ],
                                    "text": "gate",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-9",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        190,
                                        210,
                                        471.0,
                                        20.0
                                    ],
                                    "text": "open, then close again unless the text ends in an audio extension",
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
                                        "obj-3",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-3",
                                        2
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
                                        "obj-3",
                                        1
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
                                        "obj-6",
                                        3
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
                                        "obj-4",
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
                                        "obj-3",
                                        0
                                    ],
                                    "destination": [
                                        "obj-8",
                                        1
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
                                        "obj-2",
                                        0
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
                    "maxclass": "newobj",
                    "id": "obj-52",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        140.0,
                        86.0,
                        22.0
                    ],
                    "text": "pattr path",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-53",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        175.0,
                        100.0,
                        22.0
                    ],
                    "text": "p audio-only",
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
                                        50.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "path or anything"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-2",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        50.0,
                                        250,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "path, only if it names an audio file"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        50,
                                        70,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "trigger a a b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-4",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        190,
                                        105,
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
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        100,
                                        105,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "tosymbol",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
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
                                        100,
                                        140,
                                        366.0,
                                        22.0
                                    ],
                                    "text": "regexp .+\\\\.(?i:aiff?|aifc|wave?|flac|mp3|m4a|caf)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-7",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        100,
                                        175,
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
                                    "id": "obj-8",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50,
                                        210,
                                        52.0,
                                        22.0
                                    ],
                                    "text": "gate",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-9",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        190,
                                        210,
                                        471.0,
                                        20.0
                                    ],
                                    "text": "open, then close again unless the text ends in an audio extension",
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
                                        "obj-3",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-3",
                                        2
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
                                        "obj-3",
                                        1
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
                                        "obj-6",
                                        3
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
                                        "obj-4",
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
                                        "obj-3",
                                        0
                                    ],
                                    "destination": [
                                        "obj-8",
                                        1
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
                                        "obj-2",
                                        0
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
                    "maxclass": "newobj",
                    "id": "obj-54",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        210.0,
                        140.0,
                        22.0
                    ],
                    "text": "trigger b s b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-55",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        380.0,
                        245.0,
                        58.0,
                        22.0
                    ],
                    "text": "mute 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-56",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        245.0,
                        60.0,
                        22.0
                    ],
                    "text": "delay 40",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-57",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        280.0,
                        90.0,
                        22.0
                    ],
                    "text": "zl.reg",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-58",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        420.0,
                        58.0,
                        22.0
                    ],
                    "text": "mute 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-59",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1590.0,
                        30.0,
                        79.0,
                        22.0
                    ],
                    "text": "autopattr",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-61",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        600.0,
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
                    "maxclass": "newobj",
                    "id": "obj-62",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        780.0,
                        65.0,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 100",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-63",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        900.0,
                        30.0,
                        107.0,
                        22.0
                    ],
                    "text": "loadmess 3000",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-64",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1030.0,
                        30.0,
                        107.0,
                        22.0
                    ],
                    "text": "loadmess 8000",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-65",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1290.0,
                        30.0,
                        121.0,
                        22.0
                    ],
                    "text": "loadmess buf #1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-66",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        250.0,
                        30.0,
                        121.0,
                        22.0
                    ],
                    "text": "loadmess set #1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-67",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        693.3,
                        655.0,
                        121.0,
                        22.0
                    ],
                    "text": "loadmess set #1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-68",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        500.0,
                        30.0,
                        87.5,
                        22.0
                    ],
                    "text": "loadmess 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        605.0,
                        510.0,
                        465.0,
                        510.0
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
                        905.0,
                        510.0,
                        465.0,
                        510.0
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
                        1035.0,
                        510.0,
                        465.0,
                        510.0
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
                        1165.0,
                        510.0,
                        465.0,
                        510.0
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
                        "obj-37",
                        0
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
                        581.6666666666666,
                        565.0,
                        365.0,
                        565.0
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
                        465.0,
                        565.0,
                        365.0,
                        565.0
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
                        815.0,
                        625.0,
                        1032.5,
                        625.0
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
                        698.3,
                        640.0,
                        990.0,
                        640.0
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
                        172.0,
                        375.0,
                        35.0,
                        375.0
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
                        "obj-8",
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        105.0,
                        510.0,
                        465.0,
                        510.0
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
                        "obj-50",
                        0
                    ],
                    "destination": [
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        1425.0,
                        510.0,
                        465.0,
                        510.0
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
                        "obj-51",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-51",
                        0
                    ],
                    "destination": [
                        "obj-52",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-52",
                        0
                    ],
                    "destination": [
                        "obj-53",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-53",
                        0
                    ],
                    "destination": [
                        "obj-54",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-54",
                        2
                    ],
                    "destination": [
                        "obj-55",
                        0
                    ],
                    "midpoints": [
                        165.0,
                        235.0,
                        385.0,
                        235.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-54",
                        1
                    ],
                    "destination": [
                        "obj-57",
                        1
                    ],
                    "midpoints": [
                        100.0,
                        270.0,
                        115.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-54",
                        0
                    ],
                    "destination": [
                        "obj-56",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-56",
                        0
                    ],
                    "destination": [
                        "obj-57",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-57",
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
                        "obj-55",
                        0
                    ],
                    "destination": [
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        385.0,
                        510.0,
                        465.0,
                        510.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        76.0,
                        410.0,
                        105.0,
                        410.0
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
                        "obj-58",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-58",
                        0
                    ],
                    "destination": [
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        35.0,
                        510.0,
                        465.0,
                        510.0
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
                        "obj-61",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-61",
                        1
                    ],
                    "destination": [
                        "obj-60",
                        0
                    ],
                    "midpoints": [
                        688.0,
                        225.0,
                        745.0,
                        225.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-61",
                        0
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
                        "obj-62",
                        0
                    ],
                    "destination": [
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        785.0,
                        95.0,
                        605.0,
                        95.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-63",
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
                        "obj-64",
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
                        "obj-65",
                        0
                    ],
                    "destination": [
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        1295.0,
                        510.0,
                        465.0,
                        510.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-66",
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
                        "obj-67",
                        0
                    ],
                    "destination": [
                        "obj-34",
                        0
                    ],
                    "midpoints": [
                        698.3,
                        690.0,
                        905.0,
                        690.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-68",
                        0
                    ],
                    "destination": [
                        "obj-43",
                        0
                    ],
                    "midpoints": [
                        505.0,
                        65.0,
                        465.0,
                        65.0
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