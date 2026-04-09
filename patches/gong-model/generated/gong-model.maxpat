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
            85.0,
            112.0,
            1052.0,
            756.0
        ],
        "boxes": [
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        20.0,
                        170.0,
                        24.0
                    ],
                    "text": "Gong Physical Model"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        45.0,
                        541.0,
                        20.0
                    ],
                    "text": "Modal synthesis with nonlinear coupling, bloom, and 5-point structure morph"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        20.0,
                        72.0,
                        58.0,
                        22.0
                    ],
                    "text": "notein"
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
                        20.0,
                        110.0,
                        44.0,
                        22.0
                    ],
                    "text": "mtof"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        134.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend base_freq"
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
                        "float"
                    ],
                    "patching_rect": [
                        170.0,
                        110.0,
                        58.0,
                        22.0
                    ],
                    "text": "/ 127."
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
                        170.0,
                        140.0,
                        128.0,
                        22.0
                    ],
                    "text": "prepend velocity"
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
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        320.0,
                        80.0,
                        65.0,
                        22.0
                    ],
                    "text": "touchin"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-9",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        320.0,
                        110.0,
                        58.0,
                        22.0
                    ],
                    "text": "/ 127."
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
                        320.0,
                        140.0,
                        142.0,
                        22.0
                    ],
                    "text": "prepend aftertouch"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-11",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        201.0,
                        149.0,
                        20.0
                    ],
                    "text": "Audio Exciter Input"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        20.0,
                        225.0,
                        64.0,
                        22.0
                    ],
                    "text": "adc~ 1"
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
                        "signal"
                    ],
                    "patching_rect": [
                        20.0,
                        250.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-14",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        58.5,
                        301.0,
                        93.0,
                        20.0
                    ],
                    "text": "gen~ Engine"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        20.0,
                        322.0,
                        128.0,
                        22.0
                    ],
                    "text": "gen~ gong-engine"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-56",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        362.0,
                        58.0,
                        20.0
                    ],
                    "text": "Output"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-57",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        20.0,
                        382.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.7"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-58",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        130.0,
                        382.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.7"
                }
            },
            {
                "box": {
                    "id": "obj-60",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        61.5,
                        472.5,
                        45.0,
                        45.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-61",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        20.0,
                        417.0,
                        15.0,
                        100.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-62",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        130.0,
                        417.0,
                        15.0,
                        100.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-63",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        220.0,
                        362.0,
                        107.0,
                        20.0
                    ],
                    "text": "Visualization"
                }
            },
            {
                "box": {
                    "id": "obj-64",
                    "maxclass": "spectroscope~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        220.0,
                        382.0,
                        180.0,
                        120.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-65",
                    "maxclass": "scope~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        220.0,
                        517.0,
                        180.0,
                        80.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-66",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        162.0,
                        110.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-67",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        170.0,
                        162.0,
                        110.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-68",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        320.0,
                        165.0,
                        110.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-79",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        168.5,
                        322.0,
                        131.0,
                        22.0
                    ],
                    "text": "receive gong-ctrl"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-90",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        530.0,
                        69.0,
                        20.0
                    ],
                    "text": "Test Strike"
                }
            },
            {
                "box": {
                    "id": "obj-91",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        20.0,
                        552.0,
                        24.0,
                        24.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-92",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        20.0,
                        582.0,
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
                    "id": "obj-93",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        20.0,
                        612.0,
                        44.0,
                        22.0
                    ],
                    "text": "f 60"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-94",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        636.0,
                        44.0,
                        22.0
                    ],
                    "text": "mtof"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-95",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        660.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend base_freq"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-96",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        684.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-97",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        173.5,
                        612.0,
                        51.0,
                        22.0
                    ],
                    "text": "f 0.8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-98",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        173.5,
                        636.0,
                        128.0,
                        22.0
                    ],
                    "text": "prepend velocity"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-99",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        173.5,
                        660.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-100",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        173.5,
                        684.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend strike_force"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-101",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        173.5,
                        708.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-102",
                    "maxclass": "newobj",
                    "numinlets": 5,
                    "numoutlets": 4,
                    "outlettype": [
                        "int",
                        "",
                        "",
                        "int"
                    ],
                    "patching_rect": [
                        334.25,
                        612.0,
                        81.5,
                        22.0
                    ],
                    "text": "counter"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-103",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        334.25,
                        636.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend strike_count"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-104",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        334.25,
                        660.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-105",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        170.0,
                        164.0,
                        44.0,
                        22.0
                    ],
                    "text": "> 0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-106",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        ""
                    ],
                    "patching_rect": [
                        170.0,
                        188.0,
                        72.0,
                        22.0
                    ],
                    "text": "select 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-107",
                    "maxclass": "newobj",
                    "numinlets": 5,
                    "numoutlets": 4,
                    "outlettype": [
                        "int",
                        "",
                        "",
                        "int"
                    ],
                    "patching_rect": [
                        170.0,
                        212.0,
                        81.5,
                        22.0
                    ],
                    "text": "counter"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-108",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        170.0,
                        236.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend strike_count"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-109",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        170.0,
                        260.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-110",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        300.0,
                        164.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend strike_force"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-111",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        300.0,
                        188.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-172",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        484.0,
                        65.0,
                        65.0,
                        20.0
                    ],
                    "text": "structure"
                }
            },
            {
                "box": {
                    "id": "obj-173",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        489.0,
                        83.0,
                        40.0,
                        40.0
                    ],
                    "varname": "d_structure"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-174",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        83.0,
                        135.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-175",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        486.0,
                        127.0,
                        52.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-176",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        107.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend structure"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-177",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        539.0,
                        131.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-178",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        484.0,
                        153.0,
                        65.0,
                        20.0
                    ],
                    "text": "brightness"
                }
            },
            {
                "box": {
                    "id": "obj-179",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        489.0,
                        171.0,
                        40.0,
                        40.0
                    ],
                    "varname": "d_brightness"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-180",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        171.0,
                        135.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-181",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        486.0,
                        215.0,
                        52.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-182",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        195.0,
                        142.0,
                        22.0
                    ],
                    "text": "prepend brightness"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-183",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        539.0,
                        219.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-184",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        484.0,
                        241.0,
                        65.0,
                        20.0
                    ],
                    "text": "decay"
                }
            },
            {
                "box": {
                    "id": "obj-185",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        489.0,
                        259.0,
                        40.0,
                        40.0
                    ],
                    "varname": "d_decay"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-186",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        259.0,
                        163.0,
                        22.0
                    ],
                    "text": "scale 0 127 0.1 30. 3"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-187",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        486.0,
                        303.0,
                        52.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-188",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        283.0,
                        142.0,
                        22.0
                    ],
                    "text": "prepend decay_time"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-189",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        539.0,
                        307.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-190",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        484.0,
                        329.0,
                        65.0,
                        20.0
                    ],
                    "text": "position"
                }
            },
            {
                "box": {
                    "id": "obj-191",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        489.0,
                        347.0,
                        40.0,
                        40.0
                    ],
                    "varname": "d_position"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-192",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        347.0,
                        135.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-193",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        486.0,
                        391.0,
                        52.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-194",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        371.0,
                        128.0,
                        22.0
                    ],
                    "text": "prepend position"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-195",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        539.0,
                        395.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-196",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        484.0,
                        417.0,
                        70.0,
                        20.0
                    ],
                    "text": "nonlinearity"
                }
            },
            {
                "box": {
                    "id": "obj-197",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        489.0,
                        435.0,
                        40.0,
                        40.0
                    ],
                    "varname": "d_nonlinearity"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-198",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        435.0,
                        135.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-199",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        486.0,
                        479.0,
                        52.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-200",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        459.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend nonlinearity"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-201",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        539.0,
                        483.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-202",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        717.0,
                        65.0,
                        65.0,
                        20.0
                    ],
                    "text": "hardness"
                }
            },
            {
                "box": {
                    "id": "obj-203",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        722.0,
                        83.0,
                        40.0,
                        40.0
                    ],
                    "varname": "d_hardness"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-204",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        83.0,
                        135.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-205",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        719.0,
                        127.0,
                        52.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-206",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        107.0,
                        177.0,
                        22.0
                    ],
                    "text": "prepend mallet_hardness"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-207",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        131.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-208",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        717.0,
                        153.0,
                        65.0,
                        20.0
                    ],
                    "text": "bloom amt"
                }
            },
            {
                "box": {
                    "id": "obj-209",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        722.0,
                        171.0,
                        40.0,
                        40.0
                    ],
                    "varname": "d_bloom"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-210",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        171.0,
                        135.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-211",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        719.0,
                        215.0,
                        52.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-212",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        195.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend bloom_amount"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-213",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        219.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-214",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        717.0,
                        241.0,
                        65.0,
                        20.0
                    ],
                    "text": "bloom spd"
                }
            },
            {
                "box": {
                    "id": "obj-215",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        722.0,
                        259.0,
                        40.0,
                        40.0
                    ],
                    "varname": "d_bloom_speed"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-216",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        259.0,
                        156.0,
                        22.0
                    ],
                    "text": "scale 0 127 0.1 5. 2"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-217",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        719.0,
                        303.0,
                        52.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-218",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        283.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend bloom_speed"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-219",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        307.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-220",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        717.0,
                        329.0,
                        65.0,
                        20.0
                    ],
                    "text": "modes"
                }
            },
            {
                "box": {
                    "id": "obj-221",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        722.0,
                        347.0,
                        40.0,
                        40.0
                    ],
                    "varname": "d_modes"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-222",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        347.0,
                        128.0,
                        22.0
                    ],
                    "text": "scale 0 127 4 32"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-223",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        719.0,
                        391.0,
                        52.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-224",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        371.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend num_modes"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-225",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        395.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-226",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        717.0,
                        417.0,
                        65.0,
                        20.0
                    ],
                    "text": "gain"
                }
            },
            {
                "box": {
                    "id": "obj-227",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        722.0,
                        435.0,
                        40.0,
                        40.0
                    ],
                    "varname": "d_gain"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-228",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        435.0,
                        135.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-229",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        719.0,
                        479.0,
                        52.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-230",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        459.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend output_gain"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-231",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        483.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-232",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        717,
                        20,
                        58.0,
                        20.0
                    ],
                    "text": "Preset",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-233",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        770,
                        18,
                        140,
                        22
                    ],
                    "parameter_enable": 0,
                    "items": [
                        "Tam-Tam",
                        ",",
                        "Opera Gong",
                        ",",
                        "Church Bell",
                        ",",
                        "Gamelan",
                        ",",
                        "Dark Crash",
                        ",",
                        "Singing Bowl"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-234",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        722,
                        510,
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
                    "id": "obj-235",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        722,
                        532,
                        114.0,
                        22.0
                    ],
                    "text": "prepend recall",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-236",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        722,
                        554,
                        275.0,
                        22.0
                    ],
                    "text": "pattrstorage gong-presets @savemode 3",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "varname": "gong-presets",
                    "saved_object_attributes": {
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    }
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-237",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        850,
                        554,
                        79.0,
                        22.0
                    ],
                    "text": "autopattr",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "restore": {
                        "d_structure": [
                            64
                        ],
                        "d_brightness": [
                            64
                        ],
                        "d_decay": [
                            64
                        ],
                        "d_position": [
                            64
                        ],
                        "d_nonlinearity": [
                            13
                        ],
                        "d_hardness": [
                            64
                        ],
                        "d_bloom": [
                            13
                        ],
                        "d_bloom_speed": [
                            54
                        ],
                        "d_modes": [
                            91
                        ],
                        "d_gain": [
                            64
                        ]
                    }
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-238",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        850,
                        510,
                        72.0,
                        22.0
                    ],
                    "text": "loadbang",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-239",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        850,
                        532,
                        72.0,
                        22.0
                    ],
                    "text": "recall 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-240",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        550.0,
                        10.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.5.0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-68",
                        0
                    ],
                    "midpoints": [
                        329.5,
                        165.0,
                        329.5,
                        165.0
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
                        "obj-101",
                        0
                    ],
                    "midpoints": [
                        183.0,
                        708.0,
                        183.0,
                        708.0
                    ],
                    "source": [
                        "obj-100",
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
                        343.75,
                        636.0,
                        343.75,
                        636.0
                    ],
                    "source": [
                        "obj-102",
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
                        343.75,
                        660.0,
                        343.75,
                        660.0
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
                        "obj-106",
                        0
                    ],
                    "midpoints": [
                        179.5,
                        189.0,
                        179.5,
                        189.0
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
                        179.5,
                        213.0,
                        179.5,
                        213.0
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
                    "midpoints": [
                        179.5,
                        237.0,
                        179.5,
                        237.0
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
                        179.5,
                        261.0,
                        179.5,
                        261.0
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
                        "obj-111",
                        0
                    ],
                    "midpoints": [
                        309.5,
                        189.0,
                        309.5,
                        189.0
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
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        249.0,
                        29.5,
                        249.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        273.0,
                        29.5,
                        273.0
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
                        "obj-57",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        345.0,
                        6.0,
                        345.0,
                        6.0,
                        378.0,
                        29.5,
                        378.0
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
                        "obj-58",
                        0
                    ],
                    "midpoints": [
                        138.5,
                        345.0,
                        139.5,
                        345.0
                    ],
                    "source": [
                        "obj-15",
                        1
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
                        498.5,
                        123.0,
                        534.0,
                        123.0,
                        534.0,
                        81.0,
                        548.5,
                        81.0
                    ],
                    "source": [
                        "obj-173",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-175",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        108.0,
                        531.0,
                        108.0,
                        531.0,
                        123.0,
                        495.5,
                        123.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-174",
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
                        548.5,
                        108.0,
                        548.5,
                        108.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-174",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-177",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        132.0,
                        548.5,
                        132.0
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
                        "obj-180",
                        0
                    ],
                    "midpoints": [
                        498.5,
                        213.0,
                        471.0,
                        213.0,
                        471.0,
                        150.0,
                        549.0,
                        150.0,
                        549.0,
                        168.0,
                        548.5,
                        168.0
                    ],
                    "source": [
                        "obj-179",
                        0
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
                        548.5,
                        195.0,
                        531.0,
                        195.0,
                        531.0,
                        150.0,
                        480.0,
                        150.0,
                        480.0,
                        210.0,
                        495.5,
                        210.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-180",
                        0
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
                        548.5,
                        195.0,
                        548.5,
                        195.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-180",
                        0
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
                        548.5,
                        219.0,
                        548.5,
                        219.0
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
                        "obj-186",
                        0
                    ],
                    "midpoints": [
                        498.5,
                        300.0,
                        534.0,
                        300.0,
                        534.0,
                        258.0,
                        548.5,
                        258.0
                    ],
                    "source": [
                        "obj-185",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-187",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        282.0,
                        531.0,
                        282.0,
                        531.0,
                        300.0,
                        495.5,
                        300.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-186",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-188",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        282.0,
                        548.5,
                        282.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-186",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-189",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        306.0,
                        548.5,
                        306.0
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
                        "obj-192",
                        0
                    ],
                    "midpoints": [
                        498.5,
                        387.0,
                        471.0,
                        387.0,
                        471.0,
                        516.0,
                        705.0,
                        516.0,
                        705.0,
                        444.0,
                        684.0,
                        444.0,
                        684.0,
                        342.0,
                        548.5,
                        342.0
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
                        "obj-193",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        372.0,
                        531.0,
                        372.0,
                        531.0,
                        387.0,
                        495.5,
                        387.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-192",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-194",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        372.0,
                        548.5,
                        372.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-192",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-195",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        396.0,
                        548.5,
                        396.0
                    ],
                    "source": [
                        "obj-194",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-198",
                        0
                    ],
                    "midpoints": [
                        498.5,
                        477.0,
                        483.0,
                        477.0,
                        483.0,
                        516.0,
                        705.0,
                        516.0,
                        705.0,
                        444.0,
                        684.0,
                        444.0,
                        684.0,
                        432.0,
                        548.5,
                        432.0
                    ],
                    "source": [
                        "obj-197",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-199",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        459.0,
                        531.0,
                        459.0,
                        531.0,
                        414.0,
                        471.0,
                        414.0,
                        471.0,
                        474.0,
                        495.5,
                        474.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-198",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-200",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        459.0,
                        548.5,
                        459.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-198",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-201",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        483.0,
                        548.5,
                        483.0
                    ],
                    "source": [
                        "obj-200",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-204",
                        0
                    ],
                    "midpoints": [
                        731.5,
                        123.0,
                        702.0,
                        123.0,
                        702.0,
                        51.0,
                        783.0,
                        51.0,
                        783.0,
                        78.0,
                        781.5,
                        78.0
                    ],
                    "source": [
                        "obj-203",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-205",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        108.0,
                        762.0,
                        108.0,
                        762.0,
                        123.0,
                        728.5,
                        123.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-204",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-206",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        108.0,
                        781.5,
                        108.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-204",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-207",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        132.0,
                        781.5,
                        132.0
                    ],
                    "source": [
                        "obj-206",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-210",
                        0
                    ],
                    "midpoints": [
                        731.5,
                        213.0,
                        702.0,
                        213.0,
                        702.0,
                        51.0,
                        960.0,
                        51.0,
                        960.0,
                        156.0,
                        783.0,
                        156.0,
                        783.0,
                        168.0,
                        781.5,
                        168.0
                    ],
                    "source": [
                        "obj-209",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-211",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        195.0,
                        762.0,
                        195.0,
                        762.0,
                        150.0,
                        702.0,
                        150.0,
                        702.0,
                        210.0,
                        728.5,
                        210.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-210",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-212",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        195.0,
                        781.5,
                        195.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-210",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-213",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        219.0,
                        781.5,
                        219.0
                    ],
                    "source": [
                        "obj-212",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-216",
                        0
                    ],
                    "midpoints": [
                        731.5,
                        300.0,
                        768.0,
                        300.0,
                        768.0,
                        258.0,
                        781.5,
                        258.0
                    ],
                    "source": [
                        "obj-215",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-217",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        282.0,
                        762.0,
                        282.0,
                        762.0,
                        300.0,
                        728.5,
                        300.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-216",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-218",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        282.0,
                        781.5,
                        282.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-216",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-219",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        306.0,
                        781.5,
                        306.0
                    ],
                    "source": [
                        "obj-218",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-222",
                        0
                    ],
                    "midpoints": [
                        731.5,
                        387.0,
                        702.0,
                        387.0,
                        702.0,
                        447.0,
                        705.0,
                        447.0,
                        705.0,
                        516.0,
                        933.0,
                        516.0,
                        933.0,
                        342.0,
                        781.5,
                        342.0
                    ],
                    "source": [
                        "obj-221",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-223",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        372.0,
                        762.0,
                        372.0,
                        762.0,
                        387.0,
                        728.5,
                        387.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-222",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-224",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        372.0,
                        781.5,
                        372.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-222",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-225",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        396.0,
                        781.5,
                        396.0
                    ],
                    "source": [
                        "obj-224",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-228",
                        0
                    ],
                    "midpoints": [
                        731.5,
                        477.0,
                        705.0,
                        477.0,
                        705.0,
                        516.0,
                        933.0,
                        516.0,
                        933.0,
                        432.0,
                        781.5,
                        432.0
                    ],
                    "source": [
                        "obj-227",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-229",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        459.0,
                        762.0,
                        459.0,
                        762.0,
                        414.0,
                        714.0,
                        414.0,
                        714.0,
                        474.0,
                        728.5,
                        474.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-228",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-230",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        459.0,
                        781.5,
                        459.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-228",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-231",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        483.0,
                        781.5,
                        483.0
                    ],
                    "source": [
                        "obj-230",
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
                        29.5,
                        96.0,
                        29.5,
                        96.0
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
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        49.0,
                        96.0,
                        179.5,
                        96.0
                    ],
                    "source": [
                        "obj-3",
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
                        29.5,
                        135.0,
                        29.5,
                        135.0
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
                        "obj-66",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        159.0,
                        29.5,
                        159.0
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
                        "obj-60",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        414.0,
                        71.0,
                        414.0
                    ],
                    "order": 2,
                    "source": [
                        "obj-57",
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
                    "midpoints": [
                        29.5,
                        405.0,
                        29.0,
                        405.0
                    ],
                    "order": 3,
                    "source": [
                        "obj-57",
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
                        29.5,
                        405.0,
                        117.0,
                        405.0,
                        117.0,
                        369.0,
                        207.0,
                        369.0,
                        207.0,
                        378.0,
                        229.5,
                        378.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-57",
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
                        29.5,
                        414.0,
                        207.0,
                        414.0,
                        207.0,
                        513.0,
                        229.5,
                        513.0
                    ],
                    "order": 0,
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
                        139.5,
                        405.0,
                        97.0,
                        405.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-58",
                        0
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
                        139.5,
                        405.0,
                        139.0,
                        405.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-58",
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
                        179.5,
                        135.0,
                        165.0,
                        135.0,
                        165.0,
                        159.0,
                        179.5,
                        159.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-6",
                        0
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
                        179.5,
                        135.0,
                        306.0,
                        135.0,
                        306.0,
                        159.0,
                        309.5,
                        159.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        179.5,
                        135.0,
                        179.5,
                        135.0
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
                        "obj-67",
                        0
                    ],
                    "midpoints": [
                        179.5,
                        165.0,
                        179.5,
                        165.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        178.0,
                        345.0,
                        162.0,
                        345.0,
                        162.0,
                        288.0,
                        29.5,
                        288.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        329.5,
                        105.0,
                        329.5,
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
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        329.5,
                        135.0,
                        329.5,
                        135.0
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
                        "obj-92",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        579.0,
                        29.5,
                        579.0
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
                        "obj-102",
                        0
                    ],
                    "midpoints": [
                        117.5,
                        606.0,
                        159.0,
                        606.0,
                        159.0,
                        597.0,
                        234.0,
                        597.0,
                        234.0,
                        609.0,
                        343.75,
                        609.0
                    ],
                    "source": [
                        "obj-92",
                        2
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
                        29.5,
                        606.0,
                        29.5,
                        606.0
                    ],
                    "source": [
                        "obj-92",
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
                        73.5,
                        615.0,
                        159.0,
                        615.0,
                        159.0,
                        609.0,
                        183.0,
                        609.0
                    ],
                    "source": [
                        "obj-92",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-94",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        636.0,
                        29.5,
                        636.0
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
                        "obj-95",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        660.0,
                        29.5,
                        660.0
                    ],
                    "source": [
                        "obj-94",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-96",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        684.0,
                        29.5,
                        684.0
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
                        "obj-100",
                        0
                    ],
                    "midpoints": [
                        183.0,
                        636.0,
                        168.0,
                        636.0,
                        168.0,
                        681.0,
                        183.0,
                        681.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-97",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-98",
                        0
                    ],
                    "midpoints": [
                        183.0,
                        636.0,
                        183.0,
                        636.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-97",
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
                        183.0,
                        660.0,
                        183.0,
                        660.0
                    ],
                    "source": [
                        "obj-98",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-233",
                        0
                    ],
                    "destination": [
                        "obj-234",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-234",
                        0
                    ],
                    "destination": [
                        "obj-235",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-235",
                        0
                    ],
                    "destination": [
                        "obj-236",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-238",
                        0
                    ],
                    "destination": [
                        "obj-239",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-239",
                        0
                    ],
                    "destination": [
                        "obj-236",
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