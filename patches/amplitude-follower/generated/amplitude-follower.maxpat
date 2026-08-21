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
            268.0,
            355.0,
            1140.0,
            361.0
        ],
        "boxes": [
            {
                "box": {
                    "maxclass": "panel",
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        850,
                        18,
                        272,
                        152
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        8.0,
                        8.0,
                        272.0,
                        152.0
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
                    "id": "obj-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        375.0,
                        30.0,
                        380.0,
                        20.0
                    ],
                    "text": "amplitude follower — RMS, one-pole smoothing in gen~",
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
                        255.0,
                        29.0,
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
                    "id": "obj-4",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        255.0,
                        76.0,
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
                        255.0,
                        105.0,
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
                        255.0,
                        150.0,
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
                        375.0,
                        105.0,
                        114.0,
                        20.0
                    ],
                    "text": "smoothing (ms)",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        18.0,
                        42.0,
                        85.0,
                        18.0
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
                                    "code": "Param smooth(100, min=1, max=5000);\nParam floordb(-60, min=-96, max=-6);\nParam curve(1, min=0.1, max=4);\nHistory ms1(0);\na = exp(-1 / (smooth * 0.001 * samplerate));\nsq = in1 * in1;\nms = sq + a * (ms1 - sq);\nms1 = ms;\nrms = sqrt(ms);\ndb = 20 * log10(max(rms, 0.00001));\nlin = clamp((db - floordb) / (0 - floordb), 0, 1);\nout1 = pow(lin, curve);\n",
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
                                        45.0,
                                        63.5,
                                        243.5,
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
                                    ],
                                    "midpoints": [
                                        243.5,
                                        335.5,
                                        45.0,
                                        335.5
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
                    "sig": 0.0,
                    "presentation": 1,
                    "presentation_rect": [
                        18.0,
                        124.0,
                        70.0,
                        22.0
                    ]
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
                    "text": "RMS amplitude 0-1",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        95.0,
                        126.0,
                        140.0,
                        18.0
                    ]
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
                        255.0,
                        225.0,
                        107.0,
                        22.0
                    ],
                    "text": "trigger b b b"
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
                        500.0,
                        76.0,
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
                        500.0,
                        105.0,
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
                        500.0,
                        150.0,
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
                        560.0,
                        105.0,
                        86.0,
                        20.0
                    ],
                    "text": "floor (dB)",
                    "presentation": 1,
                    "presentation_rect": [
                        108.0,
                        42.0,
                        70.0,
                        18.0
                    ]
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
                        660.0,
                        76.0,
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
                        660.0,
                        105.0,
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
                        660.0,
                        150.0,
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
                        720.0,
                        105.0,
                        93.0,
                        20.0
                    ],
                    "text": "curve (exp)",
                    "presentation": 1,
                    "presentation_rect": [
                        198.0,
                        42.0,
                        72.0,
                        18.0
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
                        850,
                        180,
                        142.0,
                        20.0
                    ],
                    "text": "amplitude follower",
                    "fontname": "Arial",
                    "fontsize": 13.0,
                    "presentation": 1,
                    "presentation_rect": [
                        18.0,
                        14.0,
                        160.0,
                        22.0
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
                        850,
                        210,
                        51.0,
                        20.0
                    ],
                    "text": "input",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        205.0,
                        97.0,
                        50.0,
                        18.0
                    ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        1152.0,
                        252.0,
                        1152.0,
                        68.0,
                        507.0,
                        68.0
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
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        1160.0,
                        252.0,
                        1160.0,
                        68.0,
                        667.0,
                        68.0
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        262.0,
                        97.0,
                        247.0,
                        97.0,
                        247.0,
                        135.0,
                        247.0,
                        142.0,
                        247.0,
                        142.0,
                        247.0,
                        180.0,
                        247.0,
                        184.0,
                        319.0,
                        184.0,
                        319.0,
                        220.0,
                        262.0,
                        220.0
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
                        "obj-14",
                        0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        543.0,
                        142.0,
                        342.0,
                        142.0,
                        342.0,
                        180.0,
                        165.5,
                        180.0
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
                        696.0,
                        142.0,
                        342.0,
                        142.0,
                        342.0,
                        180.0,
                        342.0,
                        142.0,
                        492.0,
                        142.0,
                        492.0,
                        180.0,
                        165.5,
                        180.0
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
                        37.0,
                        58.5,
                        102.0,
                        58.5
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
                        37.0,
                        57.0,
                        54.0,
                        57.0,
                        54.0,
                        86.0,
                        165.5,
                        86.0
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        291.0,
                        68.0,
                        303.0,
                        68.0,
                        303.0,
                        106.0,
                        303.0,
                        97.0,
                        313.0,
                        97.0,
                        313.0,
                        135.0,
                        313.0,
                        142.0,
                        342.0,
                        142.0,
                        342.0,
                        180.0,
                        342.0,
                        184.0,
                        319.0,
                        184.0,
                        319.0,
                        220.0,
                        308.5,
                        220.0
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
                        "obj-6",
                        0
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
                        294.5,
                        161.0,
                        165.5,
                        161.0
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
                        165.5,
                        182.0,
                        112.0,
                        182.0
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
        ],
        "openinpresentation": 1
    }
}