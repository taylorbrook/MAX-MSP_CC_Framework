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
            87.0,
            1660.0,
            510.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "id": "obj-228",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5058.0,
                        281.5,
                        50.0,
                        22.0
                    ],
                    "text": "72"
                }
            },
            {
                "box": {
                    "id": "obj-227",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5116.0,
                        281.5,
                        50.0,
                        22.0
                    ],
                    "text": "0"
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
                        5385.0,
                        30.0,
                        240.0,
                        20.0
                    ],
                    "text": "MINITAUR — Moog Bass Synthesizer"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            494.0,
                            227.0,
                            873.0,
                            800.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-172",
                                    "maxclass": "kslider",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "parameter_enable": 0,
                                    "patching_rect": [
                                        405.0,
                                        50.0,
                                        336.0,
                                        53.0
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
                                        30.0,
                                        20.0,
                                        219.0,
                                        20.0
                                    ],
                                    "text": "--- NOTE INPUT & PRIORITY ---"
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
                                        50.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "notein"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        90.0,
                                        62.5,
                                        22.0
                                    ],
                                    "text": "stripnote"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        120.0,
                                        66.0,
                                        22.0
                                    ],
                                    "text": "clip 0 72"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        150.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send mt-note"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-6",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        120.0,
                                        150.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send mt-vel"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        120.0,
                                        120.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "> 0"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        120.0,
                                        180.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send mt-gate"
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
                                        30.0,
                                        180.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "mtof"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        210.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send mt-freq"
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
                                        250.0,
                                        20.0,
                                        142.0,
                                        20.0
                                    ],
                                    "text": "--- PITCH BEND ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        250.0,
                                        50.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "bendin"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        250.0,
                                        80.0,
                                        111.0,
                                        35.0
                                    ],
                                    "text": "scale 0 16383 -1. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        250.0,
                                        110.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send mt-bend"
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
                                        250.0,
                                        140.0,
                                        205.0,
                                        20.0
                                    ],
                                    "text": "--- MOD WHEEL (CC 1/33) ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-16",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        250.0,
                                        170.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        170.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 33"
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
                                        250.0,
                                        200.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
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
                                        "int"
                                    ],
                                    "patching_rect": [
                                        310.0,
                                        230.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-20",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        310.0,
                                        260.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-21",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        310.0,
                                        290.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-mod-wheel"
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
                                        30.0,
                                        260.0,
                                        212.0,
                                        20.0
                                    ],
                                    "text": "--- 14-BIT CC PARAMETERS ---"
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
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        290.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 3"
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
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        290.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 35"
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
                                        30.0,
                                        320.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-26",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        90.0,
                                        350.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-27",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        90.0,
                                        380.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-28",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        90.0,
                                        410.0,
                                        143.0,
                                        22.0
                                    ],
                                    "text": "send mt-cc-lfo-rate"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-29",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        290.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 7"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-30",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        290.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 39"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-31",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        320.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-32",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        350.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-33",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        380.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-34",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        270.0,
                                        410.0,
                                        143.0,
                                        22.0
                                    ],
                                    "text": "send mt-cc-volume"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-35",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        390.0,
                                        290.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 12"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-36",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        290.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 44"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-37",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        390.0,
                                        320.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-38",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        350.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-39",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        380.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-40",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        450.0,
                                        410.0,
                                        143.0,
                                        22.0
                                    ],
                                    "text": "send mt-cc-lfo-vcf"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-41",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        290.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 13"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-42",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        690.0,
                                        290.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 45"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-43",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        320.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-44",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        630.0,
                                        350.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-45",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        630.0,
                                        380.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-46",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        630.0,
                                        410.0,
                                        143.0,
                                        22.0
                                    ],
                                    "text": "send mt-cc-lfo-vco"
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
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        750.0,
                                        290.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 15"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-48",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        870.0,
                                        290.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 47"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-49",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        750.0,
                                        320.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-50",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        350.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-51",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        380.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-52",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        810.0,
                                        410.0,
                                        143.0,
                                        22.0
                                    ],
                                    "text": "send mt-cc-vco1-lvl"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-53",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        290.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 16"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-54",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        1050.0,
                                        290.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 48"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-55",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        320.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
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
                                        "int"
                                    ],
                                    "patching_rect": [
                                        990.0,
                                        350.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-57",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        990.0,
                                        380.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-58",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        990.0,
                                        410.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-vco2-lvl"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-59",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        450.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 17"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-60",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        450.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 49"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-61",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        480.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-62",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        90.0,
                                        510.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-63",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        90.0,
                                        540.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-64",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        90.0,
                                        570.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-vco2-freq"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-65",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        450.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 19"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-66",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        450.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 51"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-67",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        480.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-68",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        510.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-69",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        540.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-70",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        270.0,
                                        570.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-cutoff"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-71",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        390.0,
                                        450.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 21"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-72",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        450.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 53"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-73",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        390.0,
                                        480.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-74",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        510.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-75",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        540.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-76",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        450.0,
                                        570.0,
                                        98.0,
                                        35.0
                                    ],
                                    "text": "send mt-cc-resonance"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-77",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        450.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 22"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-78",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        690.0,
                                        450.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 50"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-79",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        480.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
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
                                        "int"
                                    ],
                                    "patching_rect": [
                                        630.0,
                                        510.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-81",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        630.0,
                                        540.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-82",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        630.0,
                                        570.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-filt-eg-amt"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-83",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        750.0,
                                        450.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 23"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-84",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        870.0,
                                        450.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 55"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-85",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        750.0,
                                        480.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-86",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        510.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-87",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        540.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-88",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        810.0,
                                        570.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-filt-att"
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
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        450.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 24"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-90",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        1050.0,
                                        450.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 56"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-91",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        480.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-92",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        990.0,
                                        510.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-93",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        990.0,
                                        540.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-94",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        990.0,
                                        570.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-filt-dec"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-95",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        610.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 25"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-96",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        610.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 57"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-97",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        640.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-98",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        90.0,
                                        670.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-99",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        90.0,
                                        700.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-100",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        90.0,
                                        730.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-filt-sus"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-101",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        610.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 27"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-102",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        610.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 59"
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
                                        210.0,
                                        640.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-104",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        670.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-105",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        700.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-106",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        270.0,
                                        730.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-ext-lvl"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-107",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        390.0,
                                        610.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 28"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-108",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        610.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 60"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-109",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        390.0,
                                        640.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-110",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        670.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-111",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        700.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-112",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        450.0,
                                        730.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-amp-att"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-113",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        610.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 29"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-114",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        690.0,
                                        610.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 61"
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
                                        570.0,
                                        640.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-116",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        630.0,
                                        670.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-117",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        630.0,
                                        700.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-118",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        630.0,
                                        730.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-amp-dec"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-119",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        750.0,
                                        610.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-120",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        870.0,
                                        610.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 62"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-121",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        750.0,
                                        640.0,
                                        92.0,
                                        22.0
                                    ],
                                    "text": "expr $i1 * 128"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-122",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        670.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-123",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        700.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 16383 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-124",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        810.0,
                                        730.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-amp-sus"
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
                                        30.0,
                                        600.0,
                                        233.0,
                                        20.0
                                    ],
                                    "text": "--- 7-BIT SWITCHES & PARAMS ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-126",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        630.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 5"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-127",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        660.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-128",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        690.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-glide-rate"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-129",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        630.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 20"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-130",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        660.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-131",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        180.0,
                                        690.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-kb-track"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-132",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        700.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 65"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-133",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        730.0,
                                        32.5,
                                        35.0
                                    ],
                                    "text": ">= 64"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-134",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        760.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-glide-sw"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-135",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        190.0,
                                        700.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 70"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-136",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        190.0,
                                        730.0,
                                        32.5,
                                        35.0
                                    ],
                                    "text": ">= 64"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-137",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        190.0,
                                        760.0,
                                        97.5,
                                        49.0
                                    ],
                                    "text": "send mt-cc-vco1-wave"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-138",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        700.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 71"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-139",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        730.0,
                                        32.5,
                                        35.0
                                    ],
                                    "text": ">= 64"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-140",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        350.0,
                                        760.0,
                                        97.5,
                                        49.0
                                    ],
                                    "text": "send mt-cc-vco2-wave"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-141",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        700.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 72"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-142",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        730.0,
                                        32.5,
                                        35.0
                                    ],
                                    "text": ">= 64"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-143",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        510.0,
                                        760.0,
                                        97.5,
                                        49.0
                                    ],
                                    "text": "send mt-cc-release-sw"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-144",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        670.0,
                                        700.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 73"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-145",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        670.0,
                                        730.0,
                                        32.5,
                                        35.0
                                    ],
                                    "text": ">= 64"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-146",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        670.0,
                                        760.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-legato"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-147",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        800.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 80"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-148",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        830.0,
                                        32.5,
                                        35.0
                                    ],
                                    "text": ">= 64"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-149",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        860.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-hard-sync"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-150",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        190.0,
                                        800.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 81"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-151",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        190.0,
                                        830.0,
                                        32.5,
                                        35.0
                                    ],
                                    "text": ">= 64"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-152",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        190.0,
                                        860.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-note-sync"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-153",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        800.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 82"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-154",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        830.0,
                                        32.5,
                                        35.0
                                    ],
                                    "text": ">= 64"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-155",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        350.0,
                                        860.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-lfo-keytrig"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-156",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        800.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 112"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-157",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        830.0,
                                        32.5,
                                        35.0
                                    ],
                                    "text": ">= 64"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-158",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        510.0,
                                        860.0,
                                        97.5,
                                        49.0
                                    ],
                                    "text": "send mt-cc-lfo-vco2only"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-159",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        630.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 85"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-160",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        660.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0 5"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-161",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        330.0,
                                        690.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-lfo-wave"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-162",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        630.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 92"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-163",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        660.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0 2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-164",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        480.0,
                                        690.0,
                                        97.5,
                                        35.0
                                    ],
                                    "text": "send mt-cc-glide-type"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-165",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        630.0,
                                        630.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 89"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-166",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        630.0,
                                        660.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-167",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        630.0,
                                        690.0,
                                        97.5,
                                        49.0
                                    ],
                                    "text": "send mt-cc-filt-vel-sens"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-168",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        780.0,
                                        630.0,
                                        59.5,
                                        22.0
                                    ],
                                    "text": "ctlin 90"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-169",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        780.0,
                                        660.0,
                                        111.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-170",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        780.0,
                                        690.0,
                                        97.5,
                                        49.0
                                    ],
                                    "text": "send mt-cc-amp-vel-sens"
                                }
                            },
                            {
                                "box": {
                                    "comment": "pcontrol inlet",
                                    "id": "obj-171",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1150.0,
                                        20.0,
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
                                        "obj-103",
                                        0
                                    ],
                                    "midpoints": [
                                        219.5,
                                        633.0,
                                        219.5,
                                        633.0
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
                                        "obj-104",
                                        1
                                    ],
                                    "midpoints": [
                                        339.5,
                                        633.0,
                                        312.0,
                                        633.0,
                                        312.0,
                                        666.0,
                                        293.0,
                                        666.0
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
                                        219.5,
                                        684.0,
                                        276.0,
                                        684.0,
                                        276.0,
                                        666.0,
                                        279.5,
                                        666.0
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
                                        "obj-105",
                                        0
                                    ],
                                    "midpoints": [
                                        279.5,
                                        693.0,
                                        279.5,
                                        693.0
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
                                        "obj-106",
                                        0
                                    ],
                                    "midpoints": [
                                        279.5,
                                        723.0,
                                        279.5,
                                        723.0
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
                                        "obj-109",
                                        0
                                    ],
                                    "midpoints": [
                                        399.5,
                                        633.0,
                                        399.5,
                                        633.0
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
                                        "obj-110",
                                        1
                                    ],
                                    "midpoints": [
                                        519.5,
                                        657.0,
                                        477.0,
                                        657.0,
                                        477.0,
                                        663.0,
                                        473.0,
                                        663.0
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
                                        "obj-110",
                                        0
                                    ],
                                    "midpoints": [
                                        399.5,
                                        684.0,
                                        447.0,
                                        684.0,
                                        447.0,
                                        666.0,
                                        459.5,
                                        666.0
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
                                        "obj-111",
                                        0
                                    ],
                                    "midpoints": [
                                        459.5,
                                        693.0,
                                        459.5,
                                        693.0
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
                                        "obj-112",
                                        0
                                    ],
                                    "midpoints": [
                                        459.5,
                                        723.0,
                                        459.5,
                                        723.0
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
                                        "obj-115",
                                        0
                                    ],
                                    "midpoints": [
                                        579.5,
                                        633.0,
                                        579.5,
                                        633.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        699.5,
                                        657.0,
                                        653.0,
                                        657.0
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
                                        "obj-116",
                                        0
                                    ],
                                    "midpoints": [
                                        579.5,
                                        663.0,
                                        639.5,
                                        663.0
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
                                        639.5,
                                        693.0,
                                        639.5,
                                        693.0
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
                                        0
                                    ],
                                    "midpoints": [
                                        639.5,
                                        723.0,
                                        639.5,
                                        723.0
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
                                        "obj-121",
                                        0
                                    ],
                                    "midpoints": [
                                        759.5,
                                        633.0,
                                        759.5,
                                        633.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        259.5,
                                        75.0,
                                        259.5,
                                        75.0
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
                                        "obj-122",
                                        1
                                    ],
                                    "midpoints": [
                                        879.5,
                                        645.0,
                                        843.0,
                                        645.0,
                                        843.0,
                                        663.0,
                                        833.0,
                                        663.0
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
                                        759.5,
                                        684.0,
                                        816.0,
                                        684.0,
                                        816.0,
                                        666.0,
                                        819.5,
                                        666.0
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
                                        819.5,
                                        693.0,
                                        819.5,
                                        693.0
                                    ],
                                    "source": [
                                        "obj-122",
                                        0
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
                                        819.5,
                                        723.0,
                                        819.5,
                                        723.0
                                    ],
                                    "source": [
                                        "obj-123",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-127",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        654.0,
                                        39.5,
                                        654.0
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
                                        "obj-128",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        684.0,
                                        39.5,
                                        684.0
                                    ],
                                    "source": [
                                        "obj-127",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-130",
                                        0
                                    ],
                                    "midpoints": [
                                        189.5,
                                        654.0,
                                        189.5,
                                        654.0
                                    ],
                                    "source": [
                                        "obj-129",
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
                                        259.5,
                                        117.0,
                                        259.5,
                                        117.0
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
                                        "obj-131",
                                        0
                                    ],
                                    "midpoints": [
                                        189.5,
                                        684.0,
                                        189.5,
                                        684.0
                                    ],
                                    "source": [
                                        "obj-130",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-133",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        723.0,
                                        39.5,
                                        723.0
                                    ],
                                    "source": [
                                        "obj-132",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-134",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        768.0,
                                        39.5,
                                        768.0
                                    ],
                                    "source": [
                                        "obj-133",
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
                                        199.5,
                                        723.0,
                                        199.5,
                                        723.0
                                    ],
                                    "source": [
                                        "obj-135",
                                        0
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
                                        199.5,
                                        768.0,
                                        199.5,
                                        768.0
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
                                        "obj-139",
                                        0
                                    ],
                                    "midpoints": [
                                        359.5,
                                        723.0,
                                        359.5,
                                        723.0
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
                                        "obj-140",
                                        0
                                    ],
                                    "midpoints": [
                                        359.5,
                                        768.0,
                                        359.5,
                                        768.0
                                    ],
                                    "source": [
                                        "obj-139",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-142",
                                        0
                                    ],
                                    "midpoints": [
                                        519.5,
                                        723.0,
                                        519.5,
                                        723.0
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
                                        "obj-143",
                                        0
                                    ],
                                    "midpoints": [
                                        519.5,
                                        768.0,
                                        519.5,
                                        768.0
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
                                        "obj-145",
                                        0
                                    ],
                                    "midpoints": [
                                        679.5,
                                        723.0,
                                        679.5,
                                        723.0
                                    ],
                                    "source": [
                                        "obj-144",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-146",
                                        0
                                    ],
                                    "midpoints": [
                                        679.5,
                                        768.0,
                                        679.5,
                                        768.0
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
                                        "obj-148",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        825.0,
                                        39.5,
                                        825.0
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
                                        "obj-149",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        867.0,
                                        39.5,
                                        867.0
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
                                        "obj-151",
                                        0
                                    ],
                                    "midpoints": [
                                        199.5,
                                        825.0,
                                        199.5,
                                        825.0
                                    ],
                                    "source": [
                                        "obj-150",
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
                                        199.5,
                                        867.0,
                                        199.5,
                                        867.0
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
                                        "obj-154",
                                        0
                                    ],
                                    "midpoints": [
                                        359.5,
                                        825.0,
                                        359.5,
                                        825.0
                                    ],
                                    "source": [
                                        "obj-153",
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
                                        359.5,
                                        867.0,
                                        359.5,
                                        867.0
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
                                        "obj-157",
                                        0
                                    ],
                                    "midpoints": [
                                        519.5,
                                        825.0,
                                        519.5,
                                        825.0
                                    ],
                                    "source": [
                                        "obj-156",
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
                                        519.5,
                                        867.0,
                                        519.5,
                                        867.0
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
                                        "obj-160",
                                        0
                                    ],
                                    "midpoints": [
                                        339.5,
                                        654.0,
                                        339.5,
                                        654.0
                                    ],
                                    "source": [
                                        "obj-159",
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
                                        259.5,
                                        195.0,
                                        259.5,
                                        195.0
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
                                        "obj-161",
                                        0
                                    ],
                                    "midpoints": [
                                        339.5,
                                        684.0,
                                        339.5,
                                        684.0
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
                                        "obj-163",
                                        0
                                    ],
                                    "midpoints": [
                                        489.5,
                                        654.0,
                                        489.5,
                                        654.0
                                    ],
                                    "source": [
                                        "obj-162",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-164",
                                        0
                                    ],
                                    "midpoints": [
                                        489.5,
                                        684.0,
                                        489.5,
                                        684.0
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
                                        "obj-166",
                                        0
                                    ],
                                    "midpoints": [
                                        639.5,
                                        654.0,
                                        639.5,
                                        654.0
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
                                        "obj-167",
                                        0
                                    ],
                                    "midpoints": [
                                        639.5,
                                        684.0,
                                        639.5,
                                        684.0
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
                                        "obj-169",
                                        0
                                    ],
                                    "midpoints": [
                                        789.5,
                                        654.0,
                                        789.5,
                                        654.0
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
                                        "obj-170",
                                        0
                                    ],
                                    "midpoints": [
                                        789.5,
                                        684.0,
                                        789.5,
                                        684.0
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
                                        "obj-19",
                                        1
                                    ],
                                    "midpoints": [
                                        379.5,
                                        225.0,
                                        333.0,
                                        225.0
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
                                        "obj-3",
                                        1
                                    ],
                                    "midpoints": [
                                        731.5,
                                        114.0,
                                        372.0,
                                        114.0,
                                        372.0,
                                        66.0,
                                        309.0,
                                        66.0,
                                        309.0,
                                        72.0,
                                        83.0,
                                        72.0
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
                                        "obj-3",
                                        0
                                    ],
                                    "midpoints": [
                                        414.5,
                                        105.0,
                                        372.0,
                                        105.0,
                                        372.0,
                                        66.0,
                                        309.0,
                                        66.0,
                                        309.0,
                                        72.0,
                                        39.5,
                                        72.0
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
                                        "obj-19",
                                        0
                                    ],
                                    "midpoints": [
                                        259.5,
                                        225.0,
                                        319.5,
                                        225.0
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
                                        "obj-20",
                                        0
                                    ],
                                    "midpoints": [
                                        319.5,
                                        255.0,
                                        319.5,
                                        255.0
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
                                        "obj-3",
                                        1
                                    ],
                                    "midpoints": [
                                        55.5,
                                        87.0,
                                        83.0,
                                        87.0
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
                                    "midpoints": [
                                        39.5,
                                        75.0,
                                        39.5,
                                        75.0
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
                                        "obj-21",
                                        0
                                    ],
                                    "midpoints": [
                                        319.5,
                                        285.0,
                                        319.5,
                                        285.0
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
                                        "obj-25",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        315.0,
                                        39.5,
                                        315.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        159.5,
                                        345.0,
                                        113.0,
                                        345.0
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
                                        39.5,
                                        345.0,
                                        99.5,
                                        345.0
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
                                        "obj-27",
                                        0
                                    ],
                                    "midpoints": [
                                        99.5,
                                        375.0,
                                        99.5,
                                        375.0
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
                                        "obj-28",
                                        0
                                    ],
                                    "midpoints": [
                                        99.5,
                                        405.0,
                                        99.5,
                                        405.0
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
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        219.5,
                                        315.0,
                                        219.5,
                                        315.0
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
                                    "midpoints": [
                                        39.5,
                                        114.0,
                                        39.5,
                                        114.0
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
                                        83.0,
                                        114.0,
                                        117.0,
                                        114.0,
                                        117.0,
                                        144.0,
                                        129.5,
                                        144.0
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-3",
                                        1
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
                                        83.0,
                                        114.0,
                                        129.5,
                                        114.0
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-3",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-32",
                                        1
                                    ],
                                    "midpoints": [
                                        339.5,
                                        345.0,
                                        293.0,
                                        345.0
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
                                        "obj-32",
                                        0
                                    ],
                                    "midpoints": [
                                        219.5,
                                        345.0,
                                        279.5,
                                        345.0
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
                                        279.5,
                                        375.0,
                                        279.5,
                                        375.0
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
                                        "obj-34",
                                        0
                                    ],
                                    "midpoints": [
                                        279.5,
                                        405.0,
                                        279.5,
                                        405.0
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
                                        "obj-37",
                                        0
                                    ],
                                    "midpoints": [
                                        399.5,
                                        315.0,
                                        399.5,
                                        315.0
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
                                        "obj-38",
                                        1
                                    ],
                                    "midpoints": [
                                        519.5,
                                        345.0,
                                        473.0,
                                        345.0
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
                                        399.5,
                                        345.0,
                                        459.5,
                                        345.0
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
                                        459.5,
                                        375.0,
                                        459.5,
                                        375.0
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
                                    "midpoints": [
                                        459.5,
                                        405.0,
                                        459.5,
                                        405.0
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
                                    "midpoints": [
                                        39.5,
                                        144.0,
                                        39.5,
                                        144.0
                                    ],
                                    "order": 1,
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
                                        39.5,
                                        144.0,
                                        27.0,
                                        144.0,
                                        27.0,
                                        174.0,
                                        39.5,
                                        174.0
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-4",
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
                                        579.5,
                                        315.0,
                                        579.5,
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
                                        1
                                    ],
                                    "midpoints": [
                                        699.5,
                                        345.0,
                                        653.0,
                                        345.0
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
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        579.5,
                                        345.0,
                                        639.5,
                                        345.0
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
                                        639.5,
                                        375.0,
                                        639.5,
                                        375.0
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
                                        "obj-46",
                                        0
                                    ],
                                    "midpoints": [
                                        639.5,
                                        405.0,
                                        639.5,
                                        405.0
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
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        759.5,
                                        315.0,
                                        759.5,
                                        315.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        879.5,
                                        345.0,
                                        833.0,
                                        345.0
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
                                        "obj-50",
                                        0
                                    ],
                                    "midpoints": [
                                        759.5,
                                        345.0,
                                        819.5,
                                        345.0
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
                                        819.5,
                                        375.0,
                                        819.5,
                                        375.0
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
                                        "obj-52",
                                        0
                                    ],
                                    "midpoints": [
                                        819.5,
                                        405.0,
                                        819.5,
                                        405.0
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
                                        "obj-55",
                                        0
                                    ],
                                    "midpoints": [
                                        939.5,
                                        315.0,
                                        939.5,
                                        315.0
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
                                        1059.5,
                                        345.0,
                                        1013.0,
                                        345.0
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
                                        "obj-56",
                                        0
                                    ],
                                    "midpoints": [
                                        939.5,
                                        345.0,
                                        999.5,
                                        345.0
                                    ],
                                    "source": [
                                        "obj-55",
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
                                        999.5,
                                        375.0,
                                        999.5,
                                        375.0
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
                                        "obj-58",
                                        0
                                    ],
                                    "midpoints": [
                                        999.5,
                                        405.0,
                                        999.5,
                                        405.0
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
                                        "obj-61",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        474.0,
                                        39.5,
                                        474.0
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
                                        "obj-62",
                                        1
                                    ],
                                    "midpoints": [
                                        159.5,
                                        507.0,
                                        113.0,
                                        507.0
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
                                        "obj-62",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        504.0,
                                        99.5,
                                        504.0
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
                                        "obj-63",
                                        0
                                    ],
                                    "midpoints": [
                                        99.5,
                                        534.0,
                                        99.5,
                                        534.0
                                    ],
                                    "source": [
                                        "obj-62",
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
                                        99.5,
                                        564.0,
                                        99.5,
                                        564.0
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
                                        "obj-67",
                                        0
                                    ],
                                    "midpoints": [
                                        219.5,
                                        474.0,
                                        219.5,
                                        474.0
                                    ],
                                    "source": [
                                        "obj-65",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-68",
                                        1
                                    ],
                                    "midpoints": [
                                        339.5,
                                        507.0,
                                        293.0,
                                        507.0
                                    ],
                                    "source": [
                                        "obj-66",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-68",
                                        0
                                    ],
                                    "midpoints": [
                                        219.5,
                                        504.0,
                                        279.5,
                                        504.0
                                    ],
                                    "source": [
                                        "obj-67",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-69",
                                        0
                                    ],
                                    "midpoints": [
                                        279.5,
                                        534.0,
                                        279.5,
                                        534.0
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
                                        "obj-70",
                                        0
                                    ],
                                    "midpoints": [
                                        279.5,
                                        564.0,
                                        279.5,
                                        564.0
                                    ],
                                    "source": [
                                        "obj-69",
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
                                        129.5,
                                        144.0,
                                        162.0,
                                        144.0,
                                        162.0,
                                        135.0,
                                        228.0,
                                        135.0,
                                        228.0,
                                        177.0,
                                        129.5,
                                        177.0
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
                                        "obj-73",
                                        0
                                    ],
                                    "midpoints": [
                                        399.5,
                                        474.0,
                                        399.5,
                                        474.0
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
                                        "obj-74",
                                        1
                                    ],
                                    "midpoints": [
                                        519.5,
                                        507.0,
                                        473.0,
                                        507.0
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
                                        "obj-74",
                                        0
                                    ],
                                    "midpoints": [
                                        399.5,
                                        504.0,
                                        459.5,
                                        504.0
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
                                        "obj-75",
                                        0
                                    ],
                                    "midpoints": [
                                        459.5,
                                        534.0,
                                        459.5,
                                        534.0
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
                                        "obj-76",
                                        0
                                    ],
                                    "midpoints": [
                                        459.5,
                                        564.0,
                                        459.5,
                                        564.0
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
                                        "obj-79",
                                        0
                                    ],
                                    "midpoints": [
                                        579.5,
                                        474.0,
                                        579.5,
                                        474.0
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
                                        "obj-80",
                                        1
                                    ],
                                    "midpoints": [
                                        699.5,
                                        507.0,
                                        653.0,
                                        507.0
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
                                        "obj-80",
                                        0
                                    ],
                                    "midpoints": [
                                        579.5,
                                        504.0,
                                        639.5,
                                        504.0
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
                                        639.5,
                                        534.0,
                                        639.5,
                                        534.0
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
                                        "obj-82",
                                        0
                                    ],
                                    "midpoints": [
                                        639.5,
                                        564.0,
                                        639.5,
                                        564.0
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
                                        "obj-85",
                                        0
                                    ],
                                    "midpoints": [
                                        759.5,
                                        474.0,
                                        759.5,
                                        474.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        879.5,
                                        507.0,
                                        833.0,
                                        507.0
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
                                        "obj-86",
                                        0
                                    ],
                                    "midpoints": [
                                        759.5,
                                        504.0,
                                        819.5,
                                        504.0
                                    ],
                                    "source": [
                                        "obj-85",
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
                                        819.5,
                                        534.0,
                                        819.5,
                                        534.0
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
                                        "obj-88",
                                        0
                                    ],
                                    "midpoints": [
                                        819.5,
                                        564.0,
                                        819.5,
                                        564.0
                                    ],
                                    "source": [
                                        "obj-87",
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
                                        939.5,
                                        474.0,
                                        939.5,
                                        474.0
                                    ],
                                    "source": [
                                        "obj-89",
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
                                        39.5,
                                        204.0,
                                        39.5,
                                        204.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        1059.5,
                                        507.0,
                                        1013.0,
                                        507.0
                                    ],
                                    "source": [
                                        "obj-90",
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
                                        939.5,
                                        504.0,
                                        999.5,
                                        504.0
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
                                        "obj-93",
                                        0
                                    ],
                                    "midpoints": [
                                        999.5,
                                        534.0,
                                        999.5,
                                        534.0
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
                                        "obj-94",
                                        0
                                    ],
                                    "midpoints": [
                                        999.5,
                                        564.0,
                                        999.5,
                                        564.0
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
                                        "obj-97",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        633.0,
                                        39.5,
                                        633.0
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
                                        "obj-98",
                                        1
                                    ],
                                    "midpoints": [
                                        159.5,
                                        645.0,
                                        123.0,
                                        645.0,
                                        123.0,
                                        663.0,
                                        113.0,
                                        663.0
                                    ],
                                    "source": [
                                        "obj-96",
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
                                        39.5,
                                        663.0,
                                        27.0,
                                        663.0,
                                        27.0,
                                        684.0,
                                        96.0,
                                        684.0,
                                        96.0,
                                        666.0,
                                        99.5,
                                        666.0
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
                                        "obj-99",
                                        0
                                    ],
                                    "midpoints": [
                                        99.5,
                                        693.0,
                                        99.5,
                                        693.0
                                    ],
                                    "source": [
                                        "obj-98",
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
                                        99.5,
                                        723.0,
                                        99.5,
                                        723.0
                                    ],
                                    "source": [
                                        "obj-99",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        3705.0,
                        150.0,
                        86.0,
                        22.0
                    ],
                    "text": "p midi-input"
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
                            134.0,
                            167.0,
                            900.0,
                            600.0
                        ],
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
                                        30.0,
                                        20.0,
                                        163.0,
                                        20.0
                                    ],
                                    "text": "--- VCO 1 & VCO 2 ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        50.0,
                                        94.0,
                                        49.0
                                    ],
                                    "text": "receive~ mt-glide-freq-sig"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        50.0,
                                        83.0,
                                        49.0
                                    ],
                                    "text": "receive mt-cc-fine-tune"
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
                                        200.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        100.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
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
                                        200.0,
                                        130.0,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~ 2."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        155.0,
                                        45.0,
                                        22.0
                                    ],
                                    "text": "-~ 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        180.0,
                                        50.5,
                                        22.0
                                    ],
                                    "text": "/~ 12."
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
                                                    "code": "\n// Convert semitones offset to frequency ratio\n// out1 = 2^(in1/12)\nout1 = pow(2, in1 / 12.0);\n",
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
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-2",
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
                                        200.0,
                                        210.0,
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
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        250.0,
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
                                    "id": "obj-11",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        400.0,
                                        50.0,
                                        83.0,
                                        49.0
                                    ],
                                    "text": "receive mt-cc-vco2-freq"
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
                                        400.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        400.0,
                                        100.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        400.0,
                                        130.0,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~ 24."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        400.0,
                                        155.0,
                                        45.0,
                                        22.0
                                    ],
                                    "text": "-~ 12."
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
                                                    "code": "\n// Convert semitones offset to frequency ratio\n// out1 = 2^(in1/12)\nout1 = pow(2, in1 / 12.0);\n",
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
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-2",
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
                                        400.0,
                                        185.0,
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
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        400.0,
                                        250.0,
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
                                    "id": "obj-18",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        280.0,
                                        107.0,
                                        20.0
                                    ],
                                    "text": "--- VCO 1 ---"
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        310.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "saw~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-20",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        310.0,
                                        62.5,
                                        22.0
                                    ],
                                    "text": "rect~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-21",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        340.0,
                                        162.5,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-vco1-wave"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-22",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        80.0,
                                        370.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        370.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+ 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-24",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        80.0,
                                        410.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ mt-vco1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-25",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        400.0,
                                        280.0,
                                        107.0,
                                        20.0
                                    ],
                                    "text": "--- VCO 2 ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-26",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        400.0,
                                        310.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "saw~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-27",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        310.0,
                                        62.5,
                                        22.0
                                    ],
                                    "text": "rect~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-28",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        400.0,
                                        340.0,
                                        165.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-vco2-wave"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-29",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        600.0,
                                        291.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-30",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        400.0,
                                        370.0,
                                        32.5,
                                        22.0
                                    ],
                                    "text": "+ 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-31",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        597.0,
                                        327.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ mt-vco2"
                                }
                            },
                            {
                                "box": {
                                    "comment": "pcontrol inlet",
                                    "id": "obj-32",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        600.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-33",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        380.0,
                                        125.0,
                                        22.0
                                    ],
                                    "text": "receive mt-bend"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-34",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        380.0,
                                        181.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-hard-sync"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-35",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        280.0,
                                        178.0,
                                        195.0,
                                        22.0
                                    ],
                                    "text": "receive~ mt-lfo-pitch-mod"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-36",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        540.0,
                                        380.0,
                                        202.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-lfo-vco2only"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-37",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        600.0,
                                        20.0,
                                        62.0,
                                        22.0
                                    ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-38",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "bang",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        600.0,
                                        45.0,
                                        80.5,
                                        22.0
                                    ],
                                    "text": "trigger b b"
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
                                        600.0,
                                        70.0,
                                        29.5,
                                        22.0
                                    ],
                                    "text": "1"
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
                                        650.0,
                                        70.0,
                                        29.5,
                                        22.0
                                    ],
                                    "text": "1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-41",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        278.0,
                                        29.0,
                                        22.0
                                    ],
                                    "text": "*~"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-42",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        280.0,
                                        205.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "*~ 2."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-43",
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
                                            0.0,
                                            0.0,
                                            600.0,
                                            450.0
                                        ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "id": "obj-1",
                                                    "maxclass": "newobj",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        50.0,
                                                        50.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "code": "\n// Convert octave offset to frequency ratio\nout1 = pow(2, in1);\n",
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
                                                        50.0,
                                                        100.0,
                                                        152.0,
                                                        22.0
                                                    ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-3",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        50.0,
                                                        150.0,
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
                                        "editing_bgcolor": [
                                            0.65,
                                            0.65,
                                            0.65,
                                            1.0
                                        ]
                                    },
                                    "patching_rect": [
                                        280.0,
                                        235.0,
                                        36.0,
                                        22.0
                                    ],
                                    "text": "gen~"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-41",
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
                                        "obj-16",
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
                                        "obj-17",
                                        1
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
                                        "obj-26",
                                        0
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-17",
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
                                    "order": 0,
                                    "source": [
                                        "obj-17",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-22",
                                        1
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
                                        "obj-10",
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
                                        "obj-22",
                                        2
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
                                        "obj-22",
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
                                        "obj-29",
                                        1
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
                                        "obj-29",
                                        2
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
                                    "source": [
                                        "obj-28",
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
                                        "obj-29",
                                        0
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
                                        "obj-42",
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
                                        "obj-38",
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
                                        "obj-39",
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
                                        "obj-40",
                                        0
                                    ],
                                    "source": [
                                        "obj-38",
                                        1
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
                                        "obj-29",
                                        0
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
                                        "obj-17",
                                        0
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-41",
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
                                    "order": 2,
                                    "source": [
                                        "obj-41",
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
                                    "order": 1,
                                    "source": [
                                        "obj-41",
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
                                    "source": [
                                        "obj-42",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-41",
                                        1
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
                                    "order": 1,
                                    "source": [
                                        "obj-7",
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
                                    "order": 0,
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
                                        1
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
                        3855.0,
                        150.0,
                        86.0,
                        22.0
                    ],
                    "text": "p oscillators"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            134.0,
                            167.0,
                            600.0,
                            400.0
                        ],
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
                                        30.0,
                                        20.0,
                                        107.0,
                                        20.0
                                    ],
                                    "text": "--- MIXER ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        50.0,
                                        94.0,
                                        35.0
                                    ],
                                    "text": "receive~ mt-vco1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        80.0,
                                        83.0,
                                        35.0
                                    ],
                                    "text": "receive mt-cc-vco1-lvl"
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
                                        30.0,
                                        105.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        130.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
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
                                        30.0,
                                        160.0,
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
                                    "id": "obj-7",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        50.0,
                                        94.0,
                                        35.0
                                    ],
                                    "text": "receive~ mt-vco2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        80.0,
                                        83.0,
                                        35.0
                                    ],
                                    "text": "receive mt-cc-vco2-lvl"
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
                                        200.0,
                                        105.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
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
                                        200.0,
                                        130.0,
                                        39.0,
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
                                        200.0,
                                        160.0,
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
                                    "id": "obj-12",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        50.0,
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
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        80.0,
                                        83.0,
                                        35.0
                                    ],
                                    "text": "receive mt-cc-ext-lvl"
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
                                        370.0,
                                        105.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        130.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
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
                                        370.0,
                                        160.0,
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
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        120.0,
                                        200.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-18",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        240.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~"
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        270.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "tanh~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-20",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        200.0,
                                        300.0,
                                        88.0,
                                        35.0
                                    ],
                                    "text": "send~ mt-mix-out"
                                }
                            },
                            {
                                "box": {
                                    "comment": "pcontrol inlet",
                                    "id": "obj-21",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        470.0,
                                        20.0,
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
                                        "obj-11",
                                        1
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
                                        "obj-17",
                                        1
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
                                        "obj-16",
                                        1
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
                                        1
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
                                        "obj-20",
                                        0
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
                                        "obj-6",
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
                                        1
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
                                        "obj-17",
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
                                        "obj-11",
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
                                        "obj-9",
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
                                        "obj-10",
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
                        3990.0,
                        150.0,
                        86.0,
                        22.0
                    ],
                    "text": "p mixer"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            50.0,
                            50.0,
                            500.0,
                            350.0
                        ],
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
                                        30.0,
                                        20.0,
                                        198.0,
                                        20.0
                                    ],
                                    "text": "--- GLIDE / PORTAMENTO ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        50.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive mt-freq"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        80.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "$1 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        105.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        50.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-glide-rate"
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
                                        150.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
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
                                        150.0,
                                        100.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        250.0,
                                        50.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-glide-type"
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
                                        250.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
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
                                        250.0,
                                        100.0,
                                        39.0,
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
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        50.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-glide-sw"
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
                                        350.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        100.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
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
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-4",
                                                    "maxclass": "newobj",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        290.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 4"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "code": "\n// Glide/Portamento with 3 types\n// in 1: target freq Hz, in 2: rate 0-1\n// in 3: type 0-2, in 4: enable\n\nHistory current_freq(0);\n\ntarget = in1;\nrate = in2;\nglide_type = in3;\nenable = in4;\n\nglide_ms = 1.0 + rate * 1999.0;\ncoeff = 1.0 / (glide_ms * 0.001 * samplerate);\n\ndiff = target - current_freq;\nsel = round(clamp(glide_type, 0, 2));\n\n// Linear constant rate\nhz_step = max(abs(diff) * coeff, 0.01);\nlin_rate = current_freq + clamp(diff, -hz_step, hz_step);\n\n// Linear constant time\nlin_time = current_freq + diff * coeff;\n\n// Exponential\nexpo = current_freq + diff * coeff * 4;\n\nglided = (sel == 0) ? lin_rate : (sel == 1) ? lin_time : expo;\n\ncurrent_freq = (enable < 0.5) ? target : glided;\n\nout1 = current_freq;\n",
                                                    "fontface": 0,
                                                    "fontname": "<Monospaced>",
                                                    "fontsize": 12.0,
                                                    "id": "obj-5",
                                                    "maxclass": "codebox",
                                                    "numinlets": 4,
                                                    "numoutlets": 1,
                                                    "outlettype": [
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
                                                    "id": "obj-6",
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
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-5",
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
                                                        "obj-5",
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
                                                        "obj-5",
                                                        2
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
                                                        3
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
                                        100.0,
                                        180.0,
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
                                    "id": "obj-15",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        100.0,
                                        240.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ mt-glide-freq-sig"
                                }
                            },
                            {
                                "box": {
                                    "comment": "pcontrol inlet",
                                    "id": "obj-16",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        20.0,
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
                                        "obj-14",
                                        2
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
                                        "obj-14",
                                        3
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
                                    "source": [
                                        "obj-3",
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
                                        "obj-14",
                                        1
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
                                        "obj-9",
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
                                        "obj-10",
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
                        4125.0,
                        150.0,
                        86.0,
                        22.0
                    ],
                    "text": "p glide"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            134.0,
                            167.0,
                            800.0,
                            500.0
                        ],
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
                                        30.0,
                                        20.0,
                                        177.0,
                                        20.0
                                    ],
                                    "text": "--- FILTER ENVELOPE ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        50.0,
                                        83.0,
                                        35.0
                                    ],
                                    "text": "receive mt-gate"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        80.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "$1 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        105.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        140.0,
                                        83.0,
                                        35.0
                                    ],
                                    "text": "receive mt-cc-filt-att"
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
                                        165.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
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
                                        30.0,
                                        190.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        220.0,
                                        42.0,
                                        49.0
                                    ],
                                    "text": "*~ 29999."
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        245.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~ 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        140.0,
                                        83.0,
                                        35.0
                                    ],
                                    "text": "receive mt-cc-filt-dec"
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
                                        150.0,
                                        165.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        190.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        220.0,
                                        42.0,
                                        49.0
                                    ],
                                    "text": "*~ 29999."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        245.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~ 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        140.0,
                                        83.0,
                                        35.0
                                    ],
                                    "text": "receive mt-cc-filt-sus"
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
                                        270.0,
                                        165.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        190.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-18",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        390.0,
                                        140.0,
                                        83.0,
                                        49.0
                                    ],
                                    "text": "receive mt-cc-release-sw"
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
                                        390.0,
                                        165.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-20",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        390.0,
                                        190.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-21",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        140.0,
                                        83.0,
                                        35.0
                                    ],
                                    "text": "receive mt-cc-legato"
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
                                        500.0,
                                        165.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        190.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-24",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
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
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-4",
                                                    "maxclass": "newobj",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        290.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 4"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-5",
                                                    "maxclass": "newobj",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        370.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 5"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-6",
                                                    "maxclass": "newobj",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        450.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 6"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "code": "\n// ADSR Envelope with shared Decay/Release\n// in 1: gate, in 2: attack ms, in 3: decay ms\n// in 4: sustain 0-1, in 5: release enable, in 6: retrigger mode\n\nHistory env(0);\nHistory stage(0);\nHistory prev_gate(0);\n\ngate = in1;\natt_ms = max(in2, 1);\ndec_ms = max(in3, 1);\nsus_level = clamp(in4, 0, 1);\nrel_enable = in5;\nretrig_mode = in6;\n\ngate_on = (gate > 0.5) * (prev_gate <= 0.5);\ngate_off = (gate <= 0.5) * (prev_gate > 0.5);\nprev_gate = gate;\n\n// Note on: reset env if not legato, go to attack\nenv = (gate_on * (retrig_mode < 0.5)) ? 0 : env;\nstage = gate_on ? 1 : stage;\n\n// Note off: release or instant off\nstage = (gate_off * (rel_enable > 0.5)) ? 4 : (gate_off * (rel_enable <= 0.5)) ? 0 : stage;\nenv = (gate_off * (rel_enable <= 0.5)) ? 0 : env;\n\natt_coeff = 1.0 / (att_ms * 0.001 * samplerate);\ndec_coeff = 1.0 / (dec_ms * 0.001 * samplerate);\ndec_smooth = 1.0 / (dec_ms * 0.001 * samplerate + 1);\n\n// Attack\natt_env = env + att_coeff;\natt_done = att_env >= 1.0;\natt_env = att_done ? 1.0 : att_env;\n\n// Decay\ndec_env = env - (env - sus_level) * dec_smooth;\ndec_done = dec_env <= sus_level + 0.001;\ndec_env = dec_done ? sus_level : dec_env;\n\n// Release\nrel_env = env * (1.0 - dec_coeff);\nrel_done = rel_env < 0.001;\nrel_env = rel_done ? 0 : rel_env;\n\n// Select stage output\nenv = (stage == 1) ? att_env : (stage == 2) ? dec_env : (stage == 3) ? sus_level : (stage == 4) ? rel_env : 0;\n\n// Advance stage\nstage = ((stage == 1) * att_done) ? 2 : ((stage == 2) * dec_done) ? 3 : ((stage == 4) * rel_done) ? 0 : stage;\n\nout1 = env;\n",
                                                    "fontface": 0,
                                                    "fontname": "<Monospaced>",
                                                    "fontsize": 12.0,
                                                    "id": "obj-7",
                                                    "maxclass": "codebox",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
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
                                                    "id": "obj-8",
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
                                                        "obj-7",
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
                                                        "obj-7",
                                                        2
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
                                                        "obj-7",
                                                        3
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
                                                        "obj-7",
                                                        4
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
                                                        "obj-7",
                                                        5
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
                                        150.0,
                                        290.0,
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
                                    "id": "obj-25",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        150.0,
                                        340.0,
                                        88.0,
                                        35.0
                                    ],
                                    "text": "send~ mt-filt-eg-sig"
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
                                        30.0,
                                        370.0,
                                        156.0,
                                        20.0
                                    ],
                                    "text": "--- AMP ENVELOPE ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-27",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        400.0,
                                        83.0,
                                        35.0
                                    ],
                                    "text": "receive mt-cc-amp-att"
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
                                        30.0,
                                        425.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-29",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        450.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-30",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        480.0,
                                        42.0,
                                        49.0
                                    ],
                                    "text": "*~ 29999."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-31",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        505.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~ 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-32",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        400.0,
                                        83.0,
                                        49.0
                                    ],
                                    "text": "receive mt-cc-amp-dec"
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
                                        150.0,
                                        425.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-34",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        450.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-35",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        480.0,
                                        42.0,
                                        49.0
                                    ],
                                    "text": "*~ 29999."
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
                                        150.0,
                                        505.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~ 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-37",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        400.0,
                                        83.0,
                                        49.0
                                    ],
                                    "text": "receive mt-cc-amp-sus"
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
                                        270.0,
                                        425.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-39",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        450.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-40",
                                    "maxclass": "newobj",
                                    "numinlets": 6,
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
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-4",
                                                    "maxclass": "newobj",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        290.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 4"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-5",
                                                    "maxclass": "newobj",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        370.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 5"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-6",
                                                    "maxclass": "newobj",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        450.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 6"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "code": "\n// ADSR Envelope with shared Decay/Release\n// in 1: gate, in 2: attack ms, in 3: decay ms\n// in 4: sustain 0-1, in 5: release enable, in 6: retrigger mode\n\nHistory env(0);\nHistory stage(0);\nHistory prev_gate(0);\n\ngate = in1;\natt_ms = max(in2, 1);\ndec_ms = max(in3, 1);\nsus_level = clamp(in4, 0, 1);\nrel_enable = in5;\nretrig_mode = in6;\n\ngate_on = (gate > 0.5) * (prev_gate <= 0.5);\ngate_off = (gate <= 0.5) * (prev_gate > 0.5);\nprev_gate = gate;\n\n// Note on: reset env if not legato, go to attack\nenv = (gate_on * (retrig_mode < 0.5)) ? 0 : env;\nstage = gate_on ? 1 : stage;\n\n// Note off: release or instant off\nstage = (gate_off * (rel_enable > 0.5)) ? 4 : (gate_off * (rel_enable <= 0.5)) ? 0 : stage;\nenv = (gate_off * (rel_enable <= 0.5)) ? 0 : env;\n\natt_coeff = 1.0 / (att_ms * 0.001 * samplerate);\ndec_coeff = 1.0 / (dec_ms * 0.001 * samplerate);\ndec_smooth = 1.0 / (dec_ms * 0.001 * samplerate + 1);\n\n// Attack\natt_env = env + att_coeff;\natt_done = att_env >= 1.0;\natt_env = att_done ? 1.0 : att_env;\n\n// Decay\ndec_env = env - (env - sus_level) * dec_smooth;\ndec_done = dec_env <= sus_level + 0.001;\ndec_env = dec_done ? sus_level : dec_env;\n\n// Release\nrel_env = env * (1.0 - dec_coeff);\nrel_done = rel_env < 0.001;\nrel_env = rel_done ? 0 : rel_env;\n\n// Select stage output\nenv = (stage == 1) ? att_env : (stage == 2) ? dec_env : (stage == 3) ? sus_level : (stage == 4) ? rel_env : 0;\n\n// Advance stage\nstage = ((stage == 1) * att_done) ? 2 : ((stage == 2) * dec_done) ? 3 : ((stage == 4) * rel_done) ? 0 : stage;\n\nout1 = env;\n",
                                                    "fontface": 0,
                                                    "fontname": "<Monospaced>",
                                                    "fontsize": 12.0,
                                                    "id": "obj-7",
                                                    "maxclass": "codebox",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
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
                                                    "id": "obj-8",
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
                                                        "obj-7",
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
                                                        "obj-7",
                                                        2
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
                                                        "obj-7",
                                                        3
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
                                                        "obj-7",
                                                        4
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
                                                        "obj-7",
                                                        5
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
                                        150.0,
                                        540.0,
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
                                    "id": "obj-41",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        150.0,
                                        590.0,
                                        88.0,
                                        35.0
                                    ],
                                    "text": "send~ mt-amp-eg-sig"
                                }
                            },
                            {
                                "box": {
                                    "comment": "pcontrol inlet",
                                    "id": "obj-42",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        600.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-43",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        440.0,
                                        118.0,
                                        22.0
                                    ],
                                    "text": "receive mt-vel"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-44",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        440.0,
                                        202.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-amp-vel-sens"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-45",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        440.0,
                                        209.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-filt-vel-sens"
                                }
                            }
                        ],
                        "lines": [
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
                                        "obj-24",
                                        2
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
                                        "obj-24",
                                        3
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
                                        "obj-20",
                                        0
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
                                        "obj-24",
                                        4
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-20",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-40",
                                        4
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-20",
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
                                        "obj-21",
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
                                        "obj-24",
                                        5
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-23",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-40",
                                        5
                                    ],
                                    "order": 0,
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
                                    "source": [
                                        "obj-24",
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
                                        "obj-31",
                                        0
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
                                        "obj-40",
                                        1
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
                                    "source": [
                                        "obj-32",
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
                                    "source": [
                                        "obj-33",
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
                                    "source": [
                                        "obj-35",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-40",
                                        2
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
                                        3
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
                                        "obj-24",
                                        0
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-4",
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
                                    "order": 0,
                                    "source": [
                                        "obj-4",
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
                                    "source": [
                                        "obj-5",
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
                                        "obj-8",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-24",
                                        1
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
                        4275.0,
                        150.0,
                        86.0,
                        22.0
                    ],
                    "text": "p envelopes"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            676.0,
                            254.0,
                            700.0,
                            500.0
                        ],
                        "visible": 1,
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
                                        30.0,
                                        20.0,
                                        93.0,
                                        20.0
                                    ],
                                    "text": "--- LFO ---"
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
                                        30.0,
                                        50.0,
                                        144.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-lfo-rate"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        100.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        130.0,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~ 4."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-6",
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
                                                    "code": "\n// Map 0-1 to 0.01-100 Hz (exponential)\nout1 = 0.01 * pow(10000, clamp(in1, 0, 1));\n",
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
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-2",
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
                                        30.0,
                                        160.0,
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
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        50.0,
                                        144.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-lfo-wave"
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
                                        200.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
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
                                        200.0,
                                        100.0,
                                        39.0,
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
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        50.0,
                                        144.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-lfo-keytrig"
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
                                        350.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        100.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        130.0,
                                        83.0,
                                        35.0
                                    ],
                                    "text": "receive mt-gate"
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
                                        350.0,
                                        155.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "$1 0"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        180.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
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
                                        350.0,
                                        210.0,
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
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        50.0,
                                        155.0,
                                        22.0
                                    ],
                                    "text": "receive~ mt-filt-eg-sig"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-18",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
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
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-4",
                                                    "maxclass": "newobj",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        290.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 4"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "code": "\n// LFO with 6 waveforms\n// in 1: rate Hz\n// in 2: waveform select 0-5\n// in 3: key trigger\n// in 4: filter EG value\n\nHistory phase(0);\nHistory sh_val(0);\nHistory sh_prev(0);\n\nrate = in1;\nwaveform = in2;\nkey_trig = in3;\nfilt_eg = in4;\n\nphase = (key_trig > 0.5) ? 0 : phase;\ninc = rate / samplerate;\nphase = wrap(phase + inc, 0, 1);\n\ntri = (1.0 - abs(phase * 2.0 - 1.0)) * 2.0 - 1.0;\nsqr = (phase < 0.5) ? 1.0 : -1.0;\nsaw_w = phase * 2.0 - 1.0;\nramp_w = (1.0 - phase) * 2.0 - 1.0;\n\nnew_cyc = (phase < sh_prev) ? 1 : 0;\nsh_val = new_cyc ? noise() : sh_val;\nsh_prev = phase;\n\nsel = round(clamp(waveform, 0, 5));\nlfo_out = (sel == 0) ? tri : (sel == 1) ? sqr : (sel == 2) ? saw_w : (sel == 3) ? ramp_w : (sel == 4) ? sh_val : filt_eg;\n\nout1 = lfo_out;\n",
                                                    "fontface": 0,
                                                    "fontname": "<Monospaced>",
                                                    "fontsize": 12.0,
                                                    "id": "obj-5",
                                                    "maxclass": "codebox",
                                                    "numinlets": 4,
                                                    "numoutlets": 1,
                                                    "outlettype": [
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
                                                    "id": "obj-6",
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
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-5",
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
                                                        "obj-5",
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
                                                        "obj-5",
                                                        2
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
                                                        3
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
                                        200.0,
                                        250.0,
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
                                    "id": "obj-19",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        27.5,
                                        272.0,
                                        149.0,
                                        20.0
                                    ],
                                    "text": "--- MOD ROUTING ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-20",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        27.5,
                                        294.0,
                                        163.0,
                                        22.0
                                    ],
                                    "text": "receive mt-mod-wheel"
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
                                        27.5,
                                        327.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-22",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        27.5,
                                        352.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        197.5,
                                        294.0,
                                        163.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-lfo-vco"
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
                                        197.5,
                                        327.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-25",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        197.5,
                                        352.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-26",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        197.5,
                                        382.0,
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
                                    "id": "obj-27",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        197.5,
                                        412.0,
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
                                    "id": "obj-28",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        197.5,
                                        442.0,
                                        144.0,
                                        22.0
                                    ],
                                    "text": "send~ mt-lfo-pitch-mod"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-29",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        397.5,
                                        294.0,
                                        163.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-lfo-vcf"
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
                                        397.5,
                                        327.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-31",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        397.5,
                                        352.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-32",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        397.5,
                                        382.0,
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
                                    "id": "obj-33",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        397.5,
                                        412.0,
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
                                    "id": "obj-34",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        397.5,
                                        442.0,
                                        144.0,
                                        22.0
                                    ],
                                    "text": "send~ mt-lfo-filt-mod"
                                }
                            },
                            {
                                "box": {
                                    "comment": "pcontrol inlet",
                                    "id": "obj-35",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        133.0,
                                        10.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-36",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        27.5,
                                        342.0,
                                        181.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-note-sync"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        359.5,
                                        75.0,
                                        359.5,
                                        75.0
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
                                        359.5,
                                        99.0,
                                        359.5,
                                        99.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        359.5,
                                        123.0,
                                        336.0,
                                        123.0,
                                        336.0,
                                        207.0,
                                        382.5,
                                        207.0
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
                                        359.5,
                                        168.0,
                                        359.5,
                                        168.0
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
                                        359.5,
                                        180.0,
                                        359.5,
                                        180.0
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
                                        359.5,
                                        204.0,
                                        359.5,
                                        204.0
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
                                        2
                                    ],
                                    "midpoints": [
                                        359.5,
                                        234.0,
                                        277.5,
                                        234.0
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
                                        "obj-18",
                                        3
                                    ],
                                    "midpoints": [
                                        509.5,
                                        246.0,
                                        311.5,
                                        246.0
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
                                        "obj-26",
                                        0
                                    ],
                                    "midpoints": [
                                        209.5,
                                        291.0,
                                        192.0,
                                        291.0,
                                        192.0,
                                        324.0,
                                        258.0,
                                        324.0,
                                        258.0,
                                        378.0,
                                        207.0,
                                        378.0
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-18",
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
                                        209.5,
                                        273.0,
                                        384.0,
                                        273.0,
                                        384.0,
                                        378.0,
                                        407.0,
                                        378.0
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-18",
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
                                        75.0,
                                        39.5,
                                        75.0
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
                                        "obj-21",
                                        0
                                    ],
                                    "midpoints": [
                                        37.0,
                                        318.0,
                                        37.0,
                                        318.0
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
                                        "obj-22",
                                        0
                                    ],
                                    "midpoints": [
                                        37.0,
                                        351.0,
                                        37.0,
                                        351.0
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
                                        "obj-27",
                                        1
                                    ],
                                    "midpoints": [
                                        37.0,
                                        408.0,
                                        230.0,
                                        408.0
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-22",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-33",
                                        1
                                    ],
                                    "midpoints": [
                                        37.0,
                                        408.0,
                                        430.0,
                                        408.0
                                    ],
                                    "order": 0,
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
                                    "midpoints": [
                                        207.0,
                                        318.0,
                                        207.0,
                                        318.0
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
                                        207.0,
                                        351.0,
                                        207.0,
                                        351.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        207.0,
                                        375.0,
                                        230.0,
                                        375.0
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
                                        "obj-27",
                                        0
                                    ],
                                    "midpoints": [
                                        207.0,
                                        405.0,
                                        207.0,
                                        405.0
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
                                        "obj-28",
                                        0
                                    ],
                                    "midpoints": [
                                        207.0,
                                        435.0,
                                        207.0,
                                        435.0
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
                                        407.0,
                                        318.0,
                                        407.0,
                                        318.0
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
                                    "midpoints": [
                                        39.5,
                                        99.0,
                                        39.5,
                                        99.0
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
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        407.0,
                                        351.0,
                                        407.0,
                                        351.0
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
                                        "obj-32",
                                        1
                                    ],
                                    "midpoints": [
                                        407.0,
                                        375.0,
                                        430.0,
                                        375.0
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
                                        407.0,
                                        405.0,
                                        407.0,
                                        405.0
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
                                        "obj-34",
                                        0
                                    ],
                                    "midpoints": [
                                        407.0,
                                        435.0,
                                        407.0,
                                        435.0
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        123.0,
                                        39.5,
                                        123.0
                                    ],
                                    "order": 1,
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
                                        39.5,
                                        123.0,
                                        27.0,
                                        123.0,
                                        27.0,
                                        153.0,
                                        39.5,
                                        153.0
                                    ],
                                    "order": 0,
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
                                        39.5,
                                        237.0,
                                        209.5,
                                        237.0
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
                                    "midpoints": [
                                        209.5,
                                        75.0,
                                        209.5,
                                        75.0
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
                                        "obj-9",
                                        0
                                    ],
                                    "midpoints": [
                                        209.5,
                                        99.0,
                                        209.5,
                                        99.0
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
                                        "obj-18",
                                        1
                                    ],
                                    "midpoints": [
                                        209.5,
                                        237.0,
                                        243.5,
                                        237.0
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
                        4410.0,
                        150.0,
                        86.0,
                        22.0
                    ],
                    "text": "p lfo"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            134.0,
                            167.0,
                            803.0,
                            504.0
                        ],
                        "visible": 1,
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
                                        30.0,
                                        20.0,
                                        198.0,
                                        20.0
                                    ],
                                    "text": "--- MOOG LADDER FILTER ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        50.0,
                                        134.0,
                                        22.0
                                    ],
                                    "text": "receive~ mt-mix-out"
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
                                        200.0,
                                        50.0,
                                        123.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-cutoff"
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
                                        200.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        100.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-6",
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
                                                    "code": "\n// Map 0-1 to 20-20000 Hz (exponential)\nout1 = 20.0 * pow(1000, clamp(in1, 0, 1));\n",
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
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-2",
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
                                        200.0,
                                        130.0,
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
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        50.0,
                                        134.0,
                                        22.0
                                    ],
                                    "text": "receive~ mt-filt-eg-sig"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        80.0,
                                        141.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-filt-eg-amt"
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
                                        350.0,
                                        105.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
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
                                        350.0,
                                        130.0,
                                        39.0,
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
                                        350.0,
                                        160.0,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~ 2."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        185.0,
                                        45.0,
                                        22.0
                                    ],
                                    "text": "-~ 1."
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
                                        350.0,
                                        215.0,
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
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        350.0,
                                        245.0,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~ 5."
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
                                                    "code": "\nout1 = pow(2, in1);\n",
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
                                        350.0,
                                        275.0,
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
                                    "id": "obj-16",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        50.0,
                                        134.0,
                                        22.0
                                    ],
                                    "text": "receive~ mt-lfo-filt-mod"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        80.0,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~ 5."
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
                                                    "code": "\nout1 = pow(2, in1);\n",
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
                                        500.0,
                                        110.0,
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
                                    "id": "obj-19",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        204.5,
                                        299.0,
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
                                    "id": "obj-20",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        275.0,
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
                                    "id": "obj-21",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        559.0,
                                        340.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-resonance"
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
                                        559.0,
                                        373.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        559.0,
                                        398.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-24",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
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
                                                    "code": "\n// Moog Ladder Filter - Huovilainen improved model\n// 4-pole 24dB/oct low-pass with self-oscillation\n// in 1: audio input\n// in 2: cutoff frequency (Hz)\n// in 3: resonance (0-1, self-oscillates near 1)\n\nHistory s0(0);\nHistory s1(0);\nHistory s2(0);\nHistory s3(0);\nHistory clip_prev(0);\n\ninput = in1;\ncutoff_hz = in2;\nresonance = in3;\n\nfc = clamp(cutoff_hz, 20, samplerate * 0.45);\nwc = 2 * 3.14159265 * fc / samplerate;\nwc2 = wc * 0.5;\ng = wc2 / (1.0 + wc2);\n\nk = resonance * 4.0;\nfb = clip_prev;\nx = tanh(input - k * fb);\n\na = s0 + g * (x - s0);\nb = s1 + g * (a - s1);\nc = s2 + g * (b - s2);\nd = s3 + g * (c - s3);\n\ns0 = a;\ns1 = b;\ns2 = c;\ns3 = d;\nclip_prev = tanh(d);\n\nout1 = d;\n",
                                                    "fontface": 0,
                                                    "fontname": "<Monospaced>",
                                                    "fontsize": 12.0,
                                                    "id": "obj-4",
                                                    "maxclass": "codebox",
                                                    "numinlets": 3,
                                                    "numoutlets": 1,
                                                    "outlettype": [
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
                                        200.0,
                                        400.0,
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
                                    "id": "obj-25",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        200.0,
                                        450.0,
                                        88.0,
                                        35.0
                                    ],
                                    "text": "send~ mt-filt-out"
                                }
                            },
                            {
                                "box": {
                                    "comment": "pcontrol inlet",
                                    "id": "obj-26",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        604.0,
                                        10.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-27",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        24.0,
                                        340.0,
                                        174.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-kb-track"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-28",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        211.0,
                                        340.0,
                                        209.0,
                                        22.0
                                    ],
                                    "text": "receive mt-cc-filt-vel-sens"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-29",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        426.0,
                                        340.0,
                                        125.0,
                                        22.0
                                    ],
                                    "text": "receive mt-note"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        359.5,
                                        153.0,
                                        359.5,
                                        153.0
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
                                        359.5,
                                        183.0,
                                        359.5,
                                        183.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        359.5,
                                        210.0,
                                        382.5,
                                        210.0
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
                                        359.5,
                                        240.0,
                                        359.5,
                                        240.0
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
                                        359.5,
                                        270.0,
                                        359.5,
                                        270.0
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
                                        "obj-19",
                                        1
                                    ],
                                    "midpoints": [
                                        359.5,
                                        300.0,
                                        258.0,
                                        300.0,
                                        258.0,
                                        294.0,
                                        237.0,
                                        294.0
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
                                        509.5,
                                        75.0,
                                        509.5,
                                        75.0
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
                                        "obj-18",
                                        0
                                    ],
                                    "midpoints": [
                                        509.5,
                                        105.0,
                                        509.5,
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
                                        "obj-20",
                                        1
                                    ],
                                    "midpoints": [
                                        509.5,
                                        261.0,
                                        532.5,
                                        261.0
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
                                        "obj-20",
                                        0
                                    ],
                                    "midpoints": [
                                        214.0,
                                        324.0,
                                        486.0,
                                        324.0,
                                        486.0,
                                        270.0,
                                        509.5,
                                        270.0
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
                                        "obj-24",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        327.0,
                                        198.0,
                                        327.0,
                                        198.0,
                                        387.0,
                                        209.5,
                                        387.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        509.5,
                                        327.0,
                                        420.0,
                                        327.0,
                                        420.0,
                                        387.0,
                                        260.5,
                                        387.0
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
                                        "obj-22",
                                        0
                                    ],
                                    "midpoints": [
                                        568.5,
                                        363.0,
                                        568.5,
                                        363.0
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
                                        "obj-23",
                                        0
                                    ],
                                    "midpoints": [
                                        568.5,
                                        396.0,
                                        568.5,
                                        396.0
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
                                        2
                                    ],
                                    "midpoints": [
                                        568.5,
                                        423.0,
                                        333.0,
                                        423.0,
                                        333.0,
                                        396.0,
                                        311.5,
                                        396.0
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
                                        209.5,
                                        423.0,
                                        209.5,
                                        423.0
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
                                        "obj-4",
                                        0
                                    ],
                                    "midpoints": [
                                        209.5,
                                        75.0,
                                        209.5,
                                        75.0
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
                                    "midpoints": [
                                        209.5,
                                        99.0,
                                        209.5,
                                        99.0
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
                                        209.5,
                                        123.0,
                                        209.5,
                                        123.0
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
                                        209.5,
                                        285.0,
                                        214.0,
                                        285.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        359.5,
                                        75.0,
                                        336.0,
                                        75.0,
                                        336.0,
                                        210.0,
                                        359.5,
                                        210.0
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
                                        "obj-9",
                                        0
                                    ],
                                    "midpoints": [
                                        359.5,
                                        105.0,
                                        359.5,
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
                                        359.5,
                                        129.0,
                                        359.5,
                                        129.0
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
                        4545.0,
                        150.0,
                        86.0,
                        22.0
                    ],
                    "text": "p filter"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-9",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            134.0,
                            167.0,
                            500.0,
                            400.0
                        ],
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
                                        30.0,
                                        20.0,
                                        156.0,
                                        20.0
                                    ],
                                    "text": "--- VCA & OUTPUT ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        50.0,
                                        94.0,
                                        35.0
                                    ],
                                    "text": "receive~ mt-filt-out"
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
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        200.0,
                                        50.0,
                                        94.0,
                                        35.0
                                    ],
                                    "text": "receive~ mt-amp-eg-sig"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        100.0,
                                        100.0,
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
                                    "id": "obj-5",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        130.0,
                                        83.0,
                                        35.0
                                    ],
                                    "text": "receive mt-cc-volume"
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
                                        155.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 30"
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
                                        30.0,
                                        180.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        100.0,
                                        200.0,
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
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        100.0,
                                        240.0,
                                        64.0,
                                        22.0
                                    ],
                                    "text": "clip~ -1. 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        100.0,
                                        290.0,
                                        35.0,
                                        22.0
                                    ],
                                    "text": "dac~"
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
                                        200.0,
                                        240.0,
                                        15.0,
                                        100.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "pcontrol inlet",
                                    "id": "obj-12",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        300.0,
                                        20.0,
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
                                        "obj-4",
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
                                        1
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
                                        "obj-8",
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
                                        1
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
                                        "obj-9",
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
                                        "obj-10",
                                        1
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-9",
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
                                    "order": 2,
                                    "source": [
                                        "obj-9",
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
                                    "order": 0,
                                    "source": [
                                        "obj-9",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        4695.0,
                        150.0,
                        86.0,
                        22.0
                    ],
                    "text": "p vca-output"
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
                        5385.0,
                        75.0,
                        247.0,
                        20.0
                    ],
                    "text": "========== UI CONTROLS =========="
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        990.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        94.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5385.0,
                        135.0,
                        79.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        76.0,
                        56.0,
                        17.0
                    ],
                    "text": "FINE TUNE"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-13",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        990.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-14",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1005.0,
                        150.0,
                        118.0,
                        22.0
                    ],
                    "text": "send mt-cc-fine-tune"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        990.0,
                        30.0,
                        131.0,
                        22.0
                    ],
                    "text": "receive mt-cc-fine-tune"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-16",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        990.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-17",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1140.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        94.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-18",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5385.0,
                        180.0,
                        79.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        76.0,
                        61.0,
                        17.0
                    ],
                    "text": "VCO2 FREQ"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-19",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1140.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-20",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1155.0,
                        150.0,
                        121.0,
                        22.0
                    ],
                    "text": "send mt-cc-vco2-freq"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-21",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1140.0,
                        30.0,
                        134.0,
                        22.0
                    ],
                    "text": "receive mt-cc-vco2-freq"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1140.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        4830.0,
                        0.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        99.0,
                        20.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        4830.0,
                        30.0,
                        129.0,
                        22.0
                    ],
                    "text": "send mt-cc-vco1-wave"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-25",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5385.0,
                        225.0,
                        65.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        125.0,
                        76.0,
                        50.0,
                        15.0
                    ],
                    "text": "VCO1 SQ"
                }
            },
            {
                "box": {
                    "id": "obj-26",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        4965.0,
                        0.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        170.0,
                        99.0,
                        20.0,
                        20.0
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
                        4965.0,
                        30.0,
                        129.0,
                        22.0
                    ],
                    "text": "send mt-cc-vco2-wave"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-28",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5385.0,
                        285.0,
                        65.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        165.0,
                        76.0,
                        50.0,
                        15.0
                    ],
                    "text": "VCO2 SQ"
                }
            },
            {
                "box": {
                    "id": "obj-29",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1290.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        94.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-30",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5385.0,
                        330.0,
                        72.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        76.0,
                        55.0,
                        17.0
                    ],
                    "text": "VCO1 LVL"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-31",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1290.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-32",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1305.0,
                        150.0,
                        112.0,
                        22.0
                    ],
                    "text": "send mt-cc-vco1-lvl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-33",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1290.0,
                        30.0,
                        125.0,
                        22.0
                    ],
                    "text": "receive mt-cc-vco1-lvl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-34",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1290.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-35",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1440.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        365.0,
                        94.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-36",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5385.0,
                        375.0,
                        72.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        365.0,
                        76.0,
                        55.0,
                        17.0
                    ],
                    "text": "VCO2 LVL"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-37",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1440.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-38",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1455.0,
                        150.0,
                        112.0,
                        22.0
                    ],
                    "text": "send mt-cc-vco2-lvl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1440.0,
                        30.0,
                        125.0,
                        22.0
                    ],
                    "text": "receive mt-cc-vco2-lvl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-40",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1440.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-41",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1590.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        500.0,
                        94.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-42",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5640.0,
                        30.0,
                        58.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        500.0,
                        76.0,
                        55.0,
                        17.0
                    ],
                    "text": "CUTOFF"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-43",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1590.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-44",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1605.0,
                        150.0,
                        100.0,
                        22.0
                    ],
                    "text": "send mt-cc-cutoff"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-45",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1590.0,
                        30.0,
                        113.0,
                        22.0
                    ],
                    "text": "receive mt-cc-cutoff"
                }
            },
            {
                "box": {
                    "id": "obj-47",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1755.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        555.0,
                        94.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-48",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5640.0,
                        75.0,
                        79.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        555.0,
                        76.0,
                        66.0,
                        17.0
                    ],
                    "text": "RESONANCE"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-49",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1755.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-50",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1755.0,
                        150.0,
                        127.0,
                        22.0
                    ],
                    "text": "send mt-cc-resonance"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-51",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1755.0,
                        30.0,
                        140.0,
                        22.0
                    ],
                    "text": "receive mt-cc-resonance"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-52",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1755.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-53",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1905.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        610.0,
                        94.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-54",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5640.0,
                        135.0,
                        58.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        610.0,
                        76.0,
                        55.0,
                        17.0
                    ],
                    "text": "EG AMT"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-55",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1905.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-56",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1905.0,
                        150.0,
                        125.0,
                        22.0
                    ],
                    "text": "send mt-cc-filt-eg-amt"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-57",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1905.0,
                        30.0,
                        137.0,
                        22.0
                    ],
                    "text": "receive mt-cc-filt-eg-amt"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-58",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1905.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-59",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        2055.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        202.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-60",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5640.0,
                        180.0,
                        51.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        184.0,
                        50.0,
                        17.0
                    ],
                    "text": "F.ATT"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-61",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2055.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-62",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2055.0,
                        150.0,
                        101.0,
                        22.0
                    ],
                    "text": "send mt-cc-filt-att"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-63",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2055.0,
                        30.0,
                        113.0,
                        22.0
                    ],
                    "text": "receive mt-cc-filt-att"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-64",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2055.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-65",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        2205.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        202.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-66",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5640.0,
                        225.0,
                        51.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        184.0,
                        50.0,
                        17.0
                    ],
                    "text": "F.DEC"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-67",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2205.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
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
                        2205.0,
                        150.0,
                        107.0,
                        22.0
                    ],
                    "text": "send mt-cc-filt-dec"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-69",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2205.0,
                        30.0,
                        119.0,
                        22.0
                    ],
                    "text": "receive mt-cc-filt-dec"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-70",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2205.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-71",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        2355.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        125.0,
                        202.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-72",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5640.0,
                        285.0,
                        51.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        125.0,
                        184.0,
                        50.0,
                        17.0
                    ],
                    "text": "F.SUS"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-73",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2355.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-74",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2355.0,
                        150.0,
                        106.0,
                        22.0
                    ],
                    "text": "send mt-cc-filt-sus"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-75",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2355.0,
                        30.0,
                        119.0,
                        22.0
                    ],
                    "text": "receive mt-cc-filt-sus"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-76",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2355.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-77",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        2505.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        245.0,
                        202.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-78",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5640.0,
                        330.0,
                        51.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        245.0,
                        184.0,
                        50.0,
                        17.0
                    ],
                    "text": "A.ATT"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-79",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2505.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-80",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2505.0,
                        150.0,
                        112.0,
                        22.0
                    ],
                    "text": "send mt-cc-amp-att"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-81",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2505.0,
                        30.0,
                        125.0,
                        22.0
                    ],
                    "text": "receive mt-cc-amp-att"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-82",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2505.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-83",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        2655.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        300.0,
                        202.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-84",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5640.0,
                        375.0,
                        51.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        300.0,
                        184.0,
                        50.0,
                        17.0
                    ],
                    "text": "A.DEC"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-85",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2655.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-86",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2655.0,
                        150.0,
                        118.0,
                        22.0
                    ],
                    "text": "send mt-cc-amp-dec"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-87",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2655.0,
                        30.0,
                        131.0,
                        22.0
                    ],
                    "text": "receive mt-cc-amp-dec"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-88",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2655.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-89",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        2805.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        355.0,
                        202.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-90",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5730.0,
                        30.0,
                        51.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        355.0,
                        184.0,
                        50.0,
                        17.0
                    ],
                    "text": "A.SUS"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-91",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2805.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-92",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2805.0,
                        150.0,
                        117.0,
                        22.0
                    ],
                    "text": "send mt-cc-amp-sus"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-93",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2805.0,
                        30.0,
                        130.0,
                        22.0
                    ],
                    "text": "receive mt-cc-amp-sus"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-94",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2805.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-95",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5100.0,
                        0.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        185.0,
                        207.0,
                        20.0,
                        20.0
                    ]
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
                        5100.0,
                        30.0,
                        129.0,
                        22.0
                    ],
                    "text": "send mt-cc-release-sw"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-97",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5730.0,
                        75.0,
                        65.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        180.0,
                        184.0,
                        55.0,
                        15.0
                    ],
                    "text": "RELEASE"
                }
            },
            {
                "box": {
                    "id": "obj-98",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        2955.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        530.0,
                        202.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-99",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5730.0,
                        135.0,
                        72.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        530.0,
                        184.0,
                        55.0,
                        17.0
                    ],
                    "text": "LFO RATE"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-100",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2955.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
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
                        2970.0,
                        150.0,
                        109.0,
                        22.0
                    ],
                    "text": "send mt-cc-lfo-rate"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-102",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2955.0,
                        30.0,
                        121.0,
                        22.0
                    ],
                    "text": "receive mt-cc-lfo-rate"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-103",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2955.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-104",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        3105.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585.0,
                        202.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-105",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5730.0,
                        180.0,
                        65.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585.0,
                        184.0,
                        55.0,
                        17.0
                    ],
                    "text": "LFO>VCO"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-106",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3105.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-107",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3120.0,
                        150.0,
                        107.0,
                        22.0
                    ],
                    "text": "send mt-cc-lfo-vco"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-108",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3105.0,
                        30.0,
                        119.0,
                        22.0
                    ],
                    "text": "receive mt-cc-lfo-vco"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-109",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3105.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-110",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        3255.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        640.0,
                        202.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-111",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5730.0,
                        225.0,
                        65.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        640.0,
                        184.0,
                        55.0,
                        17.0
                    ],
                    "text": "LFO>VCF"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-112",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3255.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-113",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3270.0,
                        150.0,
                        103.0,
                        22.0
                    ],
                    "text": "send mt-cc-lfo-vcf"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-114",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3255.0,
                        30.0,
                        116.0,
                        22.0
                    ],
                    "text": "receive mt-cc-lfo-vcf"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-115",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3255.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-116",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5250.0,
                        0.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        860.0,
                        207.0,
                        20.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-117",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5250.0,
                        30.0,
                        115.0,
                        22.0
                    ],
                    "text": "send mt-cc-glide-sw"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-118",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5730.0,
                        285.0,
                        51.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        855.0,
                        184.0,
                        45.0,
                        15.0
                    ],
                    "text": "GLIDE"
                }
            },
            {
                "box": {
                    "id": "obj-119",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        3405.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        895.0,
                        202.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-120",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5730.0,
                        330.0,
                        72.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        895.0,
                        184.0,
                        55.0,
                        17.0
                    ],
                    "text": "GLIDE RT"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-121",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3405.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-122",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3420.0,
                        150.0,
                        121.0,
                        22.0
                    ],
                    "text": "send mt-cc-glide-rate"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-123",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3405.0,
                        30.0,
                        134.0,
                        22.0
                    ],
                    "text": "receive mt-cc-glide-rate"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-124",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3405.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "id": "obj-125",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        3555.0,
                        60.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        800.0,
                        94.0,
                        40.0,
                        40.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-126",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5730.0,
                        375.0,
                        58.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        800.0,
                        76.0,
                        55.0,
                        17.0
                    ],
                    "text": "VOLUME"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-127",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3555.0,
                        120.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-128",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3570.0,
                        150.0,
                        110.0,
                        22.0
                    ],
                    "text": "send mt-cc-volume"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-129",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3555.0,
                        30.0,
                        123.0,
                        22.0
                    ],
                    "text": "receive mt-cc-volume"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-130",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3555.0,
                        75.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0. 1. 0 127"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-131",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5820.0,
                        30.0,
                        86.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        8.0,
                        200.0,
                        24.0
                    ],
                    "text": "MINITAUR"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-132",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5820.0,
                        75.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        58.0,
                        70.0,
                        18.0
                    ],
                    "text": "OSC"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-133",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5820.0,
                        135.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        58.0,
                        70.0,
                        18.0
                    ],
                    "text": "MIX"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-134",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5820.0,
                        180.0,
                        58.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        500.0,
                        58.0,
                        70.0,
                        18.0
                    ],
                    "text": "FILTER"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-135",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5820.0,
                        225.0,
                        65.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        166.0,
                        70.0,
                        18.0
                    ],
                    "text": "FILT EG"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-136",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5820.0,
                        285.0,
                        58.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        245.0,
                        166.0,
                        70.0,
                        18.0
                    ],
                    "text": "AMP EG"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-137",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5820.0,
                        330.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        530.0,
                        166.0,
                        55.0,
                        18.0
                    ],
                    "text": "LFO"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-138",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5820.0,
                        375.0,
                        44.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        855.0,
                        166.0,
                        55.0,
                        18.0
                    ],
                    "text": "PERF"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-139",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5910.0,
                        30.0,
                        40.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        800.0,
                        58.0,
                        55.0,
                        18.0
                    ],
                    "text": "VOL"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-140",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5910.0,
                        75.0,
                        198.0,
                        20.0
                    ],
                    "text": "--- SUBPATCHER BUTTONS ---"
                }
            },
            {
                "box": {
                    "id": "obj-141",
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
                        3705.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        32.0,
                        55.0,
                        18.0
                    ],
                    "text": "MIDI"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-142",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3705.0,
                        75.0,
                        44.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-143",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3705.0,
                        105.0,
                        58.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-144",
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
                        3855.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        75.0,
                        32.0,
                        55.0,
                        18.0
                    ],
                    "text": "OSC"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-145",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3855.0,
                        75.0,
                        44.0,
                        22.0
                    ],
                    "text": "open"
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
                        ""
                    ],
                    "patching_rect": [
                        3855.0,
                        105.0,
                        58.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-147",
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
                        3990.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        135.0,
                        32.0,
                        55.0,
                        18.0
                    ],
                    "text": "MIX"
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
                        3990.0,
                        75.0,
                        44.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-149",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3990.0,
                        105.0,
                        58.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-150",
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
                        4125.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        195.0,
                        32.0,
                        55.0,
                        18.0
                    ],
                    "text": "GLIDE"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-151",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4125.0,
                        75.0,
                        44.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-152",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4125.0,
                        105.0,
                        58.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-153",
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
                        4275.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        255.0,
                        32.0,
                        55.0,
                        18.0
                    ],
                    "text": "ENV"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-154",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4275.0,
                        75.0,
                        44.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-155",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4275.0,
                        105.0,
                        58.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-156",
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
                        4410.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        315.0,
                        32.0,
                        55.0,
                        18.0
                    ],
                    "text": "LFO"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-157",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4410.0,
                        75.0,
                        44.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-158",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4410.0,
                        105.0,
                        58.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-159",
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
                        4545.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        375.0,
                        32.0,
                        55.0,
                        18.0
                    ],
                    "text": "FILT"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-160",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4545.0,
                        75.0,
                        44.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-161",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4545.0,
                        105.0,
                        58.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-162",
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
                        4695.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        435.0,
                        32.0,
                        55.0,
                        18.0
                    ],
                    "text": "VCA"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-163",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4695.0,
                        75.0,
                        44.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-164",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4695.0,
                        105.0,
                        58.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-165",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5910.0,
                        135.0,
                        100.0,
                        20.0
                    ],
                    "text": "--- INIT ---"
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
                    "id": "obj-166",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        62.0,
                        22.0
                    ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-167",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 8,
                    "outlettype": [
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
                        123.0,
                        22.0
                    ],
                    "text": "trigger b b b b b b b b"
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
                        90.0,
                        120.0,
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
                    "id": "obj-169",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        75.0,
                        150.0,
                        100.0,
                        22.0
                    ],
                    "text": "send mt-cc-cutoff"
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
                        150.0,
                        120.0,
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
                    "id": "obj-171",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        180.0,
                        150.0,
                        110.0,
                        22.0
                    ],
                    "text": "send mt-cc-volume"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-172",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210.0,
                        120.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-173",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        300.0,
                        150.0,
                        112.0,
                        22.0
                    ],
                    "text": "send mt-cc-vco1-lvl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-174",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        255.0,
                        120.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-175",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        405.0,
                        150.0,
                        112.0,
                        22.0
                    ],
                    "text": "send mt-cc-vco2-lvl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-176",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        315.0,
                        120.0,
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
                    "id": "obj-177",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        525.0,
                        150.0,
                        117.0,
                        22.0
                    ],
                    "text": "send mt-cc-amp-sus"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-178",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        375.0,
                        120.0,
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
                    "id": "obj-179",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        630.0,
                        150.0,
                        106.0,
                        22.0
                    ],
                    "text": "send mt-cc-filt-sus"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-180",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420.0,
                        120.0,
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
                    "id": "obj-181",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        750.0,
                        150.0,
                        125.0,
                        22.0
                    ],
                    "text": "send mt-cc-filt-eg-amt"
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
                        480.0,
                        120.0,
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
                    "id": "obj-183",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        855.0,
                        150.0,
                        118.0,
                        22.0
                    ],
                    "text": "send mt-cc-fine-tune"
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
                        2805.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-185",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2655.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-186",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2505.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-187",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2355.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-188",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2205.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-189",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2055.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
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
                        1905.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
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
                        1755.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-192",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1440.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-193",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1290.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-194",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1140.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-195",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        990.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-196",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3555.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-197",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3405.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-198",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3255.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-199",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3105.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-200",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2955.0,
                        105.0,
                        43.0,
                        22.0
                    ],
                    "text": "set $1"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-201",
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
                        990.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        136.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-202",
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
                        1140.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        136.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-203",
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
                        1290.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        136.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-204",
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
                        1440.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        365.0,
                        136.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-205",
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
                        1590.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        500.0,
                        136.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-206",
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
                        1755.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        555.0,
                        136.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-207",
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
                        1905.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        610.0,
                        136.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-208",
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
                        2055.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        244.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-209",
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
                        2205.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        244.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-210",
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
                        2355.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        125.0,
                        244.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-211",
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
                        2505.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        245.0,
                        244.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-212",
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
                        2655.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        300.0,
                        244.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-213",
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
                        2805.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        355.0,
                        244.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-214",
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
                        2955.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        530.0,
                        244.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-215",
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
                        3105.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        585.0,
                        244.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-216",
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
                        3255.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        640.0,
                        244.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-217",
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
                        3405.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        895.0,
                        244.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-218",
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
                        3555.0,
                        200.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        800.0,
                        136.0,
                        45.0,
                        20.0
                    ],
                    "triangle": 0
                }
            },
            {
                "box": {
                    "id": "obj-219",
                    "maxclass": "kslider",
                    "mode": 1,
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        4830.0,
                        94.0,
                        336.0,
                        53.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        296.0,
                        336.0,
                        53.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-220",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4830.0,
                        164.0,
                        66.0,
                        22.0
                    ],
                    "text": "clip 0 72"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-221",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4830.0,
                        204.0,
                        37.0,
                        22.0
                    ],
                    "text": "mtof"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-222",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        4830.0,
                        224.0,
                        97.5,
                        22.0
                    ],
                    "text": "send mt-freq"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-223",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        4930.0,
                        204.0,
                        97.5,
                        22.0
                    ],
                    "text": "send mt-note"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-224",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        5050.0,
                        164.0,
                        32.5,
                        22.0
                    ],
                    "text": "> 0"
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
                        5050.0,
                        204.0,
                        97.5,
                        22.0
                    ],
                    "text": "send mt-gate"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-226",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        4830.0,
                        74.0,
                        80.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        278.0,
                        80.0,
                        18.0
                    ],
                    "text": "KEYBOARD"
                }
            },
            {
                "box": {
                    "fontname": "Arial Bold",
                    "fontsize": 11.0,
                    "id": "obj-229",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5015.0,
                        260.0,
                        80.0,
                        18.0
                    ],
                    "text": "OSC"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-230",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5015.0,
                        278.0,
                        55.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        205.0,
                        76.0,
                        50.0,
                        17.0
                    ],
                    "text": "H.SYNC"
                }
            },
            {
                "box": {
                    "id": "obj-231",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5025.0,
                        298.0,
                        20.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        210.0,
                        99.0,
                        20.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-232",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5015.0,
                        358.0,
                        142.0,
                        22.0
                    ],
                    "text": "send mt-cc-hard-sync"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-233",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5075.0,
                        278.0,
                        55.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        245.0,
                        76.0,
                        50.0,
                        17.0
                    ],
                    "text": "N.SYNC"
                }
            },
            {
                "box": {
                    "id": "obj-234",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5085.0,
                        298.0,
                        20.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        250.0,
                        99.0,
                        20.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-235",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5075.0,
                        358.0,
                        142.0,
                        22.0
                    ],
                    "text": "send mt-cc-note-sync"
                }
            },
            {
                "box": {
                    "fontname": "Arial Bold",
                    "fontsize": 11.0,
                    "id": "obj-236",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5155.0,
                        260.0,
                        80.0,
                        18.0
                    ],
                    "text": "MIX"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-237",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5155.0,
                        278.0,
                        55.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        420.0,
                        76.0,
                        50.0,
                        17.0
                    ],
                    "text": "EXT LVL"
                }
            },
            {
                "box": {
                    "id": "obj-238",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5155.0,
                        298.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        420.0,
                        94.0,
                        40.0,
                        40.0
                    ],
                    "size": 128.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-239",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5155.0,
                        358.0,
                        122.5,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-240",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5155.0,
                        340.0,
                        45.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        420.0,
                        136.0,
                        45.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-241",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5155.0,
                        378.0,
                        129.0,
                        22.0
                    ],
                    "text": "send mt-cc-ext-lvl"
                }
            },
            {
                "box": {
                    "fontname": "Arial Bold",
                    "fontsize": 11.0,
                    "id": "obj-242",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5255.0,
                        260.0,
                        80.0,
                        18.0
                    ],
                    "text": "FILTER"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-243",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5255.0,
                        278.0,
                        55.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        665.0,
                        76.0,
                        50.0,
                        17.0
                    ],
                    "text": "KB TRK"
                }
            },
            {
                "box": {
                    "id": "obj-244",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5255.0,
                        298.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        665.0,
                        94.0,
                        40.0,
                        40.0
                    ],
                    "size": 128.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-245",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5255.0,
                        358.0,
                        122.5,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-246",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5255.0,
                        340.0,
                        45.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        665.0,
                        136.0,
                        45.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-247",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5255.0,
                        378.0,
                        135.5,
                        22.0
                    ],
                    "text": "send mt-cc-kb-track"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-248",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5315.0,
                        278.0,
                        55.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        720.0,
                        76.0,
                        50.0,
                        17.0
                    ],
                    "text": "FLT VEL"
                }
            },
            {
                "box": {
                    "id": "obj-249",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5315.0,
                        298.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        720.0,
                        94.0,
                        40.0,
                        40.0
                    ],
                    "size": 128.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-250",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5315.0,
                        358.0,
                        122.5,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-251",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5315.0,
                        340.0,
                        45.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        720.0,
                        136.0,
                        45.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-252",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5315.0,
                        378.0,
                        168.0,
                        22.0
                    ],
                    "text": "send mt-cc-filt-vel-sens"
                }
            },
            {
                "box": {
                    "fontname": "Arial Bold",
                    "fontsize": 11.0,
                    "id": "obj-253",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5395.0,
                        260.0,
                        80.0,
                        18.0
                    ],
                    "text": "AMP"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-254",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5395.0,
                        278.0,
                        55.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        410.0,
                        184.0,
                        50.0,
                        17.0
                    ],
                    "text": "AMP VEL"
                }
            },
            {
                "box": {
                    "id": "obj-255",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5395.0,
                        298.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        410.0,
                        202.0,
                        40.0,
                        40.0
                    ],
                    "size": 128.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-256",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5395.0,
                        358.0,
                        122.5,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-257",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5395.0,
                        340.0,
                        45.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        410.0,
                        244.0,
                        45.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-258",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5395.0,
                        378.0,
                        161.5,
                        22.0
                    ],
                    "text": "send mt-cc-amp-vel-sens"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-259",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5455.0,
                        278.0,
                        55.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        465.0,
                        184.0,
                        50.0,
                        15.0
                    ],
                    "text": "LEGATO"
                }
            },
            {
                "box": {
                    "id": "obj-260",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5465.0,
                        298.0,
                        20.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        470.0,
                        207.0,
                        20.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-261",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5455.0,
                        358.0,
                        122.5,
                        22.0
                    ],
                    "text": "send mt-cc-legato"
                }
            },
            {
                "box": {
                    "fontname": "Arial Bold",
                    "fontsize": 11.0,
                    "id": "obj-262",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5535.0,
                        260.0,
                        80.0,
                        18.0
                    ],
                    "text": "LFO"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-263",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5535.0,
                        278.0,
                        55.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        695.0,
                        184.0,
                        50.0,
                        17.0
                    ],
                    "text": "WAVE"
                }
            },
            {
                "box": {
                    "id": "obj-264",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5535.0,
                        298.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        695.0,
                        202.0,
                        40.0,
                        40.0
                    ],
                    "size": 128.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-265",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5535.0,
                        358.0,
                        109.5,
                        22.0
                    ],
                    "text": "scale 0 127 0 5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-266",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5535.0,
                        340.0,
                        45.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        695.0,
                        244.0,
                        45.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-267",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5535.0,
                        378.0,
                        135.5,
                        22.0
                    ],
                    "text": "send mt-cc-lfo-wave"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-268",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5595.0,
                        278.0,
                        55.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        750.0,
                        184.0,
                        50.0,
                        15.0
                    ],
                    "text": "KEY TR"
                }
            },
            {
                "box": {
                    "id": "obj-269",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5605.0,
                        298.0,
                        20.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        755.0,
                        207.0,
                        20.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-270",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5595.0,
                        358.0,
                        155.0,
                        22.0
                    ],
                    "text": "send mt-cc-lfo-keytrig"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-271",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5655.0,
                        278.0,
                        60.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        790.0,
                        184.0,
                        55.0,
                        15.0
                    ],
                    "text": "VCO2 O"
                }
            },
            {
                "box": {
                    "id": "obj-272",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5665.0,
                        298.0,
                        20.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        795.0,
                        207.0,
                        20.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-273",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5655.0,
                        358.0,
                        161.5,
                        22.0
                    ],
                    "text": "send mt-cc-lfo-vco2only"
                }
            },
            {
                "box": {
                    "fontname": "Arial Bold",
                    "fontsize": 11.0,
                    "id": "obj-274",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5715.0,
                        260.0,
                        80.0,
                        18.0
                    ],
                    "text": "PERF"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-275",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5715.0,
                        278.0,
                        55.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        950.0,
                        184.0,
                        50.0,
                        17.0
                    ],
                    "text": "GLD TYP"
                }
            },
            {
                "box": {
                    "id": "obj-276",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5715.0,
                        298.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        950.0,
                        202.0,
                        40.0,
                        40.0
                    ],
                    "size": 128.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-277",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5715.0,
                        358.0,
                        109.5,
                        22.0
                    ],
                    "text": "scale 0 127 0 2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-278",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5715.0,
                        340.0,
                        45.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        950.0,
                        244.0,
                        45.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-279",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5715.0,
                        378.0,
                        148.5,
                        22.0
                    ],
                    "text": "send mt-cc-glide-type"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-280",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        5775.0,
                        278.0,
                        55.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        278.0,
                        50.0,
                        17.0
                    ],
                    "text": "MOD WH"
                }
            },
            {
                "box": {
                    "id": "obj-281",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5775.0,
                        298.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        296.0,
                        40.0,
                        40.0
                    ],
                    "size": 128.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-282",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5775.0,
                        358.0,
                        122.5,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-283",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        5775.0,
                        340.0,
                        45.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        338.0,
                        45.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-284",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5775.0,
                        378.0,
                        122.5,
                        22.0
                    ],
                    "text": "send mt-mod-wheel"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-101",
                        0
                    ],
                    "midpoints": [
                        2964.5,
                        144.0,
                        2979.5,
                        144.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-100",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-214",
                        0
                    ],
                    "midpoints": [
                        2964.5,
                        144.0,
                        2964.5,
                        144.0
                    ],
                    "order": 1,
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
                        2964.5,
                        54.0,
                        2964.5,
                        54.0
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
                        "obj-200",
                        0
                    ],
                    "midpoints": [
                        2964.5,
                        99.0,
                        2964.5,
                        99.0
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
                        3114.5,
                        102.0,
                        3102.0,
                        102.0,
                        3102.0,
                        117.0,
                        3114.5,
                        117.0
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
                        "obj-107",
                        0
                    ],
                    "midpoints": [
                        3114.5,
                        144.0,
                        3129.5,
                        144.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-106",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-215",
                        0
                    ],
                    "midpoints": [
                        3114.5,
                        144.0,
                        3114.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-106",
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
                        3114.5,
                        54.0,
                        3114.5,
                        54.0
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
                        "obj-199",
                        0
                    ],
                    "midpoints": [
                        3114.5,
                        99.0,
                        3114.5,
                        99.0
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
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        999.5,
                        102.0,
                        987.0,
                        102.0,
                        987.0,
                        117.0,
                        999.5,
                        117.0
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
                        "obj-112",
                        0
                    ],
                    "midpoints": [
                        3264.5,
                        102.0,
                        3252.0,
                        102.0,
                        3252.0,
                        117.0,
                        3264.5,
                        117.0
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
                        "obj-113",
                        0
                    ],
                    "midpoints": [
                        3264.5,
                        144.0,
                        3279.5,
                        144.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-112",
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
                        3264.5,
                        144.0,
                        3264.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-112",
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
                        3264.5,
                        54.0,
                        3264.5,
                        54.0
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
                        "obj-198",
                        0
                    ],
                    "midpoints": [
                        3264.5,
                        99.0,
                        3264.5,
                        99.0
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
                        5259.5,
                        27.0,
                        5259.5,
                        27.0
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
                        "obj-121",
                        0
                    ],
                    "midpoints": [
                        3414.5,
                        102.0,
                        3402.0,
                        102.0,
                        3402.0,
                        117.0,
                        3414.5,
                        117.0
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
                        "obj-122",
                        0
                    ],
                    "midpoints": [
                        3414.5,
                        144.0,
                        3429.5,
                        144.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-121",
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
                        3414.5,
                        144.0,
                        3414.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-121",
                        0
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
                        3414.5,
                        54.0,
                        3414.5,
                        54.0
                    ],
                    "source": [
                        "obj-123",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-197",
                        0
                    ],
                    "midpoints": [
                        3414.5,
                        99.0,
                        3414.5,
                        99.0
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
                        "obj-127",
                        0
                    ],
                    "midpoints": [
                        3564.5,
                        102.0,
                        3552.0,
                        102.0,
                        3552.0,
                        117.0,
                        3564.5,
                        117.0
                    ],
                    "source": [
                        "obj-125",
                        0
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
                        3564.5,
                        144.0,
                        3579.5,
                        144.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-127",
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
                        3564.5,
                        144.0,
                        3564.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-127",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-130",
                        0
                    ],
                    "midpoints": [
                        3564.5,
                        54.0,
                        3564.5,
                        54.0
                    ],
                    "source": [
                        "obj-129",
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
                        999.5,
                        144.0,
                        1014.5,
                        144.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-13",
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
                        999.5,
                        144.0,
                        999.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-13",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-196",
                        0
                    ],
                    "midpoints": [
                        3564.5,
                        99.0,
                        3564.5,
                        99.0
                    ],
                    "source": [
                        "obj-130",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-142",
                        0
                    ],
                    "midpoints": [
                        3714.5,
                        51.0,
                        3714.5,
                        51.0
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
                        "obj-143",
                        0
                    ],
                    "midpoints": [
                        3714.5,
                        99.0,
                        3714.5,
                        99.0
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
                        "obj-2",
                        0
                    ],
                    "midpoints": [
                        3714.5,
                        129.0,
                        3714.5,
                        129.0
                    ],
                    "source": [
                        "obj-143",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-145",
                        0
                    ],
                    "midpoints": [
                        3864.5,
                        51.0,
                        3864.5,
                        51.0
                    ],
                    "source": [
                        "obj-144",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-146",
                        0
                    ],
                    "midpoints": [
                        3864.5,
                        99.0,
                        3864.5,
                        99.0
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
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        3864.5,
                        129.0,
                        3864.5,
                        129.0
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
                    "midpoints": [
                        3999.5,
                        51.0,
                        3999.5,
                        51.0
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
                        "obj-149",
                        0
                    ],
                    "midpoints": [
                        3999.5,
                        99.0,
                        3999.5,
                        99.0
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
                        3999.5,
                        129.0,
                        3999.5,
                        129.0
                    ],
                    "source": [
                        "obj-149",
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
                        999.5,
                        54.0,
                        999.5,
                        54.0
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
                        "obj-151",
                        0
                    ],
                    "midpoints": [
                        4134.5,
                        51.0,
                        4134.5,
                        51.0
                    ],
                    "source": [
                        "obj-150",
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
                        4134.5,
                        99.0,
                        4134.5,
                        99.0
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        4134.5,
                        129.0,
                        4134.5,
                        129.0
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
                        "obj-154",
                        0
                    ],
                    "midpoints": [
                        4284.5,
                        51.0,
                        4284.5,
                        51.0
                    ],
                    "source": [
                        "obj-153",
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
                        4284.5,
                        99.0,
                        4284.5,
                        99.0
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
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        4284.5,
                        129.0,
                        4284.5,
                        129.0
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
                        "obj-157",
                        0
                    ],
                    "midpoints": [
                        4419.5,
                        51.0,
                        4419.5,
                        51.0
                    ],
                    "source": [
                        "obj-156",
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
                        4419.5,
                        99.0,
                        4419.5,
                        99.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        4419.5,
                        129.0,
                        4419.5,
                        129.0
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
                        "obj-160",
                        0
                    ],
                    "midpoints": [
                        4554.5,
                        51.0,
                        4554.5,
                        51.0
                    ],
                    "source": [
                        "obj-159",
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
                        999.5,
                        99.0,
                        999.5,
                        99.0
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
                        "obj-161",
                        0
                    ],
                    "midpoints": [
                        4554.5,
                        99.0,
                        4554.5,
                        99.0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        4554.5,
                        129.0,
                        4554.5,
                        129.0
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
                        "obj-163",
                        0
                    ],
                    "midpoints": [
                        4704.5,
                        51.0,
                        4704.5,
                        51.0
                    ],
                    "source": [
                        "obj-162",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-164",
                        0
                    ],
                    "midpoints": [
                        4704.5,
                        99.0,
                        4704.5,
                        99.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        4704.5,
                        129.0,
                        4704.5,
                        129.0
                    ],
                    "source": [
                        "obj-164",
                        0
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
                        39.5,
                        54.0,
                        39.5,
                        54.0
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
                        "obj-168",
                        0
                    ],
                    "midpoints": [
                        143.5,
                        99.0,
                        102.0,
                        99.0,
                        102.0,
                        117.0,
                        99.5,
                        117.0
                    ],
                    "source": [
                        "obj-167",
                        7
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
                        128.64285714285714,
                        117.0,
                        159.5,
                        117.0
                    ],
                    "source": [
                        "obj-167",
                        6
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
                        113.78571428571429,
                        99.0,
                        219.5,
                        99.0
                    ],
                    "source": [
                        "obj-167",
                        5
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
                        98.92857142857143,
                        99.0,
                        264.5,
                        99.0
                    ],
                    "source": [
                        "obj-167",
                        4
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
                        84.07142857142857,
                        99.0,
                        324.5,
                        99.0
                    ],
                    "source": [
                        "obj-167",
                        3
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
                        69.21428571428572,
                        99.0,
                        384.5,
                        99.0
                    ],
                    "source": [
                        "obj-167",
                        2
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
                        54.35714285714286,
                        99.0,
                        429.5,
                        99.0
                    ],
                    "source": [
                        "obj-167",
                        1
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
                        39.5,
                        99.0,
                        15.0,
                        99.0,
                        15.0,
                        15.0,
                        489.5,
                        15.0
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
                        "obj-169",
                        0
                    ],
                    "midpoints": [
                        99.5,
                        144.0,
                        84.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-168",
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
                        99.5,
                        144.0,
                        177.0,
                        144.0,
                        177.0,
                        186.0,
                        1599.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-168",
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
                        1149.5,
                        102.0,
                        1137.0,
                        102.0,
                        1137.0,
                        117.0,
                        1149.5,
                        117.0
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
                        "obj-171",
                        0
                    ],
                    "midpoints": [
                        159.5,
                        144.0,
                        189.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-170",
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
                        159.5,
                        144.0,
                        177.0,
                        144.0,
                        177.0,
                        186.0,
                        3564.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-170",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-173",
                        0
                    ],
                    "midpoints": [
                        219.5,
                        144.0,
                        309.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-172",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-203",
                        0
                    ],
                    "midpoints": [
                        219.5,
                        144.0,
                        291.0,
                        144.0,
                        291.0,
                        186.0,
                        1299.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-172",
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
                        264.5,
                        144.0,
                        414.5,
                        144.0
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
                        "obj-204",
                        0
                    ],
                    "midpoints": [
                        264.5,
                        144.0,
                        291.0,
                        144.0,
                        291.0,
                        186.0,
                        1449.5,
                        186.0
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
                        324.5,
                        144.0,
                        372.0,
                        144.0,
                        372.0,
                        105.0,
                        534.5,
                        105.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-176",
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
                        324.5,
                        144.0,
                        297.0,
                        144.0,
                        297.0,
                        186.0,
                        2814.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-176",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-179",
                        0
                    ],
                    "midpoints": [
                        384.5,
                        144.0,
                        417.0,
                        144.0,
                        417.0,
                        105.0,
                        639.5,
                        105.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-178",
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
                        384.5,
                        144.0,
                        519.0,
                        144.0,
                        519.0,
                        186.0,
                        2364.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-178",
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
                        429.5,
                        144.0,
                        477.0,
                        144.0,
                        477.0,
                        105.0,
                        759.5,
                        105.0
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
                        "obj-207",
                        0
                    ],
                    "midpoints": [
                        429.5,
                        144.0,
                        519.0,
                        144.0,
                        519.0,
                        186.0,
                        1914.5,
                        186.0
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
                        489.5,
                        144.0,
                        522.0,
                        144.0,
                        522.0,
                        183.0,
                        747.0,
                        183.0,
                        747.0,
                        135.0,
                        864.5,
                        135.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-182",
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
                        489.5,
                        144.0,
                        519.0,
                        144.0,
                        519.0,
                        186.0,
                        999.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-182",
                        0
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
                        2814.5,
                        129.0,
                        2790.0,
                        129.0,
                        2790.0,
                        57.0,
                        2814.5,
                        57.0
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
                        "obj-83",
                        0
                    ],
                    "midpoints": [
                        2664.5,
                        129.0,
                        2640.0,
                        129.0,
                        2640.0,
                        57.0,
                        2664.5,
                        57.0
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
                        "obj-77",
                        0
                    ],
                    "midpoints": [
                        2514.5,
                        129.0,
                        2490.0,
                        129.0,
                        2490.0,
                        57.0,
                        2514.5,
                        57.0
                    ],
                    "source": [
                        "obj-186",
                        0
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
                        2364.5,
                        129.0,
                        2340.0,
                        129.0,
                        2340.0,
                        57.0,
                        2364.5,
                        57.0
                    ],
                    "source": [
                        "obj-187",
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
                        2214.5,
                        129.0,
                        2190.0,
                        129.0,
                        2190.0,
                        57.0,
                        2214.5,
                        57.0
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
                        "obj-59",
                        0
                    ],
                    "midpoints": [
                        2064.5,
                        129.0,
                        2040.0,
                        129.0,
                        2040.0,
                        57.0,
                        2064.5,
                        57.0
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
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        1149.5,
                        144.0,
                        1164.5,
                        144.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-19",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-202",
                        0
                    ],
                    "midpoints": [
                        1149.5,
                        144.0,
                        1149.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-19",
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
                        1914.5,
                        129.0,
                        1890.0,
                        129.0,
                        1890.0,
                        57.0,
                        1914.5,
                        57.0
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
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        1764.5,
                        129.0,
                        1740.0,
                        129.0,
                        1740.0,
                        57.0,
                        1764.5,
                        57.0
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
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        1449.5,
                        129.0,
                        1425.0,
                        129.0,
                        1425.0,
                        57.0,
                        1449.5,
                        57.0
                    ],
                    "source": [
                        "obj-192",
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
                        1299.5,
                        129.0,
                        1275.0,
                        129.0,
                        1275.0,
                        57.0,
                        1299.5,
                        57.0
                    ],
                    "source": [
                        "obj-193",
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
                        1149.5,
                        129.0,
                        1125.0,
                        129.0,
                        1125.0,
                        57.0,
                        1149.5,
                        57.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        999.5,
                        129.0,
                        975.0,
                        129.0,
                        975.0,
                        57.0,
                        999.5,
                        57.0
                    ],
                    "source": [
                        "obj-195",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-125",
                        0
                    ],
                    "midpoints": [
                        3564.5,
                        129.0,
                        3540.0,
                        129.0,
                        3540.0,
                        57.0,
                        3564.5,
                        57.0
                    ],
                    "source": [
                        "obj-196",
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
                        3414.5,
                        129.0,
                        3390.0,
                        129.0,
                        3390.0,
                        57.0,
                        3414.5,
                        57.0
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
                        "obj-110",
                        0
                    ],
                    "midpoints": [
                        3264.5,
                        129.0,
                        3240.0,
                        129.0,
                        3240.0,
                        57.0,
                        3264.5,
                        57.0
                    ],
                    "source": [
                        "obj-198",
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
                        3114.5,
                        129.0,
                        3090.0,
                        129.0,
                        3090.0,
                        57.0,
                        3114.5,
                        57.0
                    ],
                    "source": [
                        "obj-199",
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
                        2964.5,
                        129.0,
                        2940.0,
                        129.0,
                        2940.0,
                        57.0,
                        2964.5,
                        57.0
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
                        "obj-22",
                        0
                    ],
                    "midpoints": [
                        1149.5,
                        54.0,
                        1149.5,
                        54.0
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
                        "obj-220",
                        0
                    ],
                    "midpoints": [
                        4839.5,
                        150.0,
                        4839.5,
                        150.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-219",
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
                        5156.5,
                        159.0,
                        5059.5,
                        159.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-219",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-227",
                        1
                    ],
                    "midpoints": [
                        5156.5,
                        150.0,
                        5156.5,
                        150.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-219",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-228",
                        1
                    ],
                    "midpoints": [
                        4839.5,
                        150.0,
                        4815.0,
                        150.0,
                        4815.0,
                        267.0,
                        5098.5,
                        267.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-219",
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
                        1149.5,
                        99.0,
                        1149.5,
                        99.0
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
                        "obj-221",
                        0
                    ],
                    "midpoints": [
                        4839.5,
                        189.0,
                        4839.5,
                        189.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-220",
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
                        4839.5,
                        198.0,
                        4939.5,
                        198.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-220",
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
                        4839.5,
                        228.0,
                        4839.5,
                        228.0
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
                        "obj-225",
                        0
                    ],
                    "midpoints": [
                        5059.5,
                        189.0,
                        5059.5,
                        189.0
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
                        "obj-24",
                        0
                    ],
                    "midpoints": [
                        4839.5,
                        27.0,
                        4839.5,
                        27.0
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
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        4974.5,
                        27.0,
                        4974.5,
                        27.0
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
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        1299.5,
                        102.0,
                        1287.0,
                        102.0,
                        1287.0,
                        117.0,
                        1299.5,
                        117.0
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
                        "obj-203",
                        0
                    ],
                    "midpoints": [
                        1299.5,
                        144.0,
                        1299.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-31",
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
                        1299.5,
                        144.0,
                        1314.5,
                        144.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-31",
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
                        1299.5,
                        54.0,
                        1299.5,
                        54.0
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
                        "obj-193",
                        0
                    ],
                    "midpoints": [
                        1299.5,
                        99.0,
                        1299.5,
                        99.0
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
                        "obj-37",
                        0
                    ],
                    "midpoints": [
                        1449.5,
                        102.0,
                        1437.0,
                        102.0,
                        1437.0,
                        117.0,
                        1449.5,
                        117.0
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
                        "obj-204",
                        0
                    ],
                    "midpoints": [
                        1449.5,
                        144.0,
                        1449.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-37",
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
                        1449.5,
                        144.0,
                        1464.5,
                        144.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-37",
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
                        1449.5,
                        54.0,
                        1449.5,
                        54.0
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
                        "obj-192",
                        0
                    ],
                    "midpoints": [
                        1449.5,
                        99.0,
                        1449.5,
                        99.0
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
                        "obj-43",
                        0
                    ],
                    "midpoints": [
                        1599.5,
                        102.0,
                        1599.5,
                        102.0
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
                        "obj-205",
                        0
                    ],
                    "midpoints": [
                        1599.5,
                        144.0,
                        1599.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-43",
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
                        1599.5,
                        144.0,
                        1614.5,
                        144.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-43",
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
                        1764.5,
                        102.0,
                        1752.0,
                        102.0,
                        1752.0,
                        117.0,
                        1764.5,
                        117.0
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
                        "obj-206",
                        0
                    ],
                    "midpoints": [
                        1764.5,
                        144.0,
                        1740.0,
                        144.0,
                        1740.0,
                        186.0,
                        1764.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-49",
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
                        1764.5,
                        144.0,
                        1764.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-49",
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
                        1764.5,
                        54.0,
                        1764.5,
                        54.0
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
                        "obj-191",
                        0
                    ],
                    "midpoints": [
                        1764.5,
                        99.0,
                        1764.5,
                        99.0
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
                        "obj-55",
                        0
                    ],
                    "midpoints": [
                        1914.5,
                        102.0,
                        1902.0,
                        102.0,
                        1902.0,
                        117.0,
                        1914.5,
                        117.0
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
                        "obj-207",
                        0
                    ],
                    "midpoints": [
                        1914.5,
                        144.0,
                        1902.0,
                        144.0,
                        1902.0,
                        186.0,
                        1914.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-55",
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
                        1914.5,
                        144.0,
                        1914.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-55",
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
                        1914.5,
                        54.0,
                        1914.5,
                        54.0
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
                        "obj-190",
                        0
                    ],
                    "midpoints": [
                        1914.5,
                        99.0,
                        1914.5,
                        99.0
                    ],
                    "source": [
                        "obj-58",
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
                        2064.5,
                        102.0,
                        2052.0,
                        102.0,
                        2052.0,
                        117.0,
                        2064.5,
                        117.0
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
                        "obj-208",
                        0
                    ],
                    "midpoints": [
                        2064.5,
                        144.0,
                        2040.0,
                        144.0,
                        2040.0,
                        186.0,
                        2064.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-61",
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
                        2064.5,
                        144.0,
                        2064.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-61",
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
                        2064.5,
                        54.0,
                        2064.5,
                        54.0
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
                        "obj-189",
                        0
                    ],
                    "midpoints": [
                        2064.5,
                        99.0,
                        2064.5,
                        99.0
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
                        "obj-67",
                        0
                    ],
                    "midpoints": [
                        2214.5,
                        102.0,
                        2202.0,
                        102.0,
                        2202.0,
                        117.0,
                        2214.5,
                        117.0
                    ],
                    "source": [
                        "obj-65",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-209",
                        0
                    ],
                    "midpoints": [
                        2214.5,
                        144.0,
                        2190.0,
                        144.0,
                        2190.0,
                        186.0,
                        2214.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-67",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-68",
                        0
                    ],
                    "midpoints": [
                        2214.5,
                        144.0,
                        2214.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-67",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-70",
                        0
                    ],
                    "midpoints": [
                        2214.5,
                        54.0,
                        2214.5,
                        54.0
                    ],
                    "source": [
                        "obj-69",
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
                        2214.5,
                        99.0,
                        2214.5,
                        99.0
                    ],
                    "source": [
                        "obj-70",
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
                        2364.5,
                        102.0,
                        2352.0,
                        102.0,
                        2352.0,
                        117.0,
                        2364.5,
                        117.0
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
                        "obj-210",
                        0
                    ],
                    "midpoints": [
                        2364.5,
                        144.0,
                        2340.0,
                        144.0,
                        2340.0,
                        186.0,
                        2364.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-73",
                        0
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
                        2364.5,
                        144.0,
                        2364.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-73",
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
                        2364.5,
                        54.0,
                        2364.5,
                        54.0
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
                        "obj-187",
                        0
                    ],
                    "midpoints": [
                        2364.5,
                        99.0,
                        2364.5,
                        99.0
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
                        "obj-79",
                        0
                    ],
                    "midpoints": [
                        2514.5,
                        102.0,
                        2502.0,
                        102.0,
                        2502.0,
                        117.0,
                        2514.5,
                        117.0
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
                        "obj-211",
                        0
                    ],
                    "midpoints": [
                        2514.5,
                        144.0,
                        2490.0,
                        144.0,
                        2490.0,
                        186.0,
                        2514.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-79",
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
                        2514.5,
                        144.0,
                        2514.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-79",
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
                        2514.5,
                        54.0,
                        2514.5,
                        54.0
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
                        "obj-186",
                        0
                    ],
                    "midpoints": [
                        2514.5,
                        99.0,
                        2514.5,
                        99.0
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
                        "obj-85",
                        0
                    ],
                    "midpoints": [
                        2664.5,
                        102.0,
                        2652.0,
                        102.0,
                        2652.0,
                        117.0,
                        2664.5,
                        117.0
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
                        "obj-212",
                        0
                    ],
                    "midpoints": [
                        2664.5,
                        144.0,
                        2640.0,
                        144.0,
                        2640.0,
                        186.0,
                        2664.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-85",
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
                        2664.5,
                        144.0,
                        2664.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-85",
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
                        2664.5,
                        54.0,
                        2664.5,
                        54.0
                    ],
                    "source": [
                        "obj-87",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-185",
                        0
                    ],
                    "midpoints": [
                        2664.5,
                        99.0,
                        2664.5,
                        99.0
                    ],
                    "source": [
                        "obj-88",
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
                        2814.5,
                        102.0,
                        2802.0,
                        102.0,
                        2802.0,
                        117.0,
                        2814.5,
                        117.0
                    ],
                    "source": [
                        "obj-89",
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
                        2814.5,
                        144.0,
                        2790.0,
                        144.0,
                        2790.0,
                        186.0,
                        2814.5,
                        186.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-91",
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
                        2814.5,
                        144.0,
                        2814.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-91",
                        0
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
                        2814.5,
                        54.0,
                        2814.5,
                        54.0
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
                        "obj-184",
                        0
                    ],
                    "midpoints": [
                        2814.5,
                        99.0,
                        2814.5,
                        99.0
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
                        5109.5,
                        27.0,
                        5109.5,
                        27.0
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
                        2964.5,
                        102.0,
                        2952.0,
                        102.0,
                        2952.0,
                        117.0,
                        2964.5,
                        117.0
                    ],
                    "source": [
                        "obj-98",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-232",
                        0
                    ],
                    "source": [
                        "obj-231",
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
                    "source": [
                        "obj-234",
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
                    "source": [
                        "obj-238",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-240",
                        0
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
                        "obj-241",
                        0
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
                        "obj-245",
                        0
                    ],
                    "source": [
                        "obj-244",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-246",
                        0
                    ],
                    "source": [
                        "obj-245",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-247",
                        0
                    ],
                    "source": [
                        "obj-245",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-250",
                        0
                    ],
                    "source": [
                        "obj-249",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-251",
                        0
                    ],
                    "source": [
                        "obj-250",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-252",
                        0
                    ],
                    "source": [
                        "obj-250",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-256",
                        0
                    ],
                    "source": [
                        "obj-255",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-257",
                        0
                    ],
                    "source": [
                        "obj-256",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-258",
                        0
                    ],
                    "source": [
                        "obj-256",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-261",
                        0
                    ],
                    "source": [
                        "obj-260",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-265",
                        0
                    ],
                    "source": [
                        "obj-264",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-266",
                        0
                    ],
                    "source": [
                        "obj-265",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-267",
                        0
                    ],
                    "source": [
                        "obj-265",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-270",
                        0
                    ],
                    "source": [
                        "obj-269",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-273",
                        0
                    ],
                    "source": [
                        "obj-272",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-277",
                        0
                    ],
                    "source": [
                        "obj-276",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-278",
                        0
                    ],
                    "source": [
                        "obj-277",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-279",
                        0
                    ],
                    "source": [
                        "obj-277",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-282",
                        0
                    ],
                    "source": [
                        "obj-281",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-283",
                        0
                    ],
                    "source": [
                        "obj-282",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-284",
                        0
                    ],
                    "source": [
                        "obj-282",
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