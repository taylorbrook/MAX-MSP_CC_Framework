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
            80.0,
            100.0,
            782.0,
            708.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        58.0,
                        22.0
                    ],
                    "text": "notein"
                }
            },
            {
                "box": {
                    "id": "obj-2",
                    "maxclass": "kslider",
                    "mode": 2,
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        135.0,
                        90.0,
                        336.0,
                        53.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        400.0,
                        644.0,
                        95.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        150.0,
                        88.0,
                        22.0
                    ],
                    "text": "pack 0 0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
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
                        120.0,
                        240.0,
                        135.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "filename": "ji-engine.js",
                        "parameter_enable": 0
                    },
                    "text": "js ji-engine.js"
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "maxclass": "number",
                    "maximum": 12,
                    "minimum": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        480.0,
                        150.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        64.0,
                        48.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-6",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2805.0,
                        30.0,
                        58.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        42.0,
                        48.0,
                        18.0
                    ],
                    "text": "voices",
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
                    "format": 6,
                    "id": "obj-7",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        542.0,
                        150.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        64.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-8",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2805.0,
                        75.0,
                        86.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        42.0,
                        70.0,
                        18.0
                    ],
                    "text": "complexity",
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
                    "id": "obj-9",
                    "maxclass": "number",
                    "maximum": 11,
                    "minimum": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        604.0,
                        150.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        366.0,
                        64.0,
                        48.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-10",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2805.0,
                        135.0,
                        51.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        366.0,
                        42.0,
                        40.0,
                        18.0
                    ],
                    "text": "tonic",
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
                    "format": 6,
                    "id": "obj-11",
                    "maxclass": "flonum",
                    "maximum": 480.0,
                    "minimum": 400.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        666.0,
                        150.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        426.0,
                        64.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2805.0,
                        180.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        426.0,
                        42.0,
                        40.0,
                        18.0
                    ],
                    "text": "A4",
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
                    "id": "obj-13",
                    "items": [
                        "Free",
                        ",",
                        "Close",
                        ",",
                        "Open",
                        ",",
                        "Drop-2",
                        ",",
                        "Thirds",
                        ",",
                        "Quartal",
                        ",",
                        "Quintal"
                    ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        728.0,
                        150.0,
                        100.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        502.0,
                        64.0,
                        96.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-14",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2805.0,
                        225.0,
                        65.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        502.0,
                        42.0,
                        60.0,
                        18.0
                    ],
                    "text": "voicing",
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
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 8,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "voice count (2-12)",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "complexity (0-1)",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "tonic (0-11)",
                                    "id": "obj-3",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        120.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "master tune A4 (Hz)",
                                    "id": "obj-4",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "voicing mode (0-6)",
                                    "id": "obj-5",
                                    "index": 5,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "tagged param messages to ji-engine",
                                    "id": "obj-6",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        405.0,
                                        120.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "prepend voicecount"
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        345.0,
                                        75.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "prepend complexity"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        75.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "prepend tonic"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "maxclass": "newobj",
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
                                    "text": "prepend mastertune"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-11",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        495.0,
                                        75.0,
                                        149.0,
                                        22.0
                                    ],
                                    "text": "prepend voicingmode"
                                }
                            },
                            {
                                "box": {
                                    "comment": "data to prepend stereospread",
                                    "id": "obj-12",
                                    "index": 6,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        255.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        75.0,
                                        156.0,
                                        22.0
                                    ],
                                    "text": "prepend stereospread"
                                }
                            },
                            {
                                "box": {
                                    "comment": "data to prepend detunerandom",
                                    "id": "obj-14",
                                    "index": 7,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        300.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        960.0,
                                        120.0,
                                        156.0,
                                        22.0
                                    ],
                                    "text": "prepend detunerandom"
                                }
                            },
                            {
                                "box": {
                                    "comment": "data to prepend timingrandom",
                                    "id": "obj-16",
                                    "index": 8,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        345.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1110.0,
                                        75.0,
                                        156.0,
                                        22.0
                                    ],
                                    "text": "prepend timingrandom"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        22.0,
                                        67.0,
                                        22.0,
                                        67.0,
                                        68.0,
                                        39.5,
                                        68.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        189.5,
                                        67.0,
                                        337.0,
                                        67.0,
                                        337.0,
                                        105.0,
                                        414.5,
                                        105.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        504.5,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        414.5,
                                        105.0
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
                                        264.5,
                                        22.0,
                                        338.0,
                                        22.0,
                                        338.0,
                                        68.0,
                                        338.0,
                                        22.0,
                                        383.0,
                                        22.0,
                                        383.0,
                                        68.0,
                                        383.0,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        652.0,
                                        67.0,
                                        330.0,
                                        67.0,
                                        330.0,
                                        105.0,
                                        330.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        819.5,
                                        105.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        819.5,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        414.5,
                                        105.0
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
                                        309.5,
                                        22.0,
                                        383.0,
                                        22.0,
                                        383.0,
                                        68.0,
                                        383.0,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        652.0,
                                        67.0,
                                        330.0,
                                        67.0,
                                        330.0,
                                        105.0,
                                        330.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        652.0,
                                        67.0,
                                        802.0,
                                        67.0,
                                        802.0,
                                        105.0,
                                        802.0,
                                        112.0,
                                        443.0,
                                        112.0,
                                        443.0,
                                        158.0,
                                        969.5,
                                        158.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        969.5,
                                        131.0,
                                        414.5,
                                        131.0
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
                                        354.5,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        775.0,
                                        67.0,
                                        775.0,
                                        105.0,
                                        775.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        652.0,
                                        67.0,
                                        802.0,
                                        67.0,
                                        802.0,
                                        105.0,
                                        1119.5,
                                        105.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        1119.5,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        775.0,
                                        67.0,
                                        775.0,
                                        105.0,
                                        775.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        652.0,
                                        67.0,
                                        802.0,
                                        67.0,
                                        802.0,
                                        105.0,
                                        802.0,
                                        112.0,
                                        952.0,
                                        112.0,
                                        952.0,
                                        150.0,
                                        414.5,
                                        150.0
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
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        84.5,
                                        22.0,
                                        158.0,
                                        22.0,
                                        158.0,
                                        68.0,
                                        158.0,
                                        22.0,
                                        203.0,
                                        22.0,
                                        203.0,
                                        68.0,
                                        203.0,
                                        22.0,
                                        248.0,
                                        22.0,
                                        248.0,
                                        68.0,
                                        248.0,
                                        22.0,
                                        247.0,
                                        22.0,
                                        247.0,
                                        68.0,
                                        247.0,
                                        22.0,
                                        292.0,
                                        22.0,
                                        292.0,
                                        68.0,
                                        292.0,
                                        22.0,
                                        337.0,
                                        22.0,
                                        337.0,
                                        68.0,
                                        337.0,
                                        67.0,
                                        180.0,
                                        67.0,
                                        180.0,
                                        105.0,
                                        180.0,
                                        67.0,
                                        330.0,
                                        67.0,
                                        330.0,
                                        105.0,
                                        354.5,
                                        105.0
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
                                        "obj-9",
                                        0
                                    ],
                                    "midpoints": [
                                        129.5,
                                        22.0,
                                        203.0,
                                        22.0,
                                        203.0,
                                        68.0,
                                        203.0,
                                        22.0,
                                        248.0,
                                        22.0,
                                        248.0,
                                        68.0,
                                        248.0,
                                        22.0,
                                        293.0,
                                        22.0,
                                        293.0,
                                        68.0,
                                        293.0,
                                        22.0,
                                        338.0,
                                        22.0,
                                        338.0,
                                        68.0,
                                        338.0,
                                        22.0,
                                        383.0,
                                        22.0,
                                        383.0,
                                        68.0,
                                        383.0,
                                        67.0,
                                        180.0,
                                        67.0,
                                        180.0,
                                        105.0,
                                        180.0,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        330.0,
                                        67.0,
                                        330.0,
                                        105.0,
                                        330.0,
                                        67.0,
                                        487.0,
                                        67.0,
                                        487.0,
                                        105.0,
                                        669.5,
                                        105.0
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
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        174.5,
                                        22.0,
                                        202.0,
                                        22.0,
                                        202.0,
                                        68.0,
                                        202.0,
                                        22.0,
                                        247.0,
                                        22.0,
                                        247.0,
                                        68.0,
                                        247.0,
                                        67.0,
                                        180.0,
                                        67.0,
                                        180.0,
                                        105.0,
                                        189.5,
                                        105.0
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
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        219.5,
                                        22.0,
                                        293.0,
                                        22.0,
                                        293.0,
                                        68.0,
                                        293.0,
                                        22.0,
                                        338.0,
                                        22.0,
                                        338.0,
                                        68.0,
                                        338.0,
                                        22.0,
                                        383.0,
                                        22.0,
                                        383.0,
                                        68.0,
                                        383.0,
                                        67.0,
                                        337.0,
                                        67.0,
                                        337.0,
                                        105.0,
                                        337.0,
                                        67.0,
                                        330.0,
                                        67.0,
                                        330.0,
                                        105.0,
                                        504.5,
                                        105.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        67.0,
                                        337.0,
                                        67.0,
                                        337.0,
                                        105.0,
                                        337.0,
                                        67.0,
                                        330.0,
                                        67.0,
                                        330.0,
                                        105.0,
                                        414.5,
                                        105.0
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
                                        "obj-6",
                                        0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        669.5,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        487.0,
                                        67.0,
                                        487.0,
                                        105.0,
                                        414.5,
                                        105.0
                                    ],
                                    "source": [
                                        "obj-9",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        600.0,
                        195.0,
                        86.0,
                        22.0
                    ],
                    "text": "p params"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-16",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2805.0,
                        285.0,
                        51.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        42.0,
                        60.0,
                        18.0
                    ],
                    "text": "ratio",
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
                    "id": "obj-17",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2805.0,
                        330.0,
                        51.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        42.0,
                        60.0,
                        18.0
                    ],
                    "text": "cents",
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
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 12,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "degree 0 ratio text",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 1 ratio text",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 2 ratio text",
                                    "id": "obj-3",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        120.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 3 ratio text",
                                    "id": "obj-4",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 4 ratio text",
                                    "id": "obj-5",
                                    "index": 5,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 5 ratio text",
                                    "id": "obj-6",
                                    "index": 6,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        255.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 6 ratio text",
                                    "id": "obj-7",
                                    "index": 7,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        300.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 7 ratio text",
                                    "id": "obj-8",
                                    "index": 8,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        345.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 8 ratio text",
                                    "id": "obj-9",
                                    "index": 9,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        390.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 9 ratio text",
                                    "id": "obj-10",
                                    "index": 10,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        435.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 10 ratio text",
                                    "id": "obj-11",
                                    "index": 11,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 11 ratio text",
                                    "id": "obj-12",
                                    "index": 12,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        525.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "ratio <deg> <n/d> messages to ji-engine",
                                    "id": "obj-13",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        840.0,
                                        120.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 0"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        990.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-16",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1545.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 3"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-18",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1125.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 4"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-19",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1410.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 5"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-20",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        300.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 6"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-21",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 7"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-22",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1275.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 8"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 9"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-24",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        435.0,
                                        75.0,
                                        128.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 10"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-25",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        855.0,
                                        75.0,
                                        128.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 11"
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
                                        39.5,
                                        22.0,
                                        67.0,
                                        22.0,
                                        67.0,
                                        68.0,
                                        39.5,
                                        68.0
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
                                        "obj-23",
                                        0
                                    ],
                                    "midpoints": [
                                        444.5,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        22.0,
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        67.0,
                                        577.0,
                                        67.0,
                                        577.0,
                                        105.0,
                                        577.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        729.5,
                                        105.0
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
                                        "obj-24",
                                        0
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
                                        "obj-25",
                                        0
                                    ],
                                    "midpoints": [
                                        534.5,
                                        67.0,
                                        714.0,
                                        67.0,
                                        714.0,
                                        105.0,
                                        714.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        864.5,
                                        105.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        294.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        577.0,
                                        67.0,
                                        577.0,
                                        105.0,
                                        577.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        427.0,
                                        67.0,
                                        427.0,
                                        105.0,
                                        427.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        849.5,
                                        105.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        999.5,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        991.0,
                                        67.0,
                                        991.0,
                                        105.0,
                                        849.5,
                                        105.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        1554.5,
                                        67.0,
                                        1119.0,
                                        67.0,
                                        1119.0,
                                        105.0,
                                        1119.0,
                                        67.0,
                                        1254.0,
                                        67.0,
                                        1254.0,
                                        105.0,
                                        1254.0,
                                        67.0,
                                        1402.0,
                                        67.0,
                                        1402.0,
                                        105.0,
                                        1402.0,
                                        67.0,
                                        1267.0,
                                        67.0,
                                        1267.0,
                                        105.0,
                                        1267.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        991.0,
                                        67.0,
                                        991.0,
                                        105.0,
                                        849.5,
                                        105.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        174.5,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        577.0,
                                        67.0,
                                        577.0,
                                        105.0,
                                        577.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        849.5,
                                        105.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        1134.5,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        982.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        991.0,
                                        67.0,
                                        991.0,
                                        105.0,
                                        849.5,
                                        105.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        1419.5,
                                        67.0,
                                        1119.0,
                                        67.0,
                                        1119.0,
                                        105.0,
                                        1119.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
                                        67.0,
                                        1267.0,
                                        67.0,
                                        1267.0,
                                        105.0,
                                        1267.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        991.0,
                                        67.0,
                                        991.0,
                                        105.0,
                                        849.5,
                                        105.0
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
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        84.5,
                                        22.0,
                                        158.0,
                                        22.0,
                                        158.0,
                                        68.0,
                                        158.0,
                                        22.0,
                                        203.0,
                                        22.0,
                                        203.0,
                                        68.0,
                                        203.0,
                                        22.0,
                                        248.0,
                                        22.0,
                                        248.0,
                                        68.0,
                                        248.0,
                                        22.0,
                                        293.0,
                                        22.0,
                                        293.0,
                                        68.0,
                                        293.0,
                                        22.0,
                                        338.0,
                                        22.0,
                                        338.0,
                                        68.0,
                                        338.0,
                                        22.0,
                                        383.0,
                                        22.0,
                                        383.0,
                                        68.0,
                                        383.0,
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
                                        22.0,
                                        473.0,
                                        22.0,
                                        473.0,
                                        68.0,
                                        473.0,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        22.0,
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        67.0,
                                        159.0,
                                        67.0,
                                        159.0,
                                        105.0,
                                        159.0,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        294.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        577.0,
                                        67.0,
                                        577.0,
                                        105.0,
                                        577.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        999.5,
                                        105.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        309.5,
                                        67.0,
                                        577.0,
                                        67.0,
                                        577.0,
                                        105.0,
                                        577.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        849.5,
                                        105.0
                                    ],
                                    "source": [
                                        "obj-20",
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
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        849.5,
                                        105.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        1284.5,
                                        67.0,
                                        1119.0,
                                        67.0,
                                        1119.0,
                                        105.0,
                                        1119.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        991.0,
                                        67.0,
                                        991.0,
                                        105.0,
                                        849.5,
                                        105.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        729.5,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        849.5,
                                        105.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        444.5,
                                        67.0,
                                        714.0,
                                        67.0,
                                        714.0,
                                        105.0,
                                        714.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        849.5,
                                        105.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        864.5,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.5,
                                        105.0
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
                                        "obj-16",
                                        0
                                    ],
                                    "midpoints": [
                                        129.5,
                                        22.0,
                                        203.0,
                                        22.0,
                                        203.0,
                                        68.0,
                                        203.0,
                                        22.0,
                                        248.0,
                                        22.0,
                                        248.0,
                                        68.0,
                                        248.0,
                                        22.0,
                                        293.0,
                                        22.0,
                                        293.0,
                                        68.0,
                                        293.0,
                                        22.0,
                                        338.0,
                                        22.0,
                                        338.0,
                                        68.0,
                                        338.0,
                                        22.0,
                                        383.0,
                                        22.0,
                                        383.0,
                                        68.0,
                                        383.0,
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
                                        22.0,
                                        473.0,
                                        22.0,
                                        473.0,
                                        68.0,
                                        473.0,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        22.0,
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        67.0,
                                        159.0,
                                        67.0,
                                        159.0,
                                        105.0,
                                        159.0,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        982.0,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        294.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
                                        67.0,
                                        1402.0,
                                        67.0,
                                        1402.0,
                                        105.0,
                                        1402.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        714.0,
                                        67.0,
                                        714.0,
                                        105.0,
                                        714.0,
                                        67.0,
                                        1267.0,
                                        67.0,
                                        1267.0,
                                        105.0,
                                        1267.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        1554.5,
                                        105.0
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
                                        "obj-17",
                                        0
                                    ],
                                    "midpoints": [
                                        174.5,
                                        22.0,
                                        202.0,
                                        22.0,
                                        202.0,
                                        68.0,
                                        174.5,
                                        68.0
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
                                        "obj-18",
                                        0
                                    ],
                                    "midpoints": [
                                        219.5,
                                        22.0,
                                        293.0,
                                        22.0,
                                        293.0,
                                        68.0,
                                        293.0,
                                        22.0,
                                        338.0,
                                        22.0,
                                        338.0,
                                        68.0,
                                        338.0,
                                        22.0,
                                        383.0,
                                        22.0,
                                        383.0,
                                        68.0,
                                        383.0,
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
                                        22.0,
                                        473.0,
                                        22.0,
                                        473.0,
                                        68.0,
                                        473.0,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        22.0,
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        982.0,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        294.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        714.0,
                                        67.0,
                                        714.0,
                                        105.0,
                                        714.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        1134.5,
                                        105.0
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
                                        "obj-19",
                                        0
                                    ],
                                    "midpoints": [
                                        264.5,
                                        22.0,
                                        338.0,
                                        22.0,
                                        338.0,
                                        68.0,
                                        338.0,
                                        22.0,
                                        383.0,
                                        22.0,
                                        383.0,
                                        68.0,
                                        383.0,
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
                                        22.0,
                                        473.0,
                                        22.0,
                                        473.0,
                                        68.0,
                                        473.0,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        22.0,
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        982.0,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        294.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        714.0,
                                        67.0,
                                        714.0,
                                        105.0,
                                        714.0,
                                        67.0,
                                        1267.0,
                                        67.0,
                                        1267.0,
                                        105.0,
                                        1267.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        1419.5,
                                        105.0
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
                                        "obj-20",
                                        0
                                    ],
                                    "midpoints": [
                                        309.5,
                                        22.0,
                                        337.0,
                                        22.0,
                                        337.0,
                                        68.0,
                                        309.5,
                                        68.0
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
                                        "obj-21",
                                        0
                                    ],
                                    "midpoints": [
                                        354.5,
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
                                        22.0,
                                        473.0,
                                        22.0,
                                        473.0,
                                        68.0,
                                        473.0,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        22.0,
                                        517.0,
                                        22.0,
                                        517.0,
                                        68.0,
                                        517.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        594.5,
                                        105.0
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
                                        "obj-22",
                                        0
                                    ],
                                    "midpoints": [
                                        399.5,
                                        22.0,
                                        473.0,
                                        22.0,
                                        473.0,
                                        68.0,
                                        473.0,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        22.0,
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        982.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        714.0,
                                        67.0,
                                        714.0,
                                        105.0,
                                        714.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        1284.5,
                                        105.0
                                    ],
                                    "source": [
                                        "obj-9",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        1350.0,
                        150.0,
                        86.0,
                        22.0
                    ],
                    "text": "p ratios"
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-19",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1065.0,
                        30.0,
                        76.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        64.0,
                        76.0,
                        22.0
                    ],
                    "text": "0c",
                    "nosymquotes": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2805.0,
                        375.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        67.0,
                        26.0,
                        18.0
                    ],
                    "text": "0",
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
                    "fontsize": 11.0,
                    "id": "obj-21",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1155.0,
                        30.0,
                        76.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        90.0,
                        76.0,
                        22.0
                    ],
                    "text": "90.225c",
                    "nosymquotes": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-22",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2910.0,
                        30.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        93.0,
                        26.0,
                        18.0
                    ],
                    "text": "1",
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
                    "fontsize": 11.0,
                    "id": "obj-23",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1245.0,
                        30.0,
                        76.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        116.0,
                        76.0,
                        22.0
                    ],
                    "text": "192.18c",
                    "nosymquotes": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-24",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2910.0,
                        75.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        119.0,
                        26.0,
                        18.0
                    ],
                    "text": "2",
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
                    "fontsize": 11.0,
                    "id": "obj-25",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1335.0,
                        30.0,
                        76.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        142.0,
                        76.0,
                        22.0
                    ],
                    "text": "294.135c",
                    "nosymquotes": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-26",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2910.0,
                        135.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        145.0,
                        26.0,
                        18.0
                    ],
                    "text": "3",
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
                    "fontsize": 11.0,
                    "id": "obj-27",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1425.0,
                        30.0,
                        76.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        168.0,
                        76.0,
                        22.0
                    ],
                    "text": "390.225c",
                    "nosymquotes": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-28",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2910.0,
                        180.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        171.0,
                        26.0,
                        18.0
                    ],
                    "text": "4",
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
                    "fontsize": 11.0,
                    "id": "obj-29",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1515.0,
                        30.0,
                        76.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        194.0,
                        76.0,
                        22.0
                    ],
                    "text": "498.045c",
                    "nosymquotes": 1
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
                        2910.0,
                        225.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        197.0,
                        26.0,
                        18.0
                    ],
                    "text": "5",
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
                    "fontsize": 11.0,
                    "id": "obj-31",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1065.0,
                        75.0,
                        76.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        220.0,
                        76.0,
                        22.0
                    ],
                    "text": "588.27c",
                    "nosymquotes": 1
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
                        2910.0,
                        285.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        223.0,
                        26.0,
                        18.0
                    ],
                    "text": "6",
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
                    "fontsize": 11.0,
                    "id": "obj-33",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1155.0,
                        75.0,
                        76.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        246.0,
                        76.0,
                        22.0
                    ],
                    "text": "696.09c",
                    "nosymquotes": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-34",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2910.0,
                        330.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        249.0,
                        26.0,
                        18.0
                    ],
                    "text": "7",
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
                    "fontsize": 11.0,
                    "id": "obj-35",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1245.0,
                        75.0,
                        76.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        272.0,
                        76.0,
                        22.0
                    ],
                    "text": "792.18c",
                    "nosymquotes": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-36",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2910.0,
                        375.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        275.0,
                        26.0,
                        18.0
                    ],
                    "text": "8",
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
                    "fontsize": 11.0,
                    "id": "obj-37",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1335.0,
                        75.0,
                        76.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        298.0,
                        76.0,
                        22.0
                    ],
                    "text": "888.27c",
                    "nosymquotes": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-38",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2970.0,
                        30.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        301.0,
                        26.0,
                        18.0
                    ],
                    "text": "9",
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
                    "fontsize": 11.0,
                    "id": "obj-39",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1425.0,
                        75.0,
                        76.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        324.0,
                        76.0,
                        22.0
                    ],
                    "text": "996.09c",
                    "nosymquotes": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-40",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2970.0,
                        75.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        327.0,
                        26.0,
                        18.0
                    ],
                    "text": "10",
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
                    "fontsize": 11.0,
                    "id": "obj-41",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1515.0,
                        75.0,
                        76.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        350.0,
                        76.0,
                        22.0
                    ],
                    "text": "1092.18c",
                    "nosymquotes": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-42",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2970.0,
                        135.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        353.0,
                        26.0,
                        18.0
                    ],
                    "text": "11",
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
                    "id": "obj-43",
                    "maxclass": "newobj",
                    "numinlets": 13,
                    "numoutlets": 13,
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
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        270.0,
                        233.0,
                        22.0
                    ],
                    "text": "route 0 1 2 3 4 5 6 7 8 9 10 11"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-44",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        105.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        64.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-45",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        180.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        90.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-46",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        240.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        116.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-47",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        300.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        142.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-48",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        375.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        168.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-49",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        435.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        194.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-50",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        495.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        220.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-51",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        570.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        246.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-52",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        630.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        272.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-53",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        690.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        298.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-54",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        765.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        324.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-55",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        825.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        350.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-56",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        375.0,
                        270.0,
                        135.0,
                        22.0
                    ],
                    "text": "mc.sig~ @chans 12"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-57",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        525.0,
                        270.0,
                        135.0,
                        22.0
                    ],
                    "text": "mc.sig~ @chans 12"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-59",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        1050.0,
                        315.0,
                        184.0,
                        22.0
                    ],
                    "text": "mc.rampsmooth~ 2205 2205"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-60",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        1020.0,
                        360.0,
                        51.0,
                        22.0
                    ],
                    "text": "mc.*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-61",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        1035.0,
                        405.0,
                        164.0,
                        22.0
                    ],
                    "text": "mc.mixdown~ 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-62",
                    "maxclass": "newobj",
                    "numinlets": 5,
                    "numoutlets": 4,
                    "outlettype": [
                        "signal",
                        "signal",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        675.0,
                        270.0,
                        177.0,
                        22.0
                    ],
                    "text": "adsr~ 10. 150. 0.7 400."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-63",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        885.0,
                        450.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-64",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        900.0,
                        480.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.1"
                }
            },
            {
                "box": {
                    "id": "obj-65",
                    "maxclass": "gain~",
                    "multichannelvariant": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        540.0,
                        525.0,
                        22.0,
                        140.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        620.0,
                        110.0,
                        30.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-66",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        570.0,
                        525.0,
                        15.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        655.0,
                        110.0,
                        15.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ],
                    "id": "obj-67",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        525.0,
                        690.0,
                        45.0,
                        45.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-68",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 12,
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
                        "",
                        "",
                        ""
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "unused (re-init bang)",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "voices init",
                                    "id": "obj-2",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        60.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "complexity init",
                                    "id": "obj-3",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        135.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "tonic init",
                                    "id": "obj-4",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        210.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "A4 init",
                                    "id": "obj-5",
                                    "index": 4,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        300.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "voicing init",
                                    "id": "obj-6",
                                    "index": 5,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        375.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "gain init",
                                    "id": "obj-7",
                                    "index": 6,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        450.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "dump cents",
                                    "id": "obj-8",
                                    "index": 7,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        540.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        75.0,
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
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 12,
                                    "outlettype": [
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        245.0,
                                        22.0
                                    ],
                                    "text": "trigger b b b b b b b b b b b b"
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
                                        30.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        105.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "5"
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
                                        195.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "0.5"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "0"
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
                                        345.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "440."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-16",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        435.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "0"
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
                                        510.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "120"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-18",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        120.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "0.5"
                                }
                            },
                            {
                                "box": {
                                    "comment": "data from 0.5",
                                    "id": "obj-19",
                                    "index": 8,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        615.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-20",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        120.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "5."
                                }
                            },
                            {
                                "box": {
                                    "comment": "data from 5.",
                                    "id": "obj-21",
                                    "index": 9,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        690.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ]
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
                                        735.0,
                                        120.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "10."
                                }
                            },
                            {
                                "box": {
                                    "comment": "data from 10.",
                                    "id": "obj-23",
                                    "index": 10,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        765.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ]
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
                                        810.0,
                                        120.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "0."
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
                                        885.0,
                                        120.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "0.3"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-26",
                                    "index": 11,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        840.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-27",
                                    "index": 12,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        915.0,
                                        165.0,
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
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        67.5,
                                        39.5,
                                        67.5
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
                                    "source": [
                                        "obj-10",
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
                                        60.04545454545455,
                                        112.0,
                                        103.0,
                                        112.0,
                                        103.0,
                                        150.0,
                                        114.5,
                                        150.0
                                    ],
                                    "source": [
                                        "obj-10",
                                        1
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
                                        80.5909090909091,
                                        112.0,
                                        103.0,
                                        112.0,
                                        103.0,
                                        150.0,
                                        103.0,
                                        112.0,
                                        178.0,
                                        112.0,
                                        178.0,
                                        150.0,
                                        204.5,
                                        150.0
                                    ],
                                    "source": [
                                        "obj-10",
                                        2
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
                                        101.13636363636363,
                                        112.0,
                                        103.0,
                                        112.0,
                                        103.0,
                                        150.0,
                                        103.0,
                                        112.0,
                                        178.0,
                                        112.0,
                                        178.0,
                                        150.0,
                                        178.0,
                                        112.0,
                                        187.0,
                                        112.0,
                                        187.0,
                                        150.0,
                                        279.5,
                                        150.0
                                    ],
                                    "source": [
                                        "obj-10",
                                        3
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
                                        121.68181818181819,
                                        112.0,
                                        178.0,
                                        112.0,
                                        178.0,
                                        150.0,
                                        178.0,
                                        112.0,
                                        268.0,
                                        112.0,
                                        268.0,
                                        150.0,
                                        268.0,
                                        112.0,
                                        262.0,
                                        112.0,
                                        262.0,
                                        150.0,
                                        354.5,
                                        150.0
                                    ],
                                    "source": [
                                        "obj-10",
                                        4
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-16",
                                        0
                                    ],
                                    "midpoints": [
                                        142.22727272727275,
                                        112.0,
                                        178.0,
                                        112.0,
                                        178.0,
                                        150.0,
                                        178.0,
                                        112.0,
                                        268.0,
                                        112.0,
                                        268.0,
                                        150.0,
                                        268.0,
                                        112.0,
                                        262.0,
                                        112.0,
                                        262.0,
                                        150.0,
                                        262.0,
                                        112.0,
                                        337.0,
                                        112.0,
                                        337.0,
                                        150.0,
                                        444.5,
                                        150.0
                                    ],
                                    "source": [
                                        "obj-10",
                                        5
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
                                        162.77272727272725,
                                        112.0,
                                        178.0,
                                        112.0,
                                        178.0,
                                        150.0,
                                        178.0,
                                        112.0,
                                        268.0,
                                        112.0,
                                        268.0,
                                        150.0,
                                        268.0,
                                        112.0,
                                        343.0,
                                        112.0,
                                        343.0,
                                        150.0,
                                        343.0,
                                        112.0,
                                        337.0,
                                        112.0,
                                        337.0,
                                        150.0,
                                        337.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        519.5,
                                        150.0
                                    ],
                                    "source": [
                                        "obj-10",
                                        6
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
                                        183.3181818181818,
                                        112.0,
                                        268.0,
                                        112.0,
                                        268.0,
                                        150.0,
                                        268.0,
                                        112.0,
                                        343.0,
                                        112.0,
                                        343.0,
                                        150.0,
                                        343.0,
                                        112.0,
                                        418.0,
                                        112.0,
                                        418.0,
                                        150.0,
                                        418.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        594.5,
                                        150.0
                                    ],
                                    "source": [
                                        "obj-10",
                                        7
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
                                        203.86363636363637,
                                        112.0,
                                        268.0,
                                        112.0,
                                        268.0,
                                        150.0,
                                        268.0,
                                        112.0,
                                        343.0,
                                        112.0,
                                        343.0,
                                        150.0,
                                        343.0,
                                        112.0,
                                        418.0,
                                        112.0,
                                        418.0,
                                        150.0,
                                        418.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        502.0,
                                        112.0,
                                        577.0,
                                        112.0,
                                        577.0,
                                        150.0,
                                        669.5,
                                        150.0
                                    ],
                                    "source": [
                                        "obj-10",
                                        8
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
                                        224.4090909090909,
                                        112.0,
                                        268.0,
                                        112.0,
                                        268.0,
                                        150.0,
                                        268.0,
                                        112.0,
                                        343.0,
                                        112.0,
                                        343.0,
                                        150.0,
                                        343.0,
                                        112.0,
                                        418.0,
                                        112.0,
                                        418.0,
                                        150.0,
                                        418.0,
                                        112.0,
                                        508.0,
                                        112.0,
                                        508.0,
                                        150.0,
                                        508.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        502.0,
                                        112.0,
                                        577.0,
                                        112.0,
                                        577.0,
                                        150.0,
                                        577.0,
                                        112.0,
                                        652.0,
                                        112.0,
                                        652.0,
                                        150.0,
                                        744.5,
                                        150.0
                                    ],
                                    "source": [
                                        "obj-10",
                                        9
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
                                        "obj-10",
                                        10
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
                                        "obj-10",
                                        11
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
                                        112.0,
                                        178.0,
                                        112.0,
                                        178.0,
                                        150.0,
                                        178.0,
                                        112.0,
                                        268.0,
                                        112.0,
                                        268.0,
                                        150.0,
                                        268.0,
                                        112.0,
                                        343.0,
                                        112.0,
                                        343.0,
                                        150.0,
                                        343.0,
                                        112.0,
                                        337.0,
                                        112.0,
                                        337.0,
                                        150.0,
                                        337.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        502.0,
                                        157.0,
                                        98.0,
                                        157.0,
                                        98.0,
                                        203.0,
                                        98.0,
                                        157.0,
                                        173.0,
                                        157.0,
                                        173.0,
                                        203.0,
                                        173.0,
                                        157.0,
                                        248.0,
                                        157.0,
                                        248.0,
                                        203.0,
                                        248.0,
                                        157.0,
                                        292.0,
                                        157.0,
                                        292.0,
                                        203.0,
                                        292.0,
                                        157.0,
                                        367.0,
                                        157.0,
                                        367.0,
                                        203.0,
                                        367.0,
                                        157.0,
                                        442.0,
                                        157.0,
                                        442.0,
                                        203.0,
                                        549.5,
                                        203.0
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
                                        "obj-2",
                                        0
                                    ],
                                    "midpoints": [
                                        114.5,
                                        112.0,
                                        103.0,
                                        112.0,
                                        103.0,
                                        150.0,
                                        103.0,
                                        157.0,
                                        127.0,
                                        157.0,
                                        127.0,
                                        203.0,
                                        69.5,
                                        203.0
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
                                        "obj-3",
                                        0
                                    ],
                                    "midpoints": [
                                        204.5,
                                        112.0,
                                        178.0,
                                        112.0,
                                        178.0,
                                        150.0,
                                        178.0,
                                        157.0,
                                        202.0,
                                        157.0,
                                        202.0,
                                        203.0,
                                        144.5,
                                        203.0
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
                                        "obj-4",
                                        0
                                    ],
                                    "midpoints": [
                                        279.5,
                                        112.0,
                                        268.0,
                                        112.0,
                                        268.0,
                                        150.0,
                                        268.0,
                                        157.0,
                                        292.0,
                                        157.0,
                                        292.0,
                                        203.0,
                                        219.5,
                                        203.0
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        354.5,
                                        112.0,
                                        343.0,
                                        112.0,
                                        343.0,
                                        150.0,
                                        343.0,
                                        157.0,
                                        367.0,
                                        157.0,
                                        367.0,
                                        203.0,
                                        309.5,
                                        203.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        444.5,
                                        112.0,
                                        418.0,
                                        112.0,
                                        418.0,
                                        150.0,
                                        418.0,
                                        157.0,
                                        442.0,
                                        157.0,
                                        442.0,
                                        203.0,
                                        384.5,
                                        203.0
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        519.5,
                                        112.0,
                                        508.0,
                                        112.0,
                                        508.0,
                                        150.0,
                                        508.0,
                                        157.0,
                                        532.0,
                                        157.0,
                                        532.0,
                                        203.0,
                                        459.5,
                                        203.0
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
                                        "obj-21",
                                        0
                                    ],
                                    "source": [
                                        "obj-20",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-23",
                                        0
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
                                        "obj-26",
                                        0
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
                                        "obj-27",
                                        0
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
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        84.5,
                                        63.5,
                                        39.5,
                                        63.5
                                    ],
                                    "source": [
                                        "obj-9",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        105.0,
                        30.0,
                        86.0,
                        22.0
                    ],
                    "text": "p init"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-69",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2970.0,
                        180.0,
                        327.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        10.0,
                        327.0,
                        24.0
                    ],
                    "text": "JI HARMONIZER — tuning + chord engine",
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
                    "id": "obj-70",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2970.0,
                        225.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.7.2",
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
                    "id": "obj-71",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        360.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend applyvalues"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-72",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        405.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend applyvalues"
                }
            },
            {
                "box": {
                    "id": "obj-73",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1094.0,
                        5.0,
                        18.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        66.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-74",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1184.0,
                        5.0,
                        18.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        92.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-75",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1274.0,
                        5.0,
                        18.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        118.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-76",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1364.0,
                        5.0,
                        18.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        144.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-77",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1454.0,
                        5.0,
                        18.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        170.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-78",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1544.0,
                        5.0,
                        18.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        196.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-79",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1094.0,
                        103.0,
                        18.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        222.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-80",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1184.0,
                        103.0,
                        18.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        248.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-81",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1274.0,
                        103.0,
                        18.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        274.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-82",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1364.0,
                        103.0,
                        18.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        300.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-83",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1454.0,
                        103.0,
                        18.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        326.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-84",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1544.0,
                        103.0,
                        18.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        352.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-85",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        955.0,
                        103.0,
                        107.0,
                        20.0
                    ],
                    "text": "degree enable"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-86",
                    "maxclass": "newobj",
                    "numinlets": 12,
                    "numoutlets": 13,
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
                        "",
                        "",
                        "",
                        ""
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "degree 0 toggle",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 1 toggle",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 2 toggle",
                                    "id": "obj-3",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 3 toggle",
                                    "id": "obj-4",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        290.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 4 toggle",
                                    "id": "obj-5",
                                    "index": 5,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 5 toggle",
                                    "id": "obj-6",
                                    "index": 6,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 6 toggle",
                                    "id": "obj-7",
                                    "index": 7,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        530.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 7 toggle",
                                    "id": "obj-8",
                                    "index": 8,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        610.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 8 toggle",
                                    "id": "obj-9",
                                    "index": 9,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        690.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 9 toggle",
                                    "id": "obj-10",
                                    "index": 10,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        770.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 10 toggle",
                                    "id": "obj-11",
                                    "index": 11,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        850.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 11 toggle",
                                    "id": "obj-12",
                                    "index": 12,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree messages to ji-engine",
                                    "id": "obj-13",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        50.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 0",
                                    "id": "obj-14",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        130.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 1",
                                    "id": "obj-15",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        210.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 2",
                                    "id": "obj-16",
                                    "index": 4,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        290.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 3",
                                    "id": "obj-17",
                                    "index": 5,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        370.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 4",
                                    "id": "obj-18",
                                    "index": 6,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        450.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 5",
                                    "id": "obj-19",
                                    "index": 7,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        530.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 6",
                                    "id": "obj-20",
                                    "index": 8,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        610.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 7",
                                    "id": "obj-21",
                                    "index": 9,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        690.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 8",
                                    "id": "obj-22",
                                    "index": 10,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        770.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 9",
                                    "id": "obj-23",
                                    "index": 11,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        850.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 10",
                                    "id": "obj-24",
                                    "index": 12,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        930.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 11",
                                    "id": "obj-25",
                                    "index": 13,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        1010.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-26",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        150.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 0 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-27",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        150.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 1 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-28",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        150.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 2 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-29",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        290.0,
                                        150.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 3 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-30",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        150.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 4 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-31",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        150.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 5 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-32",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        530.0,
                                        150.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 6 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-33",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        610.0,
                                        150.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 7 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-34",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
                                        150.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 8 $1"
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
                                        770.0,
                                        150.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 9 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-36",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        850.0,
                                        150.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "degree 10 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-37",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        150.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "degree 11 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-38",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        210.0,
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
                                    "id": "obj-39",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 12,
                                    "outlettype": [
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        300.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "trigger b b b b b b b b b b b b"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-40",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        290.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-41",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        110.0,
                                        290.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-42",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        190.0,
                                        290.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-43",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        290.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-44",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        290.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-45",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        430.0,
                                        290.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-46",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        290.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-47",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        590.0,
                                        290.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-48",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        670.0,
                                        290.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-49",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        750.0,
                                        290.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-50",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        830.0,
                                        290.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-51",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        910.0,
                                        290.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-26",
                                        0
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
                                        "obj-35",
                                        0
                                    ],
                                    "midpoints": [
                                        779.5,
                                        142.0,
                                        791.0,
                                        142.0,
                                        791.0,
                                        180.0,
                                        779.5,
                                        180.0
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
                                        "obj-36",
                                        0
                                    ],
                                    "midpoints": [
                                        859.5,
                                        142.0,
                                        871.0,
                                        142.0,
                                        871.0,
                                        180.0,
                                        859.5,
                                        180.0
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
                                        "obj-37",
                                        0
                                    ],
                                    "midpoints": [
                                        939.5,
                                        142.0,
                                        958.0,
                                        142.0,
                                        958.0,
                                        180.0,
                                        939.5,
                                        180.0
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
                                        "obj-27",
                                        0
                                    ],
                                    "midpoints": [
                                        139.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        139.5,
                                        180.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        59.5,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        59.5,
                                        240.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        139.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        122.0,
                                        242.0,
                                        122.0,
                                        288.0,
                                        59.5,
                                        288.0
                                    ],
                                    "source": [
                                        "obj-27",
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
                                        219.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        122.0,
                                        142.0,
                                        122.0,
                                        180.0,
                                        122.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        202.0,
                                        242.0,
                                        202.0,
                                        288.0,
                                        59.5,
                                        288.0
                                    ],
                                    "source": [
                                        "obj-28",
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
                                        299.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        202.0,
                                        142.0,
                                        202.0,
                                        180.0,
                                        202.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        202.0,
                                        242.0,
                                        202.0,
                                        288.0,
                                        202.0,
                                        242.0,
                                        282.0,
                                        242.0,
                                        282.0,
                                        288.0,
                                        59.5,
                                        288.0
                                    ],
                                    "source": [
                                        "obj-29",
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
                                        219.5,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        219.5,
                                        180.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        379.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        202.0,
                                        142.0,
                                        202.0,
                                        180.0,
                                        202.0,
                                        142.0,
                                        282.0,
                                        142.0,
                                        282.0,
                                        180.0,
                                        282.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        282.0,
                                        242.0,
                                        282.0,
                                        288.0,
                                        282.0,
                                        242.0,
                                        362.0,
                                        242.0,
                                        362.0,
                                        288.0,
                                        59.5,
                                        288.0
                                    ],
                                    "source": [
                                        "obj-30",
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
                                        459.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        282.0,
                                        142.0,
                                        282.0,
                                        180.0,
                                        282.0,
                                        142.0,
                                        362.0,
                                        142.0,
                                        362.0,
                                        180.0,
                                        362.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        282.0,
                                        242.0,
                                        282.0,
                                        288.0,
                                        282.0,
                                        242.0,
                                        362.0,
                                        242.0,
                                        362.0,
                                        288.0,
                                        362.0,
                                        242.0,
                                        442.0,
                                        242.0,
                                        442.0,
                                        288.0,
                                        59.5,
                                        288.0
                                    ],
                                    "source": [
                                        "obj-31",
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
                                        539.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        282.0,
                                        142.0,
                                        282.0,
                                        180.0,
                                        282.0,
                                        142.0,
                                        362.0,
                                        142.0,
                                        362.0,
                                        180.0,
                                        362.0,
                                        142.0,
                                        442.0,
                                        142.0,
                                        442.0,
                                        180.0,
                                        442.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        328.0,
                                        242.0,
                                        328.0,
                                        288.0,
                                        328.0,
                                        242.0,
                                        362.0,
                                        242.0,
                                        362.0,
                                        288.0,
                                        362.0,
                                        242.0,
                                        442.0,
                                        242.0,
                                        442.0,
                                        288.0,
                                        442.0,
                                        242.0,
                                        522.0,
                                        242.0,
                                        522.0,
                                        288.0,
                                        59.5,
                                        288.0
                                    ],
                                    "source": [
                                        "obj-32",
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
                                        619.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        391.0,
                                        142.0,
                                        391.0,
                                        180.0,
                                        391.0,
                                        142.0,
                                        362.0,
                                        142.0,
                                        362.0,
                                        180.0,
                                        362.0,
                                        142.0,
                                        442.0,
                                        142.0,
                                        442.0,
                                        180.0,
                                        442.0,
                                        142.0,
                                        522.0,
                                        142.0,
                                        522.0,
                                        180.0,
                                        522.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        328.0,
                                        242.0,
                                        328.0,
                                        288.0,
                                        328.0,
                                        242.0,
                                        362.0,
                                        242.0,
                                        362.0,
                                        288.0,
                                        362.0,
                                        242.0,
                                        442.0,
                                        242.0,
                                        442.0,
                                        288.0,
                                        442.0,
                                        242.0,
                                        522.0,
                                        242.0,
                                        522.0,
                                        288.0,
                                        522.0,
                                        242.0,
                                        602.0,
                                        242.0,
                                        602.0,
                                        288.0,
                                        59.5,
                                        288.0
                                    ],
                                    "source": [
                                        "obj-33",
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
                                        699.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        391.0,
                                        142.0,
                                        391.0,
                                        180.0,
                                        391.0,
                                        142.0,
                                        362.0,
                                        142.0,
                                        362.0,
                                        180.0,
                                        362.0,
                                        142.0,
                                        442.0,
                                        142.0,
                                        442.0,
                                        180.0,
                                        442.0,
                                        142.0,
                                        522.0,
                                        142.0,
                                        522.0,
                                        180.0,
                                        522.0,
                                        142.0,
                                        602.0,
                                        142.0,
                                        602.0,
                                        180.0,
                                        602.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        328.0,
                                        242.0,
                                        328.0,
                                        288.0,
                                        328.0,
                                        242.0,
                                        408.0,
                                        242.0,
                                        408.0,
                                        288.0,
                                        408.0,
                                        242.0,
                                        442.0,
                                        242.0,
                                        442.0,
                                        288.0,
                                        442.0,
                                        242.0,
                                        522.0,
                                        242.0,
                                        522.0,
                                        288.0,
                                        522.0,
                                        242.0,
                                        602.0,
                                        242.0,
                                        602.0,
                                        288.0,
                                        602.0,
                                        242.0,
                                        682.0,
                                        242.0,
                                        682.0,
                                        288.0,
                                        59.5,
                                        288.0
                                    ],
                                    "source": [
                                        "obj-34",
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
                                        779.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        391.0,
                                        142.0,
                                        391.0,
                                        180.0,
                                        391.0,
                                        142.0,
                                        471.0,
                                        142.0,
                                        471.0,
                                        180.0,
                                        471.0,
                                        142.0,
                                        442.0,
                                        142.0,
                                        442.0,
                                        180.0,
                                        442.0,
                                        142.0,
                                        522.0,
                                        142.0,
                                        522.0,
                                        180.0,
                                        522.0,
                                        142.0,
                                        602.0,
                                        142.0,
                                        602.0,
                                        180.0,
                                        602.0,
                                        142.0,
                                        682.0,
                                        142.0,
                                        682.0,
                                        180.0,
                                        682.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        328.0,
                                        242.0,
                                        328.0,
                                        288.0,
                                        328.0,
                                        242.0,
                                        408.0,
                                        242.0,
                                        408.0,
                                        288.0,
                                        408.0,
                                        242.0,
                                        442.0,
                                        242.0,
                                        442.0,
                                        288.0,
                                        442.0,
                                        242.0,
                                        522.0,
                                        242.0,
                                        522.0,
                                        288.0,
                                        522.0,
                                        242.0,
                                        602.0,
                                        242.0,
                                        602.0,
                                        288.0,
                                        602.0,
                                        242.0,
                                        682.0,
                                        242.0,
                                        682.0,
                                        288.0,
                                        682.0,
                                        242.0,
                                        762.0,
                                        242.0,
                                        762.0,
                                        288.0,
                                        59.5,
                                        288.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        859.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        391.0,
                                        142.0,
                                        391.0,
                                        180.0,
                                        391.0,
                                        142.0,
                                        471.0,
                                        142.0,
                                        471.0,
                                        180.0,
                                        471.0,
                                        142.0,
                                        442.0,
                                        142.0,
                                        442.0,
                                        180.0,
                                        442.0,
                                        142.0,
                                        522.0,
                                        142.0,
                                        522.0,
                                        180.0,
                                        522.0,
                                        142.0,
                                        602.0,
                                        142.0,
                                        602.0,
                                        180.0,
                                        602.0,
                                        142.0,
                                        682.0,
                                        142.0,
                                        682.0,
                                        180.0,
                                        682.0,
                                        142.0,
                                        762.0,
                                        142.0,
                                        762.0,
                                        180.0,
                                        762.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        328.0,
                                        242.0,
                                        328.0,
                                        288.0,
                                        328.0,
                                        242.0,
                                        408.0,
                                        242.0,
                                        408.0,
                                        288.0,
                                        408.0,
                                        242.0,
                                        488.0,
                                        242.0,
                                        488.0,
                                        288.0,
                                        488.0,
                                        242.0,
                                        522.0,
                                        242.0,
                                        522.0,
                                        288.0,
                                        522.0,
                                        242.0,
                                        602.0,
                                        242.0,
                                        602.0,
                                        288.0,
                                        602.0,
                                        242.0,
                                        682.0,
                                        242.0,
                                        682.0,
                                        288.0,
                                        682.0,
                                        242.0,
                                        762.0,
                                        242.0,
                                        762.0,
                                        288.0,
                                        762.0,
                                        242.0,
                                        842.0,
                                        242.0,
                                        842.0,
                                        288.0,
                                        59.5,
                                        288.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        939.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        391.0,
                                        142.0,
                                        391.0,
                                        180.0,
                                        391.0,
                                        142.0,
                                        471.0,
                                        142.0,
                                        471.0,
                                        180.0,
                                        471.0,
                                        142.0,
                                        551.0,
                                        142.0,
                                        551.0,
                                        180.0,
                                        551.0,
                                        142.0,
                                        522.0,
                                        142.0,
                                        522.0,
                                        180.0,
                                        522.0,
                                        142.0,
                                        602.0,
                                        142.0,
                                        602.0,
                                        180.0,
                                        602.0,
                                        142.0,
                                        682.0,
                                        142.0,
                                        682.0,
                                        180.0,
                                        682.0,
                                        142.0,
                                        762.0,
                                        142.0,
                                        762.0,
                                        180.0,
                                        762.0,
                                        142.0,
                                        842.0,
                                        142.0,
                                        842.0,
                                        180.0,
                                        842.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        328.0,
                                        242.0,
                                        328.0,
                                        288.0,
                                        328.0,
                                        242.0,
                                        408.0,
                                        242.0,
                                        408.0,
                                        288.0,
                                        408.0,
                                        242.0,
                                        488.0,
                                        242.0,
                                        488.0,
                                        288.0,
                                        488.0,
                                        242.0,
                                        522.0,
                                        242.0,
                                        522.0,
                                        288.0,
                                        522.0,
                                        242.0,
                                        602.0,
                                        242.0,
                                        602.0,
                                        288.0,
                                        602.0,
                                        242.0,
                                        682.0,
                                        242.0,
                                        682.0,
                                        288.0,
                                        682.0,
                                        242.0,
                                        762.0,
                                        242.0,
                                        762.0,
                                        288.0,
                                        762.0,
                                        242.0,
                                        842.0,
                                        242.0,
                                        842.0,
                                        288.0,
                                        842.0,
                                        242.0,
                                        922.0,
                                        242.0,
                                        922.0,
                                        288.0,
                                        59.5,
                                        288.0
                                    ],
                                    "source": [
                                        "obj-37",
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
                                        39.5,
                                        242.0,
                                        88.0,
                                        242.0,
                                        88.0,
                                        288.0,
                                        88.0,
                                        242.0,
                                        122.0,
                                        242.0,
                                        122.0,
                                        288.0,
                                        122.0,
                                        282.0,
                                        89.0,
                                        282.0,
                                        89.0,
                                        320.0,
                                        89.0,
                                        282.0,
                                        102.0,
                                        282.0,
                                        102.0,
                                        320.0,
                                        39.5,
                                        320.0
                                    ],
                                    "source": [
                                        "obj-38",
                                        0
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
                                        "obj-39",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        58.95454545454545,
                                        282.0,
                                        89.0,
                                        282.0,
                                        89.0,
                                        320.0,
                                        119.5,
                                        320.0
                                    ],
                                    "source": [
                                        "obj-39",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        78.4090909090909,
                                        282.0,
                                        89.0,
                                        282.0,
                                        89.0,
                                        320.0,
                                        89.0,
                                        282.0,
                                        169.0,
                                        282.0,
                                        169.0,
                                        320.0,
                                        199.5,
                                        320.0
                                    ],
                                    "source": [
                                        "obj-39",
                                        2
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-43",
                                        0
                                    ],
                                    "midpoints": [
                                        97.86363636363637,
                                        282.0,
                                        169.0,
                                        282.0,
                                        169.0,
                                        320.0,
                                        169.0,
                                        282.0,
                                        182.0,
                                        282.0,
                                        182.0,
                                        320.0,
                                        279.5,
                                        320.0
                                    ],
                                    "source": [
                                        "obj-39",
                                        3
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        117.31818181818181,
                                        282.0,
                                        169.0,
                                        282.0,
                                        169.0,
                                        320.0,
                                        169.0,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        262.0,
                                        282.0,
                                        262.0,
                                        320.0,
                                        359.5,
                                        320.0
                                    ],
                                    "source": [
                                        "obj-39",
                                        4
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-45",
                                        0
                                    ],
                                    "midpoints": [
                                        136.77272727272725,
                                        282.0,
                                        169.0,
                                        282.0,
                                        169.0,
                                        320.0,
                                        169.0,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        262.0,
                                        282.0,
                                        262.0,
                                        320.0,
                                        262.0,
                                        282.0,
                                        342.0,
                                        282.0,
                                        342.0,
                                        320.0,
                                        439.5,
                                        320.0
                                    ],
                                    "source": [
                                        "obj-39",
                                        5
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-46",
                                        0
                                    ],
                                    "midpoints": [
                                        156.22727272727275,
                                        282.0,
                                        169.0,
                                        282.0,
                                        169.0,
                                        320.0,
                                        169.0,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        329.0,
                                        282.0,
                                        329.0,
                                        320.0,
                                        329.0,
                                        282.0,
                                        342.0,
                                        282.0,
                                        342.0,
                                        320.0,
                                        342.0,
                                        282.0,
                                        422.0,
                                        282.0,
                                        422.0,
                                        320.0,
                                        519.5,
                                        320.0
                                    ],
                                    "source": [
                                        "obj-39",
                                        6
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-47",
                                        0
                                    ],
                                    "midpoints": [
                                        175.6818181818182,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        329.0,
                                        282.0,
                                        329.0,
                                        320.0,
                                        329.0,
                                        282.0,
                                        409.0,
                                        282.0,
                                        409.0,
                                        320.0,
                                        409.0,
                                        282.0,
                                        422.0,
                                        282.0,
                                        422.0,
                                        320.0,
                                        422.0,
                                        282.0,
                                        502.0,
                                        282.0,
                                        502.0,
                                        320.0,
                                        599.5,
                                        320.0
                                    ],
                                    "source": [
                                        "obj-39",
                                        7
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-48",
                                        0
                                    ],
                                    "midpoints": [
                                        195.13636363636363,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        329.0,
                                        282.0,
                                        329.0,
                                        320.0,
                                        329.0,
                                        282.0,
                                        409.0,
                                        282.0,
                                        409.0,
                                        320.0,
                                        409.0,
                                        282.0,
                                        422.0,
                                        282.0,
                                        422.0,
                                        320.0,
                                        422.0,
                                        282.0,
                                        502.0,
                                        282.0,
                                        502.0,
                                        320.0,
                                        502.0,
                                        282.0,
                                        582.0,
                                        282.0,
                                        582.0,
                                        320.0,
                                        679.5,
                                        320.0
                                    ],
                                    "source": [
                                        "obj-39",
                                        8
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        214.5909090909091,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        329.0,
                                        282.0,
                                        329.0,
                                        320.0,
                                        329.0,
                                        282.0,
                                        409.0,
                                        282.0,
                                        409.0,
                                        320.0,
                                        409.0,
                                        282.0,
                                        489.0,
                                        282.0,
                                        489.0,
                                        320.0,
                                        489.0,
                                        282.0,
                                        502.0,
                                        282.0,
                                        502.0,
                                        320.0,
                                        502.0,
                                        282.0,
                                        582.0,
                                        282.0,
                                        582.0,
                                        320.0,
                                        582.0,
                                        282.0,
                                        662.0,
                                        282.0,
                                        662.0,
                                        320.0,
                                        759.5,
                                        320.0
                                    ],
                                    "source": [
                                        "obj-39",
                                        9
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-50",
                                        0
                                    ],
                                    "midpoints": [
                                        234.04545454545453,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        329.0,
                                        282.0,
                                        329.0,
                                        320.0,
                                        329.0,
                                        282.0,
                                        409.0,
                                        282.0,
                                        409.0,
                                        320.0,
                                        409.0,
                                        282.0,
                                        489.0,
                                        282.0,
                                        489.0,
                                        320.0,
                                        489.0,
                                        282.0,
                                        569.0,
                                        282.0,
                                        569.0,
                                        320.0,
                                        569.0,
                                        282.0,
                                        582.0,
                                        282.0,
                                        582.0,
                                        320.0,
                                        582.0,
                                        282.0,
                                        662.0,
                                        282.0,
                                        662.0,
                                        320.0,
                                        662.0,
                                        282.0,
                                        742.0,
                                        282.0,
                                        742.0,
                                        320.0,
                                        839.5,
                                        320.0
                                    ],
                                    "source": [
                                        "obj-39",
                                        10
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        253.5,
                                        282.0,
                                        329.0,
                                        282.0,
                                        329.0,
                                        320.0,
                                        329.0,
                                        282.0,
                                        409.0,
                                        282.0,
                                        409.0,
                                        320.0,
                                        409.0,
                                        282.0,
                                        489.0,
                                        282.0,
                                        489.0,
                                        320.0,
                                        489.0,
                                        282.0,
                                        569.0,
                                        282.0,
                                        569.0,
                                        320.0,
                                        569.0,
                                        282.0,
                                        582.0,
                                        282.0,
                                        582.0,
                                        320.0,
                                        582.0,
                                        282.0,
                                        662.0,
                                        282.0,
                                        662.0,
                                        320.0,
                                        662.0,
                                        282.0,
                                        742.0,
                                        282.0,
                                        742.0,
                                        320.0,
                                        742.0,
                                        282.0,
                                        822.0,
                                        282.0,
                                        822.0,
                                        320.0,
                                        919.5,
                                        320.0
                                    ],
                                    "source": [
                                        "obj-39",
                                        11
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-29",
                                        0
                                    ],
                                    "midpoints": [
                                        299.5,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        299.5,
                                        180.0
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
                                        "obj-14",
                                        0
                                    ],
                                    "midpoints": [
                                        1070.0,
                                        317.0,
                                        1070.0,
                                        242.0,
                                        139.5,
                                        242.0
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
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        1078.0,
                                        317.0,
                                        1078.0,
                                        242.0,
                                        219.5,
                                        242.0
                                    ],
                                    "source": [
                                        "obj-41",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-16",
                                        0
                                    ],
                                    "midpoints": [
                                        1086.0,
                                        317.0,
                                        1086.0,
                                        242.0,
                                        299.5,
                                        242.0
                                    ],
                                    "source": [
                                        "obj-42",
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
                                        1094.0,
                                        317.0,
                                        1094.0,
                                        242.0,
                                        379.5,
                                        242.0
                                    ],
                                    "source": [
                                        "obj-43",
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
                                        1102.0,
                                        317.0,
                                        1102.0,
                                        242.0,
                                        459.5,
                                        242.0
                                    ],
                                    "source": [
                                        "obj-44",
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
                                        1110.0,
                                        317.0,
                                        1110.0,
                                        242.0,
                                        539.5,
                                        242.0
                                    ],
                                    "source": [
                                        "obj-45",
                                        0
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
                                        1118.0,
                                        317.0,
                                        1118.0,
                                        242.0,
                                        619.5,
                                        242.0
                                    ],
                                    "source": [
                                        "obj-46",
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
                                        1126.0,
                                        317.0,
                                        1126.0,
                                        242.0,
                                        699.5,
                                        242.0
                                    ],
                                    "source": [
                                        "obj-47",
                                        0
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
                                        1134.0,
                                        317.0,
                                        1134.0,
                                        242.0,
                                        779.5,
                                        242.0
                                    ],
                                    "source": [
                                        "obj-48",
                                        0
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
                                        1142.0,
                                        317.0,
                                        1142.0,
                                        242.0,
                                        859.5,
                                        242.0
                                    ],
                                    "source": [
                                        "obj-49",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-30",
                                        0
                                    ],
                                    "midpoints": [
                                        379.5,
                                        142.0,
                                        391.0,
                                        142.0,
                                        391.0,
                                        180.0,
                                        379.5,
                                        180.0
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
                                        "obj-24",
                                        0
                                    ],
                                    "midpoints": [
                                        1150.0,
                                        317.0,
                                        1150.0,
                                        242.0,
                                        939.5,
                                        242.0
                                    ],
                                    "source": [
                                        "obj-50",
                                        0
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
                                        1158.0,
                                        317.0,
                                        1158.0,
                                        242.0,
                                        1019.5,
                                        242.0
                                    ],
                                    "source": [
                                        "obj-51",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        459.5,
                                        142.0,
                                        471.0,
                                        142.0,
                                        471.0,
                                        180.0,
                                        459.5,
                                        180.0
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
                                        "obj-32",
                                        0
                                    ],
                                    "midpoints": [
                                        539.5,
                                        142.0,
                                        551.0,
                                        142.0,
                                        551.0,
                                        180.0,
                                        539.5,
                                        180.0
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
                                        "obj-33",
                                        0
                                    ],
                                    "midpoints": [
                                        619.5,
                                        142.0,
                                        631.0,
                                        142.0,
                                        631.0,
                                        180.0,
                                        619.5,
                                        180.0
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
                                        "obj-34",
                                        0
                                    ],
                                    "midpoints": [
                                        699.5,
                                        142.0,
                                        711.0,
                                        142.0,
                                        711.0,
                                        180.0,
                                        699.5,
                                        180.0
                                    ],
                                    "source": [
                                        "obj-9",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        1065.0,
                        131.0,
                        86.0,
                        22.0
                    ],
                    "text": "p degrees"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-87",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        955.0,
                        128.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        199.0,
                        42.0,
                        26.0,
                        18.0
                    ],
                    "text": "on",
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
                    "data": {
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
                                        "maxclass": "newobj",
                                        "text": "in 1",
                                        "patching_rect": [
                                            50.0,
                                            20.0,
                                            30.0,
                                            22.0
                                        ],
                                        "id": "obj-1",
                                        "fontsize": 12.0,
                                        "numinlets": 0,
                                        "fontname": "Arial",
                                        "numoutlets": 1,
                                        "outlettype": [
                                            ""
                                        ]
                                    }
                                },
                                {
                                    "box": {
                                        "maxclass": "newobj",
                                        "text": "in 2",
                                        "patching_rect": [
                                            130.0,
                                            20.0,
                                            30.0,
                                            22.0
                                        ],
                                        "id": "obj-2",
                                        "fontsize": 12.0,
                                        "numinlets": 0,
                                        "fontname": "Arial",
                                        "numoutlets": 1,
                                        "outlettype": [
                                            ""
                                        ]
                                    }
                                },
                                {
                                    "box": {
                                        "maxclass": "newobj",
                                        "text": "in 3",
                                        "patching_rect": [
                                            210.0,
                                            20.0,
                                            30.0,
                                            22.0
                                        ],
                                        "id": "obj-3",
                                        "fontsize": 12.0,
                                        "numinlets": 0,
                                        "fontname": "Arial",
                                        "numoutlets": 1,
                                        "outlettype": [
                                            ""
                                        ]
                                    }
                                },
                                {
                                    "box": {
                                        "maxclass": "codebox",
                                        "patching_rect": [
                                            50.0,
                                            80.0,
                                            400.0,
                                            200.0
                                        ],
                                        "id": "obj-4",
                                        "fontsize": 12.0,
                                        "numinlets": 3,
                                        "fontname": "<Monospaced>",
                                        "numoutlets": 1,
                                        "outlettype": [
                                            ""
                                        ],
                                        "fontface": 0,
                                        "code": "Param gaina(1.0, min=0, max=1);\nParam gainb(0.0, min=0, max=1);\nParam spacing(0., min=0, max=1);\nParam inversion(0.3, min=0, max=1);\nParam spacingratio(2., min=0.5, max=16.);\nParam inversionratio(0.5, min=0.03125, max=2.);\nParam spacingthresh(1., min=0., max=1.);\nParam inversionthresh(1., min=0., max=1.);\nParam lfoofs(0., min=0., max=6.2832);\nParam lforatea(0.5, min=0.01, max=20.);\nParam lfodeptha(0., min=0., max=1.);\nParam lforateb(0.5, min=0.01, max=20.);\nParam lfodepthb(0., min=0., max=1.);\nHistory phb(0);\nHistory phspc(0);\nHistory phinv(0);\nHistory phlfa(0);\nHistory phlfb(0);\nHistory sga(1.0);\nHistory sgb(0.0);\nHistory smix(0);\nHistory imix(0);\nBuffer wta(\"jiharmA\");\nBuffer wtb(\"jiharmB\");\n\n// dual morphing wavetable oscillator with spacing/inversion octave copies —\n// verbatim port of WavetableOscillator.h + WavetableVoice render/startNote\n// buffer layout: idx = mip*524288 + frame*2048 + sample (11 mips, 256 frames)\nf = max(in1, 0.);\n\n// v1.14 per-sub-voice LFOs: phases accumulate in lockstep across mc instances\n// (same rate history); per-instance random offset (lfoofs, root = 0) on top:\n// pos = clamp(basePos + sin(phase + ofs) * depth, 0, 1)\ntwopi = 6.28318530717959;\npla = wrap(phlfa + lforatea / samplerate, 0., 1.);\nphlfa = pla;\nplb = wrap(phlfb + lforateb / samplerate, 0., 1.);\nphlfb = plb;\nposa = clamp(in2 + sin(pla * twopi + lfoofs) * lfodeptha, 0., 1.);\nposb = clamp(in3 + sin(plb * twopi + lfoofs) * lfodepthb, 0., 1.);\n\n// spacing/inversion gates: live knob vs per-noteOn threshold, ~250 ms\n// one-pole crossfade (VST gainSmoothCoeff); baseMix = (1-s)(1-i)\nscoeff = 1. - exp(-1. / (0.25 * samplerate));\nsm = smix + ((spacing >= spacingthresh) - smix) * scoeff;\nsmix = sm;\nim = imix + ((inversion >= inversionthresh) - imix) * scoeff;\nimix = im;\nbasemix = (1. - sm) * (1. - im);\n\n// smoothed osc A/B gains (~20 ms), shared by all three groups\nga = sga + (gaina - sga) * 0.001;\nsga = ga;\ngb = sgb + (gainb - sgb) * 0.001;\nsgb = gb;\n\n// frame indices shared by all three groups (same modulated positions)\nfpa = posa * 255.;\nfa0 = floor(fpa);\nfa1 = min(fa0 + 1., 255.);\nffa = fpa - fa0;\nfpb = posb * 255.;\nfb0 = floor(fpb);\nfb1 = min(fb0 + 1., 255.);\nffb = fpb - fb0;\n\n// --- base group ---\nph = wrap(phb + f / samplerate, 0., 1.);\nphb = ph;\nlev = clamp(floor(log2(max(f, 1.) / 20.)), 0., 10.);\nmb = lev * 524288.;\nsp = ph * 2048.;\ns0 = floor(sp);\nsf = sp - s0;\ns1 = wrap(s0 + 1., 0., 2048.);\na00 = peek(wta, mb + fa0 * 2048. + s0, 0);\na01 = peek(wta, mb + fa0 * 2048. + s1, 0);\na10 = peek(wta, mb + fa1 * 2048. + s0, 0);\na11 = peek(wta, mb + fa1 * 2048. + s1, 0);\nla0 = a00 + sf * (a01 - a00);\nla1 = a10 + sf * (a11 - a10);\noa = la0 + ffa * (la1 - la0);\nb00 = peek(wtb, mb + fb0 * 2048. + s0, 0);\nb01 = peek(wtb, mb + fb0 * 2048. + s1, 0);\nb10 = peek(wtb, mb + fb1 * 2048. + s0, 0);\nb11 = peek(wtb, mb + fb1 * 2048. + s1, 0);\nlb0 = b00 + sf * (b01 - b00);\nlb1 = b10 + sf * (b11 - b10);\nob = lb0 + ffb * (lb1 - lb0);\ngbase = oa * ga + ob * gb;\n\n// --- spacing group (octave copies up, ratio rolled at noteOn) ---\nf2 = f * spacingratio;\nph2 = wrap(phspc + f2 / samplerate, 0., 1.);\nphspc = ph2;\nlev2 = clamp(floor(log2(max(f2, 1.) / 20.)), 0., 10.);\nmb2 = lev2 * 524288.;\nsp2 = ph2 * 2048.;\nt0 = floor(sp2);\ntf = sp2 - t0;\nt1 = wrap(t0 + 1., 0., 2048.);\nc00 = peek(wta, mb2 + fa0 * 2048. + t0, 0);\nc01 = peek(wta, mb2 + fa0 * 2048. + t1, 0);\nc10 = peek(wta, mb2 + fa1 * 2048. + t0, 0);\nc11 = peek(wta, mb2 + fa1 * 2048. + t1, 0);\nlc0 = c00 + tf * (c01 - c00);\nlc1 = c10 + tf * (c11 - c10);\noc = lc0 + ffa * (lc1 - lc0);\nd00 = peek(wtb, mb2 + fb0 * 2048. + t0, 0);\nd01 = peek(wtb, mb2 + fb0 * 2048. + t1, 0);\nd10 = peek(wtb, mb2 + fb1 * 2048. + t0, 0);\nd11 = peek(wtb, mb2 + fb1 * 2048. + t1, 0);\nld0 = d00 + tf * (d01 - d00);\nld1 = d10 + tf * (d11 - d10);\nod = ld0 + ffb * (ld1 - ld0);\ngspc = oc * ga + od * gb;\n\n// --- inversion group (octave copies down, ratio rolled at noteOn) ---\nf3 = f * inversionratio;\nph3 = wrap(phinv + f3 / samplerate, 0., 1.);\nphinv = ph3;\nlev3 = clamp(floor(log2(max(f3, 1.) / 20.)), 0., 10.);\nmb3 = lev3 * 524288.;\nsp3 = ph3 * 2048.;\nu0 = floor(sp3);\nuf = sp3 - u0;\nu1 = wrap(u0 + 1., 0., 2048.);\ne00 = peek(wta, mb3 + fa0 * 2048. + u0, 0);\ne01 = peek(wta, mb3 + fa0 * 2048. + u1, 0);\ne10 = peek(wta, mb3 + fa1 * 2048. + u0, 0);\ne11 = peek(wta, mb3 + fa1 * 2048. + u1, 0);\nle0 = e00 + uf * (e01 - e00);\nle1 = e10 + uf * (e11 - e10);\noe = le0 + ffa * (le1 - le0);\nv00 = peek(wtb, mb3 + fb0 * 2048. + u0, 0);\nv01 = peek(wtb, mb3 + fb0 * 2048. + u1, 0);\nv10 = peek(wtb, mb3 + fb1 * 2048. + u0, 0);\nv11 = peek(wtb, mb3 + fb1 * 2048. + u1, 0);\nlv0 = v00 + uf * (v01 - v00);\nlv1 = v10 + uf * (v11 - v10);\nov = lv0 + ffb * (lv1 - lv0);\nginv = oe * ga + ov * gb;\n\nout1 = gbase * basemix + gspc * sm + ginv * im;\n"
                                    }
                                },
                                {
                                    "box": {
                                        "maxclass": "newobj",
                                        "text": "out 1",
                                        "linecount": 2,
                                        "patching_rect": [
                                            50.0,
                                            320.0,
                                            30.0,
                                            22.0
                                        ],
                                        "id": "obj-5",
                                        "fontsize": 12.0,
                                        "numinlets": 1,
                                        "fontname": "Arial",
                                        "numoutlets": 0
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
                                            "obj-5",
                                            0
                                        ],
                                        "midpoints": [
                                            59.5,
                                            300.0,
                                            59.5,
                                            300.0
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
                                            "obj-4",
                                            2
                                        ],
                                        "midpoints": [
                                            219.5,
                                            61.0,
                                            440.5,
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
                                            "obj-4",
                                            1
                                        ],
                                        "midpoints": [
                                            139.5,
                                            12.0,
                                            202.0,
                                            12.0,
                                            202.0,
                                            50.0,
                                            250.0,
                                            50.0
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
                                            "obj-4",
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
                        }
                    },
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-88",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        885.0,
                        315.0,
                        121.0,
                        22.0
                    ],
                    "text": "mc.gen~",
                    "wrapper_uniquekey": "u309002165"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-89",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "bang"
                    ],
                    "patching_rect": [
                        1305.0,
                        240.0,
                        282.0,
                        22.0
                    ],
                    "text": "buffer~ jiharmA bank00-ji-harmonic.wav"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-90",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300.0,
                        213.0,
                        380.0,
                        20.0
                    ],
                    "text": "per-osc banks: 20 rendered WAVs (11 mipmaps x 256 frames x 2048)"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-91",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 4,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        ""
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "Position A (0-1)",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "Position B (0-1)",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "LFO Rate (Hz)",
                                    "id": "obj-3",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "LFO Depth (0-1)",
                                    "id": "obj-4",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        290.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "Position A signal",
                                    "id": "obj-5",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        50.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "Position B signal",
                                    "id": "obj-6",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        130.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        100.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 20"
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
                                        100.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 20"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        45.0,
                                        135.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        135.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-11",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        255.0,
                                        105.0,
                                        68.0,
                                        22.0
                                    ],
                                    "text": "cycle~"
                                }
                            },
                            {
                                "box": {
                                    "comment": "signal to cycle~",
                                    "id": "obj-15",
                                    "index": 5,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "signal to *~",
                                    "id": "obj-16",
                                    "index": 6,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "signal from cycle~",
                                    "id": "obj-19",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        210.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-20",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        185.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "lforatea $1"
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
                                        295.0,
                                        215.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "lfodeptha $1"
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
                                        380.0,
                                        185.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "lforateb $1"
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
                                        465.0,
                                        215.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "lfodepthb $1"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-24",
                                    "index": 4,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        285.0,
                                        255.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-25",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "float",
                                        "float"
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        300.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "trigger f f"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-7",
                                        0
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
                                        "obj-6",
                                        0
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
                                        "obj-19",
                                        0
                                    ],
                                    "midpoints": [
                                        264.5,
                                        142.0,
                                        247.0,
                                        142.0,
                                        247.0,
                                        180.0,
                                        219.5,
                                        180.0
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
                                        "obj-22",
                                        0
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
                                        "obj-23",
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
                                        "obj-8",
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
                                        "obj-24",
                                        0
                                    ],
                                    "source": [
                                        "obj-20",
                                        0
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
                                        "obj-21",
                                        0
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
                                        "obj-22",
                                        0
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
                                        "obj-23",
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
                                    "source": [
                                        "obj-25",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-20",
                                        0
                                    ],
                                    "source": [
                                        "obj-25",
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
                                    "source": [
                                        "obj-3",
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
                                    "source": [
                                        "obj-4",
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
                                        59.5,
                                        128.5,
                                        54.5,
                                        128.5
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
                                        "obj-10",
                                        0
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
                                        "obj-5",
                                        0
                                    ],
                                    "source": [
                                        "obj-9",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        1350.0,
                        315.0,
                        86.0,
                        22.0
                    ],
                    "text": "p wtctl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-92",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300.0,
                        350.0,
                        72.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        130.0,
                        72.0,
                        20.0
                    ],
                    "text": "wt pos A"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-93",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1395.0,
                        360.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        152.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-94",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300.0,
                        380.0,
                        72.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        390.0,
                        130.0,
                        72.0,
                        20.0
                    ],
                    "text": "wt pos B"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-95",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1395.0,
                        405.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        390.0,
                        152.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-96",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300.0,
                        410.0,
                        72.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        186.0,
                        72.0,
                        20.0
                    ],
                    "text": "lfo A rate"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-97",
                    "maxclass": "flonum",
                    "maximum": 20.0,
                    "minimum": 0.01,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1395.0,
                        450.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        208.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-98",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300.0,
                        440.0,
                        79.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        186.0,
                        72.0,
                        20.0
                    ],
                    "text": "lfo A depth"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-99",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1395.0,
                        495.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        208.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-100",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300.0,
                        470.0,
                        86.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        130.0,
                        72.0,
                        20.0
                    ],
                    "text": "osc gain A"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-101",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1395.0,
                        540.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        152.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-102",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300.0,
                        500.0,
                        86.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        470.0,
                        130.0,
                        72.0,
                        20.0
                    ],
                    "text": "osc gain B"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-103",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1395.0,
                        585.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        470.0,
                        152.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-104",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1480.0,
                        470.0,
                        72.0,
                        22.0
                    ],
                    "text": "gaina $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-105",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1480.0,
                        500.0,
                        72.0,
                        22.0
                    ],
                    "text": "gainb $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-106",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        1650.0,
                        315.0,
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
                    "id": "obj-107",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 16,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        1650.0,
                        360.0,
                        289.0,
                        22.0
                    ],
                    "text": "trigger b b b b b b b b b b b b b b b b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-108",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1650.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-109",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1710.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-110",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1770.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-111",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1830.0,
                        410.0,
                        44.0,
                        22.0
                    ],
                    "text": "0.25"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-112",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1890.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-113",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1950.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-114",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300.0,
                        185.0,
                        261.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        106.0,
                        260.0,
                        20.0
                    ],
                    "text": "WAVETABLE ENGINE (dual osc, 20 banks)"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-115",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        450.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend applyvalues"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-116",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        1245.0,
                        540.0,
                        135.0,
                        22.0
                    ],
                    "text": "mc.sig~ @chans 12"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-117",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        1245.0,
                        630.0,
                        184.0,
                        22.0
                    ],
                    "text": "mc.rampsmooth~ 2205 2205"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-118",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        1245.0,
                        585.0,
                        51.0,
                        22.0
                    ],
                    "text": "mc.*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-119",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        1245.0,
                        675.0,
                        164.0,
                        22.0
                    ],
                    "text": "mc.mixdown~ 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-120",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1095.0,
                        450.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-121",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1095.0,
                        495.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.1"
                }
            },
            {
                "box": {
                    "id": "obj-122",
                    "maxclass": "gain~",
                    "multichannelvariant": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        600.0,
                        525.0,
                        22.0,
                        140.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-123",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        630.0,
                        525.0,
                        15.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        672.0,
                        110.0,
                        15.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-124",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        840.0,
                        150.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        290.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-125",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        840.0,
                        120.0,
                        58.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        268.0,
                        72.0,
                        18.0
                    ],
                    "text": "spread",
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
                    "format": 6,
                    "id": "obj-126",
                    "maxclass": "flonum",
                    "maximum": 50.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        900.0,
                        165.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        290.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-127",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        902.0,
                        120.0,
                        79.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        268.0,
                        72.0,
                        18.0
                    ],
                    "text": "detune ct",
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
                    "format": 6,
                    "id": "obj-128",
                    "maxclass": "flonum",
                    "maximum": 100.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        960.0,
                        165.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        390.0,
                        290.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-129",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        964.0,
                        120.0,
                        79.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        390.0,
                        268.0,
                        72.0,
                        18.0
                    ],
                    "text": "timing ms",
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
                    "id": "obj-130",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        840.0,
                        95.0,
                        275.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        244.0,
                        260.0,
                        18.0
                    ],
                    "text": "CHORD FEEL (spread / detune / timing)",
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
                    "id": "obj-131",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "bang"
                    ],
                    "patching_rect": [
                        1305.0,
                        720.0,
                        282.0,
                        22.0
                    ],
                    "text": "buffer~ jiharmB bank00-ji-harmonic.wav"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-132",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1620.0,
                        218.0,
                        114.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        322.0,
                        100.0,
                        20.0
                    ],
                    "text": "bank A (osc A)"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-133",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1815.0,
                        218.0,
                        114.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        410.0,
                        322.0,
                        100.0,
                        20.0
                    ],
                    "text": "bank B (osc B)"
                }
            },
            {
                "box": {
                    "id": "obj-134",
                    "items": [
                        "bank00-ji-harmonic.wav",
                        ",",
                        "bank01-warm-analog.wav",
                        ",",
                        "bank02-choir.wav",
                        ",",
                        "bank03-strings.wav",
                        ",",
                        "bank04-glass.wav",
                        ",",
                        "bank05-evolving.wav",
                        ",",
                        "bank06-organ.wav",
                        ",",
                        "bank07-ethereal.wav",
                        ",",
                        "bank08-dark-matter.wav",
                        ",",
                        "bank09-sine.wav",
                        ",",
                        "bank10-square.wav",
                        ",",
                        "bank11-triangle.wav",
                        ",",
                        "bank12-spectral-cloud.wav",
                        ",",
                        "bank13-metallic-resonance.wav",
                        ",",
                        "bank14-formant-vowel.wav",
                        ",",
                        "bank15-warm-sub.wav",
                        ",",
                        "bank16-soft-flute.wav",
                        ",",
                        "bank17-velvet-pad.wav",
                        ",",
                        "bank18-whisper.wav",
                        ",",
                        "bank19-deep-haze.wav"
                    ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1620.0,
                        255.0,
                        185.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        344.0,
                        170.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-135",
                    "items": [
                        "bank00-ji-harmonic.wav",
                        ",",
                        "bank01-warm-analog.wav",
                        ",",
                        "bank02-choir.wav",
                        ",",
                        "bank03-strings.wav",
                        ",",
                        "bank04-glass.wav",
                        ",",
                        "bank05-evolving.wav",
                        ",",
                        "bank06-organ.wav",
                        ",",
                        "bank07-ethereal.wav",
                        ",",
                        "bank08-dark-matter.wav",
                        ",",
                        "bank09-sine.wav",
                        ",",
                        "bank10-square.wav",
                        ",",
                        "bank11-triangle.wav",
                        ",",
                        "bank12-spectral-cloud.wav",
                        ",",
                        "bank13-metallic-resonance.wav",
                        ",",
                        "bank14-formant-vowel.wav",
                        ",",
                        "bank15-warm-sub.wav",
                        ",",
                        "bank16-soft-flute.wav",
                        ",",
                        "bank17-velvet-pad.wav",
                        ",",
                        "bank18-whisper.wav",
                        ",",
                        "bank19-deep-haze.wav"
                    ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1815.0,
                        255.0,
                        185.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        410.0,
                        344.0,
                        170.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-136",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1620.0,
                        450.0,
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
                    "id": "obj-137",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1815.0,
                        300.0,
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
                    "id": "obj-138",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
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
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "newobj",
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
                                    "text": "in 2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "maxclass": "newobj",
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
                                    "text": "in 3"
                                }
                            },
                            {
                                "box": {
                                    "code": "Param cutoff(8000., min=20., max=20000.);\nParam res(0.707, min=0.5, max=10.);\nParam lfodepth(0., min=0., max=1.);\nParam veltofilt(0., min=0., max=1.);\nParam vel(1., min=0., max=1.);\nHistory smoothcut(8000.);\nHistory s1l(0.);\nHistory s2l(0.);\nHistory s1r(0.);\nHistory s2r(0.);\n\n// master TPT SVF lowpass -- verbatim port of the VST master-bus filter\n// (JUCE StateVariableTPTFilter, Zavalishin TPT structure)\n// in1/in2 = L/R post-envelope, in3 = LFO A signal (sin of phase A)\n\n// velocity mod (VST v2.2.0): cutoff * (1 - veltofilt * (1 - lastNoteVelocity))\n// then ~20 ms one-pole smoothing (VST uses a 20 ms linear ramp)\ntarget = cutoff * (1. - veltofilt * (1. - vel));\nsc = smoothcut + (target - smoothcut) * 0.001;\nsmoothcut = sc;\n\n// filter LFO (VST v2.2.0): cutoff * 2^(sin(phaseA) * depth * 2), clamped\nfc = clamp(sc * pow(2., in3 * lfodepth * 2.), 20., 20000.);\n\ng = tan(3.14159265358979 * fc / samplerate);\nr2 = 1. / res;\nh = 1. / (1. + r2 * g + g * g);\n\nhpl = h * (in1 - s1l * (g + r2) - s2l);\nbpl = hpl * g + s1l;\ns1l = hpl * g + bpl;\nlpl = bpl * g + s2l;\ns2l = bpl * g + lpl;\n\nhpr = h * (in2 - s1r * (g + r2) - s2r);\nbpr = hpr * g + s1r;\ns1r = hpr * g + bpr;\nlpr = bpr * g + s2r;\ns2r = bpr * g + lpr;\n\nout1 = lpl;\nout2 = lpr;\n",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "codebox",
                                    "numinlets": 3,
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
                                    ]
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
                                    "id": "obj-6",
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
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-4",
                                        0
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
                                        "obj-4",
                                        1
                                    ],
                                    "midpoints": [
                                        139.5,
                                        12.0,
                                        202.0,
                                        12.0,
                                        202.0,
                                        50.0,
                                        250.0,
                                        50.0
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
                                        2
                                    ],
                                    "midpoints": [
                                        219.5,
                                        61.0,
                                        440.5,
                                        61.0
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
                                    "midpoints": [
                                        440.5,
                                        300.0,
                                        139.5,
                                        300.0
                                    ],
                                    "source": [
                                        "obj-4",
                                        1
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
                        1480.0,
                        640.0,
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
                    "id": "obj-139",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        885.0,
                        520.0,
                        100.0,
                        22.0
                    ],
                    "text": "send~ jhFinL"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-140",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1095.0,
                        520.0,
                        100.0,
                        22.0
                    ],
                    "text": "send~ jhFinR"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-141",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1480.0,
                        590.0,
                        121.0,
                        22.0
                    ],
                    "text": "receive~ jhFinL"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-142",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1600.0,
                        590.0,
                        121.0,
                        22.0
                    ],
                    "text": "receive~ jhFinR"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-143",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1480.0,
                        720.0,
                        107.0,
                        22.0
                    ],
                    "text": "send~ jhFoutL"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-144",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1600.0,
                        720.0,
                        107.0,
                        22.0
                    ],
                    "text": "send~ jhFoutR"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-145",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        960.0,
                        445.0,
                        128.0,
                        22.0
                    ],
                    "text": "receive~ jhFoutL"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-146",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1160.0,
                        460.0,
                        128.0,
                        22.0
                    ],
                    "text": "receive~ jhFoutR"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-147",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        675.0,
                        360.0,
                        121.0,
                        22.0
                    ],
                    "text": "split 0.0001 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-148",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        675.0,
                        395.0,
                        58.0,
                        22.0
                    ],
                    "text": "vel $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-149",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1480.0,
                        540.0,
                        240.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        496.0,
                        200.0,
                        20.0
                    ],
                    "text": "FILTER (master TPT LP, post-env)"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-150",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1720.0,
                        570.0,
                        79.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        520.0,
                        76.0,
                        20.0
                    ],
                    "text": "cutoff Hz"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-151",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1815.0,
                        570.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        542.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-152",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1880.0,
                        570.0,
                        79.0,
                        22.0
                    ],
                    "text": "cutoff $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-153",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1720.0,
                        615.0,
                        79.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        95.0,
                        520.0,
                        76.0,
                        20.0
                    ],
                    "text": "resonance"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-154",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1815.0,
                        615.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        95.0,
                        542.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-155",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1880.0,
                        615.0,
                        58.0,
                        22.0
                    ],
                    "text": "res $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-156",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1720.0,
                        660.0,
                        114.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        175.0,
                        520.0,
                        76.0,
                        20.0
                    ],
                    "text": "filter lfo (A)"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-157",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1815.0,
                        660.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        175.0,
                        542.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-158",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1880.0,
                        660.0,
                        93.0,
                        22.0
                    ],
                    "text": "lfodepth $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-159",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1720.0,
                        705.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        255.0,
                        520.0,
                        76.0,
                        20.0
                    ],
                    "text": "vel > filter"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-160",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1815.0,
                        705.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        255.0,
                        542.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-161",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1880.0,
                        705.0,
                        100.0,
                        22.0
                    ],
                    "text": "veltofilt $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-162",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1720.0,
                        750.0,
                        86.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        335.0,
                        520.0,
                        76.0,
                        20.0
                    ],
                    "text": "lfo B rate"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-163",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1815.0,
                        750.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        335.0,
                        542.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-164",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1720.0,
                        795.0,
                        93.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        415.0,
                        520.0,
                        76.0,
                        20.0
                    ],
                    "text": "lfo B depth"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-165",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1815.0,
                        795.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        415.0,
                        542.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-166",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2010.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-167",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2070.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-168",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2130.0,
                        410.0,
                        51.0,
                        22.0
                    ],
                    "text": "8000."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-169",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2190.0,
                        410.0,
                        51.0,
                        22.0
                    ],
                    "text": "0.707"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-170",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2250.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-171",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2310.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-172",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        560.0,
                        360.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger f f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-173",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        650.0,
                        200.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        604.0,
                        76.0,
                        20.0
                    ],
                    "text": "atk ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-174",
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
                        650.0,
                        225.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        626.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-175",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        710.0,
                        200.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        95.0,
                        604.0,
                        76.0,
                        20.0
                    ],
                    "text": "dec ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-176",
                    "maxclass": "flonum",
                    "maximum": 5000.0,
                    "minimum": 10.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        710.0,
                        225.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        95.0,
                        626.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-177",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        770.0,
                        200.0,
                        40.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        175.0,
                        604.0,
                        76.0,
                        20.0
                    ],
                    "text": "sus"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-178",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        770.0,
                        225.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        175.0,
                        626.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-179",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        830.0,
                        200.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        255.0,
                        604.0,
                        76.0,
                        20.0
                    ],
                    "text": "rel ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-180",
                    "maxclass": "flonum",
                    "maximum": 10000.0,
                    "minimum": 10.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        830.0,
                        225.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        255.0,
                        626.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-181",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2370.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "10."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-182",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2430.0,
                        410.0,
                        44.0,
                        22.0
                    ],
                    "text": "150."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-183",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2490.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.7"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-184",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2550.0,
                        410.0,
                        44.0,
                        22.0
                    ],
                    "text": "400."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-185",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        650.0,
                        178.0,
                        73.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        580.0,
                        200.0,
                        20.0
                    ],
                    "text": "ENVELOPE"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-186",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020.0,
                        120.0,
                        58.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        470.0,
                        268.0,
                        72.0,
                        18.0
                    ],
                    "text": "spacing",
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
                    "id": "obj-187",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1080.0,
                        120.0,
                        66.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        550.0,
                        268.0,
                        72.0,
                        18.0
                    ],
                    "text": "inversion",
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
                    "format": 6,
                    "id": "obj-188",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1020.0,
                        165.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        470.0,
                        290.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-189",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1080.0,
                        165.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        550.0,
                        290.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-190",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1020.0,
                        195.0,
                        86.0,
                        22.0
                    ],
                    "text": "spacing $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-191",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1140.0,
                        195.0,
                        100.0,
                        22.0
                    ],
                    "text": "inversion $1"
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-192",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1605.0,
                        30.0,
                        150.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        96.0,
                        376.0,
                        128.0,
                        22.0
                    ],
                    "items": [
                        "Custom (harm 16-30)",
                        ",",
                        "12-TET",
                        ",",
                        "Pythagorean",
                        ",",
                        "Zarlino (Just Major)",
                        ",",
                        "Meantone 1/4",
                        ",",
                        "Werckmeister III",
                        ",",
                        "Kirnberger III",
                        ",",
                        "Vallotti",
                        ",",
                        "Well Tempered",
                        ",",
                        "Just Intonation",
                        ",",
                        "Bohlen-Pierce"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-193",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1605.0,
                        5.0,
                        93.0,
                        20.0
                    ],
                    "text": "temperament",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        378.0,
                        78.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-194",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1605.0,
                        75.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend temperament",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-195",
                    "numinlets": 1,
                    "numoutlets": 12,
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
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1455.0,
                        195.0,
                        86.0,
                        22.0
                    ],
                    "text": "p ratioset",
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
                                    "comment": "[degree, ratiotext] from js outlet 6"
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
                                        30.0,
                                        225.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-3",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        120.0,
                                        225.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": ""
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
                                        210.0,
                                        225.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-5",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        300.0,
                                        225.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-6",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        390.0,
                                        225.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-7",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        480.0,
                                        225.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-8",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        570.0,
                                        225.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": ""
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
                                        660.0,
                                        225.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": ""
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
                                        750.0,
                                        225.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": ""
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
                                        840.0,
                                        225.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": ""
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
                                        930.0,
                                        225.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": ""
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
                                        1020.0,
                                        225.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-14",
                                    "numinlets": 1,
                                    "numoutlets": 13,
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
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "route 0 1 2 3 4 5 6 7 8 9 10 11",
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        150.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend set",
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
                                        120.0,
                                        195.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend set",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-17",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        150.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend set",
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
                                        300.0,
                                        195.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend set",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-19",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        390.0,
                                        150.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend set",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-20",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        195.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend set",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-21",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        150.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend set",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-22",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        195.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend set",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-23",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        750.0,
                                        150.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend set",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-24",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        840.0,
                                        195.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend set",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-25",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        150.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend set",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-26",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1020.0,
                                        195.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend set",
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
                                        "obj-14",
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
                                        "obj-15",
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
                                        "obj-14",
                                        1
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
                                        "obj-14",
                                        2
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
                                        "obj-17",
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
                                        "obj-14",
                                        3
                                    ],
                                    "destination": [
                                        "obj-18",
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
                                        "obj-5",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-14",
                                        4
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
                                        "obj-19",
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
                                        "obj-14",
                                        5
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
                                        "obj-20",
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
                                        "obj-14",
                                        6
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
                                        "obj-8",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-14",
                                        7
                                    ],
                                    "destination": [
                                        "obj-22",
                                        0
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
                                        "obj-9",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-14",
                                        8
                                    ],
                                    "destination": [
                                        "obj-23",
                                        0
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
                                        "obj-10",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-14",
                                        9
                                    ],
                                    "destination": [
                                        "obj-24",
                                        0
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
                                        "obj-11",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-14",
                                        10
                                    ],
                                    "destination": [
                                        "obj-25",
                                        0
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
                                        "obj-12",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-14",
                                        11
                                    ],
                                    "destination": [
                                        "obj-26",
                                        0
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
                                        "obj-13",
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
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        1
                    ],
                    "midpoints": [
                        59.0,
                        22.0,
                        97.0,
                        22.0,
                        97.0,
                        60.0,
                        97.0,
                        82.0,
                        127.0,
                        82.0,
                        127.0,
                        151.0,
                        213.5,
                        151.0
                    ],
                    "source": [
                        "obj-1",
                        1
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
                        22.0,
                        97.0,
                        22.0,
                        97.0,
                        60.0,
                        97.0,
                        82.0,
                        127.0,
                        82.0,
                        127.0,
                        151.0,
                        144.5,
                        151.0
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
                        "obj-104",
                        0
                    ],
                    "midpoints": [
                        3451.0,
                        567.0,
                        3451.0,
                        462.0,
                        1489.5,
                        462.0
                    ],
                    "source": [
                        "obj-101",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-105",
                        0
                    ],
                    "midpoints": [
                        3459.0,
                        612.0,
                        3459.0,
                        492.0,
                        1489.5,
                        492.0
                    ],
                    "source": [
                        "obj-103",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-88",
                        0
                    ],
                    "midpoints": [
                        3403.0,
                        497.0,
                        3403.0,
                        307.0,
                        894.5,
                        307.0
                    ],
                    "source": [
                        "obj-104",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-88",
                        0
                    ],
                    "midpoints": [
                        3411.0,
                        527.0,
                        3411.0,
                        307.0,
                        894.5,
                        307.0
                    ],
                    "source": [
                        "obj-105",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-107",
                        0
                    ],
                    "midpoints": [
                        1659.5,
                        348.5,
                        1659.5,
                        348.5
                    ],
                    "source": [
                        "obj-106",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-108",
                        0
                    ],
                    "source": [
                        "obj-107",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-109",
                        0
                    ],
                    "midpoints": [
                        1677.5,
                        402.0,
                        1698.0,
                        402.0,
                        1698.0,
                        440.0,
                        1719.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-110",
                        0
                    ],
                    "midpoints": [
                        1695.5,
                        402.0,
                        1698.0,
                        402.0,
                        1698.0,
                        440.0,
                        1698.0,
                        402.0,
                        1758.0,
                        402.0,
                        1758.0,
                        440.0,
                        1779.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-111",
                        0
                    ],
                    "midpoints": [
                        1713.5,
                        402.0,
                        1758.0,
                        402.0,
                        1758.0,
                        440.0,
                        1758.0,
                        402.0,
                        1762.0,
                        402.0,
                        1762.0,
                        440.0,
                        1839.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-112",
                        0
                    ],
                    "midpoints": [
                        1731.5,
                        402.0,
                        1758.0,
                        402.0,
                        1758.0,
                        440.0,
                        1758.0,
                        402.0,
                        1818.0,
                        402.0,
                        1818.0,
                        440.0,
                        1818.0,
                        402.0,
                        1822.0,
                        402.0,
                        1822.0,
                        440.0,
                        1899.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-113",
                        0
                    ],
                    "midpoints": [
                        1749.5,
                        402.0,
                        1758.0,
                        402.0,
                        1758.0,
                        440.0,
                        1758.0,
                        402.0,
                        1818.0,
                        402.0,
                        1818.0,
                        440.0,
                        1818.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1959.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-166",
                        0
                    ],
                    "midpoints": [
                        1767.5,
                        402.0,
                        1818.0,
                        402.0,
                        1818.0,
                        440.0,
                        1818.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1942.0,
                        402.0,
                        1942.0,
                        440.0,
                        2019.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-167",
                        0
                    ],
                    "midpoints": [
                        1785.5,
                        402.0,
                        1818.0,
                        402.0,
                        1818.0,
                        440.0,
                        1818.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1942.0,
                        402.0,
                        1942.0,
                        440.0,
                        1942.0,
                        402.0,
                        2002.0,
                        402.0,
                        2002.0,
                        440.0,
                        2079.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-168",
                        0
                    ],
                    "midpoints": [
                        1803.5,
                        402.0,
                        1818.0,
                        402.0,
                        1818.0,
                        440.0,
                        1818.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2002.0,
                        402.0,
                        2002.0,
                        440.0,
                        2002.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2139.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-169",
                        0
                    ],
                    "midpoints": [
                        1821.5,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2002.0,
                        402.0,
                        2002.0,
                        440.0,
                        2002.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2199.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-170",
                        0
                    ],
                    "midpoints": [
                        1839.5,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2058.0,
                        402.0,
                        2058.0,
                        440.0,
                        2058.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2122.0,
                        402.0,
                        2182.0,
                        402.0,
                        2182.0,
                        440.0,
                        2259.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-171",
                        0
                    ],
                    "midpoints": [
                        1857.5,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2058.0,
                        402.0,
                        2058.0,
                        440.0,
                        2058.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2122.0,
                        402.0,
                        2182.0,
                        402.0,
                        2182.0,
                        440.0,
                        2182.0,
                        402.0,
                        2242.0,
                        402.0,
                        2242.0,
                        440.0,
                        2319.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        11
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-181",
                        0
                    ],
                    "midpoints": [
                        1875.5,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2058.0,
                        402.0,
                        2058.0,
                        440.0,
                        2058.0,
                        402.0,
                        2118.0,
                        402.0,
                        2118.0,
                        440.0,
                        2118.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2122.0,
                        402.0,
                        2182.0,
                        402.0,
                        2182.0,
                        440.0,
                        2182.0,
                        402.0,
                        2242.0,
                        402.0,
                        2242.0,
                        440.0,
                        2242.0,
                        402.0,
                        2302.0,
                        402.0,
                        2302.0,
                        440.0,
                        2379.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        12
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-182",
                        0
                    ],
                    "midpoints": [
                        1893.5,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2058.0,
                        402.0,
                        2058.0,
                        440.0,
                        2058.0,
                        402.0,
                        2118.0,
                        402.0,
                        2118.0,
                        440.0,
                        2118.0,
                        402.0,
                        2189.0,
                        402.0,
                        2189.0,
                        440.0,
                        2189.0,
                        402.0,
                        2182.0,
                        402.0,
                        2182.0,
                        440.0,
                        2182.0,
                        402.0,
                        2242.0,
                        402.0,
                        2242.0,
                        440.0,
                        2242.0,
                        402.0,
                        2302.0,
                        402.0,
                        2302.0,
                        440.0,
                        2302.0,
                        402.0,
                        2362.0,
                        402.0,
                        2362.0,
                        440.0,
                        2439.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        13
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-183",
                        0
                    ],
                    "midpoints": [
                        1911.5,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2058.0,
                        402.0,
                        2058.0,
                        440.0,
                        2058.0,
                        402.0,
                        2118.0,
                        402.0,
                        2118.0,
                        440.0,
                        2118.0,
                        402.0,
                        2189.0,
                        402.0,
                        2189.0,
                        440.0,
                        2189.0,
                        402.0,
                        2182.0,
                        402.0,
                        2182.0,
                        440.0,
                        2182.0,
                        402.0,
                        2242.0,
                        402.0,
                        2242.0,
                        440.0,
                        2242.0,
                        402.0,
                        2302.0,
                        402.0,
                        2302.0,
                        440.0,
                        2302.0,
                        402.0,
                        2362.0,
                        402.0,
                        2362.0,
                        440.0,
                        2362.0,
                        402.0,
                        2422.0,
                        402.0,
                        2422.0,
                        440.0,
                        2499.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        14
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-184",
                        0
                    ],
                    "midpoints": [
                        1929.5,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2058.0,
                        402.0,
                        2058.0,
                        440.0,
                        2058.0,
                        402.0,
                        2118.0,
                        402.0,
                        2118.0,
                        440.0,
                        2118.0,
                        402.0,
                        2189.0,
                        402.0,
                        2189.0,
                        440.0,
                        2189.0,
                        402.0,
                        2249.0,
                        402.0,
                        2249.0,
                        440.0,
                        2249.0,
                        402.0,
                        2242.0,
                        402.0,
                        2242.0,
                        440.0,
                        2242.0,
                        402.0,
                        2302.0,
                        402.0,
                        2302.0,
                        440.0,
                        2302.0,
                        402.0,
                        2362.0,
                        402.0,
                        2362.0,
                        440.0,
                        2362.0,
                        402.0,
                        2422.0,
                        402.0,
                        2422.0,
                        440.0,
                        2422.0,
                        402.0,
                        2482.0,
                        402.0,
                        2482.0,
                        440.0,
                        2559.5,
                        440.0
                    ],
                    "source": [
                        "obj-107",
                        15
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-93",
                        0
                    ],
                    "midpoints": [
                        3435.0,
                        437.0,
                        3435.0,
                        352.0,
                        1404.5,
                        352.0
                    ],
                    "source": [
                        "obj-108",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-95",
                        0
                    ],
                    "midpoints": [
                        1719.5,
                        402.0,
                        1642.0,
                        402.0,
                        1642.0,
                        440.0,
                        1404.5,
                        440.0
                    ],
                    "source": [
                        "obj-109",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-15",
                        3
                    ],
                    "midpoints": [
                        675.5,
                        142.0,
                        662.0,
                        142.0,
                        662.0,
                        180.0,
                        662.0,
                        170.0,
                        642.0,
                        170.0,
                        642.0,
                        206.0,
                        638.2142857142857,
                        206.0
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
                        "obj-97",
                        0
                    ],
                    "midpoints": [
                        1779.5,
                        402.0,
                        1642.0,
                        402.0,
                        1642.0,
                        440.0,
                        1642.0,
                        402.0,
                        1702.0,
                        402.0,
                        1702.0,
                        440.0,
                        1702.0,
                        442.0,
                        1612.0,
                        442.0,
                        1612.0,
                        480.0,
                        1404.5,
                        480.0
                    ],
                    "source": [
                        "obj-110",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-99",
                        0
                    ],
                    "midpoints": [
                        1839.5,
                        402.0,
                        1642.0,
                        402.0,
                        1642.0,
                        440.0,
                        1642.0,
                        402.0,
                        1702.0,
                        402.0,
                        1702.0,
                        440.0,
                        1702.0,
                        402.0,
                        1762.0,
                        402.0,
                        1762.0,
                        440.0,
                        1762.0,
                        442.0,
                        1453.0,
                        442.0,
                        1453.0,
                        480.0,
                        1453.0,
                        442.0,
                        1612.0,
                        442.0,
                        1612.0,
                        480.0,
                        1612.0,
                        462.0,
                        1560.0,
                        462.0,
                        1560.0,
                        500.0,
                        1404.5,
                        500.0
                    ],
                    "source": [
                        "obj-111",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-101",
                        0
                    ],
                    "midpoints": [
                        1899.5,
                        402.0,
                        1642.0,
                        402.0,
                        1642.0,
                        440.0,
                        1642.0,
                        402.0,
                        1702.0,
                        402.0,
                        1702.0,
                        440.0,
                        1702.0,
                        402.0,
                        1762.0,
                        402.0,
                        1762.0,
                        440.0,
                        1762.0,
                        402.0,
                        1822.0,
                        402.0,
                        1822.0,
                        440.0,
                        1822.0,
                        442.0,
                        1453.0,
                        442.0,
                        1453.0,
                        480.0,
                        1453.0,
                        442.0,
                        1612.0,
                        442.0,
                        1612.0,
                        480.0,
                        1612.0,
                        462.0,
                        1560.0,
                        462.0,
                        1560.0,
                        500.0,
                        1560.0,
                        487.0,
                        1453.0,
                        487.0,
                        1453.0,
                        525.0,
                        1453.0,
                        492.0,
                        1560.0,
                        492.0,
                        1560.0,
                        530.0,
                        1560.0,
                        532.0,
                        1728.0,
                        532.0,
                        1728.0,
                        568.0,
                        1404.5,
                        568.0
                    ],
                    "source": [
                        "obj-112",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-103",
                        0
                    ],
                    "midpoints": [
                        1959.5,
                        402.0,
                        1698.0,
                        402.0,
                        1698.0,
                        440.0,
                        1698.0,
                        402.0,
                        1702.0,
                        402.0,
                        1702.0,
                        440.0,
                        1702.0,
                        402.0,
                        1762.0,
                        402.0,
                        1762.0,
                        440.0,
                        1762.0,
                        402.0,
                        1822.0,
                        402.0,
                        1822.0,
                        440.0,
                        1822.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        442.0,
                        1453.0,
                        442.0,
                        1453.0,
                        480.0,
                        1453.0,
                        442.0,
                        1749.0,
                        442.0,
                        1749.0,
                        480.0,
                        1749.0,
                        462.0,
                        1560.0,
                        462.0,
                        1560.0,
                        500.0,
                        1560.0,
                        487.0,
                        1453.0,
                        487.0,
                        1453.0,
                        525.0,
                        1453.0,
                        492.0,
                        1560.0,
                        492.0,
                        1560.0,
                        530.0,
                        1560.0,
                        532.0,
                        1453.0,
                        532.0,
                        1453.0,
                        570.0,
                        1453.0,
                        532.0,
                        1728.0,
                        532.0,
                        1728.0,
                        568.0,
                        1728.0,
                        562.0,
                        1712.0,
                        562.0,
                        1712.0,
                        598.0,
                        1712.0,
                        562.0,
                        1807.0,
                        562.0,
                        1807.0,
                        600.0,
                        1807.0,
                        562.0,
                        1872.0,
                        562.0,
                        1872.0,
                        600.0,
                        1404.5,
                        600.0
                    ],
                    "source": [
                        "obj-113",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-116",
                        0
                    ],
                    "midpoints": [
                        129.5,
                        442.0,
                        877.0,
                        442.0,
                        877.0,
                        480.0,
                        877.0,
                        442.0,
                        1087.0,
                        442.0,
                        1087.0,
                        480.0,
                        1087.0,
                        452.0,
                        1152.0,
                        452.0,
                        1152.0,
                        490.0,
                        1152.0,
                        462.0,
                        1292.0,
                        462.0,
                        1292.0,
                        498.0,
                        1292.0,
                        472.0,
                        892.0,
                        472.0,
                        892.0,
                        510.0,
                        892.0,
                        487.0,
                        1087.0,
                        487.0,
                        1087.0,
                        525.0,
                        1087.0,
                        492.0,
                        1292.0,
                        492.0,
                        1292.0,
                        528.0,
                        1292.0,
                        512.0,
                        877.0,
                        512.0,
                        877.0,
                        550.0,
                        877.0,
                        512.0,
                        1087.0,
                        512.0,
                        1087.0,
                        550.0,
                        1087.0,
                        517.0,
                        570.0,
                        517.0,
                        570.0,
                        673.0,
                        570.0,
                        517.0,
                        593.0,
                        517.0,
                        593.0,
                        633.0,
                        593.0,
                        517.0,
                        630.0,
                        517.0,
                        630.0,
                        673.0,
                        630.0,
                        517.0,
                        653.0,
                        517.0,
                        653.0,
                        633.0,
                        1254.5,
                        633.0
                    ],
                    "source": [
                        "obj-115",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-117",
                        0
                    ],
                    "midpoints": [
                        1254.5,
                        577.0,
                        1304.0,
                        577.0,
                        1304.0,
                        615.0,
                        1254.5,
                        615.0
                    ],
                    "source": [
                        "obj-116",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-118",
                        1
                    ],
                    "midpoints": [
                        3467.0,
                        657.0,
                        3467.0,
                        577.0,
                        1286.5,
                        577.0
                    ],
                    "source": [
                        "obj-117",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-119",
                        0
                    ],
                    "midpoints": [
                        1254.5,
                        622.0,
                        1237.0,
                        622.0,
                        1237.0,
                        660.0,
                        1254.5,
                        660.0
                    ],
                    "source": [
                        "obj-118",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-120",
                        0
                    ],
                    "midpoints": [
                        3443.0,
                        702.0,
                        3443.0,
                        442.0,
                        1104.5,
                        442.0
                    ],
                    "source": [
                        "obj-119",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-140",
                        0
                    ],
                    "midpoints": [
                        1104.5,
                        487.0,
                        1161.0,
                        487.0,
                        1161.0,
                        525.0,
                        1104.5,
                        525.0
                    ],
                    "source": [
                        "obj-120",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-122",
                        0
                    ],
                    "midpoints": [
                        1104.5,
                        512.0,
                        877.0,
                        512.0,
                        877.0,
                        550.0,
                        877.0,
                        512.0,
                        1087.0,
                        512.0,
                        1087.0,
                        550.0,
                        1087.0,
                        517.0,
                        653.0,
                        517.0,
                        653.0,
                        633.0,
                        609.5,
                        633.0
                    ],
                    "source": [
                        "obj-121",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-123",
                        0
                    ],
                    "midpoints": [
                        652.0,
                        670.0,
                        652.0,
                        517.0,
                        639.0,
                        517.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-122",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-67",
                        1
                    ],
                    "midpoints": [
                        609.5,
                        517.0,
                        570.0,
                        517.0,
                        570.0,
                        673.0,
                        560.5,
                        673.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-122",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-15",
                        5
                    ],
                    "midpoints": [
                        849.5,
                        142.0,
                        662.0,
                        142.0,
                        662.0,
                        180.0,
                        662.0,
                        142.0,
                        724.0,
                        142.0,
                        724.0,
                        180.0,
                        724.0,
                        142.0,
                        720.0,
                        142.0,
                        720.0,
                        180.0,
                        720.0,
                        170.0,
                        730.0,
                        170.0,
                        730.0,
                        206.0,
                        657.3571428571429,
                        206.0
                    ],
                    "source": [
                        "obj-124",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-15",
                        6
                    ],
                    "midpoints": [
                        909.5,
                        170.0,
                        730.0,
                        170.0,
                        730.0,
                        206.0,
                        666.9285714285714,
                        206.0
                    ],
                    "source": [
                        "obj-126",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-15",
                        7
                    ],
                    "midpoints": [
                        969.5,
                        157.0,
                        892.0,
                        157.0,
                        892.0,
                        195.0,
                        892.0,
                        170.0,
                        730.0,
                        170.0,
                        730.0,
                        206.0,
                        676.5,
                        206.0
                    ],
                    "source": [
                        "obj-128",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-15",
                        4
                    ],
                    "midpoints": [
                        737.5,
                        142.0,
                        662.0,
                        142.0,
                        662.0,
                        180.0,
                        662.0,
                        142.0,
                        724.0,
                        142.0,
                        724.0,
                        180.0,
                        724.0,
                        170.0,
                        730.0,
                        170.0,
                        730.0,
                        206.0,
                        647.7857142857143,
                        206.0
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
                        "obj-136",
                        0
                    ],
                    "midpoints": [
                        1712.5,
                        307.0,
                        1730.0,
                        307.0,
                        1730.0,
                        345.0,
                        1730.0,
                        352.0,
                        1642.0,
                        352.0,
                        1642.0,
                        390.0,
                        1642.0,
                        402.0,
                        1698.0,
                        402.0,
                        1698.0,
                        440.0,
                        1698.0,
                        402.0,
                        1702.0,
                        402.0,
                        1702.0,
                        440.0,
                        1629.5,
                        440.0
                    ],
                    "source": [
                        "obj-134",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-137",
                        0
                    ],
                    "midpoints": [
                        1907.5,
                        288.5,
                        1824.5,
                        288.5
                    ],
                    "source": [
                        "obj-135",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-89",
                        0
                    ],
                    "midpoints": [
                        3355.0,
                        477.0,
                        3355.0,
                        232.0,
                        1314.5,
                        232.0
                    ],
                    "source": [
                        "obj-136",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-131",
                        0
                    ],
                    "midpoints": [
                        1824.5,
                        307.0,
                        1642.0,
                        307.0,
                        1642.0,
                        345.0,
                        1642.0,
                        352.0,
                        1453.0,
                        352.0,
                        1453.0,
                        390.0,
                        1453.0,
                        352.0,
                        1642.0,
                        352.0,
                        1642.0,
                        390.0,
                        1642.0,
                        397.0,
                        1453.0,
                        397.0,
                        1453.0,
                        435.0,
                        1453.0,
                        402.0,
                        1642.0,
                        402.0,
                        1642.0,
                        440.0,
                        1642.0,
                        402.0,
                        1702.0,
                        402.0,
                        1702.0,
                        440.0,
                        1702.0,
                        402.0,
                        1762.0,
                        402.0,
                        1762.0,
                        440.0,
                        1762.0,
                        402.0,
                        1822.0,
                        402.0,
                        1822.0,
                        440.0,
                        1822.0,
                        442.0,
                        1453.0,
                        442.0,
                        1453.0,
                        480.0,
                        1453.0,
                        442.0,
                        1612.0,
                        442.0,
                        1612.0,
                        480.0,
                        1612.0,
                        462.0,
                        1560.0,
                        462.0,
                        1560.0,
                        500.0,
                        1560.0,
                        487.0,
                        1453.0,
                        487.0,
                        1453.0,
                        525.0,
                        1453.0,
                        492.0,
                        1560.0,
                        492.0,
                        1560.0,
                        530.0,
                        1560.0,
                        532.0,
                        1453.0,
                        532.0,
                        1453.0,
                        570.0,
                        1453.0,
                        532.0,
                        1728.0,
                        532.0,
                        1728.0,
                        568.0,
                        1728.0,
                        562.0,
                        1712.0,
                        562.0,
                        1712.0,
                        598.0,
                        1712.0,
                        562.0,
                        1807.0,
                        562.0,
                        1807.0,
                        600.0,
                        1807.0,
                        562.0,
                        1872.0,
                        562.0,
                        1872.0,
                        600.0,
                        1872.0,
                        577.0,
                        1453.0,
                        577.0,
                        1453.0,
                        615.0,
                        1453.0,
                        582.0,
                        1609.0,
                        582.0,
                        1609.0,
                        620.0,
                        1609.0,
                        582.0,
                        1729.0,
                        582.0,
                        1729.0,
                        620.0,
                        1729.0,
                        607.0,
                        1712.0,
                        607.0,
                        1712.0,
                        643.0,
                        1712.0,
                        607.0,
                        1807.0,
                        607.0,
                        1807.0,
                        645.0,
                        1807.0,
                        607.0,
                        1872.0,
                        607.0,
                        1872.0,
                        645.0,
                        1872.0,
                        632.0,
                        1609.0,
                        632.0,
                        1609.0,
                        670.0,
                        1609.0,
                        652.0,
                        1712.0,
                        652.0,
                        1712.0,
                        688.0,
                        1712.0,
                        652.0,
                        1807.0,
                        652.0,
                        1807.0,
                        690.0,
                        1807.0,
                        652.0,
                        1872.0,
                        652.0,
                        1872.0,
                        690.0,
                        1872.0,
                        697.0,
                        1712.0,
                        697.0,
                        1712.0,
                        733.0,
                        1712.0,
                        697.0,
                        1807.0,
                        697.0,
                        1807.0,
                        735.0,
                        1807.0,
                        697.0,
                        1872.0,
                        697.0,
                        1872.0,
                        735.0,
                        1872.0,
                        712.0,
                        1595.0,
                        712.0,
                        1595.0,
                        750.0,
                        1595.0,
                        712.0,
                        1715.0,
                        712.0,
                        1715.0,
                        750.0,
                        1314.5,
                        750.0
                    ],
                    "source": [
                        "obj-137",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-143",
                        0
                    ],
                    "midpoints": [
                        1489.5,
                        712.0,
                        1595.0,
                        712.0,
                        1595.0,
                        750.0,
                        1489.5,
                        750.0
                    ],
                    "source": [
                        "obj-138",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-144",
                        0
                    ],
                    "midpoints": [
                        1591.5,
                        712.0,
                        1595.0,
                        712.0,
                        1595.0,
                        750.0,
                        1595.0,
                        712.0,
                        1595.0,
                        712.0,
                        1595.0,
                        750.0,
                        1609.5,
                        750.0
                    ],
                    "source": [
                        "obj-138",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        1489.5,
                        626.0,
                        1489.5,
                        626.0
                    ],
                    "source": [
                        "obj-141",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-138",
                        1
                    ],
                    "midpoints": [
                        1609.5,
                        582.0,
                        1609.0,
                        582.0,
                        1609.0,
                        620.0,
                        1540.5,
                        620.0
                    ],
                    "source": [
                        "obj-142",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-64",
                        0
                    ],
                    "midpoints": [
                        969.5,
                        442.0,
                        935.0,
                        442.0,
                        935.0,
                        480.0,
                        909.5,
                        480.0
                    ],
                    "source": [
                        "obj-145",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-121",
                        0
                    ],
                    "midpoints": [
                        1169.5,
                        488.5,
                        1104.5,
                        488.5
                    ],
                    "source": [
                        "obj-146",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-148",
                        0
                    ],
                    "source": [
                        "obj-147",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        684.5,
                        397.0,
                        1027.0,
                        397.0,
                        1027.0,
                        435.0,
                        1027.0,
                        397.0,
                        1387.0,
                        397.0,
                        1387.0,
                        435.0,
                        1387.0,
                        402.0,
                        1292.0,
                        402.0,
                        1292.0,
                        438.0,
                        1292.0,
                        432.0,
                        1292.0,
                        432.0,
                        1292.0,
                        468.0,
                        1292.0,
                        437.0,
                        1096.0,
                        437.0,
                        1096.0,
                        475.0,
                        1096.0,
                        442.0,
                        935.0,
                        442.0,
                        935.0,
                        480.0,
                        935.0,
                        442.0,
                        1387.0,
                        442.0,
                        1387.0,
                        480.0,
                        1387.0,
                        442.0,
                        1087.0,
                        442.0,
                        1087.0,
                        480.0,
                        1087.0,
                        452.0,
                        1152.0,
                        452.0,
                        1152.0,
                        490.0,
                        1152.0,
                        462.0,
                        1292.0,
                        462.0,
                        1292.0,
                        498.0,
                        1292.0,
                        462.0,
                        1472.0,
                        462.0,
                        1472.0,
                        500.0,
                        1472.0,
                        472.0,
                        966.0,
                        472.0,
                        966.0,
                        510.0,
                        966.0,
                        487.0,
                        1387.0,
                        487.0,
                        1387.0,
                        525.0,
                        1387.0,
                        487.0,
                        1087.0,
                        487.0,
                        1087.0,
                        525.0,
                        1087.0,
                        492.0,
                        1292.0,
                        492.0,
                        1292.0,
                        528.0,
                        1292.0,
                        492.0,
                        1472.0,
                        492.0,
                        1472.0,
                        530.0,
                        1472.0,
                        512.0,
                        993.0,
                        512.0,
                        993.0,
                        550.0,
                        993.0,
                        512.0,
                        1087.0,
                        512.0,
                        1087.0,
                        550.0,
                        1087.0,
                        532.0,
                        1387.0,
                        532.0,
                        1387.0,
                        570.0,
                        1387.0,
                        532.0,
                        1237.0,
                        532.0,
                        1237.0,
                        570.0,
                        1237.0,
                        532.0,
                        1472.0,
                        532.0,
                        1472.0,
                        568.0,
                        1472.0,
                        577.0,
                        1387.0,
                        577.0,
                        1387.0,
                        615.0,
                        1387.0,
                        577.0,
                        1237.0,
                        577.0,
                        1237.0,
                        615.0,
                        1237.0,
                        582.0,
                        1472.0,
                        582.0,
                        1472.0,
                        620.0,
                        1472.0,
                        622.0,
                        1237.0,
                        622.0,
                        1237.0,
                        660.0,
                        1489.5,
                        660.0
                    ],
                    "source": [
                        "obj-148",
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
                        609.5,
                        192.0,
                        642.0,
                        192.0,
                        642.0,
                        228.0,
                        642.0,
                        217.0,
                        642.0,
                        217.0,
                        642.0,
                        255.0,
                        129.5,
                        255.0
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
                        "obj-152",
                        0
                    ],
                    "midpoints": [
                        1966.0,
                        597.0,
                        1966.0,
                        562.0,
                        1889.5,
                        562.0
                    ],
                    "source": [
                        "obj-151",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        1889.5,
                        562.0,
                        1712.0,
                        562.0,
                        1712.0,
                        598.0,
                        1712.0,
                        562.0,
                        1807.0,
                        562.0,
                        1807.0,
                        600.0,
                        1807.0,
                        582.0,
                        1609.0,
                        582.0,
                        1609.0,
                        620.0,
                        1609.0,
                        582.0,
                        1729.0,
                        582.0,
                        1729.0,
                        620.0,
                        1729.0,
                        607.0,
                        1712.0,
                        607.0,
                        1712.0,
                        643.0,
                        1712.0,
                        607.0,
                        1807.0,
                        607.0,
                        1807.0,
                        645.0,
                        1807.0,
                        607.0,
                        1872.0,
                        607.0,
                        1872.0,
                        645.0,
                        1489.5,
                        645.0
                    ],
                    "source": [
                        "obj-152",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-155",
                        0
                    ],
                    "midpoints": [
                        1945.0,
                        642.0,
                        1945.0,
                        607.0,
                        1889.5,
                        607.0
                    ],
                    "source": [
                        "obj-154",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        1889.5,
                        607.0,
                        1712.0,
                        607.0,
                        1712.0,
                        643.0,
                        1712.0,
                        607.0,
                        1807.0,
                        607.0,
                        1807.0,
                        645.0,
                        1489.5,
                        645.0
                    ],
                    "source": [
                        "obj-155",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-158",
                        0
                    ],
                    "midpoints": [
                        1980.0,
                        687.0,
                        1980.0,
                        652.0,
                        1889.5,
                        652.0
                    ],
                    "source": [
                        "obj-157",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        1889.5,
                        607.0,
                        1807.0,
                        607.0,
                        1807.0,
                        645.0,
                        1807.0,
                        607.0,
                        1872.0,
                        607.0,
                        1872.0,
                        645.0,
                        1872.0,
                        652.0,
                        1712.0,
                        652.0,
                        1712.0,
                        688.0,
                        1712.0,
                        652.0,
                        1807.0,
                        652.0,
                        1807.0,
                        690.0,
                        1489.5,
                        690.0
                    ],
                    "source": [
                        "obj-158",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-161",
                        0
                    ],
                    "midpoints": [
                        1987.0,
                        732.0,
                        1987.0,
                        697.0,
                        1889.5,
                        697.0
                    ],
                    "source": [
                        "obj-160",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        3475.0,
                        732.0,
                        3475.0,
                        632.0,
                        1489.5,
                        632.0
                    ],
                    "source": [
                        "obj-161",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-91",
                        4
                    ],
                    "midpoints": [
                        3419.0,
                        777.0,
                        3419.0,
                        307.0,
                        1413.1,
                        307.0
                    ],
                    "source": [
                        "obj-163",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-91",
                        5
                    ],
                    "midpoints": [
                        3427.0,
                        822.0,
                        3427.0,
                        307.0,
                        1426.5,
                        307.0
                    ],
                    "source": [
                        "obj-165",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-163",
                        0
                    ],
                    "midpoints": [
                        2019.5,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1942.0,
                        402.0,
                        1942.0,
                        440.0,
                        1942.0,
                        562.0,
                        1873.0,
                        562.0,
                        1873.0,
                        600.0,
                        1873.0,
                        562.0,
                        1967.0,
                        562.0,
                        1967.0,
                        600.0,
                        1967.0,
                        607.0,
                        1873.0,
                        607.0,
                        1873.0,
                        645.0,
                        1873.0,
                        607.0,
                        1946.0,
                        607.0,
                        1946.0,
                        645.0,
                        1946.0,
                        652.0,
                        1842.0,
                        652.0,
                        1842.0,
                        688.0,
                        1842.0,
                        652.0,
                        1873.0,
                        652.0,
                        1873.0,
                        690.0,
                        1873.0,
                        652.0,
                        1981.0,
                        652.0,
                        1981.0,
                        690.0,
                        1981.0,
                        697.0,
                        1873.0,
                        697.0,
                        1873.0,
                        735.0,
                        1873.0,
                        697.0,
                        1988.0,
                        697.0,
                        1988.0,
                        735.0,
                        1824.5,
                        735.0
                    ],
                    "source": [
                        "obj-166",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-165",
                        0
                    ],
                    "midpoints": [
                        2079.5,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1942.0,
                        402.0,
                        1942.0,
                        440.0,
                        1942.0,
                        402.0,
                        2002.0,
                        402.0,
                        2002.0,
                        440.0,
                        2002.0,
                        562.0,
                        1873.0,
                        562.0,
                        1873.0,
                        600.0,
                        1873.0,
                        562.0,
                        1967.0,
                        562.0,
                        1967.0,
                        600.0,
                        1967.0,
                        607.0,
                        1873.0,
                        607.0,
                        1873.0,
                        645.0,
                        1873.0,
                        607.0,
                        1946.0,
                        607.0,
                        1946.0,
                        645.0,
                        1946.0,
                        652.0,
                        1842.0,
                        652.0,
                        1842.0,
                        688.0,
                        1842.0,
                        652.0,
                        1873.0,
                        652.0,
                        1873.0,
                        690.0,
                        1873.0,
                        652.0,
                        1981.0,
                        652.0,
                        1981.0,
                        690.0,
                        1981.0,
                        697.0,
                        1873.0,
                        697.0,
                        1873.0,
                        735.0,
                        1873.0,
                        697.0,
                        1988.0,
                        697.0,
                        1988.0,
                        735.0,
                        1988.0,
                        742.0,
                        1873.0,
                        742.0,
                        1873.0,
                        780.0,
                        1824.5,
                        780.0
                    ],
                    "source": [
                        "obj-167",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-151",
                        0
                    ],
                    "midpoints": [
                        2139.5,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2002.0,
                        402.0,
                        2002.0,
                        440.0,
                        2002.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        562.0,
                        1967.0,
                        562.0,
                        1967.0,
                        600.0,
                        1824.5,
                        600.0
                    ],
                    "source": [
                        "obj-168",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-154",
                        0
                    ],
                    "midpoints": [
                        2199.5,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2002.0,
                        402.0,
                        2002.0,
                        440.0,
                        2002.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2122.0,
                        562.0,
                        1873.0,
                        562.0,
                        1873.0,
                        600.0,
                        1873.0,
                        562.0,
                        1967.0,
                        562.0,
                        1967.0,
                        600.0,
                        1967.0,
                        607.0,
                        1946.0,
                        607.0,
                        1946.0,
                        645.0,
                        1824.5,
                        645.0
                    ],
                    "source": [
                        "obj-169",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-157",
                        0
                    ],
                    "midpoints": [
                        2259.5,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2058.0,
                        402.0,
                        2058.0,
                        440.0,
                        2058.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2122.0,
                        402.0,
                        2182.0,
                        402.0,
                        2182.0,
                        440.0,
                        2182.0,
                        562.0,
                        1873.0,
                        562.0,
                        1873.0,
                        600.0,
                        1873.0,
                        562.0,
                        1967.0,
                        562.0,
                        1967.0,
                        600.0,
                        1967.0,
                        607.0,
                        1873.0,
                        607.0,
                        1873.0,
                        645.0,
                        1873.0,
                        607.0,
                        1946.0,
                        607.0,
                        1946.0,
                        645.0,
                        1946.0,
                        652.0,
                        1842.0,
                        652.0,
                        1842.0,
                        688.0,
                        1842.0,
                        652.0,
                        1981.0,
                        652.0,
                        1981.0,
                        690.0,
                        1824.5,
                        690.0
                    ],
                    "source": [
                        "obj-170",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-160",
                        0
                    ],
                    "midpoints": [
                        2319.5,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2058.0,
                        402.0,
                        2058.0,
                        440.0,
                        2058.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2122.0,
                        402.0,
                        2182.0,
                        402.0,
                        2182.0,
                        440.0,
                        2182.0,
                        402.0,
                        2242.0,
                        402.0,
                        2242.0,
                        440.0,
                        2242.0,
                        562.0,
                        1873.0,
                        562.0,
                        1873.0,
                        600.0,
                        1873.0,
                        562.0,
                        1967.0,
                        562.0,
                        1967.0,
                        600.0,
                        1967.0,
                        607.0,
                        1873.0,
                        607.0,
                        1873.0,
                        645.0,
                        1873.0,
                        607.0,
                        1946.0,
                        607.0,
                        1946.0,
                        645.0,
                        1946.0,
                        652.0,
                        1842.0,
                        652.0,
                        1842.0,
                        688.0,
                        1842.0,
                        652.0,
                        1873.0,
                        652.0,
                        1873.0,
                        690.0,
                        1873.0,
                        652.0,
                        1981.0,
                        652.0,
                        1981.0,
                        690.0,
                        1981.0,
                        697.0,
                        1988.0,
                        697.0,
                        1988.0,
                        735.0,
                        1824.5,
                        735.0
                    ],
                    "source": [
                        "obj-171",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-147",
                        0
                    ],
                    "midpoints": [
                        643.5,
                        371.0,
                        684.5,
                        371.0
                    ],
                    "source": [
                        "obj-172",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-62",
                        0
                    ],
                    "midpoints": [
                        3379.0,
                        387.0,
                        3379.0,
                        262.0,
                        684.5,
                        262.0
                    ],
                    "source": [
                        "obj-172",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-62",
                        1
                    ],
                    "midpoints": [
                        659.5,
                        217.0,
                        702.0,
                        217.0,
                        702.0,
                        255.0,
                        702.0,
                        262.0,
                        668.0,
                        262.0,
                        668.0,
                        300.0,
                        724.0,
                        300.0
                    ],
                    "source": [
                        "obj-174",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-62",
                        2
                    ],
                    "midpoints": [
                        719.5,
                        217.0,
                        762.0,
                        217.0,
                        762.0,
                        255.0,
                        763.5,
                        255.0
                    ],
                    "source": [
                        "obj-176",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-62",
                        3
                    ],
                    "midpoints": [
                        779.5,
                        258.5,
                        803.0,
                        258.5
                    ],
                    "source": [
                        "obj-178",
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
                        1359.5,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        538.0,
                        142.0,
                        538.0,
                        180.0,
                        538.0,
                        142.0,
                        600.0,
                        142.0,
                        600.0,
                        180.0,
                        600.0,
                        142.0,
                        662.0,
                        142.0,
                        662.0,
                        180.0,
                        662.0,
                        142.0,
                        724.0,
                        142.0,
                        724.0,
                        180.0,
                        724.0,
                        142.0,
                        836.0,
                        142.0,
                        836.0,
                        180.0,
                        836.0,
                        142.0,
                        832.0,
                        142.0,
                        832.0,
                        180.0,
                        832.0,
                        157.0,
                        892.0,
                        157.0,
                        892.0,
                        195.0,
                        892.0,
                        157.0,
                        952.0,
                        157.0,
                        952.0,
                        195.0,
                        952.0,
                        170.0,
                        730.0,
                        170.0,
                        730.0,
                        206.0,
                        730.0,
                        177.0,
                        1292.0,
                        177.0,
                        1292.0,
                        213.0,
                        1292.0,
                        187.0,
                        694.0,
                        187.0,
                        694.0,
                        225.0,
                        694.0,
                        192.0,
                        716.0,
                        192.0,
                        716.0,
                        228.0,
                        716.0,
                        192.0,
                        776.0,
                        192.0,
                        776.0,
                        228.0,
                        776.0,
                        192.0,
                        818.0,
                        192.0,
                        818.0,
                        228.0,
                        818.0,
                        192.0,
                        822.0,
                        192.0,
                        822.0,
                        228.0,
                        822.0,
                        205.0,
                        1292.0,
                        205.0,
                        1292.0,
                        241.0,
                        1292.0,
                        217.0,
                        708.0,
                        217.0,
                        708.0,
                        255.0,
                        708.0,
                        217.0,
                        768.0,
                        217.0,
                        768.0,
                        255.0,
                        768.0,
                        217.0,
                        762.0,
                        217.0,
                        762.0,
                        255.0,
                        762.0,
                        217.0,
                        822.0,
                        217.0,
                        822.0,
                        255.0,
                        822.0,
                        232.0,
                        1297.0,
                        232.0,
                        1297.0,
                        270.0,
                        129.5,
                        270.0
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
                        "obj-62",
                        4
                    ],
                    "source": [
                        "obj-180",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-174",
                        0
                    ],
                    "midpoints": [
                        3323.0,
                        437.0,
                        3323.0,
                        217.0,
                        659.5,
                        217.0
                    ],
                    "source": [
                        "obj-181",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-176",
                        0
                    ],
                    "midpoints": [
                        3331.0,
                        437.0,
                        3331.0,
                        217.0,
                        719.5,
                        217.0
                    ],
                    "source": [
                        "obj-182",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-178",
                        0
                    ],
                    "midpoints": [
                        3339.0,
                        437.0,
                        3339.0,
                        217.0,
                        779.5,
                        217.0
                    ],
                    "source": [
                        "obj-183",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-180",
                        0
                    ],
                    "midpoints": [
                        3347.0,
                        437.0,
                        3347.0,
                        217.0,
                        839.5,
                        217.0
                    ],
                    "source": [
                        "obj-184",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-190",
                        0
                    ],
                    "source": [
                        "obj-188",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-191",
                        0
                    ],
                    "source": [
                        "obj-189",
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
                        1074.5,
                        22.0,
                        1239.0,
                        22.0,
                        1239.0,
                        60.0,
                        1239.0,
                        22.0,
                        1237.0,
                        22.0,
                        1237.0,
                        60.0,
                        1237.0,
                        22.0,
                        1327.0,
                        22.0,
                        1327.0,
                        60.0,
                        1327.0,
                        67.0,
                        1149.0,
                        67.0,
                        1149.0,
                        105.0,
                        1149.0,
                        67.0,
                        1239.0,
                        67.0,
                        1239.0,
                        105.0,
                        1239.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        123.0,
                        1159.0,
                        123.0,
                        1159.0,
                        161.0,
                        1359.5,
                        161.0
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
                        "obj-88",
                        0
                    ],
                    "source": [
                        "obj-190",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-88",
                        0
                    ],
                    "source": [
                        "obj-191",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        1
                    ],
                    "midpoints": [
                        461.5,
                        146.5,
                        213.5,
                        146.5
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
                        "obj-18",
                        1
                    ],
                    "midpoints": [
                        1164.5,
                        22.0,
                        1237.0,
                        22.0,
                        1237.0,
                        60.0,
                        1237.0,
                        22.0,
                        1327.0,
                        22.0,
                        1327.0,
                        60.0,
                        1327.0,
                        67.0,
                        1239.0,
                        67.0,
                        1239.0,
                        105.0,
                        1239.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1365.5909090909092,
                        129.0
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
                        "obj-18",
                        2
                    ],
                    "midpoints": [
                        1254.5,
                        22.0,
                        1327.0,
                        22.0,
                        1327.0,
                        60.0,
                        1327.0,
                        67.0,
                        1329.0,
                        67.0,
                        1329.0,
                        105.0,
                        1329.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1371.6818181818182,
                        129.0
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
                        "obj-18",
                        3
                    ],
                    "midpoints": [
                        1344.5,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1377.7727272727273,
                        129.0
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
                        "obj-18",
                        4
                    ],
                    "midpoints": [
                        1434.5,
                        22.0,
                        1419.0,
                        22.0,
                        1419.0,
                        60.0,
                        1419.0,
                        67.0,
                        1419.0,
                        67.0,
                        1419.0,
                        105.0,
                        1419.0,
                        67.0,
                        1417.0,
                        67.0,
                        1417.0,
                        105.0,
                        1417.0,
                        95.0,
                        1390.0,
                        95.0,
                        1390.0,
                        129.0,
                        1383.8636363636365,
                        129.0
                    ],
                    "source": [
                        "obj-27",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-18",
                        5
                    ],
                    "midpoints": [
                        1524.5,
                        22.0,
                        1419.0,
                        22.0,
                        1419.0,
                        60.0,
                        1419.0,
                        22.0,
                        1417.0,
                        22.0,
                        1417.0,
                        60.0,
                        1417.0,
                        67.0,
                        1419.0,
                        67.0,
                        1419.0,
                        105.0,
                        1419.0,
                        67.0,
                        1417.0,
                        67.0,
                        1417.0,
                        105.0,
                        1417.0,
                        67.0,
                        1507.0,
                        67.0,
                        1507.0,
                        105.0,
                        1507.0,
                        95.0,
                        1390.0,
                        95.0,
                        1390.0,
                        129.0,
                        1390.0,
                        95.0,
                        1446.0,
                        95.0,
                        1446.0,
                        129.0,
                        1389.9545454545455,
                        129.0
                    ],
                    "source": [
                        "obj-29",
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
                    "source": [
                        "obj-3",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-18",
                        6
                    ],
                    "midpoints": [
                        1074.5,
                        67.0,
                        1239.0,
                        67.0,
                        1239.0,
                        105.0,
                        1239.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        123.0,
                        1159.0,
                        123.0,
                        1159.0,
                        161.0,
                        1396.0454545454545,
                        161.0
                    ],
                    "source": [
                        "obj-31",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-18",
                        7
                    ],
                    "midpoints": [
                        1164.5,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1402.1363636363637,
                        129.0
                    ],
                    "source": [
                        "obj-33",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-18",
                        8
                    ],
                    "midpoints": [
                        1254.5,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1408.2272727272727,
                        129.0
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
                        "obj-18",
                        9
                    ],
                    "midpoints": [
                        1344.5,
                        67.0,
                        1417.0,
                        67.0,
                        1417.0,
                        105.0,
                        1417.0,
                        95.0,
                        1390.0,
                        95.0,
                        1390.0,
                        129.0,
                        1414.318181818182,
                        129.0
                    ],
                    "source": [
                        "obj-37",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-18",
                        10
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
                        "obj-115",
                        0
                    ],
                    "midpoints": [
                        222.3,
                        262.0,
                        112.0,
                        262.0,
                        112.0,
                        300.0,
                        112.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        238.0,
                        307.0,
                        232.0,
                        307.0,
                        232.0,
                        345.0,
                        232.0,
                        352.0,
                        277.0,
                        352.0,
                        277.0,
                        390.0,
                        277.0,
                        397.0,
                        277.0,
                        397.0,
                        277.0,
                        435.0,
                        129.5,
                        435.0
                    ],
                    "source": [
                        "obj-4",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-172",
                        0
                    ],
                    "midpoints": [
                        175.9,
                        262.0,
                        361.0,
                        262.0,
                        361.0,
                        300.0,
                        361.0,
                        262.0,
                        367.0,
                        262.0,
                        367.0,
                        300.0,
                        367.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        238.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        367.0,
                        307.0,
                        367.0,
                        345.0,
                        367.0,
                        307.0,
                        427.0,
                        307.0,
                        427.0,
                        345.0,
                        427.0,
                        307.0,
                        487.0,
                        307.0,
                        487.0,
                        345.0,
                        487.0,
                        307.0,
                        562.0,
                        307.0,
                        562.0,
                        345.0,
                        562.0,
                        352.0,
                        277.0,
                        352.0,
                        277.0,
                        390.0,
                        569.5,
                        390.0
                    ],
                    "source": [
                        "obj-4",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-43",
                        0
                    ],
                    "source": [
                        "obj-4",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-71",
                        0
                    ],
                    "midpoints": [
                        129.5,
                        262.0,
                        112.0,
                        262.0,
                        112.0,
                        300.0,
                        112.0,
                        307.0,
                        163.0,
                        307.0,
                        163.0,
                        345.0,
                        163.0,
                        307.0,
                        172.0,
                        307.0,
                        172.0,
                        345.0,
                        129.5,
                        345.0
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
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        152.7,
                        262.0,
                        112.0,
                        262.0,
                        112.0,
                        300.0,
                        112.0,
                        307.0,
                        163.0,
                        307.0,
                        163.0,
                        345.0,
                        163.0,
                        307.0,
                        172.0,
                        307.0,
                        172.0,
                        345.0,
                        172.0,
                        352.0,
                        112.0,
                        352.0,
                        112.0,
                        390.0,
                        129.5,
                        390.0
                    ],
                    "source": [
                        "obj-4",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-88",
                        0
                    ],
                    "source": [
                        "obj-4",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-18",
                        11
                    ],
                    "midpoints": [
                        1524.5,
                        67.0,
                        1509.0,
                        67.0,
                        1509.0,
                        105.0,
                        1509.0,
                        95.0,
                        1480.0,
                        95.0,
                        1480.0,
                        129.0,
                        1426.5,
                        129.0
                    ],
                    "source": [
                        "obj-41",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-44",
                        0
                    ],
                    "source": [
                        "obj-43",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-45",
                        0
                    ],
                    "midpoints": [
                        147.33333333333334,
                        307.0,
                        163.0,
                        307.0,
                        163.0,
                        345.0,
                        189.5,
                        345.0
                    ],
                    "source": [
                        "obj-43",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-46",
                        0
                    ],
                    "midpoints": [
                        165.16666666666666,
                        307.0,
                        163.0,
                        307.0,
                        163.0,
                        345.0,
                        163.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        249.5,
                        345.0
                    ],
                    "source": [
                        "obj-43",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        183.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        238.0,
                        307.0,
                        232.0,
                        307.0,
                        232.0,
                        345.0,
                        309.5,
                        345.0
                    ],
                    "source": [
                        "obj-43",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-48",
                        0
                    ],
                    "midpoints": [
                        200.83333333333331,
                        262.0,
                        367.0,
                        262.0,
                        367.0,
                        300.0,
                        367.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        238.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        292.0,
                        307.0,
                        292.0,
                        345.0,
                        384.5,
                        345.0
                    ],
                    "source": [
                        "obj-43",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-49",
                        0
                    ],
                    "midpoints": [
                        218.66666666666669,
                        262.0,
                        367.0,
                        262.0,
                        367.0,
                        300.0,
                        367.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        238.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        367.0,
                        307.0,
                        367.0,
                        345.0,
                        444.5,
                        345.0
                    ],
                    "source": [
                        "obj-43",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-50",
                        0
                    ],
                    "midpoints": [
                        236.5,
                        262.0,
                        367.0,
                        262.0,
                        367.0,
                        300.0,
                        367.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        238.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        367.0,
                        307.0,
                        367.0,
                        345.0,
                        367.0,
                        307.0,
                        427.0,
                        307.0,
                        427.0,
                        345.0,
                        504.5,
                        345.0
                    ],
                    "source": [
                        "obj-43",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-51",
                        0
                    ],
                    "midpoints": [
                        254.33333333333331,
                        262.0,
                        367.0,
                        262.0,
                        367.0,
                        300.0,
                        367.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        433.0,
                        307.0,
                        433.0,
                        345.0,
                        433.0,
                        307.0,
                        427.0,
                        307.0,
                        427.0,
                        345.0,
                        427.0,
                        307.0,
                        487.0,
                        307.0,
                        487.0,
                        345.0,
                        579.5,
                        345.0
                    ],
                    "source": [
                        "obj-43",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-52",
                        0
                    ],
                    "midpoints": [
                        272.16666666666663,
                        262.0,
                        518.0,
                        262.0,
                        518.0,
                        300.0,
                        518.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        433.0,
                        307.0,
                        433.0,
                        345.0,
                        433.0,
                        307.0,
                        493.0,
                        307.0,
                        493.0,
                        345.0,
                        493.0,
                        307.0,
                        487.0,
                        307.0,
                        487.0,
                        345.0,
                        487.0,
                        307.0,
                        562.0,
                        307.0,
                        562.0,
                        345.0,
                        639.5,
                        345.0
                    ],
                    "source": [
                        "obj-43",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        290.0,
                        262.0,
                        518.0,
                        262.0,
                        518.0,
                        300.0,
                        518.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        262.0,
                        667.0,
                        262.0,
                        667.0,
                        300.0,
                        667.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        433.0,
                        307.0,
                        433.0,
                        345.0,
                        433.0,
                        307.0,
                        493.0,
                        307.0,
                        493.0,
                        345.0,
                        493.0,
                        307.0,
                        487.0,
                        307.0,
                        487.0,
                        345.0,
                        487.0,
                        307.0,
                        562.0,
                        307.0,
                        562.0,
                        345.0,
                        562.0,
                        307.0,
                        622.0,
                        307.0,
                        622.0,
                        345.0,
                        699.5,
                        345.0
                    ],
                    "source": [
                        "obj-43",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-54",
                        0
                    ],
                    "midpoints": [
                        307.83333333333337,
                        262.0,
                        518.0,
                        262.0,
                        518.0,
                        300.0,
                        518.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        262.0,
                        667.0,
                        262.0,
                        667.0,
                        300.0,
                        667.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        433.0,
                        307.0,
                        433.0,
                        345.0,
                        433.0,
                        307.0,
                        493.0,
                        307.0,
                        493.0,
                        345.0,
                        493.0,
                        307.0,
                        553.0,
                        307.0,
                        553.0,
                        345.0,
                        553.0,
                        307.0,
                        562.0,
                        307.0,
                        562.0,
                        345.0,
                        562.0,
                        307.0,
                        622.0,
                        307.0,
                        622.0,
                        345.0,
                        622.0,
                        307.0,
                        682.0,
                        307.0,
                        682.0,
                        345.0,
                        774.5,
                        345.0
                    ],
                    "source": [
                        "obj-43",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-55",
                        0
                    ],
                    "midpoints": [
                        325.66666666666663,
                        262.0,
                        518.0,
                        262.0,
                        518.0,
                        300.0,
                        518.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        262.0,
                        667.0,
                        262.0,
                        667.0,
                        300.0,
                        667.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        433.0,
                        307.0,
                        433.0,
                        345.0,
                        433.0,
                        307.0,
                        493.0,
                        307.0,
                        493.0,
                        345.0,
                        493.0,
                        307.0,
                        553.0,
                        307.0,
                        553.0,
                        345.0,
                        553.0,
                        307.0,
                        562.0,
                        307.0,
                        562.0,
                        345.0,
                        562.0,
                        307.0,
                        622.0,
                        307.0,
                        622.0,
                        345.0,
                        622.0,
                        307.0,
                        682.0,
                        307.0,
                        682.0,
                        345.0,
                        682.0,
                        307.0,
                        757.0,
                        307.0,
                        757.0,
                        345.0,
                        834.5,
                        345.0
                    ],
                    "source": [
                        "obj-43",
                        11
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
                        489.5,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        534.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        609.5,
                        180.0
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
                        "obj-88",
                        0
                    ],
                    "midpoints": [
                        384.5,
                        262.0,
                        668.0,
                        262.0,
                        668.0,
                        300.0,
                        668.0,
                        262.0,
                        667.0,
                        262.0,
                        667.0,
                        300.0,
                        667.0,
                        307.0,
                        493.0,
                        307.0,
                        493.0,
                        345.0,
                        493.0,
                        307.0,
                        553.0,
                        307.0,
                        553.0,
                        345.0,
                        553.0,
                        307.0,
                        628.0,
                        307.0,
                        628.0,
                        345.0,
                        628.0,
                        307.0,
                        688.0,
                        307.0,
                        688.0,
                        345.0,
                        688.0,
                        307.0,
                        682.0,
                        307.0,
                        682.0,
                        345.0,
                        682.0,
                        307.0,
                        757.0,
                        307.0,
                        757.0,
                        345.0,
                        757.0,
                        307.0,
                        817.0,
                        307.0,
                        817.0,
                        345.0,
                        894.5,
                        345.0
                    ],
                    "source": [
                        "obj-56",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-59",
                        0
                    ],
                    "midpoints": [
                        534.5,
                        262.0,
                        860.0,
                        262.0,
                        860.0,
                        300.0,
                        860.0,
                        307.0,
                        628.0,
                        307.0,
                        628.0,
                        345.0,
                        628.0,
                        307.0,
                        688.0,
                        307.0,
                        688.0,
                        345.0,
                        688.0,
                        307.0,
                        748.0,
                        307.0,
                        748.0,
                        345.0,
                        748.0,
                        307.0,
                        823.0,
                        307.0,
                        823.0,
                        345.0,
                        823.0,
                        307.0,
                        817.0,
                        307.0,
                        817.0,
                        345.0,
                        817.0,
                        307.0,
                        877.0,
                        307.0,
                        877.0,
                        345.0,
                        1059.5,
                        345.0
                    ],
                    "source": [
                        "obj-57",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-60",
                        1
                    ],
                    "midpoints": [
                        1059.5,
                        348.5,
                        1061.5,
                        348.5
                    ],
                    "source": [
                        "obj-59",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-61",
                        0
                    ],
                    "source": [
                        "obj-60",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-63",
                        0
                    ],
                    "midpoints": [
                        1044.5,
                        437.0,
                        952.0,
                        437.0,
                        952.0,
                        475.0,
                        952.0,
                        442.0,
                        1087.0,
                        442.0,
                        1087.0,
                        480.0,
                        894.5,
                        480.0
                    ],
                    "source": [
                        "obj-61",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-120",
                        1
                    ],
                    "midpoints": [
                        684.5,
                        307.0,
                        688.0,
                        307.0,
                        688.0,
                        345.0,
                        688.0,
                        307.0,
                        748.0,
                        307.0,
                        748.0,
                        345.0,
                        748.0,
                        307.0,
                        823.0,
                        307.0,
                        823.0,
                        345.0,
                        823.0,
                        307.0,
                        883.0,
                        307.0,
                        883.0,
                        345.0,
                        883.0,
                        307.0,
                        1042.0,
                        307.0,
                        1042.0,
                        345.0,
                        1042.0,
                        307.0,
                        877.0,
                        307.0,
                        877.0,
                        345.0,
                        877.0,
                        352.0,
                        1012.0,
                        352.0,
                        1012.0,
                        390.0,
                        1012.0,
                        352.0,
                        804.0,
                        352.0,
                        804.0,
                        390.0,
                        804.0,
                        387.0,
                        741.0,
                        387.0,
                        741.0,
                        425.0,
                        741.0,
                        397.0,
                        1027.0,
                        397.0,
                        1027.0,
                        435.0,
                        1027.0,
                        437.0,
                        952.0,
                        437.0,
                        952.0,
                        475.0,
                        952.0,
                        442.0,
                        877.0,
                        442.0,
                        877.0,
                        480.0,
                        1127.5,
                        480.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-62",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-63",
                        1
                    ],
                    "midpoints": [
                        684.5,
                        307.0,
                        688.0,
                        307.0,
                        688.0,
                        345.0,
                        688.0,
                        307.0,
                        748.0,
                        307.0,
                        748.0,
                        345.0,
                        748.0,
                        307.0,
                        823.0,
                        307.0,
                        823.0,
                        345.0,
                        823.0,
                        307.0,
                        817.0,
                        307.0,
                        817.0,
                        345.0,
                        817.0,
                        307.0,
                        877.0,
                        307.0,
                        877.0,
                        345.0,
                        877.0,
                        352.0,
                        804.0,
                        352.0,
                        804.0,
                        390.0,
                        804.0,
                        387.0,
                        741.0,
                        387.0,
                        741.0,
                        425.0,
                        917.5,
                        425.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-62",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-139",
                        0
                    ],
                    "midpoints": [
                        894.5,
                        472.0,
                        892.0,
                        472.0,
                        892.0,
                        510.0,
                        894.5,
                        510.0
                    ],
                    "source": [
                        "obj-63",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-65",
                        0
                    ],
                    "midpoints": [
                        909.5,
                        512.0,
                        877.0,
                        512.0,
                        877.0,
                        550.0,
                        877.0,
                        517.0,
                        593.0,
                        517.0,
                        593.0,
                        633.0,
                        593.0,
                        517.0,
                        630.0,
                        517.0,
                        630.0,
                        673.0,
                        630.0,
                        517.0,
                        653.0,
                        517.0,
                        653.0,
                        633.0,
                        549.5,
                        633.0
                    ],
                    "source": [
                        "obj-64",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-122",
                        0
                    ],
                    "midpoints": [
                        629.0,
                        670.0,
                        629.0,
                        517.0,
                        609.5,
                        517.0
                    ],
                    "source": [
                        "obj-65",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-66",
                        0
                    ],
                    "midpoints": [
                        592.0,
                        670.0,
                        592.0,
                        517.0,
                        579.0,
                        517.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-65",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-67",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-65",
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
                        132.77272727272728,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        472.0,
                        142.0,
                        472.0,
                        180.0,
                        472.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        534.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        675.5,
                        180.0
                    ],
                    "source": [
                        "obj-68",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-124",
                        0
                    ],
                    "midpoints": [
                        157.13636363636363,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        87.0,
                        832.0,
                        87.0,
                        832.0,
                        123.0,
                        832.0,
                        112.0,
                        832.0,
                        112.0,
                        832.0,
                        148.0,
                        832.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        538.0,
                        142.0,
                        538.0,
                        180.0,
                        538.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        534.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        596.0,
                        142.0,
                        658.0,
                        142.0,
                        658.0,
                        180.0,
                        658.0,
                        142.0,
                        720.0,
                        142.0,
                        720.0,
                        180.0,
                        849.5,
                        180.0
                    ],
                    "source": [
                        "obj-68",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-126",
                        0
                    ],
                    "midpoints": [
                        163.22727272727275,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        87.0,
                        832.0,
                        87.0,
                        832.0,
                        123.0,
                        832.0,
                        112.0,
                        832.0,
                        112.0,
                        832.0,
                        148.0,
                        832.0,
                        112.0,
                        894.0,
                        112.0,
                        894.0,
                        148.0,
                        894.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        538.0,
                        142.0,
                        538.0,
                        180.0,
                        538.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        534.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        596.0,
                        142.0,
                        658.0,
                        142.0,
                        658.0,
                        180.0,
                        658.0,
                        142.0,
                        720.0,
                        142.0,
                        720.0,
                        180.0,
                        720.0,
                        142.0,
                        832.0,
                        142.0,
                        832.0,
                        180.0,
                        909.5,
                        180.0
                    ],
                    "source": [
                        "obj-68",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-128",
                        0
                    ],
                    "midpoints": [
                        169.3181818181818,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        87.0,
                        832.0,
                        87.0,
                        832.0,
                        123.0,
                        832.0,
                        95.0,
                        947.0,
                        95.0,
                        947.0,
                        131.0,
                        947.0,
                        112.0,
                        832.0,
                        112.0,
                        832.0,
                        148.0,
                        832.0,
                        112.0,
                        894.0,
                        112.0,
                        894.0,
                        148.0,
                        894.0,
                        112.0,
                        956.0,
                        112.0,
                        956.0,
                        148.0,
                        956.0,
                        120.0,
                        947.0,
                        120.0,
                        947.0,
                        156.0,
                        947.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        538.0,
                        142.0,
                        538.0,
                        180.0,
                        538.0,
                        142.0,
                        600.0,
                        142.0,
                        600.0,
                        180.0,
                        600.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        596.0,
                        142.0,
                        658.0,
                        142.0,
                        658.0,
                        180.0,
                        658.0,
                        142.0,
                        720.0,
                        142.0,
                        720.0,
                        180.0,
                        720.0,
                        142.0,
                        832.0,
                        142.0,
                        832.0,
                        180.0,
                        832.0,
                        157.0,
                        892.0,
                        157.0,
                        892.0,
                        195.0,
                        969.5,
                        195.0
                    ],
                    "source": [
                        "obj-68",
                        9
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
                        138.86363636363637,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        472.0,
                        142.0,
                        472.0,
                        180.0,
                        472.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        534.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        596.0,
                        142.0,
                        658.0,
                        142.0,
                        658.0,
                        180.0,
                        737.5,
                        180.0
                    ],
                    "source": [
                        "obj-68",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-188",
                        0
                    ],
                    "source": [
                        "obj-68",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-189",
                        0
                    ],
                    "source": [
                        "obj-68",
                        11
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
                        151.04545454545456,
                        82.0,
                        127.0,
                        82.0,
                        127.0,
                        151.0,
                        127.0,
                        142.0,
                        127.0,
                        142.0,
                        127.0,
                        180.0,
                        129.5,
                        180.0
                    ],
                    "source": [
                        "obj-68",
                        6
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
                        114.5,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        489.5,
                        180.0
                    ],
                    "source": [
                        "obj-68",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-65",
                        0
                    ],
                    "midpoints": [
                        144.95454545454547,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        472.0,
                        142.0,
                        472.0,
                        180.0,
                        472.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        534.0,
                        232.0,
                        263.0,
                        232.0,
                        263.0,
                        270.0,
                        263.0,
                        262.0,
                        361.0,
                        262.0,
                        361.0,
                        300.0,
                        361.0,
                        262.0,
                        367.0,
                        262.0,
                        367.0,
                        300.0,
                        367.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        307.0,
                        163.0,
                        307.0,
                        163.0,
                        345.0,
                        163.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        238.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        367.0,
                        307.0,
                        367.0,
                        345.0,
                        367.0,
                        307.0,
                        427.0,
                        307.0,
                        427.0,
                        345.0,
                        427.0,
                        307.0,
                        487.0,
                        307.0,
                        487.0,
                        345.0,
                        487.0,
                        352.0,
                        277.0,
                        352.0,
                        277.0,
                        390.0,
                        277.0,
                        352.0,
                        552.0,
                        352.0,
                        552.0,
                        390.0,
                        552.0,
                        397.0,
                        277.0,
                        397.0,
                        277.0,
                        435.0,
                        277.0,
                        442.0,
                        277.0,
                        442.0,
                        277.0,
                        480.0,
                        549.5,
                        480.0
                    ],
                    "source": [
                        "obj-68",
                        5
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
                        120.5909090909091,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        472.0,
                        142.0,
                        472.0,
                        180.0,
                        551.5,
                        180.0
                    ],
                    "source": [
                        "obj-68",
                        1
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
                        126.68181818181819,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        472.0,
                        142.0,
                        472.0,
                        180.0,
                        472.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        613.5,
                        180.0
                    ],
                    "source": [
                        "obj-68",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-15",
                        1
                    ],
                    "midpoints": [
                        551.5,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        619.0714285714286,
                        180.0
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
                        "obj-56",
                        0
                    ],
                    "midpoints": [
                        3363.0,
                        387.0,
                        3363.0,
                        262.0,
                        384.5,
                        262.0
                    ],
                    "source": [
                        "obj-71",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-57",
                        0
                    ],
                    "midpoints": [
                        3371.0,
                        432.0,
                        3371.0,
                        262.0,
                        534.5,
                        262.0
                    ],
                    "source": [
                        "obj-72",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        0
                    ],
                    "midpoints": [
                        1103.5,
                        22.0,
                        1057.0,
                        22.0,
                        1057.0,
                        60.0,
                        1057.0,
                        67.0,
                        1057.0,
                        67.0,
                        1057.0,
                        105.0,
                        1057.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1086.0,
                        95.0,
                        1086.0,
                        129.0,
                        1074.5,
                        129.0
                    ],
                    "source": [
                        "obj-73",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        1
                    ],
                    "midpoints": [
                        1193.5,
                        -3.0,
                        1120.0,
                        -3.0,
                        1120.0,
                        31.0,
                        1120.0,
                        22.0,
                        1149.0,
                        22.0,
                        1149.0,
                        60.0,
                        1149.0,
                        22.0,
                        1147.0,
                        22.0,
                        1147.0,
                        60.0,
                        1147.0,
                        67.0,
                        1149.0,
                        67.0,
                        1149.0,
                        105.0,
                        1149.0,
                        67.0,
                        1147.0,
                        67.0,
                        1147.0,
                        105.0,
                        1147.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1176.0,
                        95.0,
                        1176.0,
                        129.0,
                        1080.5909090909092,
                        129.0
                    ],
                    "source": [
                        "obj-74",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        2
                    ],
                    "midpoints": [
                        1283.5,
                        -3.0,
                        1120.0,
                        -3.0,
                        1120.0,
                        31.0,
                        1120.0,
                        -3.0,
                        1176.0,
                        -3.0,
                        1176.0,
                        31.0,
                        1176.0,
                        22.0,
                        1149.0,
                        22.0,
                        1149.0,
                        60.0,
                        1149.0,
                        22.0,
                        1147.0,
                        22.0,
                        1147.0,
                        60.0,
                        1147.0,
                        22.0,
                        1237.0,
                        22.0,
                        1237.0,
                        60.0,
                        1237.0,
                        67.0,
                        1149.0,
                        67.0,
                        1149.0,
                        105.0,
                        1149.0,
                        67.0,
                        1147.0,
                        67.0,
                        1147.0,
                        105.0,
                        1147.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1176.0,
                        95.0,
                        1176.0,
                        129.0,
                        1176.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1086.6818181818182,
                        129.0
                    ],
                    "source": [
                        "obj-75",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        3
                    ],
                    "midpoints": [
                        1373.5,
                        -3.0,
                        1120.0,
                        -3.0,
                        1120.0,
                        31.0,
                        1120.0,
                        -3.0,
                        1210.0,
                        -3.0,
                        1210.0,
                        31.0,
                        1210.0,
                        -3.0,
                        1266.0,
                        -3.0,
                        1266.0,
                        31.0,
                        1266.0,
                        22.0,
                        1149.0,
                        22.0,
                        1149.0,
                        60.0,
                        1149.0,
                        22.0,
                        1239.0,
                        22.0,
                        1239.0,
                        60.0,
                        1239.0,
                        22.0,
                        1237.0,
                        22.0,
                        1237.0,
                        60.0,
                        1237.0,
                        22.0,
                        1327.0,
                        22.0,
                        1327.0,
                        60.0,
                        1327.0,
                        67.0,
                        1149.0,
                        67.0,
                        1149.0,
                        105.0,
                        1149.0,
                        67.0,
                        1239.0,
                        67.0,
                        1239.0,
                        105.0,
                        1239.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1092.7727272727273,
                        129.0
                    ],
                    "source": [
                        "obj-76",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        4
                    ],
                    "midpoints": [
                        1463.5,
                        -3.0,
                        1120.0,
                        -3.0,
                        1120.0,
                        31.0,
                        1120.0,
                        -3.0,
                        1210.0,
                        -3.0,
                        1210.0,
                        31.0,
                        1210.0,
                        -3.0,
                        1266.0,
                        -3.0,
                        1266.0,
                        31.0,
                        1266.0,
                        -3.0,
                        1356.0,
                        -3.0,
                        1356.0,
                        31.0,
                        1356.0,
                        22.0,
                        1149.0,
                        22.0,
                        1149.0,
                        60.0,
                        1149.0,
                        22.0,
                        1239.0,
                        22.0,
                        1239.0,
                        60.0,
                        1239.0,
                        22.0,
                        1237.0,
                        22.0,
                        1237.0,
                        60.0,
                        1237.0,
                        22.0,
                        1327.0,
                        22.0,
                        1327.0,
                        60.0,
                        1327.0,
                        22.0,
                        1417.0,
                        22.0,
                        1417.0,
                        60.0,
                        1417.0,
                        67.0,
                        1149.0,
                        67.0,
                        1149.0,
                        105.0,
                        1149.0,
                        67.0,
                        1239.0,
                        67.0,
                        1239.0,
                        105.0,
                        1239.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        67.0,
                        1417.0,
                        67.0,
                        1417.0,
                        105.0,
                        1417.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        95.0,
                        1446.0,
                        95.0,
                        1446.0,
                        129.0,
                        1098.8636363636365,
                        129.0
                    ],
                    "source": [
                        "obj-77",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        5
                    ],
                    "midpoints": [
                        1553.5,
                        -3.0,
                        1120.0,
                        -3.0,
                        1120.0,
                        31.0,
                        1120.0,
                        -3.0,
                        1210.0,
                        -3.0,
                        1210.0,
                        31.0,
                        1210.0,
                        -3.0,
                        1300.0,
                        -3.0,
                        1300.0,
                        31.0,
                        1300.0,
                        -3.0,
                        1356.0,
                        -3.0,
                        1356.0,
                        31.0,
                        1356.0,
                        -3.0,
                        1446.0,
                        -3.0,
                        1446.0,
                        31.0,
                        1446.0,
                        22.0,
                        1149.0,
                        22.0,
                        1149.0,
                        60.0,
                        1149.0,
                        22.0,
                        1239.0,
                        22.0,
                        1239.0,
                        60.0,
                        1239.0,
                        22.0,
                        1329.0,
                        22.0,
                        1329.0,
                        60.0,
                        1329.0,
                        22.0,
                        1327.0,
                        22.0,
                        1327.0,
                        60.0,
                        1327.0,
                        22.0,
                        1417.0,
                        22.0,
                        1417.0,
                        60.0,
                        1417.0,
                        22.0,
                        1507.0,
                        22.0,
                        1507.0,
                        60.0,
                        1507.0,
                        67.0,
                        1149.0,
                        67.0,
                        1149.0,
                        105.0,
                        1149.0,
                        67.0,
                        1239.0,
                        67.0,
                        1239.0,
                        105.0,
                        1239.0,
                        67.0,
                        1329.0,
                        67.0,
                        1329.0,
                        105.0,
                        1329.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        67.0,
                        1417.0,
                        67.0,
                        1417.0,
                        105.0,
                        1417.0,
                        67.0,
                        1507.0,
                        67.0,
                        1507.0,
                        105.0,
                        1507.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        95.0,
                        1446.0,
                        95.0,
                        1446.0,
                        129.0,
                        1446.0,
                        95.0,
                        1536.0,
                        95.0,
                        1536.0,
                        129.0,
                        1104.9545454545455,
                        129.0
                    ],
                    "source": [
                        "obj-78",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        6
                    ],
                    "source": [
                        "obj-79",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        7
                    ],
                    "midpoints": [
                        1193.5,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1117.1363636363637,
                        129.0
                    ],
                    "source": [
                        "obj-80",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        8
                    ],
                    "midpoints": [
                        1283.5,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1123.2272727272727,
                        129.0
                    ],
                    "source": [
                        "obj-81",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        9
                    ],
                    "midpoints": [
                        1373.5,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1129.318181818182,
                        129.0
                    ],
                    "source": [
                        "obj-82",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        10
                    ],
                    "midpoints": [
                        1463.5,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1135.409090909091,
                        129.0
                    ],
                    "source": [
                        "obj-83",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        11
                    ],
                    "midpoints": [
                        1553.5,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        95.0,
                        1446.0,
                        95.0,
                        1446.0,
                        129.0,
                        1141.5,
                        129.0
                    ],
                    "source": [
                        "obj-84",
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
                        1074.5,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        538.0,
                        142.0,
                        538.0,
                        180.0,
                        538.0,
                        142.0,
                        600.0,
                        142.0,
                        600.0,
                        180.0,
                        600.0,
                        142.0,
                        662.0,
                        142.0,
                        662.0,
                        180.0,
                        662.0,
                        142.0,
                        658.0,
                        142.0,
                        658.0,
                        180.0,
                        658.0,
                        142.0,
                        720.0,
                        142.0,
                        720.0,
                        180.0,
                        720.0,
                        142.0,
                        832.0,
                        142.0,
                        832.0,
                        180.0,
                        832.0,
                        157.0,
                        892.0,
                        157.0,
                        892.0,
                        195.0,
                        892.0,
                        157.0,
                        952.0,
                        157.0,
                        952.0,
                        195.0,
                        952.0,
                        170.0,
                        642.0,
                        170.0,
                        642.0,
                        206.0,
                        642.0,
                        187.0,
                        592.0,
                        187.0,
                        592.0,
                        225.0,
                        592.0,
                        192.0,
                        642.0,
                        192.0,
                        642.0,
                        228.0,
                        642.0,
                        192.0,
                        702.0,
                        192.0,
                        702.0,
                        228.0,
                        702.0,
                        192.0,
                        762.0,
                        192.0,
                        762.0,
                        228.0,
                        762.0,
                        192.0,
                        822.0,
                        192.0,
                        822.0,
                        228.0,
                        822.0,
                        217.0,
                        642.0,
                        217.0,
                        642.0,
                        255.0,
                        642.0,
                        217.0,
                        702.0,
                        217.0,
                        702.0,
                        255.0,
                        702.0,
                        217.0,
                        762.0,
                        217.0,
                        762.0,
                        255.0,
                        762.0,
                        217.0,
                        822.0,
                        217.0,
                        822.0,
                        255.0,
                        129.5,
                        255.0
                    ],
                    "source": [
                        "obj-86",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-73",
                        0
                    ],
                    "midpoints": [
                        3275.0,
                        158.0,
                        3275.0,
                        -3.0,
                        1103.5,
                        -3.0
                    ],
                    "source": [
                        "obj-86",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-74",
                        0
                    ],
                    "midpoints": [
                        3283.0,
                        158.0,
                        3283.0,
                        -3.0,
                        1193.5,
                        -3.0
                    ],
                    "source": [
                        "obj-86",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-75",
                        0
                    ],
                    "midpoints": [
                        3291.0,
                        158.0,
                        3291.0,
                        -3.0,
                        1283.5,
                        -3.0
                    ],
                    "source": [
                        "obj-86",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-76",
                        0
                    ],
                    "midpoints": [
                        3299.0,
                        158.0,
                        3299.0,
                        -3.0,
                        1373.5,
                        -3.0
                    ],
                    "source": [
                        "obj-86",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-77",
                        0
                    ],
                    "midpoints": [
                        3307.0,
                        158.0,
                        3307.0,
                        -3.0,
                        1463.5,
                        -3.0
                    ],
                    "source": [
                        "obj-86",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-78",
                        0
                    ],
                    "midpoints": [
                        3315.0,
                        158.0,
                        3315.0,
                        -3.0,
                        1553.5,
                        -3.0
                    ],
                    "source": [
                        "obj-86",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-79",
                        0
                    ],
                    "midpoints": [
                        1113.5833333333333,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1103.5,
                        123.0
                    ],
                    "source": [
                        "obj-86",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-80",
                        0
                    ],
                    "midpoints": [
                        1119.1666666666667,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1193.5,
                        129.0
                    ],
                    "source": [
                        "obj-86",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-81",
                        0
                    ],
                    "midpoints": [
                        1124.75,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1283.5,
                        129.0
                    ],
                    "source": [
                        "obj-86",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-82",
                        0
                    ],
                    "midpoints": [
                        1130.3333333333333,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        142.0,
                        1342.0,
                        142.0,
                        1342.0,
                        180.0,
                        1373.5,
                        180.0
                    ],
                    "source": [
                        "obj-86",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-83",
                        0
                    ],
                    "midpoints": [
                        1135.9166666666667,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        142.0,
                        1342.0,
                        142.0,
                        1342.0,
                        180.0,
                        1463.5,
                        180.0
                    ],
                    "source": [
                        "obj-86",
                        11
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-84",
                        0
                    ],
                    "midpoints": [
                        1141.5,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        95.0,
                        1446.0,
                        95.0,
                        1446.0,
                        129.0,
                        1446.0,
                        142.0,
                        1342.0,
                        142.0,
                        1342.0,
                        180.0,
                        1553.5,
                        180.0
                    ],
                    "source": [
                        "obj-86",
                        12
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-118",
                        0
                    ],
                    "midpoints": [
                        894.5,
                        307.0,
                        1042.0,
                        307.0,
                        1042.0,
                        345.0,
                        1042.0,
                        352.0,
                        1079.0,
                        352.0,
                        1079.0,
                        390.0,
                        1079.0,
                        397.0,
                        1027.0,
                        397.0,
                        1027.0,
                        435.0,
                        1027.0,
                        437.0,
                        1096.0,
                        437.0,
                        1096.0,
                        475.0,
                        1096.0,
                        442.0,
                        1087.0,
                        442.0,
                        1087.0,
                        480.0,
                        1087.0,
                        452.0,
                        1152.0,
                        452.0,
                        1152.0,
                        490.0,
                        1152.0,
                        472.0,
                        966.0,
                        472.0,
                        966.0,
                        510.0,
                        966.0,
                        487.0,
                        1087.0,
                        487.0,
                        1087.0,
                        525.0,
                        1087.0,
                        512.0,
                        993.0,
                        512.0,
                        993.0,
                        550.0,
                        993.0,
                        512.0,
                        1087.0,
                        512.0,
                        1087.0,
                        550.0,
                        1087.0,
                        532.0,
                        1237.0,
                        532.0,
                        1237.0,
                        570.0,
                        1254.5,
                        570.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-88",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-60",
                        0
                    ],
                    "midpoints": [
                        894.5,
                        348.5,
                        1029.5,
                        348.5
                    ],
                    "order": 1,
                    "source": [
                        "obj-88",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-15",
                        2
                    ],
                    "source": [
                        "obj-9",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-138",
                        2
                    ],
                    "midpoints": [
                        1404.1666666666667,
                        352.0,
                        1453.0,
                        352.0,
                        1453.0,
                        390.0,
                        1453.0,
                        397.0,
                        1453.0,
                        397.0,
                        1453.0,
                        435.0,
                        1453.0,
                        442.0,
                        1453.0,
                        442.0,
                        1453.0,
                        480.0,
                        1453.0,
                        462.0,
                        1472.0,
                        462.0,
                        1472.0,
                        500.0,
                        1472.0,
                        487.0,
                        1453.0,
                        487.0,
                        1453.0,
                        525.0,
                        1453.0,
                        492.0,
                        1472.0,
                        492.0,
                        1472.0,
                        530.0,
                        1472.0,
                        532.0,
                        1453.0,
                        532.0,
                        1453.0,
                        570.0,
                        1453.0,
                        532.0,
                        1472.0,
                        532.0,
                        1472.0,
                        568.0,
                        1472.0,
                        577.0,
                        1453.0,
                        577.0,
                        1453.0,
                        615.0,
                        1453.0,
                        582.0,
                        1472.0,
                        582.0,
                        1472.0,
                        620.0,
                        1472.0,
                        582.0,
                        1592.0,
                        582.0,
                        1592.0,
                        620.0,
                        1592.0,
                        622.0,
                        1437.0,
                        622.0,
                        1437.0,
                        660.0,
                        1591.5,
                        660.0
                    ],
                    "source": [
                        "obj-91",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-88",
                        0
                    ],
                    "source": [
                        "obj-91",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-88",
                        2
                    ],
                    "midpoints": [
                        1381.8333333333333,
                        307.0,
                        1242.0,
                        307.0,
                        1242.0,
                        345.0,
                        996.5,
                        345.0
                    ],
                    "source": [
                        "obj-91",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-88",
                        1
                    ],
                    "midpoints": [
                        1359.5,
                        307.0,
                        1242.0,
                        307.0,
                        1242.0,
                        345.0,
                        945.5,
                        345.0
                    ],
                    "source": [
                        "obj-91",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-91",
                        0
                    ],
                    "midpoints": [
                        3387.0,
                        387.0,
                        3387.0,
                        307.0,
                        1359.5,
                        307.0
                    ],
                    "source": [
                        "obj-93",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-91",
                        1
                    ],
                    "midpoints": [
                        3395.0,
                        432.0,
                        3395.0,
                        307.0,
                        1372.9,
                        307.0
                    ],
                    "source": [
                        "obj-95",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-91",
                        2
                    ],
                    "midpoints": [
                        1404.5,
                        352.0,
                        1387.0,
                        352.0,
                        1387.0,
                        390.0,
                        1387.0,
                        397.0,
                        1387.0,
                        397.0,
                        1387.0,
                        435.0,
                        1387.0,
                        432.0,
                        1387.0,
                        432.0,
                        1387.0,
                        468.0,
                        1387.0,
                        462.0,
                        1394.0,
                        462.0,
                        1394.0,
                        498.0,
                        1386.3,
                        498.0
                    ],
                    "source": [
                        "obj-97",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-91",
                        3
                    ],
                    "midpoints": [
                        1404.5,
                        352.0,
                        1387.0,
                        352.0,
                        1387.0,
                        390.0,
                        1387.0,
                        397.0,
                        1387.0,
                        397.0,
                        1387.0,
                        435.0,
                        1387.0,
                        442.0,
                        1387.0,
                        442.0,
                        1387.0,
                        480.0,
                        1399.7,
                        480.0
                    ],
                    "source": [
                        "obj-99",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-192",
                        0
                    ],
                    "destination": [
                        "obj-194",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-194",
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
                        "obj-4",
                        6
                    ],
                    "destination": [
                        "obj-195",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-195",
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
                        "obj-195",
                        1
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
                        "obj-195",
                        2
                    ],
                    "destination": [
                        "obj-23",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-195",
                        3
                    ],
                    "destination": [
                        "obj-25",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-195",
                        4
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
                        "obj-195",
                        5
                    ],
                    "destination": [
                        "obj-29",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-195",
                        6
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
                        "obj-195",
                        7
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
                        "obj-195",
                        8
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
                        "obj-195",
                        9
                    ],
                    "destination": [
                        "obj-37",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-195",
                        10
                    ],
                    "destination": [
                        "obj-39",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-195",
                        11
                    ],
                    "destination": [
                        "obj-41",
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