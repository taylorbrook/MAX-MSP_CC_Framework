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
            104.0,
            1500.0,
            769.0
        ],
        "boxes": [
            {
                "box": {
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-30",
                    "maxclass": "number~",
                    "mode": 2,
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "float"
                    ],
                    "patching_rect": [
                        405.0,
                        420.0,
                        56.0,
                        22.0
                    ],
                    "sig": 0.0
                }
            },
            {
                "box": {
                    "comment": "commands: go, stop, seeksample N, seekmeasure N",
                    "id": "obj-1",
                    "index": 0,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        30.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "comment": "current sample (control)",
                    "id": "obj-2",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        285.0,
                        585.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "comment": "bar beat (control)",
                    "id": "obj-3",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1065.0,
                        645.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 5,
                    "numoutlets": 5,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        75.0,
                        268.0,
                        22.0
                    ],
                    "text": "route go stop seeksample seekmeasure"
                }
            },
            {
                "box": {
                    "bgoncolor": [
                        0.2,
                        0.7,
                        0.3,
                        1.0
                    ],
                    "id": "obj-5",
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
                        90.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "text": "GO"
                }
            },
            {
                "box": {
                    "bgoncolor": [
                        0.8,
                        0.25,
                        0.25,
                        1.0
                    ],
                    "id": "obj-6",
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
                        210.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "text": "STOP"
                }
            },
            {
                "box": {
                    "id": "obj-7",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        30.0,
                        30.0,
                        50.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-8",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        375.0,
                        30.0,
                        50.0,
                        22.0
                    ]
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
                        1440.0,
                        30.0,
                        93.0,
                        20.0
                    ],
                    "text": "seek sample",
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
                    "id": "obj-10",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1440.0,
                        75.0,
                        100.0,
                        20.0
                    ],
                    "text": "seek measure",
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
                    "id": "obj-11",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        180.0,
                        120.0,
                        80.5,
                        22.0
                    ],
                    "text": "trigger b"
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
                        300.0,
                        375.0,
                        44.0,
                        22.0
                    ],
                    "text": "stop"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-13",
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
                        510.0,
                        165.0,
                        191.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "embed": 0,
                        "precision": 6
                    },
                    "text": "coll psycography_measures"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-14",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        465.0,
                        210.0,
                        116.0,
                        22.0
                    ],
                    "text": "unpack 0 0 0"
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
                        315.0,
                        255.0,
                        58.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-16",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        285.0,
                        420.0,
                        108.0,
                        22.0
                    ],
                    "text": "count~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-17",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        300.0,
                        465.0,
                        100.0,
                        22.0
                    ],
                    "text": "send~ master"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-18",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1440.0,
                        135.0,
                        275.0,
                        20.0
                    ],
                    "text": "MASTER SAMPLE CLOCK  ->  send~ master",
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
                    "id": "obj-19",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        405.0,
                        465.0,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-20",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        420.0,
                        510.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger f f"
                }
            },
            {
                "box": {
                    "id": "obj-21",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        285.0,
                        555.0,
                        50.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1440.0,
                        180.0,
                        58.0,
                        20.0
                    ],
                    "text": "sample",
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
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        870.0,
                        555.0,
                        177.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "filename": "transport_barbeat.js",
                        "parameter_enable": 0
                    },
                    "text": "js transport_barbeat.js"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "a",
                        "a"
                    ],
                    "patching_rect": [
                        915.0,
                        585.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger a a"
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
                        960.0,
                        645.0,
                        97.0,
                        22.0
                    ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-26",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        945.0,
                        690.0,
                        107.0,
                        20.0
                    ],
                    "text": "a",
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
                        570.0,
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
                    "id": "obj-32",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        615.0,
                        75.0,
                        121.0,
                        22.0
                    ],
                    "text": "trigger b b b b"
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
                        810.0,
                        120.0,
                        219.0,
                        22.0
                    ],
                    "text": "read psycography_measures.txt"
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
                        1050.0,
                        120.0,
                        198.0,
                        22.0
                    ],
                    "text": "read psycography_beats.txt"
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
                        1260.0,
                        120.0,
                        51.0,
                        22.0
                    ],
                    "text": "clear"
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
                        "bang"
                    ],
                    "patching_rect": [
                        1320.0,
                        120.0,
                        79.0,
                        22.0
                    ],
                    "text": "delay 300"
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
                        1365.0,
                        165.0,
                        44.0,
                        22.0
                    ],
                    "text": "dump"
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
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1185.0,
                        210.0,
                        170.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "embed": 0,
                        "precision": 6
                    },
                    "text": "coll psycography_beats"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1140.0,
                        255.0,
                        97.0,
                        22.0
                    ],
                    "text": "prepend add"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-40",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1440.0,
                        225.0,
                        352.0,
                        20.0
                    ],
                    "text": "data loader: measures coll + bar:beat grid -> js",
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
                    "id": "obj-41",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        585.0,
                        120.0,
                        212.0,
                        22.0
                    ],
                    "text": "route endstop endstopmeasure"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-42",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        435.0,
                        30.0,
                        121.0,
                        22.0
                    ],
                    "text": "receive~ master"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-43",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        510.0,
                        255.0,
                        114.0,
                        22.0
                    ],
                    "text": ">=~ 1000000000"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-44",
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
                        720.0,
                        165.0,
                        191.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "embed": 0,
                        "precision": 6
                    },
                    "text": "coll psycography_measures"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-45",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        675.0,
                        210.0,
                        116.0,
                        22.0
                    ],
                    "text": "unpack 0 0 0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-46",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        540.0,
                        285.0,
                        51.0,
                        22.0
                    ],
                    "text": "edge~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-47",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        510.0,
                        330.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger b b"
                }
            },
            {
                "box": {
                    "comment": "section ended (auto-stop fired)",
                    "id": "obj-48",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        585.0,
                        375.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-49",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1440.0,
                        285.0,
                        401.0,
                        20.0
                    ],
                    "text": "auto-stop: master >= section-end sample -> stop + ended",
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
                    "id": "obj-50",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1430.0,
                        8.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.1.2",
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
                        54.5,
                        78.0,
                        96.0,
                        78.0,
                        96.0,
                        42.0,
                        119.5,
                        42.0
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
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        54.5,
                        396.0,
                        27.0,
                        396.0,
                        27.0,
                        432.0,
                        54.5,
                        432.0
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
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        159.5,
                        396.0,
                        27.0,
                        396.0,
                        27.0,
                        432.0,
                        54.5,
                        432.0
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
                    "midpoints": [
                        414.5,
                        249.0,
                        414.5,
                        249.0
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
                        414.5,
                        336.0,
                        329.5,
                        336.0
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
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        329.5,
                        396.0,
                        27.0,
                        396.0,
                        27.0,
                        432.0,
                        54.5,
                        432.0
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
                        54.5,
                        459.0,
                        54.5,
                        459.0
                    ],
                    "order": 2,
                    "source": [
                        "obj-16",
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
                        54.5,
                        468.0,
                        285.0,
                        468.0,
                        285.0,
                        447.0,
                        309.5,
                        447.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-16",
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
                        54.5,
                        480.0,
                        166.5,
                        480.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-16",
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
                        474.0,
                        309.5,
                        474.0
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
                        "obj-21",
                        0
                    ],
                    "midpoints": [
                        383.5,
                        573.0,
                        297.0,
                        573.0,
                        297.0,
                        537.0,
                        309.5,
                        537.0
                    ],
                    "source": [
                        "obj-20",
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
                        309.5,
                        519.0,
                        285.0,
                        519.0,
                        285.0,
                        573.0,
                        456.0,
                        573.0,
                        456.0,
                        525.0,
                        479.5,
                        525.0
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
                        "obj-2",
                        0
                    ],
                    "midpoints": [
                        309.5,
                        612.0,
                        564.5,
                        612.0
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
                        479.5,
                        657.0,
                        474.5,
                        657.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        699.0,
                        474.5,
                        699.0
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
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        474.5,
                        690.0,
                        660.0,
                        690.0,
                        660.0,
                        612.0,
                        684.5,
                        612.0
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
                    "midpoints": [
                        474.5,
                        729.0,
                        450.0,
                        729.0,
                        450.0,
                        657.0,
                        479.5,
                        657.0
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
                        "obj-32",
                        0
                    ],
                    "midpoints": [
                        789.5,
                        84.0,
                        789.5,
                        84.0
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
                        891.5,
                        162.0,
                        569.5,
                        162.0
                    ],
                    "source": [
                        "obj-32",
                        3
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
                        857.5,
                        162.0,
                        789.5,
                        162.0
                    ],
                    "source": [
                        "obj-32",
                        2
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
                        823.5,
                        162.0,
                        1019.5,
                        162.0
                    ],
                    "source": [
                        "obj-32",
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
                        789.5,
                        138.0,
                        1065.0,
                        138.0,
                        1065.0,
                        117.0,
                        1089.5,
                        117.0
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
                        569.5,
                        210.0,
                        414.5,
                        210.0
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        789.5,
                        225.0,
                        909.5,
                        225.0
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        1019.5,
                        225.0,
                        606.0,
                        225.0,
                        606.0,
                        285.0,
                        531.0,
                        285.0,
                        531.0,
                        516.0,
                        479.5,
                        516.0
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
                        1089.5,
                        144.0,
                        1089.5,
                        144.0
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        1089.5,
                        225.0,
                        909.5,
                        225.0
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
                        909.5,
                        264.0,
                        909.5,
                        264.0
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        909.5,
                        324.0,
                        822.0,
                        324.0,
                        822.0,
                        285.0,
                        531.0,
                        285.0,
                        531.0,
                        516.0,
                        479.5,
                        516.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        119.5,
                        150.0,
                        30.0,
                        150.0,
                        30.0,
                        225.0,
                        54.5,
                        225.0
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        181.75,
                        180.0,
                        147.0,
                        180.0,
                        147.0,
                        225.0,
                        159.5,
                        225.0
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
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        306.25,
                        135.0,
                        396.0,
                        135.0,
                        396.0,
                        210.0,
                        414.5,
                        210.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        244.0,
                        180.0,
                        270.0,
                        180.0,
                        270.0,
                        336.0,
                        329.5,
                        336.0
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
                        "obj-41",
                        0
                    ],
                    "midpoints": [
                        368.5,
                        135.0,
                        546.0,
                        135.0,
                        546.0,
                        210.0,
                        609.5,
                        210.0
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
                        "obj-43",
                        1
                    ],
                    "midpoints": [
                        609.5,
                        324.0,
                        585.0,
                        324.0,
                        585.0,
                        318.0,
                        540.0,
                        318.0,
                        540.0,
                        405.0,
                        659.5,
                        405.0
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
                        706.0,
                        324.0,
                        585.0,
                        324.0,
                        585.0,
                        318.0,
                        540.0,
                        318.0,
                        540.0,
                        393.0,
                        705.0,
                        393.0,
                        705.0,
                        357.0,
                        729.5,
                        357.0
                    ],
                    "source": [
                        "obj-41",
                        1
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
                        564.5,
                        384.0,
                        564.5,
                        384.0
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
                        "obj-46",
                        0
                    ],
                    "midpoints": [
                        564.5,
                        444.0,
                        564.5,
                        444.0
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
                        729.5,
                        384.0,
                        731.5,
                        384.0
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
                        "obj-43",
                        1
                    ],
                    "midpoints": [
                        731.5,
                        444.0,
                        681.0,
                        444.0,
                        681.0,
                        417.0,
                        659.5,
                        417.0
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
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        564.5,
                        516.0,
                        456.0,
                        516.0,
                        456.0,
                        567.0,
                        564.5,
                        567.0
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        564.5,
                        594.0,
                        411.0,
                        594.0,
                        411.0,
                        318.0,
                        204.0,
                        318.0,
                        204.0,
                        225.0,
                        159.5,
                        225.0
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
                        "obj-48",
                        0
                    ],
                    "midpoints": [
                        638.5,
                        594.0,
                        774.5,
                        594.0
                    ],
                    "source": [
                        "obj-47",
                        1
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
                        54.5,
                        186.0,
                        54.5,
                        186.0
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        159.5,
                        216.0,
                        159.5,
                        216.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        294.5,
                        336.0,
                        329.5,
                        336.0
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
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        414.5,
                        189.0,
                        414.5,
                        189.0
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