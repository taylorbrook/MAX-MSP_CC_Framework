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
            100.0,
            100.0,
            1542.0,
            783.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "maxclass": "panel",
                    "id": "obj-81",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1420.0,
                        400.0,
                        60.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        4.0,
                        2.0,
                        652.0,
                        343.0
                    ],
                    "background": 1,
                    "ignoreclick": 1,
                    "border": 0,
                    "rounded": 8,
                    "mode": 0,
                    "bgcolor": [
                        0.24,
                        0.24,
                        0.27,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "bang"
                    ],
                    "patching_rect": [
                        1100.0,
                        175.0,
                        198.0,
                        22.0
                    ],
                    "text": "buffer~ timestretch-source"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        440.0,
                        225.0,
                        80.0,
                        22.0
                    ],
                    "text": "selector~ 2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        500.0,
                        340.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "bang"
                    ],
                    "patching_rect": [
                        800.0,
                        150.0,
                        51.0,
                        22.0
                    ],
                    "text": "line~"
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        500.0,
                        385.0,
                        72.0,
                        22.0
                    ],
                    "text": "dac~ 1 2"
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "markers": [
                        -60,
                        -48,
                        -36,
                        -24,
                        -12,
                        -6,
                        0,
                        6
                    ],
                    "markersused": 8,
                    "maxclass": "levelmeter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        500.0,
                        425.0,
                        64.0,
                        32.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        532.0,
                        225.0,
                        118.0,
                        50.0
                    ]
                }
            },
            {
                "box": {
                    "buffername": "timestretch-source",
                    "id": "obj-10",
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
                        370.0,
                        505.0,
                        160.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        30.0,
                        640.0,
                        100.0
                    ],
                    "setmode": 1
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
                        "float"
                    ],
                    "patching_rect": [
                        250.0,
                        340.0,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50"
                }
            },
            {
                "box": {
                    "id": "obj-12",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        250.0,
                        385.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        416.0,
                        240.0,
                        18.0,
                        18.0
                    ],
                    "ignoreclick": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-13",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        370.0,
                        340.0,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50"
                }
            },
            {
                "box": {
                    "id": "obj-19",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        20.0,
                        0.0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        145.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                1.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Stretch [ts-1]",
                            "parameter_mmax": 16.0,
                            "parameter_mmin": 0.25,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Stretch",
                            "parameter_type": 0,
                            "parameter_unitstyle": 9,
                            "parameter_exponent": 4.39,
                            "parameter_units": "x"
                        }
                    },
                    "varname": "stretch"
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
                        20.0,
                        55.0,
                        105.0,
                        22.0
                    ],
                    "text": "stretch $1"
                }
            },
            {
                "box": {
                    "id": "obj-21",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        399.0,
                        0.0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        100.0,
                        145.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                40.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Grain [ts-2]",
                            "parameter_mmax": 200.0,
                            "parameter_mmin": 5.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Grain",
                            "parameter_type": 0,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "grain"
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
                        399.0,
                        55.0,
                        113.0,
                        22.0
                    ],
                    "text": "grain_ms $1"
                }
            },
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        520.0,
                        0.0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        180.0,
                        145.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Pitch ct [ts-3]",
                            "parameter_mmax": 2400.0,
                            "parameter_mmin": -2400.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Pitch ct",
                            "parameter_type": 0,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "pitch"
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
                        520.0,
                        55.0,
                        89.0,
                        22.0
                    ],
                    "text": "pitch $1"
                }
            },
            {
                "box": {
                    "id": "obj-25",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        270.0,
                        0.0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        225.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                128.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "WSOLA [ts-4]",
                            "parameter_mmax": 256.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "WSOLA",
                            "parameter_type": 0,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "wsola"
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
                        270.0,
                        55.0,
                        121.0,
                        22.0
                    ],
                    "text": "wsola_tol $1"
                }
            },
            {
                "box": {
                    "id": "obj-27",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        133.0,
                        0.0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        100.0,
                        225.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.05
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Jitter [ts-5]",
                            "parameter_mmax": 0.25,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Jitter",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "jitter"
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
                        133.0,
                        55.0,
                        129.0,
                        22.0
                    ],
                    "text": "jitter_amt $1"
                }
            },
            {
                "box": {
                    "id": "obj-29",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        617.0,
                        0.0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        180.0,
                        225.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Sens [ts-6]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Sens",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "sens"
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
                        617.0,
                        55.0,
                        137.0,
                        22.0
                    ],
                    "text": "sensitivity $1"
                }
            },
            {
                "box": {
                    "id": "obj-31",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        762.0,
                        0.0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        475.0,
                        240.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Gain [ts-7]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Gain",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "gain"
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
                        762.0,
                        55.0,
                        65.0,
                        22.0
                    ],
                    "text": "$1 20"
                }
            },
            {
                "box": {
                    "id": "obj-33",
                    "items": [
                        "2 voices",
                        ",",
                        "4 voices",
                        ",",
                        "8 voices"
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
                        20.0,
                        255.0,
                        100.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        260.0,
                        165.0,
                        80.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-38",
                    "maxclass": "live.toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        948.0,
                        10.0,
                        15.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        260.0,
                        240.0,
                        18.0,
                        18.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [
                                "off",
                                "on"
                            ],
                            "parameter_initial": [
                                1
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Adaptive [ts-8]",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Adaptive",
                            "parameter_type": 2
                        }
                    },
                    "varname": "adaptive"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        948.0,
                        55.0,
                        89.0,
                        22.0
                    ],
                    "text": "adapt $1"
                }
            },
            {
                "box": {
                    "id": "obj-40",
                    "maxclass": "live.toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        835.0,
                        10.0,
                        15.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        364.0,
                        240.0,
                        18.0,
                        18.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [
                                "off",
                                "on"
                            ],
                            "parameter_initial": [
                                0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Extreme [ts-9]",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Extreme",
                            "parameter_type": 2
                        }
                    },
                    "varname": "extreme"
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
                        835.0,
                        55.0,
                        105.0,
                        22.0
                    ],
                    "text": "extreme $1"
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
                        330.0,
                        220.0,
                        65.0,
                        22.0
                    ],
                    "text": "mode $1"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.35,
                        0.35,
                        0.35,
                        1.0
                    ],
                    "id": "obj-46",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1100.0,
                        115.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        95.0,
                        310.0,
                        55.0,
                        25.0
                    ],
                    "rounded": 4.0,
                    "text": "LOAD",
                    "textcolor": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                    ]
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
                        1100.0,
                        145.0,
                        44.0,
                        22.0
                    ],
                    "text": "read"
                }
            },
            {
                "box": {
                    "id": "obj-48",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        20.0,
                        115.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        161.0,
                        310.0,
                        22.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-49",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        140.0,
                        115.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        216.0,
                        310.0,
                        22.0,
                        22.0
                    ]
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
                        140.0,
                        150.0,
                        105.0,
                        22.0
                    ],
                    "text": "looping $1"
                }
            },
            {
                "box": {
                    "id": "obj-51",
                    "maxclass": "preset",
                    "numinlets": 1,
                    "numoutlets": 5,
                    "outlettype": [
                        "preset",
                        "int",
                        "preset",
                        "int",
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        222.0,
                        100.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        475.0,
                        157.0,
                        175.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-52",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1330.0,
                        30.0,
                        212.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        6.0,
                        320.0,
                        22.0
                    ],
                    "text": "WSOLA Granular Time-Stretch"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-53",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1330.0,
                        55.0,
                        100.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        132.0,
                        90.0,
                        18.0
                    ],
                    "text": "TIME / PITCH"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-54",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1330.0,
                        80.0,
                        65.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        212.0,
                        70.0,
                        18.0
                    ],
                    "text": "QUALITY"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-55",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1330.0,
                        105.0,
                        65.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        260.0,
                        148.0,
                        55.0,
                        18.0
                    ],
                    "text": "Density"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-56",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1330.0,
                        130.0,
                        72.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        260.0,
                        225.0,
                        50.0,
                        18.0
                    ],
                    "text": "Adaptive"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-57",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1330.0,
                        155.0,
                        65.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        364.0,
                        225.0,
                        50.0,
                        18.0
                    ],
                    "text": "Extreme"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-58",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1330.0,
                        180.0,
                        79.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        416.0,
                        225.0,
                        50.0,
                        18.0
                    ],
                    "text": "Transient"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-59",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1330.0,
                        205.0,
                        58.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        295.0,
                        65.0,
                        18.0
                    ],
                    "text": "SOURCE"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-60",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1330.0,
                        230.0,
                        44.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        157.0,
                        295.0,
                        30.0,
                        18.0
                    ],
                    "text": "Play"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-61",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1330.0,
                        255.0,
                        44.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        212.0,
                        295.0,
                        31.0,
                        18.0
                    ],
                    "text": "Loop"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-62",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1330.0,
                        280.0,
                        65.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        475.0,
                        137.0,
                        65.0,
                        18.0
                    ],
                    "text": "PRESETS"
                }
            },
            {
                "box": {
                    "id": "obj-63",
                    "items": [
                        "none",
                        ",",
                        "live",
                        ",",
                        "buffer"
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
                        330.0,
                        150.0,
                        100.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        310.0,
                        70.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-65",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1052.0,
                        56.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.6.2"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-66",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1114.0,
                        10.0,
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
                            478.0
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
                                    "text": "TIMESTRETCH -- WSOLA granular time-stretch for live input or a loaded file",
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
                                    "text": "SOURCE menu: none (silent), live (inputs 1+2, stereo) or buffer (mono or stereo file).",
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
                                    "text": "LOAD: choose a sound file into the buffer. The waveform shows it.",
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
                                    "text": "Play / Loop: transport. Click the waveform to seek, drag to loop a region. FREEZE holds the read point.",
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
                                    "text": "TIME / PITCH: Stretch 0.25x to 16x (1x at 12 o'clock).",
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
                                    "text": "Grain: grain length, 5-200 ms. Pitch ct: pitch shift in cents (+/-2400).",
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
                                    "text": "Gain: output level, shown on the meter.",
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
                                    "text": "QUALITY: WSOLA sets how far each grain searches for a smooth join (0 = off).",
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
                                    "text": "Jitter: small random offset on grain starts. Sens: transient detection sensitivity.",
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
                                        259,
                                        700,
                                        22
                                    ],
                                    "text": "Density: 2, 4 or 8 overlapping grains. More = smoother, more CPU.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        281,
                                        700,
                                        22
                                    ],
                                    "text": "Adaptive: shorter grains on transients (the Transient light shows them).",
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
                                        303,
                                        700,
                                        22
                                    ],
                                    "text": "Extreme: Paulstretch-style smearing for very long stretches. Preserve: onsets play through at 1x (sharp attacks), the time is paid back after.",
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
                                        325,
                                        700,
                                        22
                                    ],
                                    "text": "PRESETS: click a slot to recall, shift-click to store.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-15",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        357,
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
                                    "id": "obj-16",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        382,
                                        700,
                                        22
                                    ],
                                    "text": "A gen~ codebox records live input into a ~11 s ring buffer, or reads the file buffer directly.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-17",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        404,
                                        700,
                                        22
                                    ],
                                    "text": "Hann-windowed grains overlap and add. The read point moves at 1/Stretch speed.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-18",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        426,
                                        700,
                                        22
                                    ],
                                    "text": "Each new grain searches nearby for the best-matching start (WSOLA) to avoid phasing.",
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
                    "maxclass": "message",
                    "id": "obj-68",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        150.0,
                        86.0,
                        22.0
                    ],
                    "text": "playing $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-69",
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
                        1100.0,
                        215.0,
                        160.0,
                        22.0
                    ],
                    "text": "info~ timestretch-source",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-70",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1100.0,
                        247.0,
                        72.0,
                        22.0
                    ],
                    "text": "bufsr $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-71",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1100.0,
                        279.0,
                        90.0,
                        22.0
                    ],
                    "text": "send ts-gen",
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
                        240.0,
                        255.0,
                        100.0,
                        22.0
                    ],
                    "text": "receive ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-73",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        370.0,
                        475.0,
                        65.0,
                        22.0
                    ],
                    "text": "line $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-74",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        660.0,
                        345.0,
                        80.0,
                        22.0
                    ],
                    "text": "snapshot~ 50",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-75",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        660.0,
                        377.0,
                        50.0,
                        22.0
                    ],
                    "text": "change",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-76",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        660.0,
                        409.0,
                        60.0,
                        22.0
                    ],
                    "text": "select 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-77",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        660.0,
                        441.0,
                        30.0,
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
                    "id": "obj-78",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        660.0,
                        473.0,
                        90.0,
                        22.0
                    ],
                    "text": "send ts-stop",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-79",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        50.0,
                        115.0,
                        75.0,
                        22.0
                    ],
                    "text": "receive ts-stop",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-80",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1330.0,
                        305.0,
                        58.0,
                        20.0
                    ],
                    "text": "OUTPUT",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        475.0,
                        212.0,
                        60.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-82",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        540.0,
                        475.0,
                        105.0,
                        22.0
                    ],
                    "text": "loadmess mouseoutput up",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-83",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        370.0,
                        560.0,
                        70.0,
                        22.0
                    ],
                    "text": "sel_a $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-84",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        470.0,
                        560.0,
                        70.0,
                        22.0
                    ],
                    "text": "sel_b $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-85",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        370.0,
                        592.0,
                        90.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-86",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        850.0,
                        190.0,
                        60.0,
                        22.0
                    ],
                    "text": "trigger b b b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-87",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        930.0,
                        245.0,
                        120.0,
                        22.0
                    ],
                    "text": "sel_a 0, sel_b 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-88",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        850.0,
                        245.0,
                        35.0,
                        22.0
                    ],
                    "text": "0 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-89",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        540.0,
                        505.0,
                        95.0,
                        22.0
                    ],
                    "text": "receive ts-wave",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-90",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        850.0,
                        277.0,
                        90.0,
                        22.0
                    ],
                    "text": "send ts-wave",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.text",
                    "id": "obj-91",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        115.0,
                        60.0,
                        20.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        260.0,
                        310.0,
                        70.0,
                        22.0
                    ],
                    "varname": "freeze",
                    "mode": 1,
                    "text": "FREEZE",
                    "texton": "FROZEN",
                    "rounded": 4.0,
                    "activebgcolor": [
                        0.35,
                        0.35,
                        0.35,
                        1.0
                    ],
                    "activebgoncolor": [
                        0.38,
                        0.74,
                        0.93,
                        1.0
                    ],
                    "activetextcolor": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                    ],
                    "activetextoncolor": [
                        0.08,
                        0.08,
                        0.1,
                        1.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [
                                "off",
                                "on"
                            ],
                            "parameter_initial": [
                                0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Freeze [ts-10]",
                            "parameter_shortname": "Freeze",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_type": 2
                        }
                    }
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-92",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        145.0,
                        75.0,
                        22.0
                    ],
                    "text": "freeze $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-93",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1330.0,
                        330.0,
                        310.0,
                        20.0
                    ],
                    "text": "click waveform: seek  ·  drag: loop region",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        400.0,
                        9.0,
                        250.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-94",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        250.0,
                        295.0,
                        189.0,
                        22.0
                    ],
                    "text": "gen~ @source timestretch-source",
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
                                    "maxclass": "codebox",
                                    "id": "obj-3",
                                    "numinlets": 2,
                                    "numoutlets": 5,
                                    "outlettype": [
                                        "",
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
                                    ],
                                    "parameter_enable": 0,
                                    "code": "// timestretch v0.6.0 -- WSOLA granular time-stretch (stereo: in1/in2 -> out1 L, out5 R)\n// mode: 0 none, 1 live (ring buffer), 2 buffer (file)\nParam stretch(1, min=0.25, max=16);\nParam grain_ms(40, min=5, max=200);\nParam pitch(0, min=-2400, max=2400);\nParam wsola_tol(128, min=0, max=256);\nParam jitter_amt(0.05, min=0, max=0.25);\nParam sensitivity(0.5, min=0, max=1);\nParam adapt(1, min=0, max=1);\nParam density(4, min=2, max=8);\nParam extreme(0, min=0, max=1);\nParam mode(0, min=0, max=2);\nParam playing(0, min=0, max=1);\nParam looping(0, min=0, max=1);\nParam bufsr(0, min=0, max=384000);\nParam sel_a(0, min=0, max=100000000);\nParam sel_b(0, min=0, max=100000000);\nParam freeze(0, min=0, max=1);\nParam preserve(0, min=0, max=1);\n\nHistory one(1);\nHistory wpos(0);\nHistory rpos(0);\nHistory hop_ctr(0);\nHistory free_g(0);\nHistory hp_z1(0);\nHistory env_f(0);\nHistory env_s(0);\nHistory tr_hold(0);\nHistory ended(0);\nHistory play_z(0);\nHistory len_z(0);\nHistory mode_z(0);\nHistory sa_z(0);\nHistory sb_z(0);\nHistory lk_s(0);\nHistory lk_e(0);\nHistory lk_on(0);\nHistory lk2_s(0);\nHistory lk2_e(0);\nHistory lk2_on(0);\nHistory lk_last(0);\nHistory warm(0);\nHistory det_z(0);\nHistory drift(0);\nHistory s_state(0);\nHistory s_cand(0);\nHistory s_j(0);\nHistory s_acc(0);\nHistory s_en(0);\nHistory s_best_k(0);\nHistory s_best_c(0);\nHistory s_coarse_k(0);\nHistory s_ref(0);\nHistory s_nom(0);\nHistory s_spd(1);\nHistory s_jit(0);\n\nBuffer source;\nData circ(524288, 2);\nData gpos(16);\nData gphase(16);\nData ginc(16);\nData gactive(16);\n\n// --- setup (everything scaled by one so nothing gets hoisted) ---\nsrs = samplerate * one;\nk_st = stretch * one;\nk_tol = floor(wsola_tol * one);\nk_n = clamp(floor(density * one + 0.5), 2, 8);\nk_jit = jitter_amt * one;\nk_ext = extreme * one;\nk_mode = mode * one;\nk_play = playing * one;\nk_loop = looping * one;\nk_fsr = bufsr * one;\nk_frz = freeze * one;\nk_pres = preserve * one;\nk_sa = sel_a * one;\nk_sb = sel_b * one;\npspeed = pow(2, pitch * one / 1200);\nbase_size = max(grain_ms * one * srs * 0.001, 16);\n\nsrc_len = dim(source);\nsl = max(src_len, 1);\nch_r = min(1, max(channels(source) - 1, 0));\nis_live = 0;\nif (k_mode > 0.5) {\n    if (k_mode < 1.5) {\n        is_live = 1;\n    }\n}\nis_file = 0;\nif (k_mode > 1.5) {\n    if (src_len > 1) {\n        is_file = 1;\n    }\n}\n\n// file sample rate vs system sample rate\nsrratio = 1;\nif (is_file > 0.5) {\n    if (k_fsr > 0) {\n        srratio = k_fsr / srs;\n    }\n}\ngspd = pspeed * srratio;\n\n// loop region from the waveform selection (ms at the file rate); a click (no width) = whole file\nfsr_eff = srs * srratio;\nra = clamp(k_sa * fsr_eff * 0.001, 0, src_len);\nrb = clamp(k_sb * fsr_eff * 0.001, 0, src_len);\nreg_a = 0;\nreg_b = src_len;\nif (rb - ra > 0.01 * fsr_eff) {\n    reg_a = ra;\n    reg_b = rb;\n}\ngmax = max(gspd, 1);\n\n// --- state in ---\nrp = rpos;\nen_d = ended;\nhc = hop_ctr - 1;\nfg = free_g;\nss = s_state;\nsc = s_cand;\nsj = s_j;\nsa = s_acc;\nsen = s_en;\nsbk = s_best_k;\nsbc = s_best_c;\nsck = s_coarse_k;\nsref = s_ref;\nsnom = s_nom;\nsspd = s_spd;\nsjit = s_jit;\nlks = lk_s;\nlke = lk_e;\nlko = lk_on;\nl2s = lk2_s;\nl2e = lk2_e;\nl2o = lk2_on;\nlkl = lk_last;\nwrm = warm;\ndr = drift;\n\n// --- live ring buffer write (frozen live input stops recording) ---\nwp = wpos;\nlive_frz = 0;\nif (is_live > 0.5) {\n    if (k_frz > 0.5) {\n        live_frz = 1;\n    }\n}\nif (live_frz < 0.5) {\n    if (is_live > 0.5) {\n        poke(circ, in1, wp % 524288, 0);\n        poke(circ, in2, wp % 524288, 1);\n    }\n    wp = wp + 1;\n}\nwpos = wp;\n\n// live read head window: hi = newest safe nominal, lo = oldest safe nominal\n// transient lookahead: preserve needs to see an onset a full grain before any grain reaches it\ntlook = base_size * 0.25;\nif (k_pres > 0.5) {\n    tlook = base_size * gmax + k_tol + base_size * 0.125 + 64;\n}\nreach = k_tol + tlook + base_size * (0.125 + k_ext) + max(base_size * (gmax - 1), (base_size * 0.5 + 384) * gmax) + 64;\nhi = wp - reach;\nlo = wp - 524288 + k_tol + base_size * (1.125 + k_ext) + 1024;\n\n// --- resets on mode change / new file ---\nmode_chg = 0;\nif (abs(k_mode - mode_z) > 0.5) {\n    mode_chg = 1;\n}\nmode_z = k_mode;\nif (abs(src_len - len_z) > 0.5) {\n    if (is_file > 0.5) {\n        mode_chg = 1;\n    }\n}\nlen_z = src_len;\nif (mode_chg > 0.5) {\n    rp = reg_a;\n    if (is_live > 0.5) {\n        rp = hi;\n    }\n    en_d = 0;\n    ss = 0;\n    lks = 0;\n    lke = 0;\n    lko = 0;\n    l2s = 0;\n    l2e = 0;\n    l2o = 0;\n    lkl = -1000000;\n    wrm = 0.02 * srs;\n    dr = 0;\n}\n\n// play rising edge after the end of the file restarts from the top\nif (k_play > 0.5) {\n    if (play_z < 0.5) {\n        if (en_d > 0.5) {\n            rp = reg_a;\n            en_d = 0;\n            lks = 0;\n            lke = 0;\n            lko = 0;\n            l2s = 0;\n            l2e = 0;\n            l2o = 0;\n            lkl = -1000000;\n            wrm = 0.02 * srs;\n            dr = 0;\n        }\n    }\n}\nplay_z = k_play;\n\n// waveform click / drag: seek to the selection start\nif (abs(k_sa - sa_z) + abs(k_sb - sb_z) > 0.0001) {\n    if (is_file > 0.5) {\n        rp = ra;\n        en_d = 0;\n        ss = 0;\n        lks = 0;\n        lke = 0;\n        lko = 0;\n        l2s = 0;\n        l2e = 0;\n        l2o = 0;\n        lkl = -1000000;\n        wrm = 0.02 * srs;\n        dr = 0;\n    }\n}\nsa_z = k_sa;\nsb_z = k_sb;\n\n// --- advance read head ---\n// preserve: inside a transient window the read head runs at 1x so every grain reads the\n// same source time (the onset is reproduced, not smeared); in file mode the extra\n// advance is paid back afterwards so the long-term stretch stays exact.\nif (rp >= lke) {\n    if (l2e > lke) {\n        lks = l2s;\n        lke = l2e;\n        lko = l2o;\n        l2s = 0;\n        l2e = 0;\n    }\n}\nlocked = 0;\nif (k_pres > 0.5) {\n    if (rp >= lks) {\n        if (rp < lke) {\n            locked = 1;\n        }\n    }\n}\nrbase = srratio / k_st;\nradv = rbase;\nif (locked > 0.5) {\n    radv = srratio;\n} else {\n    if (is_file > 0.5) {\n        dr_tgt = 0;\n        if (k_pres > 0.5) {\n            if (rp < lks) {\n                if (rp >= lks - tlook - 64) {\n                    dr_tgt = (lks - lko) * (1 - 1 / k_st);\n                }\n            }\n        }\n        radv = rbase - clamp((dr - dr_tgt) / (0.02 * srs), -0.5 * rbase, 0.5 * rbase);\n    }\n}\nif (is_live > 0.5) {\n    dr = 0;\n    if (k_frz < 0.5) {\n        rp = rp + radv;\n        if (rp < lo) {\n            rp = hi;\n        }\n    }\n    if (rp > hi) {\n        rp = hi;\n    }\n}\nif (is_file > 0.5) {\n    if (k_play > 0.5) {\n        if (en_d < 0.5) {\n            if (k_frz < 0.5) {\n                rp = rp + radv;\n                dr = dr + radv - rbase;\n            }\n            if (rp >= reg_b) {\n                if (k_loop > 0.5) {\n                    rp = rp - (reg_b - reg_a);\n                    if (rp >= reg_b) {\n                        rp = reg_a;\n                    }\n                    if (rp < reg_a) {\n                        rp = reg_a;\n                    }\n                } else {\n                    rp = reg_b;\n                    en_d = 1;\n                }\n            }\n        }\n    }\n}\ncan_go = is_live;\nif (is_file > 0.5) {\n    if (k_play > 0.5) {\n        if (en_d < 0.5) {\n            can_go = 1;\n        }\n    }\n}\n\n// --- transient detection at the read head (source time) ---\ntpos = floor(rp + tlook);\ntap_s = 0;\nif (is_live > 0.5) {\n    ti = wrap(tpos, 0, 524288);\n    tap_s = (peek(circ, ti, 0) + peek(circ, ti, 1)) * 0.5;\n}\nif (is_file > 0.5) {\n    ti = wrap(tpos, 0, sl);\n    tap_s = (peek(source, ti, 0) + peek(source, ti, ch_r)) * 0.5;\n}\nhp_out = tap_s - hp_z1 * exp(-twopi * 2000 / srs);\nhp_z1 = tap_s;\na_hp = abs(hp_out);\ntscale = max(k_st / srratio, 1);\nif (k_pres > 0.5) {\n    // envelopes run in source time: scale by the actual read rate (1x inside a window)\n    tscale = clamp(srratio / max(radv, 0.000001), 1, 64);\n}\natk_c = exp(-1 / (0.001 * srs * tscale));\nrel_c = exp(-1 / (0.05 * srs * tscale));\nslow_c = exp(-1 / (0.2 * srs * tscale));\nfe = env_f;\nif (a_hp > fe) {\n    fe = a_hp + atk_c * (fe - a_hp);\n} else {\n    fe = a_hp + rel_c * (fe - a_hp);\n}\nenv_f = fe;\nse = a_hp + slow_c * (env_s - a_hp);\nenv_s = se;\nthresh = 1 + (1 - sensitivity * one) * 10;\ndet = 0;\nif (se > 0.0001) {\n    if (fe > se * thresh) {\n        det = 1;\n    }\n}\nth = tr_hold - 1;\nif (det > 0.5) {\n    th = max(base_size, 0.06 * srs);\n}\n// preserve: each onset at tpos gets a 1x window [start, end). Window 1 is the next/active one,\n// slot 2 queues one more; an onset overlapping a pending window extends it.\nwrm = max(wrm - 1, 0);\nif (k_pres > 0.5) {\n    if (det > 0.5) {\n        if (det_z < 0.5) {\n            if (wrm < 0.5) {\n                if (tpos - lkl > 0.05 * srs * srratio) {\n                    lkl = tpos;\n                    new_s = tpos - min(max(0.01 * srs, base_size * 0.25), base_size) * gmax - k_tol - 64;\n                    new_e = tpos + max(base_size * 0.5, 0.03 * srs) * srratio;\n                    if (rp < lke) {\n                        if (new_s <= lke) {\n                            lke = max(lke, new_e);\n                        } else {\n                            if (l2e > lke) {\n                                l2e = max(l2e, new_e);\n                            } else {\n                                l2s = new_s;\n                                l2e = new_e;\n                                l2o = tpos;\n                            }\n                        }\n                    } else {\n                        lks = new_s;\n                        lke = new_e;\n                        lko = tpos;\n                    }\n                }\n            }\n        }\n    }\n}\ndet_z = det;\npre = 0;\nif (k_pres > 0.5) {\n    if (rp >= lks - tlook - 64) {\n        if (rp < lke) {\n            pre = 1;\n        }\n    }\n    if (l2e > lke) {\n        if (rp >= l2s - tlook - 64) {\n            pre = 1;\n        }\n    }\n}\nth = max(th, 0);\ntr_hold = th;\nis_tr = 0;\nif (th > 0) {\n    is_tr = 1;\n}\n\n// --- grain launch ---\ngsz = base_size;\nshort_on = pre;\nif (adapt * one > 0.5) {\n    if (is_tr > 0.5) {\n        short_on = 1;\n    }\n}\nif (short_on > 0.5) {\n    gsz = min(base_size, max(0.01 * srs, base_size * 0.25));\n}\nhop = gsz / k_n;\n\nif (hc <= 0) {\n    if (can_go > 0.5) {\n        nom = rp + sjit;\n        g_start = nom;\n        if (ss > 0.5) {\n            if (abs(nom - snom) < 64) {\n                g_start = snom + sbk;\n            }\n        }\n        if (locked > 0.5) {\n            g_start = rp;\n        }\n        poke(gpos, g_start, fg, 0);\n        poke(gphase, 0, fg, 0);\n        poke(ginc, 1 / gsz, fg, 0);\n        poke(gactive, 1, fg, 0);\n\n        // set up the WSOLA search for the next launch (exactly hop samples away)\n        rd_rate = radv;\n        if (is_live > 0.5) {\n            rd_rate = min(radv, 1);\n        }\n        if (k_frz > 0.5) {\n            rd_rate = 0;\n        }\n        sjit = noise() * (k_jit * hop + k_ext * gsz) * gspd;\n        if (locked > 0.5) {\n            sjit = 0;\n        }\n        snom = rp + hop * rd_rate + sjit;\n        sref = g_start + hop * gspd;\n        sspd = gspd;\n        ss = 0;\n        if (k_tol > 0) {\n            if (k_ext < 0.5) {\n                if (locked < 0.5) {\n                    ss = 1;\n                }\n            }\n        }\n        sc = 0;\n        sj = 0;\n        sa = 0;\n        sen = 0;\n        sbk = 0;\n        sbc = -1000000;\n        sck = 0;\n        hc = hc + hop;\n    } else {\n        hc = 0;\n    }\n}\n\n// --- WSOLA search, amortised: 64 correlation points per sample ---\n// coarse: offsets 0, +4, -4, +8, ... up to +/-tol; fine: +/-1..3 around the coarse best\nkc_n = 2 * floor(k_tol / 4) + 1;\nfor (it = 0; it < 64; it += 1) {\n    if (ss > 0.5) {\n        if (ss < 2.5) {\n            odd = sc - 2 * floor(sc * 0.5);\n            kk = 4 * floor((sc + 1) * 0.5) * (2 * odd - 1);\n            if (ss > 1.5) {\n                kk = sck + (floor(sc * 0.5) + 1) * (1 - 2 * odd);\n            }\n            ir = floor(sref + sj * 3 * sspd);\n            itp = floor(snom + kk + sj * 3 * sspd);\n            va = 0;\n            vb = 0;\n            if (is_file > 0.5) {\n                ia = wrap(ir, 0, sl);\n                ib = wrap(itp, 0, sl);\n                va = peek(source, ia, 0) + peek(source, ia, ch_r);\n                vb = peek(source, ib, 0) + peek(source, ib, ch_r);\n            } else {\n                ia = wrap(ir, 0, 524288);\n                ib = wrap(itp, 0, 524288);\n                va = peek(circ, ia, 0) + peek(circ, ia, 1);\n                vb = peek(circ, ib, 0) + peek(circ, ib, 1);\n            }\n            sa = sa + va * vb;\n            sen = sen + vb * vb;\n            sj = sj + 1;\n            if (sj > 127.5) {\n                score = sa / sqrt(sen + 0.000000001);\n                nk = min(abs(kk) / max(k_tol, 1), 1);\n                bias = 1 - 0.25 * nk * nk;\n                if (score > 0) {\n                    score = score * bias;\n                } else {\n                    score = score / bias;\n                }\n                if (score > sbc) {\n                    sbc = score;\n                    sbk = kk;\n                }\n                sj = 0;\n                sa = 0;\n                sen = 0;\n                sc = sc + 1;\n                if (ss < 1.5) {\n                    if (sc > kc_n - 0.5) {\n                        ss = 2;\n                        sc = 0;\n                        sck = sbk;\n                    }\n                } else {\n                    if (sc > 5.5) {\n                        ss = 3;\n                    }\n                }\n            }\n        }\n    }\n}\n\n// --- grain synthesis: 16 voices (adaptive mixes long + short grains), linear interp, Hann ---\nosum = 0;\nosum_r = 0;\nwsum = 0;\nnf = -1;\nold_i = 0;\nold_ph = -1;\nfor (i = 0; i < 16; i += 1) {\n    act = peek(gactive, i, 0);\n    if (act > 0.5) {\n        p = peek(gpos, i, 0);\n        ph = peek(gphase, i, 0);\n        inc = peek(ginc, i, 0);\n        ip = floor(p);\n        fr = p - ip;\n        s0 = 0;\n        s1 = 0;\n        r0 = 0;\n        r1 = 0;\n        if (is_file > 0.5) {\n            if (k_loop > 0.5) {\n                i0 = wrap(ip, 0, sl);\n                i1 = wrap(ip + 1, 0, sl);\n                s0 = peek(source, i0, 0);\n                s1 = peek(source, i1, 0);\n                r0 = peek(source, i0, ch_r);\n                r1 = peek(source, i1, ch_r);\n            } else {\n                if (ip >= 0) {\n                    if (ip < sl) {\n                        s0 = peek(source, ip, 0);\n                        r0 = peek(source, ip, ch_r);\n                    }\n                }\n                if (ip >= -1) {\n                    if (ip + 1 < sl) {\n                        s1 = peek(source, ip + 1, 0);\n                        r1 = peek(source, ip + 1, ch_r);\n                    }\n                }\n            }\n        } else {\n            i0 = wrap(ip, 0, 524288);\n            i1 = wrap(ip + 1, 0, 524288);\n            s0 = peek(circ, i0, 0);\n            s1 = peek(circ, i1, 0);\n            r0 = peek(circ, i0, 1);\n            r1 = peek(circ, i1, 1);\n        }\n        w = 0.5 - 0.5 * cos(twopi * ph);\n        osum = osum + (s0 + (s1 - s0) * fr) * w;\n        osum_r = osum_r + (r0 + (r1 - r0) * fr) * w;\n        wsum = wsum + w;\n        p = p + gspd;\n        ph = ph + inc;\n        if (ph >= 1) {\n            poke(gactive, 0, i, 0);\n            if (nf < 0) {\n                nf = i;\n            }\n        } else {\n            poke(gpos, p, i, 0);\n            poke(gphase, ph, i, 0);\n            if (ph > old_ph) {\n                old_ph = ph;\n                old_i = i;\n            }\n        }\n    } else {\n        if (nf < 0) {\n            nf = i;\n        }\n    }\n}\nfg_next = nf;\nif (nf < 0) {\n    fg_next = old_i;\n}\n\n// --- state out ---\nfree_g = fg_next;\nrpos = rp;\nended = en_d;\nhop_ctr = hc;\ns_state = ss;\ns_cand = sc;\ns_j = sj;\ns_acc = sa;\ns_en = sen;\ns_best_k = sbk;\ns_best_c = sbc;\ns_coarse_k = sck;\ns_ref = sref;\ns_nom = snom;\ns_spd = sspd;\ns_jit = sjit;\nlk_s = lks;\nlk_e = lke;\nlk_on = lko;\nlk2_s = l2s;\nlk2_e = l2e;\nlk2_on = l2o;\nlk_last = lkl;\nwarm = wrm;\ndrift = dr;\n\npos_ms = -1;\nif (is_file > 0.5) {\n    pos_ms = rp * 1000 / fsr_eff;\n}\n\nnorm = 1 / max(wsum, k_n * 0.5);\nout1 = osum * norm;\nout2 = max(is_tr, pre);\nout3 = pos_ms;\nout4 = en_d;\nout5 = osum_r * norm;\n",
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
                                    "id": "obj-5",
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
                                    "id": "obj-6",
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
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        290.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 4",
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
                                        370.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 5",
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
                                        "obj-2",
                                        0
                                    ],
                                    "destination": [
                                        "obj-3",
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
                                        "obj-3",
                                        2
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
                                        "obj-3",
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
                                        "obj-3",
                                        4
                                    ],
                                    "destination": [
                                        "obj-8",
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
                    "id": "obj-95",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        470.0,
                        185.0,
                        72.0,
                        22.0
                    ],
                    "text": "adc~ 1 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-96",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        540.0,
                        225.0,
                        80.0,
                        22.0
                    ],
                    "text": "selector~ 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-97",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        185.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger i i i",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-98",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        580.0,
                        340.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "levelmeter~",
                    "id": "obj-99",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        572.0,
                        425.0,
                        64.0,
                        32.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        532.0,
                        280.0,
                        118.0,
                        50.0
                    ],
                    "markers": [
                        -60,
                        -48,
                        -36,
                        -24,
                        -12,
                        -6,
                        0,
                        6
                    ],
                    "markersused": 8
                }
            },
            {
                "box": {
                    "maxclass": "live.toggle",
                    "id": "obj-100",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        220.0,
                        15.0,
                        15.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        312.0,
                        240.0,
                        18.0,
                        18.0
                    ],
                    "varname": "preserve",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [
                                "off",
                                "on"
                            ],
                            "parameter_initial": [
                                0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Preserve [ts-11]",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Preserve",
                            "parameter_type": 2
                        }
                    }
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-101",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        245.0,
                        90.0,
                        22.0
                    ],
                    "text": "preserve $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-102",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        700.0,
                        277.0,
                        90.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-103",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1330.0,
                        355.0,
                        72.0,
                        20.0
                    ],
                    "text": "Preserve",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        312.0,
                        225.0,
                        50.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-104",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        20.0,
                        83.0,
                        70.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-105",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        133.0,
                        83.0,
                        70.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-106",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        270.0,
                        83.0,
                        70.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-107",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        399.0,
                        83.0,
                        70.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-108",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        520.0,
                        83.0,
                        70.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-109",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        617.0,
                        83.0,
                        70.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-110",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        835.0,
                        83.0,
                        70.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-111",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        948.0,
                        83.0,
                        70.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-112",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        20.0,
                        180.0,
                        70.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-113",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        140.0,
                        180.0,
                        70.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-114",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        115.0,
                        70.0,
                        22.0
                    ],
                    "text": "loadmess 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-115",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        225.0,
                        70.0,
                        22.0
                    ],
                    "text": "loadmess 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-116",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        285.0,
                        130.0,
                        22.0
                    ],
                    "text": "expr pow(2, $i1 + 1)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-117",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        315.0,
                        80.0,
                        22.0
                    ],
                    "text": "density $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-118",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        20.0,
                        345.0,
                        70.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-119",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        700.0,
                        175.0,
                        70.0,
                        22.0
                    ],
                    "text": "send ts-gen",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-120",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        800.0,
                        115.0,
                        80.0,
                        22.0
                    ],
                    "text": "loadmess 0.5 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        259.5,
                        363.0,
                        259.5,
                        363.0
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
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        51.0,
                        29.5,
                        51.0
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
                        "obj-22",
                        0
                    ],
                    "midpoints": [
                        408.5,
                        51.0,
                        408.5,
                        51.0
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
                    "midpoints": [
                        529.5,
                        51.0,
                        529.5,
                        51.0
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
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        279.5,
                        51.0,
                        279.5,
                        51.0
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
                        "obj-28",
                        0
                    ],
                    "midpoints": [
                        142.5,
                        51.0,
                        142.5,
                        51.0
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
                        "obj-30",
                        0
                    ],
                    "midpoints": [
                        626.5,
                        51.0,
                        626.5,
                        51.0
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
                        "obj-32",
                        0
                    ],
                    "midpoints": [
                        771.5,
                        51.0,
                        771.5,
                        51.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        771.5,
                        143.0,
                        804.0,
                        143.0
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
                        "obj-39",
                        0
                    ],
                    "midpoints": [
                        957.0,
                        42.0,
                        957.5,
                        42.0
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
                        "obj-41",
                        0
                    ],
                    "midpoints": [
                        844.0,
                        27.0,
                        844.5,
                        27.0
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
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        1109.5,
                        138.0,
                        1109.5,
                        138.0
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
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        1109.5,
                        168.0,
                        1109.5,
                        168.0
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
                        "obj-50",
                        0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        509.5,
                        363.0,
                        509.5,
                        363.0
                    ],
                    "order": 2,
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
                        509.5,
                        372.0,
                        576.0,
                        372.0,
                        576.0,
                        336.0,
                        589.5,
                        336.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-6",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        1
                    ],
                    "midpoints": [
                        804.0,
                        330.0,
                        548.5,
                        330.0
                    ],
                    "source": [
                        "obj-7",
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
                        "obj-68",
                        0
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
                        "obj-13",
                        0
                    ],
                    "destination": [
                        "obj-73",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-73",
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
                        "obj-74",
                        0
                    ],
                    "destination": [
                        "obj-75",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-75",
                        0
                    ],
                    "destination": [
                        "obj-76",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-76",
                        0
                    ],
                    "destination": [
                        "obj-77",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-77",
                        0
                    ],
                    "destination": [
                        "obj-78",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-51",
                        2
                    ],
                    "destination": [
                        "obj-63",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-51",
                        2
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
                        "obj-51",
                        2
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
                        "obj-51",
                        2
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
                        "obj-82",
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
                        2
                    ],
                    "destination": [
                        "obj-83",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-10",
                        3
                    ],
                    "destination": [
                        "obj-84",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-83",
                        0
                    ],
                    "destination": [
                        "obj-85",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-84",
                        0
                    ],
                    "destination": [
                        "obj-85",
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
                        "obj-86",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        2
                    ],
                    "destination": [
                        "obj-87",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-87",
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
                        "obj-86",
                        1
                    ],
                    "destination": [
                        "obj-88",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-88",
                        0
                    ],
                    "destination": [
                        "obj-90",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-89",
                        0
                    ],
                    "destination": [
                        "obj-10",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        0
                    ],
                    "destination": [
                        "obj-69",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-91",
                        0
                    ],
                    "destination": [
                        "obj-92",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-51",
                        2
                    ],
                    "destination": [
                        "obj-91",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-94",
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
                        "obj-94",
                        2
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
                        "obj-94",
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
                        "obj-44",
                        0
                    ],
                    "destination": [
                        "obj-94",
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
                        "obj-94",
                        0
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
                        "obj-94",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-94",
                        3
                    ],
                    "destination": [
                        "obj-74",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-95",
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
                        "obj-95",
                        1
                    ],
                    "destination": [
                        "obj-96",
                        1
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
                        "obj-97",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-97",
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
                        "obj-97",
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
                        "obj-97",
                        2
                    ],
                    "destination": [
                        "obj-96",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-96",
                        0
                    ],
                    "destination": [
                        "obj-94",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-94",
                        4
                    ],
                    "destination": [
                        "obj-98",
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
                        "obj-98",
                        1
                    ],
                    "midpoints": [
                        804.0,
                        330.0,
                        629.5,
                        330.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-98",
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
                        "obj-98",
                        0
                    ],
                    "destination": [
                        "obj-99",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-100",
                        0
                    ],
                    "destination": [
                        "obj-101",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-101",
                        0
                    ],
                    "destination": [
                        "obj-102",
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
                        "obj-104",
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
                        "obj-105",
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
                        "obj-106",
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
                        "obj-107",
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
                        "obj-108",
                        0
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
                        "obj-109",
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
                        "obj-110",
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
                        "obj-111",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-79",
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
                        "obj-68",
                        0
                    ],
                    "destination": [
                        "obj-112",
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
                        "obj-113",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-114",
                        0
                    ],
                    "destination": [
                        "obj-63",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-115",
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
                        "obj-116",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-116",
                        0
                    ],
                    "destination": [
                        "obj-117",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-117",
                        0
                    ],
                    "destination": [
                        "obj-118",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-92",
                        0
                    ],
                    "destination": [
                        "obj-119",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-120",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        0
                    ]
                }
            }
        ],
        "parameters": {
            "obj-19": [
                "Stretch [ts-1]",
                "Stretch",
                0
            ],
            "obj-21": [
                "Grain [ts-2]",
                "Grain",
                0
            ],
            "obj-23": [
                "Pitch ct [ts-3]",
                "Pitch ct",
                0
            ],
            "obj-25": [
                "WSOLA [ts-4]",
                "WSOLA",
                0
            ],
            "obj-27": [
                "Jitter [ts-5]",
                "Jitter",
                0
            ],
            "obj-29": [
                "Sens [ts-6]",
                "Sens",
                0
            ],
            "obj-31": [
                "Gain [ts-7]",
                "Gain",
                0
            ],
            "obj-38": [
                "Adaptive [ts-8]",
                "Adaptive",
                0
            ],
            "obj-40": [
                "Extreme [ts-9]",
                "Extreme",
                0
            ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-"
                    ],
                    "buttons": [
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-"
                    ]
                }
            },
            "inherited_shortname": 1,
            "obj-91": [
                "Freeze [ts-10]",
                "Freeze",
                0
            ],
            "obj-100": [
                "Preserve [ts-11]",
                "Preserve",
                0
            ]
        },
        "autosave": 0,
        "editing_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ],
        "bgcolor": [
            0.18,
            0.18,
            0.2,
            1.0
        ],
        "locked_bgcolor": [
            0.18,
            0.18,
            0.2,
            1.0
        ]
    }
}