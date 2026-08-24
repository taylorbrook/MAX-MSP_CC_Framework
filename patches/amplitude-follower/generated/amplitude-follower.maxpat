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
            347.0,
            288.0,
            1222.0,
            466.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "id": "obj-26",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 3,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang"
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
                        "classnamespace": "box",
                        "rect": [
                            0.0,
                            0.0,
                            1000.0,
                            780.0
                        ],
                        "boxes": [
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
                                    "id": "obj-3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        169.0,
                                        116.0,
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
                                    "id": "obj-12",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "bang",
                                        "bang",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        116.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "trigger b b b"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        50.0,
                                        203.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-24",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        85.0,
                                        203.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-25",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        120.0,
                                        203.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-1",
                                        0
                                    ],
                                    "source": [
                                        "obj-12",
                                        1
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
                                        "obj-12",
                                        2
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-25",
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
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        178.5,
                                        141.0,
                                        159.0,
                                        141.0,
                                        159.0,
                                        102.0,
                                        59.5,
                                        102.0
                                    ],
                                    "source": [
                                        "obj-3",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        179.59183502197266,
                        11.0,
                        40.0,
                        22.0
                    ],
                    "text": "p init"
                }
            },
            {
                "box": {
                    "angle": 270.0,
                    "background": 1,
                    "bordercolor": [
                        0.5725490196078431,
                        0.7176470588235294,
                        0.9058823529411765,
                        1.0
                    ],
                    "grad1": [
                        0.5372549019607843,
                        0.5372549019607843,
                        0.7764705882352941,
                        1.0
                    ],
                    "grad2": [
                        0.27058823529411763,
                        0.30980392156862746,
                        0.42745098039215684,
                        1.0
                    ],
                    "id": "obj-21",
                    "maxclass": "panel",
                    "mode": 1,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        9.0,
                        11.0,
                        157.0,
                        81.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        8.0,
                        8.0,
                        272.0,
                        152.0
                    ],
                    "proportion": 0.39,
                    "rounded": 7
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        62.0,
                        65.0,
                        80.0,
                        13.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        18.0,
                        100.0,
                        180.0,
                        14.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        64.0,
                        22.0
                    ],
                    "text": "adc~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        179.59183502197266,
                        43.65306091308594,
                        40.0,
                        22.0
                    ],
                    "text": "100"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-5",
                    "maxclass": "flonum",
                    "maximum": 5000.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        179.59183502197266,
                        72.22448921203613,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        18.0,
                        62.0,
                        70.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        179.59183502197266,
                        103.06122350692749,
                        79.0,
                        22.0
                    ],
                    "text": "smooth $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        231.63265085220337,
                        73.24489736557007,
                        114.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        18.0,
                        42.0,
                        91.0,
                        20.0
                    ],
                    "text": "smoothing (ms)",
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
                    "id": "obj-8",
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
                                    "code": "Param smooth(100, min=1, max=5000);\nParam floordb(-60, min=-96, max=-6);\nParam curve(1, min=0.1, max=4);\nHistory ms1(0);\nHistory pk1(0);\nHistory pks1(0);\na = exp(-1 / (smooth * 0.001 * samplerate));\nsq = in1 * in1;\nms = sq + a * (ms1 - sq);\nms1 = ms;\nrms = sqrt(ms);\nax = abs(in1);\npk = max(ax, pk1 * a);\npk1 = pk;\npkc = pk * 0.7071;\npks = pkc + a * (pks1 - pkc);\npks1 = pks;\nenv = max(rms, pks);\ndb = 20 * log10(max(env, 0.00001));\nlin = clamp((db - floordb) / (0 - floordb), 0, 1);\nlk = pow(lin, curve);\nok = pow(1 - lin, curve);\nout1 = lk / (lk + ok);",
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
                                        427.0,
                                        248.0
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
                                        348.0,
                                        30.0,
                                        35.0
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
                                    "midpoints": [
                                        39.5,
                                        335.5,
                                        39.5,
                                        335.5
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
                        105.0,
                        150.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-9",
                    "maxclass": "number~",
                    "mode": 2,
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "float"
                    ],
                    "patching_rect": [
                        105.0,
                        192.0,
                        56.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        18.0,
                        124.0,
                        70.0,
                        22.0
                    ],
                    "sig": 0.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-10",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        176.0,
                        192.0,
                        135.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        95.0,
                        126.0,
                        140.0,
                        20.0
                    ],
                    "text": "amplitude 0-1 (RMS/peak)",
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
                    "id": "obj-13",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        336.73469066619873,
                        43.65306091308594,
                        40.0,
                        22.0
                    ],
                    "text": "-60"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-14",
                    "maxclass": "flonum",
                    "maximum": -6.0,
                    "minimum": -96.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        336.73469066619873,
                        72.22448921203613,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        108.0,
                        62.0,
                        70.0,
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
                        336.73469066619873,
                        103.85714197158813,
                        86.0,
                        22.0
                    ],
                    "text": "floordb $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-16",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        389.7959146499634,
                        73.22448921203613,
                        61.22448921203613,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        108.0,
                        42.0,
                        70.0,
                        20.0
                    ],
                    "text": "floor (dB)"
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
                        467.3469343185425,
                        43.87755060195923,
                        40.0,
                        22.0
                    ],
                    "text": "1."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-18",
                    "maxclass": "flonum",
                    "maximum": 4.0,
                    "minimum": 0.1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        467.3469343185425,
                        72.44897890090942,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        198.0,
                        62.0,
                        60.0,
                        22.0
                    ]
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
                        467.3469343185425,
                        104.08163166046143,
                        72.0,
                        22.0
                    ],
                    "text": "curve $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        527.5510153770447,
                        72.44897890090942,
                        93.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        198.0,
                        42.0,
                        72.0,
                        20.0
                    ],
                    "text": "curve (S)"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 13.0,
                    "id": "obj-22",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        9.0,
                        94.0,
                        142.0,
                        21.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        18.0,
                        14.0,
                        160.0,
                        21.0
                    ],
                    "text": "amplitude follower"
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
                        9.0,
                        124.0,
                        51.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        205.0,
                        97.0,
                        50.0,
                        20.0
                    ],
                    "text": "input"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        550.0,
                        10.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.4.0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-14",
                        0
                    ],
                    "midpoints": [
                        346.23469066619873,
                        66.0,
                        346.23469066619873,
                        66.0
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
                        346.23469066619873,
                        96.0,
                        346.23469066619873,
                        96.0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        346.23469066619873,
                        135.0,
                        114.5,
                        135.0
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
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        476.8469343185425,
                        66.0,
                        476.8469343185425,
                        66.0
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
                        476.8469343185425,
                        96.0,
                        476.8469343185425,
                        96.0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        476.8469343185425,
                        147.0,
                        114.5,
                        147.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        60.0,
                        71.5,
                        60.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-2",
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
                        39.5,
                        81.0,
                        6.0,
                        81.0,
                        6.0,
                        156.0,
                        90.0,
                        156.0,
                        90.0,
                        147.0,
                        114.5,
                        147.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-2",
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
                        189.09183502197266,
                        36.0,
                        346.23469066619873,
                        36.0
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
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        199.59183502197266,
                        36.0,
                        321.0,
                        36.0,
                        321.0,
                        30.0,
                        476.8469343185425,
                        30.0
                    ],
                    "source": [
                        "obj-26",
                        1
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
                        210.09183502197266,
                        36.0,
                        189.09183502197266,
                        36.0
                    ],
                    "source": [
                        "obj-26",
                        2
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
                        189.09183502197266,
                        66.0,
                        189.09183502197266,
                        66.0
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
                        189.09183502197266,
                        96.0,
                        189.09183502197266,
                        96.0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        189.09183502197266,
                        135.0,
                        114.5,
                        135.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        114.5,
                        174.0,
                        114.5,
                        174.0
                    ],
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