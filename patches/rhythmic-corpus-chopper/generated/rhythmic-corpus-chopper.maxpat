{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 2,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            100.0,
            100.0,
            1048.0,
            461.0
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
                        40.0,
                        140.0,
                        30.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        20.0,
                        300.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-2",
                    "maxclass": "dial",
                    "min": 40.0,
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        336.0,
                        155.0,
                        45.0,
                        45.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        90.0,
                        60.0,
                        60.0
                    ],
                    "size": 201.0
                }
            },
            {
                "box": {
                    "id": "obj-3",
                    "maxclass": "slider",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "orientation": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        190.0,
                        155.0,
                        25.0,
                        80.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        100.0,
                        90.0,
                        30.0,
                        100.0
                    ],
                    "size": 101.0
                }
            },
            {
                "box": {
                    "id": "obj-4",
                    "maxclass": "dial",
                    "min": 1.0,
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        421.0,
                        155.0,
                        45.0,
                        45.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        150.0,
                        90.0,
                        60.0,
                        60.0
                    ],
                    "size": 64.0
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "maxclass": "tab",
                    "multiline": 0,
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        507.0,
                        155.0,
                        75.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        90.0,
                        120.0,
                        30.0
                    ],
                    "tabs": [
                        "Straight",
                        "Euclid"
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-6",
                    "maxclass": "number",
                    "maximum": 32,
                    "minimum": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        593.0,
                        155.0,
                        45.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        145.0,
                        50.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-7",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        679.0,
                        155.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        370.0,
                        90.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-8",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        764.0,
                        155.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        430.0,
                        95.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "maxclass": "number",
                    "maximum": 16,
                    "minimum": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        850.0,
                        155.0,
                        45.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        465.0,
                        99.0,
                        50.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-10",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        250.0,
                        155.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        540.0,
                        90.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        160.0,
                        300.0,
                        45.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        610.0,
                        100.0,
                        60.0,
                        22.0
                    ],
                    "ignoreclick": 1
                }
            },
            {
                "box": {
                    "buffername": "rcc_loop",
                    "id": "obj-12",
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
                        30.0,
                        650.0,
                        860.0,
                        80.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        210.0,
                        860.0,
                        120.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-13",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        348.0,
                        133.0,
                        60.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        160.0,
                        60.0,
                        18.0
                    ],
                    "text": "Tempo",
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
                    "id": "obj-14",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        202.0,
                        133.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        100.0,
                        195.0,
                        40.0,
                        18.0
                    ],
                    "text": "Sens",
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
                    "id": "obj-15",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        433.0,
                        133.0,
                        60.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        150.0,
                        160.0,
                        60.0,
                        18.0
                    ],
                    "text": "Steps",
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
                    "id": "obj-16",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        519.0,
                        133.0,
                        60.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        122.0,
                        60.0,
                        18.0
                    ],
                    "text": "Mode",
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
                        605.0,
                        133.0,
                        60.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        285.0,
                        147.0,
                        70.0,
                        18.0
                    ],
                    "text": "Euclid k",
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
                    "id": "obj-18",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        691.0,
                        133.0,
                        60.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        370.0,
                        135.0,
                        60.0,
                        18.0
                    ],
                    "text": "Scramble",
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
                    "id": "obj-19",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        776.0,
                        133.0,
                        60.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        430.0,
                        150.0,
                        80.0,
                        18.0
                    ],
                    "text": "Auto bars",
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
                    "id": "obj-20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        262.0,
                        133.0,
                        60.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        540.0,
                        135.0,
                        50.0,
                        18.0
                    ],
                    "text": "Play",
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
                    "id": "obj-21",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        160.0,
                        325.0,
                        60.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        610.0,
                        125.0,
                        60.0,
                        18.0
                    ],
                    "text": "Slices",
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
                    "id": "obj-22",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        20.0,
                        60.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        3.0,
                        80.0,
                        18.0
                    ],
                    "text": "Load loop",
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
                    "id": "obj-23",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
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
                                    "comment": "filename symbol",
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
                                    "comment": "loaded buffer name",
                                    "id": "obj-2",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        240.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "load-done bang",
                                    "id": "obj-3",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        75.0,
                                        240.0,
                                        30.0,
                                        30.0
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
                                        30.0,
                                        70.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "replace $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "float",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        105.0,
                                        147.0,
                                        22.0
                                    ],
                                    "text": "buffer~ rcc_loop"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "bang",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        150.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "trigger b b"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        195.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "rcc_loop"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-6",
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
                                        "obj-7",
                                        0
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
                                    "source": [
                                        "obj-7",
                                        1
                                    ],
                                    "midpoints": [
                                        173.0,
                                        130.0,
                                        34.0,
                                        130.0
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
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        34.0,
                                        176.0,
                                        18.0,
                                        176.0,
                                        18.0,
                                        236.0,
                                        79.0,
                                        236.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-9",
                                        0
                                    ],
                                    "source": [
                                        "obj-8",
                                        1
                                    ],
                                    "midpoints": [
                                        119.0,
                                        175.0,
                                        34.0,
                                        175.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-2",
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
                        30.0,
                        90.0,
                        60.0,
                        22.0
                    ],
                    "text": "p io"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
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
                                    "comment": "source buffer name",
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
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "sensitivity 0-100",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "slice buffer name list",
                                    "id": "obj-3",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        500.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "slice count",
                                    "id": "obj-4",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        170.0,
                                        500.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-905",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        60.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "trigger b b s s",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-906",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        140.0,
                                        140.0,
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
                                    "id": "obj-907",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        60.0,
                                        100.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "source $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-908",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        60.0,
                                        149.0,
                                        22.0
                                    ],
                                    "text": "scale 0. 100. 1. 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-909",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        100.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "trigger b f",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-910",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        140.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "threshold $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-911",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        140.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "delay 250",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-912",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        180.0,
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
                                    "maxclass": "newobj",
                                    "id": "obj-913",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        170.0,
                                        230.0,
                                        688.0,
                                        22.0
                                    ],
                                    "text": "fluid.bufonsetslice~ @indices rcc_indices @metric 1 @threshold 0.3 @minslicelength 2 @blocking 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-914",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        170.0,
                                        275.0,
                                        180.0,
                                        22.0
                                    ],
                                    "text": "js read_indices.js",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-915",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        320.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "zl.reg",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-916",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        370.0,
                                        352.0,
                                        22.0
                                    ],
                                    "text": "ears.split~ @mode list @timeunit samps @naming 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-917",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        284.0,
                                        320.0,
                                        163.0,
                                        22.0
                                    ],
                                    "text": "send rcc_slice_starts",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-918",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        460.0,
                                        320.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "send rcc_chans",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-919",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        410.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "trigger l l",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-920",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        170.0,
                                        450.0,
                                        170.0,
                                        22.0
                                    ],
                                    "text": "zl.len @zlmaxsize 4096",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-921",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        560.0,
                                        60.0,
                                        149.0,
                                        22.0
                                    ],
                                    "text": "buffer~ rcc_indices",
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
                                        "obj-905",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-905",
                                        3
                                    ],
                                    "destination": [
                                        "obj-915",
                                        1
                                    ],
                                    "midpoints": [
                                        147.0,
                                        125.0,
                                        84.0,
                                        125.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-905",
                                        1
                                    ],
                                    "destination": [
                                        "obj-907",
                                        0
                                    ],
                                    "midpoints": [
                                        71.66666666666666,
                                        85.0,
                                        64.0,
                                        85.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-907",
                                        0
                                    ],
                                    "destination": [
                                        "obj-913",
                                        0
                                    ],
                                    "midpoints": [
                                        64.0,
                                        165.0,
                                        174.0,
                                        165.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-905",
                                        2
                                    ],
                                    "destination": [
                                        "obj-906",
                                        0
                                    ],
                                    "midpoints": [
                                        109.33333333333333,
                                        85.0,
                                        144.0,
                                        85.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-906",
                                        0
                                    ],
                                    "destination": [
                                        "obj-912",
                                        0
                                    ],
                                    "midpoints": [
                                        144.0,
                                        169.0,
                                        424.0,
                                        169.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-905",
                                        0
                                    ],
                                    "destination": [
                                        "obj-913",
                                        0
                                    ],
                                    "midpoints": [
                                        34.0,
                                        173.0,
                                        174.0,
                                        173.0
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
                                        "obj-908",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-908",
                                        0
                                    ],
                                    "destination": [
                                        "obj-909",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-909",
                                        1
                                    ],
                                    "destination": [
                                        "obj-910",
                                        0
                                    ],
                                    "midpoints": [
                                        509.0,
                                        125.0,
                                        504.0,
                                        125.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-910",
                                        0
                                    ],
                                    "destination": [
                                        "obj-913",
                                        0
                                    ],
                                    "midpoints": [
                                        504.0,
                                        165.0,
                                        174.0,
                                        165.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-909",
                                        0
                                    ],
                                    "destination": [
                                        "obj-911",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-911",
                                        0
                                    ],
                                    "destination": [
                                        "obj-912",
                                        1
                                    ],
                                    "midpoints": [
                                        424.0,
                                        169.0,
                                        468.0,
                                        169.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-912",
                                        0
                                    ],
                                    "destination": [
                                        "obj-913",
                                        0
                                    ],
                                    "midpoints": [
                                        424.0,
                                        205.0,
                                        174.0,
                                        205.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-913",
                                        0
                                    ],
                                    "destination": [
                                        "obj-914",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-914",
                                        1
                                    ],
                                    "destination": [
                                        "obj-916",
                                        1
                                    ],
                                    "midpoints": [
                                        231.33333333333334,
                                        346.0,
                                        378.0,
                                        346.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-914",
                                        0
                                    ],
                                    "destination": [
                                        "obj-915",
                                        0
                                    ],
                                    "midpoints": [
                                        174.0,
                                        300.0,
                                        34.0,
                                        300.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-914",
                                        2
                                    ],
                                    "destination": [
                                        "obj-917",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-914",
                                        3
                                    ],
                                    "destination": [
                                        "obj-918",
                                        0
                                    ],
                                    "midpoints": [
                                        346.0,
                                        300.0,
                                        464.0,
                                        300.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-915",
                                        0
                                    ],
                                    "destination": [
                                        "obj-916",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-916",
                                        0
                                    ],
                                    "destination": [
                                        "obj-919",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-919",
                                        1
                                    ],
                                    "destination": [
                                        "obj-920",
                                        0
                                    ],
                                    "midpoints": [
                                        119.0,
                                        435.0,
                                        174.0,
                                        435.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-920",
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
                                        "obj-919",
                                        0
                                    ],
                                    "destination": [
                                        "obj-3",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        30.0,
                        260.0,
                        175.0,
                        22.0
                    ],
                    "text": "p slicer"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-25",
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
                            "revision": 2,
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
                                    "comment": "transport on/off",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "bpm",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "float"
                                    ],
                                    "patching_rect": [
                                        110.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "step count",
                                    "id": "obj-3",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "float"
                                    ],
                                    "patching_rect": [
                                        250.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "mode (0=straight, 1=euclid)",
                                    "id": "obj-4",
                                    "index": 5,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        561.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "euclid k",
                                    "id": "obj-5",
                                    "index": 6,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        658.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "manual randomize bang",
                                    "id": "obj-6",
                                    "index": 8,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "auto-reshuffle enable",
                                    "id": "obj-7",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        800.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "auto-reshuffle N bars",
                                    "id": "obj-8",
                                    "index": 7,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        880.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "current slice name (symbol)",
                                    "id": "obj-9",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        700.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-37",
                                    "numinlets": 4,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        60.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "rtt.clock~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-38",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        250.0,
                                        60.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "trigger i i i i",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-39",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        100.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "sig~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-40",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        140.0,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-41",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        180.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "trunc~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-42",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        110.0,
                                        180.0,
                                        66.105339,
                                        22.0
                                    ],
                                    "text": "%~ 1.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-43",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        110.0,
                                        210.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "delta~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-44",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        110.0,
                                        240.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "<~ 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-45",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        110.0,
                                        270.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "edge~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-46",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        310.0,
                                        87.0,
                                        22.0
                                    ],
                                    "text": "snapshot~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-47",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        350.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "trigger i i",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-48",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        400.0,
                                        191.0,
                                        22.0
                                    ],
                                    "text": "zl.lookup @zlmaxsize 4096",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        460.0,
                                        48.0,
                                        22.0
                                    ],
                                    "text": "% 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-50",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        460.0,
                                        400.0,
                                        300.0,
                                        22.0
                                    ],
                                    "text": "expr ($i2==0) || ((($i1*$i3)%$i4)<$i3)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-51",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        500.0,
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
                                    "maxclass": "newobj",
                                    "id": "obj-52",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        540.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "trigger i i",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-53",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        620.0,
                                        191.0,
                                        22.0
                                    ],
                                    "text": "zl.lookup @zlmaxsize 4096",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-54",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        240.0,
                                        580.0,
                                        191.0,
                                        22.0
                                    ],
                                    "text": "zl.lookup @zlmaxsize 4096",
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
                                        240.0,
                                        620.0,
                                        163.0,
                                        22.0
                                    ],
                                    "text": "line samples, line $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-56",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        240.0,
                                        660.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "send rcc_wave",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-57",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        800.0,
                                        300.0,
                                        177.0,
                                        22.0
                                    ],
                                    "text": "receive rcc_slice_names",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-58",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        800.0,
                                        330.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "trigger l l",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-59",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        880.0,
                                        360.0,
                                        170.0,
                                        22.0
                                    ],
                                    "text": "zl.len @zlmaxsize 4096",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-60",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        880.0,
                                        390.0,
                                        82.0,
                                        22.0
                                    ],
                                    "text": "maximum 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-61",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        460.0,
                                        540.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "receive rcc_slice_starts",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-62",
                                    "numinlets": 2,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        280.0,
                                        100.0,
                                        62.0,
                                        22.0
                                    ],
                                    "text": "uzi",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-63",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        280.0,
                                        135.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "- 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-64",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        250.0,
                                        170.0,
                                        81.0,
                                        22.0
                                    ],
                                    "text": "zl.group",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-65",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        250.0,
                                        280.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "zl.reg",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-66",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        250.0,
                                        315.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "trigger l l",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-67",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        345.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "zl.scramble",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-68",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        800.0,
                                        100.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "edge~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-69",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        800.0,
                                        140.0,
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
                                    "maxclass": "newobj",
                                    "id": "obj-70",
                                    "numinlets": 5,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        800.0,
                                        180.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "counter 1 4",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-71",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        800.0,
                                        220.0,
                                        54.0,
                                        22.0
                                    ],
                                    "text": "sel 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-72",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        350,
                                        250,
                                        80.5,
                                        22.0
                                    ],
                                    "text": "trigger b",
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
                                        "obj-37",
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
                                        "obj-37",
                                        1
                                    ],
                                    "midpoints": [
                                        114.0,
                                        53.0,
                                        60.0,
                                        53.0
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
                                        "obj-38",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-38",
                                        3
                                    ],
                                    "destination": [
                                        "obj-50",
                                        3
                                    ],
                                    "midpoints": [
                                        367.0,
                                        85.0,
                                        756.0,
                                        85.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-38",
                                        2
                                    ],
                                    "destination": [
                                        "obj-64",
                                        1
                                    ],
                                    "midpoints": [
                                        329.3333333333333,
                                        90.0,
                                        383.0,
                                        90.0,
                                        383.0,
                                        166.0,
                                        327.0,
                                        166.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-38",
                                        1
                                    ],
                                    "destination": [
                                        "obj-62",
                                        0
                                    ],
                                    "midpoints": [
                                        291.6666666666667,
                                        85.0,
                                        284.0,
                                        85.0
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
                                        254.0,
                                        85.0,
                                        134.0,
                                        85.0
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
                                        "obj-40",
                                        0
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
                                        "obj-40",
                                        1
                                    ],
                                    "midpoints": [
                                        134.0,
                                        125.0,
                                        68.0,
                                        125.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-40",
                                        0
                                    ],
                                    "destination": [
                                        "obj-41",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-40",
                                        0
                                    ],
                                    "destination": [
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        34.0,
                                        165.0,
                                        114.0,
                                        165.0
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
                                        "obj-45",
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
                                        "obj-46",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-45",
                                        0
                                    ],
                                    "destination": [
                                        "obj-46",
                                        0
                                    ],
                                    "midpoints": [
                                        114.0,
                                        295.0,
                                        34.0,
                                        295.0
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
                                        "obj-47",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-47",
                                        1
                                    ],
                                    "destination": [
                                        "obj-50",
                                        0
                                    ],
                                    "midpoints": [
                                        119.0,
                                        375.0,
                                        464.0,
                                        375.0
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
                                        "obj-4",
                                        0
                                    ],
                                    "destination": [
                                        "obj-50",
                                        1
                                    ],
                                    "midpoints": [
                                        565.0,
                                        53.0,
                                        561.3333333333334,
                                        53.0
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
                                        "obj-50",
                                        2
                                    ],
                                    "midpoints": [
                                        662.0,
                                        53.0,
                                        658.6666666666666,
                                        53.0
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
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        464.0,
                                        485.0,
                                        34.0,
                                        485.0
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
                                        "obj-51",
                                        1
                                    ],
                                    "midpoints": [
                                        34.0,
                                        489.0,
                                        78.0,
                                        489.0
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
                                        1
                                    ],
                                    "destination": [
                                        "obj-54",
                                        0
                                    ],
                                    "midpoints": [
                                        119.0,
                                        565.0,
                                        244.0,
                                        565.0
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
                                        "obj-55",
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
                                        "obj-56",
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
                                        "obj-9",
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
                                        "obj-58",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-58",
                                        1
                                    ],
                                    "destination": [
                                        "obj-59",
                                        0
                                    ],
                                    "midpoints": [
                                        889.0,
                                        355.0,
                                        884.0,
                                        355.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-59",
                                        0
                                    ],
                                    "destination": [
                                        "obj-60",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-60",
                                        0
                                    ],
                                    "destination": [
                                        "obj-49",
                                        1
                                    ],
                                    "midpoints": [
                                        884.0,
                                        425.0,
                                        74.0,
                                        425.0
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
                                        "obj-53",
                                        1
                                    ],
                                    "midpoints": [
                                        804.0,
                                        429.0,
                                        217.0,
                                        429.0
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
                                        "obj-54",
                                        1
                                    ],
                                    "midpoints": [
                                        464.0,
                                        565.0,
                                        427.0,
                                        565.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-62",
                                        1
                                    ],
                                    "destination": [
                                        "obj-63",
                                        0
                                    ],
                                    "midpoints": [
                                        311.0,
                                        125.0,
                                        284.0,
                                        125.0
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
                                        "obj-64",
                                        0
                                    ],
                                    "midpoints": [
                                        284.0,
                                        160.0,
                                        254.0,
                                        160.0
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
                                        "obj-65",
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
                                        "obj-66",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-66",
                                        1
                                    ],
                                    "destination": [
                                        "obj-48",
                                        1
                                    ],
                                    "midpoints": [
                                        339.0,
                                        340.0,
                                        217.0,
                                        340.0
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
                                        "obj-67",
                                        0
                                    ],
                                    "midpoints": [
                                        254.0,
                                        340.0,
                                        354.0,
                                        340.0
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
                                        "obj-65",
                                        1
                                    ],
                                    "midpoints": [
                                        354.0,
                                        371.0,
                                        238.0,
                                        371.0,
                                        238.0,
                                        276.0,
                                        304.0,
                                        276.0
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
                                        "obj-72",
                                        0
                                    ],
                                    "midpoints": [
                                        724.0,
                                        95.0,
                                        354,
                                        95.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-72",
                                        0
                                    ],
                                    "destination": [
                                        "obj-65",
                                        0
                                    ],
                                    "midpoints": [
                                        354,
                                        275.0,
                                        254.0,
                                        275.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-37",
                                        1
                                    ],
                                    "destination": [
                                        "obj-68",
                                        0
                                    ],
                                    "midpoints": [
                                        112.0,
                                        89.0,
                                        804.0,
                                        89.0
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
                                        "obj-69",
                                        1
                                    ],
                                    "midpoints": [
                                        804.0,
                                        125.0,
                                        848.0,
                                        125.0
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
                                        "obj-69",
                                        0
                                    ],
                                    "midpoints": [
                                        804.0,
                                        54.0,
                                        788.0,
                                        54.0,
                                        788.0,
                                        136.0,
                                        804.0,
                                        136.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-69",
                                        0
                                    ],
                                    "destination": [
                                        "obj-70",
                                        0
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
                                        "obj-70",
                                        4
                                    ],
                                    "midpoints": [
                                        884.0,
                                        53.0,
                                        889.0,
                                        53.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-70",
                                        0
                                    ],
                                    "destination": [
                                        "obj-71",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-71",
                                        0
                                    ],
                                    "destination": [
                                        "obj-72",
                                        0
                                    ],
                                    "midpoints": [
                                        804.0,
                                        245.0,
                                        354,
                                        245.0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        250.0,
                        260.0,
                        615.0,
                        22.0
                    ],
                    "text": "p sequencer"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-26",
                    "maxclass": "newobj",
                    "numinlets": 1,
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
                            "revision": 2,
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
                                    "comment": "slice buffer name (symbol)",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "audio L",
                                    "id": "obj-2",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        620.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "audio R",
                                    "id": "obj-3",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        170.0,
                                        620.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-11",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30,
                                        60,
                                        101.0,
                                        22.0
                                    ],
                                    "text": "route symbol",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30,
                                        100,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "trigger s b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-13",
                                    "numinlets": 5,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        110,
                                        140,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "counter 0 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-14",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        110,
                                        180,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "+ 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-15",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30,
                                        220,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "gate 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-16",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        400,
                                        20,
                                        147.0,
                                        22.0
                                    ],
                                    "text": "buffer~ rcc_dummy",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-17",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        105,
                                        260,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "trigger s b b",
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30,
                                        300,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "sig~ 1.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-19",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        105,
                                        300,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "set $1, startloop",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        300,
                                        300,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "0 0 1 2",
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
                                        250,
                                        300,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "0 8",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-22",
                                    "numinlets": 3,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30,
                                        370,
                                        140.0,
                                        22.0
                                    ],
                                    "text": "groove~ rcc_dummy 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-23",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        300,
                                        370,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "line~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-24",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30,
                                        420,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-25",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        100,
                                        420,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-26",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        475,
                                        260,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "trigger s b b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-27",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        400,
                                        300,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "sig~ 1.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-28",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        475,
                                        300,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "set $1, startloop",
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
                                        670,
                                        300,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "0 0 1 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-30",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        620,
                                        300,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "0 8",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-31",
                                    "numinlets": 3,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        400,
                                        370,
                                        140.0,
                                        22.0
                                    ],
                                    "text": "groove~ rcc_dummy 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-32",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        670,
                                        370,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "line~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-33",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        400,
                                        420,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-34",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        470,
                                        420,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-35",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30,
                                        470,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-36",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        170,
                                        470,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-37",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        260,
                                        470,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "receive rcc_chans",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-38",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        260,
                                        500,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "== 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-39",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        110,
                                        530,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-40",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        170,
                                        570,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "source": [
                                        "obj-15",
                                        0
                                    ],
                                    "destination": [
                                        "obj-17",
                                        0
                                    ],
                                    "midpoints": [
                                        34.0,
                                        245.0,
                                        109,
                                        245.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-17",
                                        2
                                    ],
                                    "destination": [
                                        "obj-20",
                                        0
                                    ],
                                    "midpoints": [
                                        208.0,
                                        285.0,
                                        304.0,
                                        285.0
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
                                        "obj-22",
                                        0
                                    ],
                                    "midpoints": [
                                        109,
                                        325.0,
                                        34.0,
                                        325.0
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
                                        "obj-22",
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
                                        "obj-23",
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
                                        "obj-24",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-22",
                                        1
                                    ],
                                    "destination": [
                                        "obj-25",
                                        0
                                    ],
                                    "midpoints": [
                                        166.0,
                                        395.0,
                                        104.0,
                                        395.0
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
                                        "obj-24",
                                        1
                                    ],
                                    "midpoints": [
                                        304.0,
                                        399.0,
                                        68.0,
                                        399.0
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
                                        "obj-25",
                                        1
                                    ],
                                    "midpoints": [
                                        304.0,
                                        403.0,
                                        138.0,
                                        403.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-15",
                                        1
                                    ],
                                    "destination": [
                                        "obj-26",
                                        0
                                    ],
                                    "midpoints": [
                                        84.0,
                                        249.0,
                                        479,
                                        249.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-26",
                                        2
                                    ],
                                    "destination": [
                                        "obj-29",
                                        0
                                    ],
                                    "midpoints": [
                                        578.0,
                                        285.0,
                                        674.0,
                                        285.0
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
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        479,
                                        325.0,
                                        404.0,
                                        325.0
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
                                        "obj-31",
                                        0
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
                                        "obj-32",
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
                                        "obj-33",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        1
                                    ],
                                    "destination": [
                                        "obj-34",
                                        0
                                    ],
                                    "midpoints": [
                                        536.0,
                                        395.0,
                                        474.0,
                                        395.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        674.0,
                                        399.0,
                                        438.0,
                                        399.0
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
                                        "obj-34",
                                        1
                                    ],
                                    "midpoints": [
                                        674.0,
                                        403.0,
                                        508.0,
                                        403.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-17",
                                        1
                                    ],
                                    "destination": [
                                        "obj-21",
                                        0
                                    ],
                                    "midpoints": [
                                        158.5,
                                        289.0,
                                        254.0,
                                        289.0
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
                                        "obj-32",
                                        0
                                    ],
                                    "midpoints": [
                                        254,
                                        329.0,
                                        674.0,
                                        329.0
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
                                        "obj-30",
                                        0
                                    ],
                                    "midpoints": [
                                        528.5,
                                        289.0,
                                        624.0,
                                        289.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-30",
                                        0
                                    ],
                                    "destination": [
                                        "obj-23",
                                        0
                                    ],
                                    "midpoints": [
                                        624,
                                        333.0,
                                        304.0,
                                        333.0
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
                                        "obj-11",
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
                                        1
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        119.0,
                                        125.0,
                                        114.0,
                                        125.0
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
                                        0
                                    ],
                                    "destination": [
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        114,
                                        205.0,
                                        34.0,
                                        205.0
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
                                        "obj-15",
                                        1
                                    ],
                                    "midpoints": [
                                        34.0,
                                        125.0,
                                        84.0,
                                        125.0
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
                                        "obj-35",
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
                                        "obj-35",
                                        1
                                    ],
                                    "midpoints": [
                                        404,
                                        445.0,
                                        73.5,
                                        445.0
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
                                        "obj-36",
                                        0
                                    ],
                                    "midpoints": [
                                        104,
                                        449.0,
                                        174.0,
                                        449.0
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
                                        "obj-36",
                                        1
                                    ],
                                    "midpoints": [
                                        474,
                                        449.0,
                                        213.5,
                                        449.0
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
                                        "obj-38",
                                        0
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
                                        1
                                    ],
                                    "midpoints": [
                                        264,
                                        525.0,
                                        148.0,
                                        525.0
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
                                        "obj-39",
                                        0
                                    ],
                                    "midpoints": [
                                        34,
                                        495.0,
                                        114.0,
                                        495.0
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
                                        "obj-40",
                                        0
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
                                        "obj-40",
                                        1
                                    ],
                                    "midpoints": [
                                        114,
                                        555.0,
                                        213.5,
                                        555.0
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
                                        "obj-2",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-40",
                                        0
                                    ],
                                    "destination": [
                                        "obj-3",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        250.0,
                        300.0,
                        95.0,
                        22.0
                    ],
                    "text": "p player"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-27",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        130.0,
                        50.0,
                        22.0
                    ],
                    "text": "t s s"
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
                        76.0,
                        170.0,
                        60.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-29",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        300.0,
                        120.0,
                        22.0
                    ],
                    "text": "s rcc_slice_names"
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
                    "id": "obj-31",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        190.0,
                        20.0,
                        60.0,
                        22.0
                    ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-32",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 6,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        190.0,
                        55.0,
                        675.0,
                        22.0
                    ],
                    "text": "t b b b b b b"
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
                        336.0,
                        95.0,
                        40.0,
                        22.0
                    ],
                    "text": "120"
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
                        190.0,
                        95.0,
                        40.0,
                        22.0
                    ],
                    "text": "70"
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
                        421.0,
                        95.0,
                        40.0,
                        22.0
                    ],
                    "text": "16"
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
                        507.0,
                        95.0,
                        40.0,
                        22.0
                    ],
                    "text": "0"
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
                        593.0,
                        95.0,
                        40.0,
                        22.0
                    ],
                    "text": "5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-38",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        850.0,
                        95.0,
                        40.0,
                        22.0
                    ],
                    "text": "4"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1000.0,
                        20.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.1.0"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-40",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1000.0,
                        45.0,
                        86.0,
                        22.0
                    ],
                    "text": "p about",
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
                            120.0,
                            120.0,
                            750.0,
                            390.0
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
                                        20,
                                        20,
                                        700,
                                        26
                                    ],
                                    "text": "RHYTHMIC CORPUS CHOPPER -- slice a loop at its hits and resequence them",
                                    "fontname": "Arial",
                                    "fontsize": 16.0,
                                    "fontface": 1
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
                                        20,
                                        58,
                                        700,
                                        23
                                    ],
                                    "text": "USING IT",
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "fontface": 1
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
                                        20,
                                        83,
                                        700,
                                        22
                                    ],
                                    "text": "Needs the FluCoMa, EARS (with bach) and Rhythm and Time Toolkit packages.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        105,
                                        700,
                                        22
                                    ],
                                    "text": "Load loop: drop an audio file here. The waveform shows it and it is sliced at each hit.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        127,
                                        700,
                                        22
                                    ],
                                    "text": "Slices: how many hits were found. Sens (0-100): higher finds more slices; changes re-slice the loop live.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-6",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        149,
                                        700,
                                        22
                                    ],
                                    "text": "Play: starts and stops the sequencer. Tempo: 40-240 BPM (default 120). Volume + Audio: output level and DSP on/off.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        171,
                                        700,
                                        22
                                    ],
                                    "text": "Steps (1-64): sequence length. Steps loop back over the slices if there are fewer.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-8",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        193,
                                        700,
                                        22
                                    ],
                                    "text": "Mode Straight: every step plays a slice. Euclid: only Euclid k hits spread over the steps play.",
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
                                        20,
                                        215,
                                        700,
                                        22
                                    ],
                                    "text": "Scramble: shuffles the step order (each slice once per cycle).",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-10",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        237,
                                        700,
                                        22
                                    ],
                                    "text": "Auto bars: toggle on to reshuffle automatically every N bars (default 4).",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-11",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        269,
                                        700,
                                        23
                                    ],
                                    "text": "HOW IT WORKS",
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "fontface": 1
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
                                        20,
                                        294,
                                        700,
                                        22
                                    ],
                                    "text": "fluid.bufonsetslice~ finds the hit points; ears.split~ cuts the loop into one buffer per slice.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-13",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        316,
                                        700,
                                        22
                                    ],
                                    "text": "rtt.clock~ runs a bar-rate ramp that is split into steps.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        20,
                                        338,
                                        700,
                                        22
                                    ],
                                    "text": "Each step picks a slice (wrapping over the slice count); two crossfading groove~ voices play it, and the waveform line marks it.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [],
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
                    "id": "obj-41",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        76.0,
                        205.0,
                        107.0,
                        22.0
                    ],
                    "text": "send rcc_wave",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        620.0,
                        128.0,
                        22.0
                    ],
                    "text": "receive rcc_wave",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-43",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420.0,
                        330.0,
                        45.0,
                        45.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        690.0,
                        90.0,
                        60.0,
                        60.0
                    ],
                    "size": 101.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-44",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420.0,
                        300.0,
                        93.0,
                        22.0
                    ],
                    "text": "loadmess 70",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-45",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420.0,
                        390.0,
                        58.0,
                        22.0
                    ],
                    "text": "/ 100.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-46",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420.0,
                        420.0,
                        51.0,
                        22.0
                    ],
                    "text": "$1 20",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-47",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        420.0,
                        450.0,
                        51.0,
                        22.0
                    ],
                    "text": "line~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-48",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        250.0,
                        490.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-49",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        330.0,
                        490.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "ezdac~",
                    "id": "obj-50",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        250.0,
                        530.0,
                        45.0,
                        45.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        770.0,
                        90.0,
                        45.0,
                        45.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-51",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        305.0,
                        530.0,
                        12.0,
                        60.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        825.0,
                        90.0,
                        12.0,
                        60.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-52",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        322.0,
                        530.0,
                        12.0,
                        60.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        841.0,
                        90.0,
                        12.0,
                        60.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-53",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        480.0,
                        330.0,
                        58.0,
                        20.0
                    ],
                    "text": "Volume",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        690.0,
                        160.0,
                        60.0,
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
                    "maxclass": "comment",
                    "id": "obj-54",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        250.0,
                        585.0,
                        51.0,
                        20.0
                    ],
                    "text": "Audio",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        770.0,
                        160.0,
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
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-23",
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
                        "obj-25",
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
                        "obj-25",
                        1
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
                        "obj-27",
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
                    "midpoints": [
                        201.0,
                        285.0,
                        164.0,
                        285.0
                    ],
                    "source": [
                        "obj-24",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-29",
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
                        "obj-26",
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
                        "obj-24",
                        0
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
                        "obj-28",
                        0
                    ],
                    "source": [
                        "obj-27",
                        1
                    ],
                    "midpoints": [
                        76.0,
                        155.0,
                        80.0,
                        155.0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-24",
                        1
                    ],
                    "midpoints": [
                        194.0,
                        238.0,
                        201.0,
                        238.0
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
                        "obj-32",
                        0
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
                        "obj-2",
                        0
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
                        "obj-3",
                        0
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
                        "obj-4",
                        0
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
                        "obj-5",
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
                        "obj-6",
                        0
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
                        "obj-9",
                        0
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
                        "obj-25",
                        2
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
                        "obj-25",
                        3
                    ],
                    "midpoints": [
                        511.0,
                        178.0,
                        514.1428571428571,
                        178.0
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
                        "obj-25",
                        4
                    ],
                    "midpoints": [
                        597.0,
                        180.0,
                        600.8571428571429,
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
                        "obj-25",
                        5
                    ],
                    "midpoints": [
                        683.0,
                        182.0,
                        687.5714285714286,
                        182.0
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
                        "obj-25",
                        6
                    ],
                    "midpoints": [
                        768.0,
                        182.0,
                        774.2857142857143,
                        182.0
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
                        "obj-25",
                        7
                    ],
                    "midpoints": [
                        854.0,
                        180.0,
                        861.0,
                        180.0
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
                        "obj-28",
                        0
                    ],
                    "destination": [
                        "obj-41",
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
                        "obj-12",
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
                        "obj-45",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
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
                        "obj-47",
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
                        1
                    ],
                    "midpoints": [
                        424.0,
                        475.0,
                        288.0,
                        475.0
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
                        "obj-49",
                        1
                    ],
                    "midpoints": [
                        424.0,
                        479.0,
                        368.0,
                        479.0
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
                        "obj-48",
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
                        "obj-49",
                        0
                    ],
                    "midpoints": [
                        341.0,
                        325.0,
                        334.0,
                        325.0
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
                        "obj-50",
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
                        "obj-50",
                        1
                    ],
                    "midpoints": [
                        334.0,
                        515.0,
                        291.0,
                        515.0
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
                        "obj-51",
                        0
                    ],
                    "midpoints": [
                        254.0,
                        519.0,
                        309.0,
                        519.0
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
                        "obj-52",
                        0
                    ],
                    "midpoints": [
                        334.0,
                        519.0,
                        326.0,
                        519.0
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
                        "obj-34",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-32",
                        1
                    ],
                    "destination": [
                        "obj-33",
                        0
                    ],
                    "midpoints": [
                        327.4,
                        80.0,
                        340.0,
                        80.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-32",
                        2
                    ],
                    "destination": [
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        460.8,
                        80.0,
                        425.0,
                        80.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-32",
                        3
                    ],
                    "destination": [
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        594.2,
                        80.0,
                        511.0,
                        80.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-32",
                        4
                    ],
                    "destination": [
                        "obj-37",
                        0
                    ],
                    "midpoints": [
                        727.6,
                        80.0,
                        597.0,
                        80.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-32",
                        5
                    ],
                    "destination": [
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        861.0,
                        80.0,
                        854.0,
                        80.0
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
        "bgcolor": [
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