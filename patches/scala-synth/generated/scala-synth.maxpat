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
            34.0,
            104.0,
            1333.0,
            565.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1871.0,
                        30.0,
                        457.0,
                        20.0
                    ],
                    "text": "--- MIDI INPUT: notein -> pack -> prepend midinote -> poly~ ---"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
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
                    "id": "obj-5",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        621.0,
                        150.0,
                        50.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-6",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        686.0,
                        150.0,
                        50.0,
                        22.0
                    ]
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
                        1871.0,
                        80.0,
                        324.0,
                        20.0
                    ],
                    "text": "DEBUG: MIDI note (left) and velocity (right)"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-9",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1871.0,
                        130.0,
                        464.0,
                        20.0
                    ],
                    "text": "DEBUG: check Max console for \"scala-midi: note <note> <vel>\""
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-10",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        291.5,
                        234.0,
                        261.0,
                        22.0
                    ],
                    "text": "poly~ scala-synth-voice 16 @steal 1"
                }
            },
            {
                "box": {
                    "id": "obj-13",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        30.0,
                        116.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        325.0,
                        483.0,
                        24.0,
                        24.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-14",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        166.0,
                        116.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        355.0,
                        483.0,
                        24.0,
                        24.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-15",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1871.0,
                        180.0,
                        394.0,
                        20.0
                    ],
                    "text": "DEBUG: Click buttons to send test note on/off to poly~"
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
                        1871.0,
                        230.0,
                        380.0,
                        20.0
                    ],
                    "text": "Left=note on (C4 vel 100), Right=note off (C4 vel 0)"
                }
            },
            {
                "box": {
                    "id": "obj-17",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        398.0,
                        116.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        82.0,
                        38.0,
                        24.0,
                        24.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "patching_rect": [
                        398.0,
                        150.0,
                        121.0,
                        22.0
                    ],
                    "text": "opendialog .scl"
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
                        404.0,
                        192.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend read"
                }
            },
            {
                "box": {
                    "id": "obj-20",
                    "maxclass": "dropfile",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        291.0,
                        30.0,
                        100.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        112.0,
                        38.0,
                        100.0,
                        24.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-21",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1063.0,
                        234.0,
                        142.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "filename": "scala-parser.js",
                        "parameter_enable": 0
                    },
                    "text": "js scala-parser.js"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "bang"
                    ],
                    "patching_rect": [
                        892.0,
                        234.0,
                        156.0,
                        22.0
                    ],
                    "text": "buffer~ scala-tuning"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-23",
                    "linecount": 2,
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1690.5,
                        318.0,
                        58.0,
                        35.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        262.0,
                        38.0,
                        120.0,
                        22.0
                    ],
                    "text": "\"8 out of 11-tET\""
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
                        1673.0,
                        276.0,
                        93.0,
                        22.0
                    ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "obj-25",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1781.0,
                        276.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        448.0,
                        38.0,
                        40.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-26",
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
                        1509.0,
                        244.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        92.0,
                        55.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-27",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1509.0,
                        276.0,
                        149.0,
                        22.0
                    ],
                    "text": "send scala-partials"
                }
            },
            {
                "box": {
                    "id": "obj-28",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1359.0,
                        226.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        155.0,
                        90.0,
                        50.0,
                        50.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-29",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1359.0,
                        276.0,
                        135.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 3."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-30",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1516.0,
                        318.0,
                        121.0,
                        22.0
                    ],
                    "text": "send scala-tilt"
                }
            },
            {
                "box": {
                    "id": "obj-31",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1202.0,
                        226.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        265.0,
                        90.0,
                        50.0,
                        50.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-32",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1202.0,
                        276.0,
                        142.0,
                        22.0
                    ],
                    "text": "scale 0 127 0.5 2."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-33",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1359.0,
                        318.0,
                        142.0,
                        22.0
                    ],
                    "text": "send scala-stretch"
                }
            },
            {
                "box": {
                    "id": "obj-34",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1052.0,
                        226.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        375.0,
                        90.0,
                        50.0,
                        50.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-35",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1052.0,
                        276.0,
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
                    "id": "obj-36",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1202.0,
                        318.0,
                        142.0,
                        22.0
                    ],
                    "text": "send scala-evenodd"
                }
            },
            {
                "box": {
                    "id": "obj-37",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        902.0,
                        226.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        485.0,
                        90.0,
                        50.0,
                        50.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-38",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        902.0,
                        276.0,
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
                    "id": "obj-39",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1059.0,
                        318.0,
                        128.0,
                        22.0
                    ],
                    "text": "send scala-drift"
                }
            },
            {
                "box": {
                    "id": "obj-40",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        731.0,
                        226.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        45.0,
                        168.0,
                        50.0,
                        50.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-41",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        731.0,
                        276.0,
                        156.0,
                        22.0
                    ],
                    "text": "scale 0 127 1. 2000."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-42",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        752.0,
                        318.0,
                        114.0,
                        22.0
                    ],
                    "text": "send scala-atk"
                }
            },
            {
                "box": {
                    "id": "obj-43",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        560.0,
                        226.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        155.0,
                        168.0,
                        50.0,
                        50.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-44",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        560.0,
                        276.0,
                        156.0,
                        22.0
                    ],
                    "text": "scale 0 127 1. 2000."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-45",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        581.0,
                        318.0,
                        114.0,
                        22.0
                    ],
                    "text": "send scala-dec"
                }
            },
            {
                "box": {
                    "id": "obj-46",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        410.0,
                        226.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        265.0,
                        168.0,
                        50.0,
                        50.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-47",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        410.0,
                        276.0,
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
                    "id": "obj-48",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        420.5,
                        318.0,
                        114.0,
                        22.0
                    ],
                    "text": "send scala-sus"
                }
            },
            {
                "box": {
                    "id": "obj-49",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        150.0,
                        217.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        375.0,
                        168.0,
                        50.0,
                        50.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-50",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        239.0,
                        276.0,
                        156.0,
                        22.0
                    ],
                    "text": "scale 0 127 1. 5000."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-51",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        260.0,
                        318.0,
                        114.0,
                        22.0
                    ],
                    "text": "send scala-rel"
                }
            },
            {
                "box": {
                    "id": "obj-52",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        89.0,
                        226.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        485.0,
                        168.0,
                        50.0,
                        50.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-53",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        89.0,
                        276.0,
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
                    "id": "obj-54",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        195.0,
                        318.0,
                        44.0,
                        22.0
                    ],
                    "text": "sig~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-55",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1871.0,
                        280.0,
                        352.0,
                        20.0
                    ],
                    "text": "--- OUTPUT: poly~ -> *~ master vol -> ezdac~ ---"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-56",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        299.5,
                        360.0,
                        40.0,
                        22.0
                    ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "obj-57",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        238.33333333333331,
                        480.0,
                        45.0,
                        45.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        475.0,
                        45.0,
                        45.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-58",
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
                        344.5,
                        360.0,
                        64.0,
                        32.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        540.0,
                        168.0,
                        64.0,
                        32.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-59",
                    "maxclass": "spectroscope~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        373.5,
                        360.0,
                        300.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        344.0,
                        550.0,
                        120.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-60",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        557.5,
                        234.0,
                        20.0,
                        80.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        160.0,
                        475.0,
                        16.0,
                        58.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-61",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1871.0,
                        330.0,
                        450.0,
                        20.0
                    ],
                    "text": "DEBUG: poly~ raw output level (if zero, no signal from voices)"
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
                        678.5,
                        360.0,
                        20.0,
                        80.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        200.0,
                        475.0,
                        16.0,
                        58.0
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
                        1871.0,
                        380.0,
                        569.0,
                        20.0
                    ],
                    "text": "DEBUG: master output level (if zero but poly~ meter shows signal, check volume)"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-73",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2455.0,
                        180.0,
                        387.0,
                        20.0
                    ],
                    "text": "--- GEN~ TEST: test additive engine outside poly~ ---"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-74",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2455.0,
                        230.0,
                        464.0,
                        20.0
                    ],
                    "text": "Enter frequency, toggle on to hear. Tests gen~ codebox directly."
                }
            },
            {
                "box": {
                    "id": "obj-75",
                    "maxclass": "number",
                    "maximum": 2000,
                    "minimum": 20,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        4.0,
                        226.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        155.0,
                        543.0,
                        55.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-76",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        30.0,
                        276.0,
                        44.0,
                        22.0
                    ],
                    "text": "sig~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-77",
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
                            "revision": 2,
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
                                    "code": "Param num_partials(8, min=1, max=32);\nParam tilt(1.0, min=0, max=3);\nParam stretch(1.0, min=0.5, max=2);\nParam even_odd(0.5, min=0, max=1);\nParam drift_amt(0.0, min=0, max=1);\n\nData phases(32);\nHistory drift_clock(0);\n\nfreq = in1;\nsum = 0;\nsr = samplerate;\n\ndrift_clock = wrap(drift_clock + 1.0 / sr, 0, 1000);\n\nif (freq > 0) {\n    for (i = 0; i < 32; i = i + 1) {\n        n = i + 1;\n\n        if (n <= num_partials) {\n            partial_freq = freq * pow(n, stretch);\n            phase_inc = partial_freq / sr;\n\n            drift_val = sin(drift_clock * TWOPI * 0.3 + n * 2.17) * drift_amt * 0.003;\n            phase_inc = phase_inc * (1 + drift_val);\n\n            phase = peek(phases, i);\n            phase = phase + phase_inc;\n            phase = wrap(phase, 0, 1);\n            poke(phases, phase, i);\n\n            amp = 1.0 / pow(n, tilt);\n\n            if (n > 1) {\n                is_even = (n % 2 == 0);\n                if (is_even) {\n                    amp = amp * clamp(even_odd * 2, 0, 1);\n                } else {\n                    amp = amp * clamp((1 - even_odd) * 2, 0, 1);\n                }\n            }\n\n            sum = sum + sin(phase * TWOPI) * amp;\n        } else {\n            poke(phases, 0, i);\n        }\n    }\n\n    sum = sum / sqrt(num_partials);\n}\n\nout1 = sum;",
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
                                        72.0,
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
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        215.0,
                                        292.0,
                                        35.0,
                                        22.0
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
                                        62.0,
                                        39.5,
                                        62.0
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
                        34.0,
                        349.0,
                        150.0,
                        22.0
                    ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-78",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        166.0,
                        399.0,
                        40.0,
                        22.0
                    ],
                    "text": "*~"
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
                        259.0,
                        120.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        220.0,
                        543.0,
                        24.0,
                        24.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-80",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        288.0,
                        150.0,
                        54.0,
                        22.0
                    ],
                    "text": "* 0.1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-81",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        266.0,
                        183.0,
                        44.0,
                        22.0
                    ],
                    "text": "sig~"
                }
            },
            {
                "box": {
                    "id": "obj-82",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        32.0,
                        445.0,
                        20.0,
                        80.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        250.0,
                        535.0,
                        16.0,
                        58.0
                    ]
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-83",
                    "maxclass": "number~",
                    "mode": 2,
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "float"
                    ],
                    "patching_rect": [
                        181.0,
                        322.0,
                        56.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        272.0,
                        543.0,
                        56.0,
                        22.0
                    ],
                    "sig": 0.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-84",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2426.0,
                        284.0,
                        79.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        545.0,
                        75.0,
                        20.0
                    ],
                    "text": "GEN~ TEST"
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
                        2426.0,
                        334.0,
                        86.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        90.0,
                        545.0,
                        65.0,
                        20.0
                    ],
                    "text": "Freq (Hz):"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-86",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2455.0,
                        380.0,
                        471.0,
                        20.0
                    ],
                    "text": "DEBUG: gen~ test meter -- if this shows level, gen~ codebox works"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-87",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        881.0,
                        318.0,
                        163.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "filename": "partial-display.js",
                        "parameter_enable": 0
                    },
                    "text": "js partial-display.js"
                }
            },
            {
                "box": {
                    "id": "obj-88",
                    "maxclass": "multislider",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        862.5,
                        360.0,
                        200.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        246.0,
                        550.0,
                        75.0
                    ],
                    "setminmax": [
                        0.0,
                        1.0
                    ],
                    "setstyle": 1,
                    "size": 32
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 20.0,
                    "id": "obj-89",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2941.0,
                        30.0,
                        150.0,
                        29.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        5.0,
                        200.0,
                        29.0
                    ],
                    "text": "SCALA SYNTH"
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
                        2941.0,
                        80.0,
                        86.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        40.0,
                        65.0,
                        20.0
                    ],
                    "text": "Load .scl:"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-91",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2941.0,
                        130.0,
                        72.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        35.0,
                        72.0,
                        70.0,
                        20.0
                    ],
                    "text": "PARTIALS"
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
                        2941.0,
                        180.0,
                        44.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        160.0,
                        72.0,
                        40.0,
                        20.0
                    ],
                    "text": "TILT"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-93",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2941.0,
                        230.0,
                        65.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        260.0,
                        72.0,
                        65.0,
                        20.0
                    ],
                    "text": "STRETCH"
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
                        2941.0,
                        280.0,
                        72.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        367.0,
                        72.0,
                        71.0,
                        20.0
                    ],
                    "text": "EVEN/ODD"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-95",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2941.0,
                        330.0,
                        51.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        487.0,
                        72.0,
                        45.0,
                        20.0
                    ],
                    "text": "DRIFT"
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
                        2941.0,
                        380.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        150.0,
                        55.0,
                        20.0
                    ],
                    "text": "ATTACK"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-97",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3049.0,
                        30.0,
                        51.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        155.0,
                        150.0,
                        50.0,
                        20.0
                    ],
                    "text": "DECAY"
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
                        3049.0,
                        80.0,
                        65.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        257.0,
                        150.0,
                        65.0,
                        20.0
                    ],
                    "text": "SUSTAIN"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-99",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3049.0,
                        130.0,
                        65.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        367.0,
                        150.0,
                        64.0,
                        20.0
                    ],
                    "text": "RELEASE"
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
                        3049.0,
                        180.0,
                        59.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        480.0,
                        150.0,
                        59.0,
                        20.0
                    ],
                    "text": "VOLUME"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-101",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3049.0,
                        230.0,
                        142.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        228.0,
                        120.0,
                        20.0
                    ],
                    "text": "Partial Amplitudes"
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
                        3049.0,
                        280.0,
                        72.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        326.0,
                        80.0,
                        20.0
                    ],
                    "text": "Spectrum"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-103",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3049.0,
                        330.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        220.0,
                        40.0,
                        42.0,
                        20.0
                    ],
                    "text": "Scale:"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-104",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3049.0,
                        380.0,
                        72.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        390.0,
                        40.0,
                        57.0,
                        20.0
                    ],
                    "text": "Degrees:"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-105",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        204.0,
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
                    "id": "obj-106",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 13,
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
                        "bang"
                    ],
                    "patching_rect": [
                        751.0,
                        150.0,
                        247.0,
                        22.0
                    ],
                    "text": "trigger b b b b b b b b b b b b b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-107",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        854.5,
                        192.0,
                        40.0,
                        22.0
                    ],
                    "text": "440"
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
                        909.5,
                        192.0,
                        121.0,
                        22.0
                    ],
                    "text": "sizeinsamps 128"
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
                        1045.5,
                        192.0,
                        40.0,
                        22.0
                    ],
                    "text": "100"
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
                        1100.5,
                        192.0,
                        40.0,
                        22.0
                    ],
                    "text": "15"
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
                        1155.5,
                        192.0,
                        40.0,
                        22.0
                    ],
                    "text": "90"
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
                        1210.5,
                        192.0,
                        40.0,
                        22.0
                    ],
                    "text": "30"
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
                        1265.5,
                        192.0,
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
                    "id": "obj-114",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1320.5,
                        192.0,
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
                    "id": "obj-115",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1375.5,
                        192.0,
                        40.0,
                        22.0
                    ],
                    "text": "64"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-116",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1430.5,
                        192.0,
                        40.0,
                        22.0
                    ],
                    "text": "42"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-117",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1485.5,
                        192.0,
                        40.0,
                        22.0
                    ],
                    "text": "43"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-118",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1540.5,
                        192.0,
                        40.0,
                        22.0
                    ],
                    "text": "8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-119",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1595.5,
                        192.0,
                        44.0,
                        22.0
                    ],
                    "text": "bang"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-120",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3206.0,
                        30.0,
                        86.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        65.0,
                        488.0,
                        82.0,
                        20.0
                    ],
                    "text": "DSP ON/OFF"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-121",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3206.0,
                        80.0,
                        51.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        148.0,
                        522.0,
                        40.0,
                        20.0
                    ],
                    "text": "poly~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-122",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3206.0,
                        130.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        186.0,
                        522.0,
                        45.0,
                        20.0
                    ],
                    "text": "master"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-123",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3206.0,
                        180.0,
                        86.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        250.0,
                        488.0,
                        79.0,
                        20.0
                    ],
                    "text": "TEST NOTE:"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-124",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3206.0,
                        230.0,
                        40.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        328.0,
                        509.0,
                        26.0,
                        20.0
                    ],
                    "text": "ON"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-125",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3206.0,
                        280.0,
                        40.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        354.0,
                        509.0,
                        32.0,
                        20.0
                    ],
                    "text": "OFF"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-200",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        30,
                        150,
                        100,
                        22
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "text": "trigger b b b"
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-201",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        186,
                        65,
                        22
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "text": "target 1"
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-202",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        100,
                        186,
                        30,
                        22
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "text": "100"
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-203",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        140,
                        186,
                        30,
                        22
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "text": "60"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-204",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        166,
                        150,
                        100,
                        22
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "text": "trigger b b b"
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-205",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        166,
                        186,
                        65,
                        22
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "text": "target 1"
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-206",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        236,
                        186,
                        24,
                        22
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "text": "0"
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-207",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        270,
                        186,
                        30,
                        22
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "text": "60"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-208",
                    "numinlets": 2,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        534,
                        72,
                        72,
                        22
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "text": "poly 16 1"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-209",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        534,
                        108,
                        107,
                        22
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "text": "prepend target"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-56",
                        0
                    ],
                    "midpoints": [
                        301.0,
                        258.0,
                        396.0,
                        258.0,
                        396.0,
                        345.0,
                        312.0,
                        345.0,
                        312.0,
                        357.0,
                        309.0,
                        357.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-10",
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
                        301.0,
                        258.0,
                        405.0,
                        258.0,
                        405.0,
                        267.0,
                        552.0,
                        267.0,
                        552.0,
                        231.0,
                        567.0,
                        231.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-10",
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
                        213.5,
                        63.0,
                        288.0,
                        63.0,
                        288.0,
                        15.0,
                        760.5,
                        15.0
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
                        988.5,
                        174.0,
                        864.0,
                        174.0
                    ],
                    "source": [
                        "obj-106",
                        12
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
                        969.5,
                        174.0,
                        919.0,
                        174.0
                    ],
                    "source": [
                        "obj-106",
                        11
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
                        950.5,
                        174.0,
                        1055.0,
                        174.0
                    ],
                    "source": [
                        "obj-106",
                        10
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
                        931.5,
                        174.0,
                        1110.0,
                        174.0
                    ],
                    "source": [
                        "obj-106",
                        9
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
                        912.5,
                        174.0,
                        1165.0,
                        174.0
                    ],
                    "source": [
                        "obj-106",
                        8
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
                        893.5,
                        174.0,
                        1220.0,
                        174.0
                    ],
                    "source": [
                        "obj-106",
                        7
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
                        874.5,
                        174.0,
                        1275.0,
                        174.0
                    ],
                    "source": [
                        "obj-106",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-114",
                        0
                    ],
                    "midpoints": [
                        855.5,
                        174.0,
                        1330.0,
                        174.0
                    ],
                    "source": [
                        "obj-106",
                        5
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
                        836.5,
                        174.0,
                        1385.0,
                        174.0
                    ],
                    "source": [
                        "obj-106",
                        4
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
                        817.5,
                        174.0,
                        1440.0,
                        174.0
                    ],
                    "source": [
                        "obj-106",
                        3
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
                        798.5,
                        183.0,
                        747.0,
                        183.0,
                        747.0,
                        135.0,
                        1495.0,
                        135.0
                    ],
                    "source": [
                        "obj-106",
                        2
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
                        779.5,
                        174.0,
                        747.0,
                        174.0,
                        747.0,
                        135.0,
                        1550.0,
                        135.0
                    ],
                    "source": [
                        "obj-106",
                        1
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
                        760.5,
                        174.0,
                        747.0,
                        174.0,
                        747.0,
                        135.0,
                        1605.0,
                        135.0
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
                        "obj-75",
                        0
                    ],
                    "midpoints": [
                        864.0,
                        216.0,
                        738.0,
                        216.0,
                        738.0,
                        15.0,
                        13.5,
                        15.0
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
                        "obj-22",
                        0
                    ],
                    "midpoints": [
                        919.0,
                        216.0,
                        897.0,
                        216.0,
                        897.0,
                        231.0,
                        901.5,
                        231.0
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
                        "obj-52",
                        0
                    ],
                    "midpoints": [
                        1055.0,
                        216.0,
                        1032.0,
                        216.0,
                        1032.0,
                        135.0,
                        423.0,
                        135.0,
                        423.0,
                        147.0,
                        273.0,
                        147.0,
                        273.0,
                        180.0,
                        252.0,
                        180.0,
                        252.0,
                        213.0,
                        98.5,
                        213.0
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
                        "obj-49",
                        0
                    ],
                    "midpoints": [
                        1110.0,
                        216.0,
                        1086.0,
                        216.0,
                        1086.0,
                        135.0,
                        423.0,
                        135.0,
                        423.0,
                        147.0,
                        273.0,
                        147.0,
                        273.0,
                        180.0,
                        252.0,
                        180.0,
                        252.0,
                        213.0,
                        159.5,
                        213.0
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
                        "obj-46",
                        0
                    ],
                    "midpoints": [
                        1165.0,
                        216.0,
                        1140.0,
                        216.0,
                        1140.0,
                        135.0,
                        519.0,
                        135.0,
                        519.0,
                        189.0,
                        504.0,
                        189.0,
                        504.0,
                        222.0,
                        419.5,
                        222.0
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
                        "obj-43",
                        0
                    ],
                    "midpoints": [
                        1220.0,
                        216.0,
                        1197.0,
                        216.0,
                        1197.0,
                        135.0,
                        672.0,
                        135.0,
                        672.0,
                        219.0,
                        569.5,
                        219.0
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
                        "obj-40",
                        0
                    ],
                    "midpoints": [
                        1275.0,
                        216.0,
                        1251.0,
                        216.0,
                        1251.0,
                        135.0,
                        740.5,
                        135.0
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
                        "obj-37",
                        0
                    ],
                    "midpoints": [
                        1330.0,
                        216.0,
                        1305.0,
                        216.0,
                        1305.0,
                        177.0,
                        906.0,
                        177.0,
                        906.0,
                        222.0,
                        911.5,
                        222.0
                    ],
                    "source": [
                        "obj-114",
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
                        1385.0,
                        216.0,
                        1362.0,
                        216.0,
                        1362.0,
                        177.0,
                        1086.0,
                        177.0,
                        1086.0,
                        222.0,
                        1061.5,
                        222.0
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
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        1440.0,
                        216.0,
                        1416.0,
                        216.0,
                        1416.0,
                        177.0,
                        1206.0,
                        177.0,
                        1206.0,
                        222.0,
                        1211.5,
                        222.0
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
                        "obj-28",
                        0
                    ],
                    "midpoints": [
                        1495.0,
                        225.0,
                        1401.0,
                        225.0,
                        1401.0,
                        222.0,
                        1368.5,
                        222.0
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
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        1550.0,
                        231.0,
                        1518.5,
                        231.0
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
                        "obj-21",
                        0
                    ],
                    "midpoints": [
                        1605.0,
                        216.0,
                        1581.0,
                        216.0,
                        1581.0,
                        177.0,
                        1086.0,
                        177.0,
                        1086.0,
                        222.0,
                        1072.5,
                        222.0
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
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        407.5,
                        141.0,
                        407.5,
                        141.0
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
                        407.5,
                        186.0,
                        413.5,
                        186.0
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
                        413.5,
                        216.0,
                        516.0,
                        216.0,
                        516.0,
                        174.0,
                        531.0,
                        174.0,
                        531.0,
                        135.0,
                        1041.0,
                        135.0,
                        1041.0,
                        222.0,
                        1072.5,
                        222.0
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        54.0,
                        15.0,
                        54.0,
                        15.0,
                        15.0,
                        630.5,
                        15.0
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
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        59.0,
                        63.0,
                        288.0,
                        63.0,
                        288.0,
                        15.0,
                        695.5,
                        15.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-2",
                        1
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
                        300.5,
                        147.0,
                        285.0,
                        147.0,
                        285.0,
                        180.0,
                        321.0,
                        180.0,
                        321.0,
                        189.0,
                        413.5,
                        189.0
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
                    "midpoints": [
                        1072.5,
                        273.0,
                        1047.0,
                        273.0,
                        1047.0,
                        351.0,
                        1668.0,
                        351.0,
                        1668.0,
                        273.0,
                        1682.5,
                        273.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        1195.5,
                        351.0,
                        1776.0,
                        351.0,
                        1776.0,
                        273.0,
                        1790.5,
                        273.0
                    ],
                    "source": [
                        "obj-21",
                        1
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
                        1682.5,
                        312.0,
                        1700.0,
                        312.0
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
                    "midpoints": [
                        1518.5,
                        267.0,
                        1518.5,
                        267.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-26",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-87",
                        0
                    ],
                    "midpoints": [
                        1518.5,
                        267.0,
                        1503.0,
                        267.0,
                        1503.0,
                        351.0,
                        1044.0,
                        351.0,
                        1044.0,
                        315.0,
                        890.5,
                        315.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-26",
                        0
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
                        1368.5,
                        267.0,
                        1368.5,
                        267.0
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
                        "obj-30",
                        0
                    ],
                    "midpoints": [
                        1368.5,
                        312.0,
                        1525.5,
                        312.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-29",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-87",
                        1
                    ],
                    "midpoints": [
                        1368.5,
                        300.0,
                        1344.0,
                        300.0,
                        1344.0,
                        351.0,
                        1044.0,
                        351.0,
                        1044.0,
                        315.0,
                        962.5,
                        315.0
                    ],
                    "order": 1,
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
                        1211.5,
                        267.0,
                        1211.5,
                        267.0
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
                        "obj-33",
                        0
                    ],
                    "midpoints": [
                        1211.5,
                        315.0,
                        1368.5,
                        315.0
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
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        1061.5,
                        267.0,
                        1061.5,
                        267.0
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
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        1061.5,
                        312.0,
                        1211.5,
                        312.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-35",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-87",
                        2
                    ],
                    "midpoints": [
                        1061.5,
                        300.0,
                        1034.5,
                        300.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-35",
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
                        911.5,
                        267.0,
                        911.5,
                        267.0
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
                        911.5,
                        315.0,
                        1068.5,
                        315.0
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
                        740.5,
                        267.0,
                        740.5,
                        267.0
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
                        "obj-42",
                        0
                    ],
                    "midpoints": [
                        740.5,
                        315.0,
                        761.5,
                        315.0
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
                    "midpoints": [
                        569.5,
                        267.0,
                        569.5,
                        267.0
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
                        569.5,
                        300.0,
                        590.5,
                        300.0
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
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        419.5,
                        267.0,
                        419.5,
                        267.0
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
                        "obj-48",
                        0
                    ],
                    "midpoints": [
                        419.5,
                        312.0,
                        430.0,
                        312.0
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
                    "midpoints": [
                        159.5,
                        267.0,
                        248.5,
                        267.0
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
                        "obj-51",
                        0
                    ],
                    "midpoints": [
                        248.5,
                        315.0,
                        269.5,
                        315.0
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
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        98.5,
                        267.0,
                        98.5,
                        267.0
                    ],
                    "source": [
                        "obj-52",
                        0
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
                        98.5,
                        312.0,
                        204.5,
                        312.0
                    ],
                    "source": [
                        "obj-53",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-56",
                        1
                    ],
                    "midpoints": [
                        204.5,
                        354.0,
                        330.0,
                        354.0
                    ],
                    "source": [
                        "obj-54",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-57",
                        1
                    ],
                    "midpoints": [
                        309.0,
                        465.0,
                        273.8333333333333,
                        465.0
                    ],
                    "order": 3,
                    "source": [
                        "obj-56",
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
                        309.0,
                        465.0,
                        247.83333333333331,
                        465.0
                    ],
                    "order": 4,
                    "source": [
                        "obj-56",
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
                        309.0,
                        384.0,
                        339.0,
                        384.0,
                        339.0,
                        357.0,
                        354.0,
                        357.0
                    ],
                    "order": 2,
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
                        309.0,
                        384.0,
                        339.0,
                        384.0,
                        339.0,
                        357.0,
                        383.0,
                        357.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-56",
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
                        309.0,
                        471.0,
                        708.0,
                        471.0,
                        708.0,
                        357.0,
                        688.0,
                        357.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-56",
                        0
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
                        13.5,
                        273.0,
                        39.5,
                        273.0
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
                        "obj-77",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        300.0,
                        43.5,
                        300.0
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
                        "obj-78",
                        0
                    ],
                    "midpoints": [
                        43.5,
                        357.0,
                        175.5,
                        357.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-77",
                        0
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
                        43.5,
                        342.0,
                        41.5,
                        342.0
                    ],
                    "order": 2,
                    "source": [
                        "obj-77",
                        0
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
                        43.5,
                        342.0,
                        27.0,
                        342.0,
                        27.0,
                        315.0,
                        190.5,
                        315.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-77",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-57",
                        1
                    ],
                    "midpoints": [
                        175.5,
                        465.0,
                        273.8333333333333,
                        465.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-78",
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
                        175.5,
                        465.0,
                        247.83333333333331,
                        465.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-78",
                        0
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
                        268.5,
                        147.0,
                        297.5,
                        147.0
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
                        "obj-81",
                        0
                    ],
                    "midpoints": [
                        297.5,
                        174.0,
                        276.0,
                        174.0,
                        276.0,
                        180.0,
                        275.5,
                        180.0
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
                        "obj-78",
                        1
                    ],
                    "midpoints": [
                        275.5,
                        207.0,
                        222.0,
                        207.0,
                        222.0,
                        273.0,
                        234.0,
                        273.0,
                        234.0,
                        315.0,
                        240.0,
                        315.0,
                        240.0,
                        357.0,
                        196.5,
                        357.0
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
                        "obj-88",
                        0
                    ],
                    "midpoints": [
                        890.5,
                        342.0,
                        872.0,
                        342.0
                    ],
                    "source": [
                        "obj-87",
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
                        "obj-200",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-200",
                        2
                    ],
                    "destination": [
                        "obj-201",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-201",
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
                        "obj-200",
                        1
                    ],
                    "destination": [
                        "obj-202",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-202",
                        0
                    ],
                    "destination": [
                        "obj-10",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-200",
                        0
                    ],
                    "destination": [
                        "obj-203",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-203",
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
                        0
                    ],
                    "destination": [
                        "obj-204",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-204",
                        2
                    ],
                    "destination": [
                        "obj-205",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-205",
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
                        "obj-204",
                        1
                    ],
                    "destination": [
                        "obj-206",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-206",
                        0
                    ],
                    "destination": [
                        "obj-10",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-204",
                        0
                    ],
                    "destination": [
                        "obj-207",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-207",
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
                        "obj-2",
                        0
                    ],
                    "destination": [
                        "obj-208",
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
                        "obj-208",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-208",
                        0
                    ],
                    "destination": [
                        "obj-209",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-209",
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
                        "obj-208",
                        1
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
                        "obj-208",
                        2
                    ],
                    "destination": [
                        "obj-10",
                        1
                    ]
                }
            }
        ],
        "autosave": 0
    }
}