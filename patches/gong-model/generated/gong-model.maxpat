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
            839.0
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
                        29.5,
                        22.0
                    ],
                    "text": "f 50"
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
                        324.25,
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
                        324.25,
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
                        324.25,
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
                        190.0,
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
                        214.0,
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
                        238.0,
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
                        262.0,
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
                        286.0,
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
                        190.0,
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
                        214.0,
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
                    "id": "obj-224",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        769.0,
                        816.0,
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
                        769.0,
                        840.0,
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-232",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        727.0,
                        58.0,
                        20.0
                    ],
                    "text": "Preset"
                }
            },
            {
                "box": {
                    "id": "obj-233",
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
                        749.0,
                        140.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-234",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        20.0,
                        787.0,
                        37.0,
                        22.0
                    ],
                    "text": "+ 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-235",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        809.0,
                        114.0,
                        22.0
                    ],
                    "text": "prepend recall"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-236",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        831.0,
                        275.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    },
                    "text": "pattrstorage gong-presets @savemode 3",
                    "varname": "gong-presets"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-237",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        148.0,
                        857.0,
                        79.0,
                        22.0
                    ],
                    "restore": {
                        "d_bloom": [
                            0.5039
                        ],
                        "d_bloom_persist": [
                            0.0
                        ],
                        "d_bloom_speed": [
                            1.5048
                        ],
                        "d_brightness": [
                            0.6535
                        ],
                        "d_decay": [
                            7.8574
                        ],
                        "d_detune": [
                            0.0
                        ],
                        "d_gain": [
                            0.5984
                        ],
                        "d_hardness": [
                            0.5984
                        ],
                        "d_material": [
                            0.5
                        ],
                        "d_mode_spectrum": [
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0
                        ],
                        "d_modes": [
                            32.0
                        ],
                        "d_noise_level": [
                            0.4
                        ],
                        "d_nonlinearity": [
                            0.4016
                        ],
                        "d_position": [
                            0.3465
                        ],
                        "d_stereo_width": [
                            1.0
                        ],
                        "d_structure": [
                            1.0
                        ],
                        "d_vel_curve": [
                            1.0
                        ]
                    },
                    "text": "autopattr",
                    "varname": "u063001597"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-238",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        148.0,
                        787.0,
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
                    "id": "obj-239",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        148.0,
                        809.0,
                        72.0,
                        22.0
                    ],
                    "text": "recall 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-240",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        550.0,
                        10.0,
                        58.0,
                        20.0
                    ],
                    "text": "v1.5.9"
                }
            },
            {
                "box": {
                    "id": "obj-300",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        484.0,
                        65.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Structure",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Struct",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_structure"
                }
            },
            {
                "box": {
                    "id": "obj-301",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        484.0,
                        153.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Brightness",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Bright",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_brightness"
                }
            },
            {
                "box": {
                    "id": "obj-302",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        484.0,
                        241.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                8.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Decay Time",
                            "parameter_mmax": 30.0,
                            "parameter_mmin": 0.1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Decay",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_decay"
                }
            },
            {
                "box": {
                    "id": "obj-304",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        484.0,
                        417.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.1
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Nonlinearity",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Nonlin",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_nonlinearity"
                }
            },
            {
                "box": {
                    "id": "obj-305",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        65.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Mallet Hardness",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Hard",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_hardness"
                }
            },
            {
                "box": {
                    "id": "obj-306",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        153.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.1
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Bloom Amount",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Bloom",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_bloom"
                }
            },
            {
                "box": {
                    "id": "obj-307",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        241.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                1.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Bloom Speed",
                            "parameter_mmax": 5.0,
                            "parameter_mmin": 0.1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "BlmSpd",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_bloom_speed"
                }
            },
            {
                "box": {
                    "id": "obj-308",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        714.0,
                        774.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                16.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Number of Modes",
                            "parameter_mmax": 32.0,
                            "parameter_mmin": 4.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Modes",
                            "parameter_type": 1,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "d_modes"
                }
            },
            {
                "box": {
                    "id": "obj-309",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        417.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Output Gain",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Gain",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_gain"
                }
            },
            {
                "box": {
                    "id": "obj-310",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        505.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Noise Level",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Noise",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_noise_level"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-311",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        547.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend noise_level"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-312",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        571.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "id": "obj-313",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        593.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.3
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Material",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Material",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_material"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-314",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        635.0,
                        142.0,
                        22.0
                    ],
                    "text": "prepend material"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-315",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        659.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-316",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        593.0,
                        180.0,
                        18.0
                    ],
                    "text": "Wool  Felt  Rubber  Wood  Metal"
                }
            },
            {
                "box": {
                    "id": "obj-317",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        329.0,
                        44.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Bloom Persist",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "BlmPst",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_bloom_persist"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-318",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        371.0,
                        163.0,
                        22.0
                    ],
                    "text": "prepend bloom_persist"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-319",
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
                    "id": "obj-320",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        681.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                1.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Stereo Width",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Width",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_stereo_width"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-321",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.5,
                        694.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend stereo_width"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-322",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.5,
                        731.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "id": "obj-323",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        484.0,
                        505.0,
                        44.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                1.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Vel Curve",
                            "parameter_mmax": 3.0,
                            "parameter_mmin": 0.3,
                            "parameter_modmode": 0,
                            "parameter_shortname": "VelCrv",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_vel_curve"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-324",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        547.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend vel_curve"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-325",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        539.0,
                        571.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "id": "obj-326",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        484.0,
                        593.0,
                        44.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Detune",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Detune",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_detune"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-327",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        635.0,
                        114.0,
                        22.0
                    ],
                    "text": "prepend detune"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-328",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        539.0,
                        659.0,
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
                    "id": "obj-329",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        334.25,
                        727.0,
                        107.0,
                        20.0
                    ],
                    "text": "Mode Spectrum"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-330",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "bang"
                    ],
                    "patching_rect": [
                        334.25,
                        845.0,
                        177.0,
                        22.0
                    ],
                    "text": "buffer~ mode_gains 32 1"
                }
            },
            {
                "box": {
                    "candicane4": [
                        0.439,
                        0.619,
                        0.07,
                        0.7
                    ],
                    "id": "obj-331",
                    "maxclass": "multislider",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        334.25,
                        749.0,
                        180.0,
                        88.0
                    ],
                    "setminmax": [
                        0.0,
                        1.0
                    ],
                    "setstyle": 1,
                    "size": 32,
                    "varname": "d_mode_spectrum"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-332",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        334.25,
                        871.0,
                        135.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "filename": "mode-gains.js",
                        "parameter_enable": 0
                    },
                    "text": "js mode-gains.js"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-333",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        479.25,
                        871.0,
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
                    "id": "obj-334",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        769.0,
                        865.0,
                        114.0,
                        22.0
                    ],
                    "text": "send mode-size"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-335",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        524.25,
                        749.0,
                        135.0,
                        22.0
                    ],
                    "text": "receive mode-size"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-336",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        524.25,
                        775.0,
                        30.0,
                        22.0
                    ],
                    "text": "i"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-337",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        524.25,
                        799.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend size"
                }
            },
            {
                "box": {
                    "maxclass": "nodes",
                    "id": "obj-338",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        474.0,
                        309.0,
                        120,
                        120
                    ],
                    "parameter_enable": 0,
                    "nodenumber": 0,
                    "displayknob": 1,
                    "varname": "d_strike_xy",
                    "bgcolor": [
                        0.2,
                        0.2,
                        0.25,
                        1.0
                    ],
                    "knobcolor": [
                        0.9,
                        0.6,
                        0.2,
                        1.0
                    ],
                    "knobsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-339",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        474.0,
                        434.0,
                        116.0,
                        22.0
                    ],
                    "text": "unpack f f f",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-340",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        474.0,
                        459.0,
                        128.0,
                        22.0
                    ],
                    "text": "prepend position",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-341",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        554.0,
                        459.0,
                        184.0,
                        22.0
                    ],
                    "text": "prepend excitation_angle",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-342",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        474.0,
                        484.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-343",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        554.0,
                        484.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-344",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        474.0,
                        293.0,
                        79.0,
                        20.0
                    ],
                    "text": "Strike XY",
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
                        "obj-225",
                        0
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
                        "obj-234",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        774.0,
                        29.5,
                        774.0
                    ],
                    "source": [
                        "obj-233",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-235",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        810.0,
                        29.5,
                        810.0
                    ],
                    "source": [
                        "obj-234",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-236",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        834.0,
                        29.5,
                        834.0
                    ],
                    "source": [
                        "obj-235",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-239",
                        0
                    ],
                    "midpoints": [
                        157.5,
                        810.0,
                        157.5,
                        810.0
                    ],
                    "source": [
                        "obj-238",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-236",
                        0
                    ],
                    "midpoints": [
                        157.5,
                        864.0,
                        6.0,
                        864.0,
                        6.0,
                        828.0,
                        29.5,
                        828.0
                    ],
                    "source": [
                        "obj-239",
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
                        "obj-176",
                        0
                    ],
                    "midpoints": [
                        493.5,
                        114.0,
                        534.0,
                        114.0,
                        534.0,
                        102.0,
                        548.5,
                        102.0
                    ],
                    "source": [
                        "obj-300",
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
                        493.5,
                        204.0,
                        534.0,
                        204.0,
                        534.0,
                        192.0,
                        548.5,
                        192.0
                    ],
                    "source": [
                        "obj-301",
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
                        493.5,
                        291.0,
                        534.0,
                        291.0,
                        534.0,
                        279.0,
                        548.5,
                        279.0
                    ],
                    "source": [
                        "obj-302",
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
                        493.5,
                        468.0,
                        534.0,
                        468.0,
                        534.0,
                        456.0,
                        548.5,
                        456.0
                    ],
                    "source": [
                        "obj-304",
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
                        726.5,
                        114.0,
                        768.0,
                        114.0,
                        768.0,
                        102.0,
                        781.5,
                        102.0
                    ],
                    "source": [
                        "obj-305",
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
                        726.5,
                        204.0,
                        768.0,
                        204.0,
                        768.0,
                        192.0,
                        781.5,
                        192.0
                    ],
                    "source": [
                        "obj-306",
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
                        726.5,
                        291.0,
                        768.0,
                        291.0,
                        768.0,
                        279.0,
                        781.5,
                        279.0
                    ],
                    "source": [
                        "obj-307",
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
                    "order": 1,
                    "source": [
                        "obj-308",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-334",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "obj-308",
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
                        726.5,
                        468.0,
                        768.0,
                        468.0,
                        768.0,
                        456.0,
                        781.5,
                        456.0
                    ],
                    "source": [
                        "obj-309",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-311",
                        0
                    ],
                    "midpoints": [
                        726.5,
                        555.0,
                        768.0,
                        555.0,
                        768.0,
                        543.0,
                        781.5,
                        543.0
                    ],
                    "source": [
                        "obj-310",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-312",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        570.0,
                        781.5,
                        570.0
                    ],
                    "source": [
                        "obj-311",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-314",
                        0
                    ],
                    "midpoints": [
                        726.5,
                        642.0,
                        768.0,
                        642.0,
                        768.0,
                        630.0,
                        781.5,
                        630.0
                    ],
                    "source": [
                        "obj-313",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-315",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        660.0,
                        781.5,
                        660.0
                    ],
                    "source": [
                        "obj-314",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-318",
                        0
                    ],
                    "midpoints": [
                        751.5,
                        378.0,
                        768.0,
                        378.0,
                        768.0,
                        366.0,
                        781.5,
                        366.0
                    ],
                    "source": [
                        "obj-317",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-319",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        396.0,
                        781.5,
                        396.0
                    ],
                    "source": [
                        "obj-318",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-321",
                        0
                    ],
                    "midpoints": [
                        726.5,
                        732.0,
                        768.0,
                        732.0,
                        768.0,
                        690.0,
                        782.0,
                        690.0
                    ],
                    "source": [
                        "obj-320",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-322",
                        0
                    ],
                    "midpoints": [
                        782.0,
                        717.0,
                        782.0,
                        717.0
                    ],
                    "source": [
                        "obj-321",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-324",
                        0
                    ],
                    "midpoints": [
                        493.5,
                        555.0,
                        534.0,
                        555.0,
                        534.0,
                        543.0,
                        548.5,
                        543.0
                    ],
                    "source": [
                        "obj-323",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-325",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        570.0,
                        548.5,
                        570.0
                    ],
                    "source": [
                        "obj-324",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-327",
                        0
                    ],
                    "midpoints": [
                        518.5,
                        642.0,
                        534.0,
                        642.0,
                        534.0,
                        630.0,
                        548.5,
                        630.0
                    ],
                    "source": [
                        "obj-326",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-328",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        660.0,
                        548.5,
                        660.0
                    ],
                    "source": [
                        "obj-327",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-332",
                        0
                    ],
                    "midpoints": [
                        343.75,
                        840.0,
                        330.0,
                        840.0,
                        330.0,
                        867.0,
                        343.75,
                        867.0
                    ],
                    "source": [
                        "obj-331",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-331",
                        0
                    ],
                    "midpoints": [
                        343.75,
                        894.0,
                        321.0,
                        894.0,
                        321.0,
                        744.0,
                        343.75,
                        744.0
                    ],
                    "source": [
                        "obj-332",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-332",
                        0
                    ],
                    "midpoints": [
                        488.75,
                        903.0,
                        321.0,
                        903.0,
                        321.0,
                        867.0,
                        343.75,
                        867.0
                    ],
                    "source": [
                        "obj-333",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-332",
                        1
                    ],
                    "midpoints": [
                        533.75,
                        771.0,
                        516.0,
                        771.0,
                        516.0,
                        867.0,
                        459.75,
                        867.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-335",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-336",
                        0
                    ],
                    "midpoints": [
                        533.75,
                        774.0,
                        533.75,
                        774.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-335",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-337",
                        0
                    ],
                    "midpoints": [
                        533.75,
                        798.0,
                        533.75,
                        798.0
                    ],
                    "source": [
                        "obj-336",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-331",
                        0
                    ],
                    "midpoints": [
                        533.75,
                        822.0,
                        516.0,
                        822.0,
                        516.0,
                        714.0,
                        330.0,
                        714.0,
                        330.0,
                        744.0,
                        343.75,
                        744.0
                    ],
                    "source": [
                        "obj-337",
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
                        "obj-338",
                        2
                    ],
                    "destination": [
                        "obj-339",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-339",
                        0
                    ],
                    "destination": [
                        "obj-340",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-339",
                        1
                    ],
                    "destination": [
                        "obj-341",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-340",
                        0
                    ],
                    "destination": [
                        "obj-342",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-341",
                        0
                    ],
                    "destination": [
                        "obj-343",
                        0
                    ]
                }
            }
        ],
        "parameters": {
            "obj-300": [
                "Structure",
                "Struct",
                0
            ],
            "obj-301": [
                "Brightness",
                "Bright",
                0
            ],
            "obj-302": [
                "Decay Time",
                "Decay",
                0
            ],
            "obj-303": [
                "Position",
                "Pos",
                0
            ],
            "obj-304": [
                "Nonlinearity",
                "Nonlin",
                0
            ],
            "obj-305": [
                "Mallet Hardness",
                "Hard",
                0
            ],
            "obj-306": [
                "Bloom Amount",
                "Bloom",
                0
            ],
            "obj-307": [
                "Bloom Speed",
                "BlmSpd",
                0
            ],
            "obj-308": [
                "Number of Modes",
                "Modes",
                0
            ],
            "obj-309": [
                "Output Gain",
                "Gain",
                0
            ],
            "obj-310": [
                "Noise Level",
                "Noise",
                0
            ],
            "obj-313": [
                "Material",
                "Material",
                0
            ],
            "obj-317": [
                "Bloom Persist",
                "BlmPst",
                0
            ],
            "obj-320": [
                "Stereo Width",
                "Width",
                0
            ],
            "obj-323": [
                "Vel Curve",
                "VelCrv",
                0
            ],
            "obj-326": [
                "Detune",
                "Detune",
                0
            ],
            "inherited_shortname": 1
        },
        "autosave": 0,
        "editing_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ]
    }
}