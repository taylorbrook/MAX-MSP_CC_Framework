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
            929.0,
            672.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "angle": 270.0,
                    "background": 1,
                    "grad1": [
                        0.94,
                        0.94,
                        0.96,
                        1.0
                    ],
                    "grad2": [
                        0.88,
                        0.89,
                        0.92,
                        1.0
                    ],
                    "id": "obj-43",
                    "maxclass": "panel",
                    "mode": 1,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        80.0,
                        694
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        0.0,
                        80.0,
                        694
                    ],
                    "proportion": 0.39,
                    "rounded": 7
                }
            },
            {
                "box": {
                    "comment": "Audio Input Left",
                    "id": "obj-1",
                    "index": 1,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        140.0,
                        13.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "comment": "Audio Input Right",
                    "id": "obj-2",
                    "index": 2,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210.0,
                        13.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "comment": "Insert Return Left",
                    "id": "obj-3",
                    "index": 3,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        350.0,
                        13.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "comment": "Insert Return Right",
                    "id": "obj-4",
                    "index": 4,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        410.0,
                        13.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        165.0,
                        13.0,
                        65.0,
                        20.0
                    ],
                    "text": "Audio L"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        235.0,
                        13.0,
                        65.0,
                        20.0
                    ],
                    "text": "Audio R"
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
                        13.0,
                        79.0,
                        20.0
                    ],
                    "text": "Ins Ret L"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        435.0,
                        13.0,
                        79.0,
                        20.0
                    ],
                    "text": "Ins Ret R"
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        310.0,
                        43.0,
                        36.0,
                        36.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        36.0,
                        24.0,
                        36.0,
                        36.0
                    ],
                    "varname": "trim"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-10",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        360.0,
                        53.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 2."
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
                        140.0,
                        53.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~ 1."
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
                        210.0,
                        53.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~ 1."
                }
            },
            {
                "box": {
                    "id": "obj-13",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        391.0,
                        102.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        30.0,
                        64.0,
                        20.0,
                        20.0
                    ],
                    "varname": "ins"
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
                        "int"
                    ],
                    "patching_rect": [
                        426.0,
                        103.0,
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
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        140.0,
                        103.0,
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
                    "id": "obj-16",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        210.0,
                        103.0,
                        160.0,
                        22.0
                    ],
                    "text": "selector~ 2"
                }
            },
            {
                "box": {
                    "id": "obj-17",
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
                        310.0,
                        158.0,
                        36.0,
                        130.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        22.0,
                        100.0,
                        36.0,
                        220.0
                    ],
                    "varname": "fader"
                }
            },
            {
                "box": {
                    "id": "obj-19",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        310.0,
                        313.0,
                        36.0,
                        36.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        36.0,
                        326.0,
                        36.0,
                        36.0
                    ],
                    "varname": "pan"
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
                        "float"
                    ],
                    "patching_rect": [
                        360.0,
                        313.0,
                        40.5,
                        22.0
                    ],
                    "text": "/ 127."
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
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        360.0,
                        338.0,
                        36.0,
                        22.0
                    ],
                    "text": "t f f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        360.0,
                        363.0,
                        32.5,
                        22.0
                    ],
                    "text": "!- 1."
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
                        "signal"
                    ],
                    "patching_rect": [
                        140.0,
                        338.0,
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
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        210.0,
                        338.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "obj-25",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        310.0,
                        383.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        24.0,
                        370.0,
                        20.0,
                        20.0
                    ],
                    "varname": "mute"
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
                        140.0,
                        383.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~ 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-28",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        210.0,
                        383.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~ 1."
                }
            },
            {
                "box": {
                    "id": "obj-29",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        140.0,
                        428.0,
                        24.0,
                        80.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        8.0,
                        400.0,
                        28.0,
                        90.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-30",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        210.0,
                        428.0,
                        24.0,
                        80.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        44.0,
                        400.0,
                        28.0,
                        90.0
                    ]
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
                        310.0,
                        428.0,
                        92.0,
                        22.0
                    ],
                    "text": "send~ master-L"
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
                        310.0,
                        453.0,
                        94.0,
                        22.0
                    ],
                    "text": "send~ master-R"
                }
            },
            {
                "box": {
                    "comment": "Post-Fader Output Left",
                    "id": "obj-33",
                    "index": 1,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        140.0,
                        523.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "comment": "Post-Fader Output Right",
                    "id": "obj-34",
                    "index": 2,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        210.0,
                        523.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "comment": "Pre-Fader Send Left",
                    "id": "obj-35",
                    "index": 3,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        310.0,
                        523.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "comment": "Pre-Fader Send Right",
                    "id": "obj-36",
                    "index": 4,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        370.0,
                        523.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-37",
                    "maxclass": "newobj",
                    "numinlets": 7,
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
                            100.0,
                            100.0,
                            1275.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        15.0,
                                        30.0,
                                        30.0
                                    ]
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
                                        60.0,
                                        15.0,
                                        51.0,
                                        20.0
                                    ],
                                    "text": "Pre L"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-3",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        216.0,
                                        15.0,
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
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        246.0,
                                        15.0,
                                        51.0,
                                        20.0
                                    ],
                                    "text": "Pre R"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-5",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        402.0,
                                        15.0,
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
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        432.0,
                                        15.0,
                                        79.0,
                                        20.0
                                    ],
                                    "text": "PostFdr L"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-7",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        588.0,
                                        15.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        618.0,
                                        15.0,
                                        79.0,
                                        20.0
                                    ],
                                    "text": "PostFdr R"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-9",
                                    "index": 5,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        774.0,
                                        15.0,
                                        30.0,
                                        30.0
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
                                        804.0,
                                        15.0,
                                        79.0,
                                        20.0
                                    ],
                                    "text": "PostPan L"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-11",
                                    "index": 6,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        960.0,
                                        15.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        990.0,
                                        15.0,
                                        79.0,
                                        20.0
                                    ],
                                    "text": "PostPan R"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        55.0,
                                        58.0,
                                        20.0
                                    ],
                                    "text": "Send 1",
                                    "textcolor": [
                                        0.3,
                                        0.3,
                                        0.35,
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
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        110.0,
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
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "float"
                                    ],
                                    "patching_rect": [
                                        80.0,
                                        120.0,
                                        40.5,
                                        22.0
                                    ],
                                    "text": "/ 127."
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
                                    "patching_rect": [
                                        30.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-19",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        95.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
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
                                        30.0,
                                        185.0,
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
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        95.0,
                                        185.0,
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
                                    "id": "obj-22",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-1-L"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        95.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-1-R"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-24",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        170.0,
                                        55.0,
                                        58.0,
                                        20.0
                                    ],
                                    "text": "Send 2",
                                    "textcolor": [
                                        0.3,
                                        0.3,
                                        0.35,
                                        1.0
                                    ]
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
                                        170.0,
                                        110.0,
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
                                    "id": "obj-28",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "float"
                                    ],
                                    "patching_rect": [
                                        220.0,
                                        120.0,
                                        40.5,
                                        22.0
                                    ],
                                    "text": "/ 127."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-29",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        170.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-30",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        235.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
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
                                        170.0,
                                        185.0,
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
                                    "id": "obj-32",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        235.0,
                                        185.0,
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
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        170.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-2-L"
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
                                        235.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-2-R"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-35",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        310.0,
                                        55.0,
                                        58.0,
                                        20.0
                                    ],
                                    "text": "Send 3",
                                    "textcolor": [
                                        0.3,
                                        0.3,
                                        0.35,
                                        1.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-37",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        310.0,
                                        110.0,
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
                                    "id": "obj-39",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "float"
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        120.0,
                                        40.5,
                                        22.0
                                    ],
                                    "text": "/ 127."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-40",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        310.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-41",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-42",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        310.0,
                                        185.0,
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
                                    "id": "obj-43",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        185.0,
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
                                    "id": "obj-44",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        310.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-3-L"
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
                                        375.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-3-R"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-46",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        450.0,
                                        55.0,
                                        58.0,
                                        20.0
                                    ],
                                    "text": "Send 4",
                                    "textcolor": [
                                        0.3,
                                        0.3,
                                        0.35,
                                        1.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-48",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        110.0,
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
                                    "id": "obj-50",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "float"
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        120.0,
                                        40.5,
                                        22.0
                                    ],
                                    "text": "/ 127."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-51",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-52",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        515.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-53",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        185.0,
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
                                    "id": "obj-54",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        515.0,
                                        185.0,
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
                                    "id": "obj-55",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        450.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-4-L"
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
                                        515.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-4-R"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-57",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        590.0,
                                        55.0,
                                        58.0,
                                        20.0
                                    ],
                                    "text": "Send 5",
                                    "textcolor": [
                                        0.3,
                                        0.3,
                                        0.35,
                                        1.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-59",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        590.0,
                                        110.0,
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
                                    "id": "obj-61",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "float"
                                    ],
                                    "patching_rect": [
                                        640.0,
                                        120.0,
                                        40.5,
                                        22.0
                                    ],
                                    "text": "/ 127."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-62",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        590.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-63",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        655.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
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
                                        590.0,
                                        185.0,
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
                                    "id": "obj-65",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        655.0,
                                        185.0,
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
                                    "id": "obj-66",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        590.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-5-L"
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
                                        655.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-5-R"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-68",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        730.0,
                                        55.0,
                                        58.0,
                                        20.0
                                    ],
                                    "text": "Send 6",
                                    "textcolor": [
                                        0.3,
                                        0.3,
                                        0.35,
                                        1.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-70",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        730.0,
                                        110.0,
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
                                    "id": "obj-72",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "float"
                                    ],
                                    "patching_rect": [
                                        780.0,
                                        120.0,
                                        40.5,
                                        22.0
                                    ],
                                    "text": "/ 127."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-73",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        730.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-74",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        795.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-75",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        730.0,
                                        185.0,
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
                                    "id": "obj-76",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        795.0,
                                        185.0,
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
                                    "id": "obj-77",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        730.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-6-L"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-78",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        795.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-6-R"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-79",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        870.0,
                                        55.0,
                                        58.0,
                                        20.0
                                    ],
                                    "text": "Send 7",
                                    "textcolor": [
                                        0.3,
                                        0.3,
                                        0.35,
                                        1.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-81",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        870.0,
                                        110.0,
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
                                    "id": "obj-83",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "float"
                                    ],
                                    "patching_rect": [
                                        920.0,
                                        120.0,
                                        40.5,
                                        22.0
                                    ],
                                    "text": "/ 127."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-84",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        870.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-85",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        935.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        870.0,
                                        185.0,
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
                                    "id": "obj-87",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        935.0,
                                        185.0,
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
                                    "id": "obj-88",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        870.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-7-L"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-89",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        935.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-7-R"
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
                                        1010.0,
                                        55.0,
                                        58.0,
                                        20.0
                                    ],
                                    "text": "Send 8",
                                    "textcolor": [
                                        0.3,
                                        0.3,
                                        0.35,
                                        1.0
                                    ]
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
                                        1010.0,
                                        110.0,
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
                                    "id": "obj-94",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "float"
                                    ],
                                    "patching_rect": [
                                        1060.0,
                                        120.0,
                                        40.5,
                                        22.0
                                    ],
                                    "text": "/ 127."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-95",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1010.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-96",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1075.0,
                                        150.0,
                                        160.0,
                                        22.0
                                    ],
                                    "text": "selector~ 3 1"
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1010.0,
                                        185.0,
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
                                    "id": "obj-98",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1075.0,
                                        185.0,
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
                                    "id": "obj-99",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        1010.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-8-L"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-100",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        1075.0,
                                        215.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-8-R"
                                }
                            },
                            {
                                "box": {
                                    "comment": "Send control: level N (0-127), tap N (0 Pre, 1 Post, 2 Pan)",
                                    "id": "obj-101",
                                    "index": 7,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1050.0,
                                        15.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-104",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1050,
                                        255,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "route level tap",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-105",
                                    "numinlets": 1,
                                    "numoutlets": 9,
                                    "outlettype": [
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
                                        1050,
                                        285,
                                        163.0,
                                        22.0
                                    ],
                                    "text": "route 1 2 3 4 5 6 7 8",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-106",
                                    "numinlets": 1,
                                    "numoutlets": 9,
                                    "outlettype": [
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
                                        1050,
                                        315,
                                        163.0,
                                        22.0
                                    ],
                                    "text": "route 1 2 3 4 5 6 7 8",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-18",
                                        1
                                    ],
                                    "midpoints": [
                                        39.5,
                                        97.5,
                                        86.5,
                                        97.5
                                    ],
                                    "order": 7,
                                    "source": [
                                        "obj-1",
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
                                    "midpoints": [
                                        39.5,
                                        97.5,
                                        226.5,
                                        97.5
                                    ],
                                    "order": 6,
                                    "source": [
                                        "obj-1",
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
                                    "midpoints": [
                                        39.5,
                                        97.5,
                                        366.5,
                                        97.5
                                    ],
                                    "order": 5,
                                    "source": [
                                        "obj-1",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-51",
                                        1
                                    ],
                                    "midpoints": [
                                        39.5,
                                        97.5,
                                        506.5,
                                        97.5
                                    ],
                                    "order": 4,
                                    "source": [
                                        "obj-1",
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
                                        39.5,
                                        97.5,
                                        646.5,
                                        97.5
                                    ],
                                    "order": 3,
                                    "source": [
                                        "obj-1",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-73",
                                        1
                                    ],
                                    "midpoints": [
                                        39.5,
                                        97.5,
                                        786.5,
                                        97.5
                                    ],
                                    "order": 2,
                                    "source": [
                                        "obj-1",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-84",
                                        1
                                    ],
                                    "midpoints": [
                                        39.5,
                                        97.5,
                                        926.5,
                                        97.5
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-1",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-95",
                                        1
                                    ],
                                    "midpoints": [
                                        39.5,
                                        97.5,
                                        1066.5,
                                        97.5
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-1",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-19",
                                        3
                                    ],
                                    "midpoints": [
                                        969.5,
                                        97.5,
                                        245.5,
                                        97.5
                                    ],
                                    "order": 7,
                                    "source": [
                                        "obj-11",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-30",
                                        3
                                    ],
                                    "midpoints": [
                                        969.5,
                                        97.5,
                                        385.5,
                                        97.5
                                    ],
                                    "order": 6,
                                    "source": [
                                        "obj-11",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-41",
                                        3
                                    ],
                                    "midpoints": [
                                        969.5,
                                        97.5,
                                        525.5,
                                        97.5
                                    ],
                                    "order": 5,
                                    "source": [
                                        "obj-11",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-52",
                                        3
                                    ],
                                    "midpoints": [
                                        969.5,
                                        97.5,
                                        665.5,
                                        97.5
                                    ],
                                    "order": 4,
                                    "source": [
                                        "obj-11",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-63",
                                        3
                                    ],
                                    "midpoints": [
                                        969.5,
                                        97.5,
                                        805.5,
                                        97.5
                                    ],
                                    "order": 3,
                                    "source": [
                                        "obj-11",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-74",
                                        3
                                    ],
                                    "midpoints": [
                                        969.5,
                                        97.5,
                                        945.5,
                                        97.5
                                    ],
                                    "order": 2,
                                    "source": [
                                        "obj-11",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-85",
                                        3
                                    ],
                                    "midpoints": [
                                        969.5,
                                        97.5,
                                        1085.5,
                                        97.5
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-11",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-96",
                                        3
                                    ],
                                    "midpoints": [
                                        969.5,
                                        97.5,
                                        1225.5,
                                        97.5
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-11",
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
                                    "order": 1,
                                    "source": [
                                        "obj-15",
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
                                        39.5,
                                        141.0,
                                        104.5,
                                        141.0
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-15",
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
                                        39.5,
                                        178.5,
                                        39.5,
                                        178.5
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
                                        104.5,
                                        178.5,
                                        104.5,
                                        178.5
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
                                        39.5,
                                        211.0,
                                        39.5,
                                        211.0
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
                                    "midpoints": [
                                        104.5,
                                        211.0,
                                        104.5,
                                        211.0
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
                                        "obj-29",
                                        0
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
                                        "obj-30",
                                        0
                                    ],
                                    "midpoints": [
                                        179.5,
                                        141.0,
                                        244.5,
                                        141.0
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
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        179.5,
                                        178.5,
                                        179.5,
                                        178.5
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
                                        "obj-19",
                                        1
                                    ],
                                    "midpoints": [
                                        225.5,
                                        97.5,
                                        151.5,
                                        97.5
                                    ],
                                    "order": 7,
                                    "source": [
                                        "obj-3",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-30",
                                        1
                                    ],
                                    "midpoints": [
                                        225.5,
                                        97.5,
                                        291.5,
                                        97.5
                                    ],
                                    "order": 6,
                                    "source": [
                                        "obj-3",
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
                                    "midpoints": [
                                        225.5,
                                        97.5,
                                        431.5,
                                        97.5
                                    ],
                                    "order": 5,
                                    "source": [
                                        "obj-3",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-52",
                                        1
                                    ],
                                    "midpoints": [
                                        225.5,
                                        97.5,
                                        571.5,
                                        97.5
                                    ],
                                    "order": 4,
                                    "source": [
                                        "obj-3",
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
                                        225.5,
                                        97.5,
                                        711.5,
                                        97.5
                                    ],
                                    "order": 3,
                                    "source": [
                                        "obj-3",
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
                                        225.5,
                                        97.5,
                                        851.5,
                                        97.5
                                    ],
                                    "order": 2,
                                    "source": [
                                        "obj-3",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-85",
                                        1
                                    ],
                                    "midpoints": [
                                        225.5,
                                        97.5,
                                        991.5,
                                        97.5
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-3",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-96",
                                        1
                                    ],
                                    "midpoints": [
                                        225.5,
                                        97.5,
                                        1131.5,
                                        97.5
                                    ],
                                    "order": 0,
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
                                    "midpoints": [
                                        244.5,
                                        178.5,
                                        244.5,
                                        178.5
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
                                        "obj-33",
                                        0
                                    ],
                                    "midpoints": [
                                        179.5,
                                        211.0,
                                        179.5,
                                        211.0
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
                                        "obj-34",
                                        0
                                    ],
                                    "midpoints": [
                                        244.5,
                                        211.0,
                                        244.5,
                                        211.0
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
                                        "obj-40",
                                        0
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
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        319.5,
                                        141.0,
                                        384.5,
                                        141.0
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
                                        "obj-42",
                                        1
                                    ],
                                    "midpoints": [
                                        369.5,
                                        163.5,
                                        342.5,
                                        163.5
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-39",
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
                                        369.5,
                                        163.5,
                                        407.5,
                                        163.5
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-39",
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
                                        319.5,
                                        178.5,
                                        319.5,
                                        178.5
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
                                        384.5,
                                        178.5,
                                        384.5,
                                        178.5
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
                                        319.5,
                                        211.0,
                                        319.5,
                                        211.0
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
                                        "obj-45",
                                        0
                                    ],
                                    "midpoints": [
                                        384.5,
                                        211.0,
                                        384.5,
                                        211.0
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
                                        "obj-51",
                                        0
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-48",
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
                                        459.5,
                                        141.0,
                                        524.5,
                                        141.0
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-48",
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
                                        411.5,
                                        97.5,
                                        133.5,
                                        97.5
                                    ],
                                    "order": 7,
                                    "source": [
                                        "obj-5",
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
                                    "midpoints": [
                                        411.5,
                                        97.5,
                                        273.5,
                                        97.5
                                    ],
                                    "order": 6,
                                    "source": [
                                        "obj-5",
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
                                    "order": 5,
                                    "source": [
                                        "obj-5",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-51",
                                        2
                                    ],
                                    "midpoints": [
                                        411.5,
                                        97.5,
                                        553.5,
                                        97.5
                                    ],
                                    "order": 4,
                                    "source": [
                                        "obj-5",
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
                                        411.5,
                                        97.5,
                                        693.5,
                                        97.5
                                    ],
                                    "order": 3,
                                    "source": [
                                        "obj-5",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-73",
                                        2
                                    ],
                                    "midpoints": [
                                        411.5,
                                        97.5,
                                        833.5,
                                        97.5
                                    ],
                                    "order": 2,
                                    "source": [
                                        "obj-5",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-84",
                                        2
                                    ],
                                    "midpoints": [
                                        411.5,
                                        97.5,
                                        973.5,
                                        97.5
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-5",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-95",
                                        2
                                    ],
                                    "midpoints": [
                                        411.5,
                                        97.5,
                                        1113.5,
                                        97.5
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-5",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-53",
                                        1
                                    ],
                                    "midpoints": [
                                        509.5,
                                        163.5,
                                        482.5,
                                        163.5
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-50",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-54",
                                        1
                                    ],
                                    "midpoints": [
                                        509.5,
                                        163.5,
                                        547.5,
                                        163.5
                                    ],
                                    "order": 0,
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
                                        459.5,
                                        178.5,
                                        459.5,
                                        178.5
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
                                        "obj-54",
                                        0
                                    ],
                                    "midpoints": [
                                        524.5,
                                        178.5,
                                        524.5,
                                        178.5
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
                                        459.5,
                                        211.0,
                                        459.5,
                                        211.0
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
                                        0
                                    ],
                                    "midpoints": [
                                        524.5,
                                        211.0,
                                        524.5,
                                        211.0
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
                                        "obj-62",
                                        0
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-59",
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
                                        599.5,
                                        141.0,
                                        664.5,
                                        141.0
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-59",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-64",
                                        1
                                    ],
                                    "midpoints": [
                                        649.5,
                                        163.5,
                                        622.5,
                                        163.5
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
                                        "obj-65",
                                        1
                                    ],
                                    "midpoints": [
                                        649.5,
                                        163.5,
                                        687.5,
                                        163.5
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
                                        "obj-64",
                                        0
                                    ],
                                    "midpoints": [
                                        599.5,
                                        178.5,
                                        599.5,
                                        178.5
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
                                        "obj-65",
                                        0
                                    ],
                                    "midpoints": [
                                        664.5,
                                        178.5,
                                        664.5,
                                        178.5
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
                                        "obj-66",
                                        0
                                    ],
                                    "midpoints": [
                                        599.5,
                                        211.0,
                                        599.5,
                                        211.0
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
                                        664.5,
                                        211.0,
                                        664.5,
                                        211.0
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
                                        "obj-19",
                                        2
                                    ],
                                    "midpoints": [
                                        597.5,
                                        97.5,
                                        198.5,
                                        97.5
                                    ],
                                    "order": 7,
                                    "source": [
                                        "obj-7",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-30",
                                        2
                                    ],
                                    "midpoints": [
                                        597.5,
                                        97.5,
                                        338.5,
                                        97.5
                                    ],
                                    "order": 6,
                                    "source": [
                                        "obj-7",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-41",
                                        2
                                    ],
                                    "midpoints": [
                                        597.5,
                                        97.5,
                                        478.5,
                                        97.5
                                    ],
                                    "order": 5,
                                    "source": [
                                        "obj-7",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-52",
                                        2
                                    ],
                                    "order": 4,
                                    "source": [
                                        "obj-7",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-63",
                                        2
                                    ],
                                    "midpoints": [
                                        597.5,
                                        97.5,
                                        758.5,
                                        97.5
                                    ],
                                    "order": 3,
                                    "source": [
                                        "obj-7",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-74",
                                        2
                                    ],
                                    "midpoints": [
                                        597.5,
                                        97.5,
                                        898.5,
                                        97.5
                                    ],
                                    "order": 2,
                                    "source": [
                                        "obj-7",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-85",
                                        2
                                    ],
                                    "midpoints": [
                                        597.5,
                                        97.5,
                                        1038.5,
                                        97.5
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
                                        "obj-96",
                                        2
                                    ],
                                    "midpoints": [
                                        597.5,
                                        97.5,
                                        1178.5,
                                        97.5
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
                                        "obj-73",
                                        0
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-70",
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
                                        739.5,
                                        141.0,
                                        804.5,
                                        141.0
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-70",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-75",
                                        1
                                    ],
                                    "midpoints": [
                                        789.5,
                                        163.5,
                                        762.5,
                                        163.5
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-72",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-76",
                                        1
                                    ],
                                    "midpoints": [
                                        789.5,
                                        163.5,
                                        827.5,
                                        163.5
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-72",
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
                                        739.5,
                                        178.5,
                                        739.5,
                                        178.5
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
                                        "obj-76",
                                        0
                                    ],
                                    "midpoints": [
                                        804.5,
                                        178.5,
                                        804.5,
                                        178.5
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
                                        "obj-77",
                                        0
                                    ],
                                    "midpoints": [
                                        739.5,
                                        211.0,
                                        739.5,
                                        211.0
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
                                        "obj-78",
                                        0
                                    ],
                                    "midpoints": [
                                        804.5,
                                        211.0,
                                        804.5,
                                        211.0
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
                                        "obj-84",
                                        0
                                    ],
                                    "order": 1,
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
                                        879.5,
                                        141.0,
                                        944.5,
                                        141.0
                                    ],
                                    "order": 0,
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
                                        1
                                    ],
                                    "midpoints": [
                                        929.5,
                                        163.5,
                                        902.5,
                                        163.5
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-83",
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
                                        929.5,
                                        163.5,
                                        967.5,
                                        163.5
                                    ],
                                    "order": 0,
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
                                        0
                                    ],
                                    "midpoints": [
                                        879.5,
                                        178.5,
                                        879.5,
                                        178.5
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
                                        "obj-87",
                                        0
                                    ],
                                    "midpoints": [
                                        944.5,
                                        178.5,
                                        944.5,
                                        178.5
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
                                        "obj-88",
                                        0
                                    ],
                                    "midpoints": [
                                        879.5,
                                        211.0,
                                        879.5,
                                        211.0
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
                                        "obj-89",
                                        0
                                    ],
                                    "midpoints": [
                                        944.5,
                                        211.0,
                                        944.5,
                                        211.0
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
                                        "obj-18",
                                        3
                                    ],
                                    "midpoints": [
                                        783.5,
                                        97.5,
                                        180.5,
                                        97.5
                                    ],
                                    "order": 7,
                                    "source": [
                                        "obj-9",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-29",
                                        3
                                    ],
                                    "midpoints": [
                                        783.5,
                                        97.5,
                                        320.5,
                                        97.5
                                    ],
                                    "order": 6,
                                    "source": [
                                        "obj-9",
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
                                    "midpoints": [
                                        783.5,
                                        97.5,
                                        460.5,
                                        97.5
                                    ],
                                    "order": 5,
                                    "source": [
                                        "obj-9",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-51",
                                        3
                                    ],
                                    "midpoints": [
                                        783.5,
                                        97.5,
                                        600.5,
                                        97.5
                                    ],
                                    "order": 4,
                                    "source": [
                                        "obj-9",
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
                                        783.5,
                                        97.5,
                                        740.5,
                                        97.5
                                    ],
                                    "order": 3,
                                    "source": [
                                        "obj-9",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-73",
                                        3
                                    ],
                                    "midpoints": [
                                        783.5,
                                        97.5,
                                        880.5,
                                        97.5
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
                                        "obj-84",
                                        3
                                    ],
                                    "midpoints": [
                                        783.5,
                                        97.5,
                                        1020.5,
                                        97.5
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
                                        "obj-95",
                                        3
                                    ],
                                    "midpoints": [
                                        783.5,
                                        97.5,
                                        1160.5,
                                        97.5
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-9",
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
                                    "order": 1,
                                    "source": [
                                        "obj-92",
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
                                        1019.5,
                                        141.0,
                                        1084.5,
                                        141.0
                                    ],
                                    "order": 0,
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
                                        1
                                    ],
                                    "midpoints": [
                                        1069.5,
                                        163.5,
                                        1042.5,
                                        163.5
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-94",
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
                                        1069.5,
                                        163.5,
                                        1107.5,
                                        163.5
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-94",
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
                                        1019.5,
                                        178.5,
                                        1019.5,
                                        178.5
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
                                        0
                                    ],
                                    "midpoints": [
                                        1084.5,
                                        178.5,
                                        1084.5,
                                        178.5
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
                                        "obj-99",
                                        0
                                    ],
                                    "midpoints": [
                                        1019.5,
                                        211.0,
                                        1019.5,
                                        211.0
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
                                        "obj-100",
                                        0
                                    ],
                                    "midpoints": [
                                        1084.5,
                                        211.0,
                                        1084.5,
                                        211.0
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
                                        "obj-101",
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
                                        "obj-104",
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
                                        "obj-104",
                                        1
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
                                        "obj-105",
                                        0
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
                                        "obj-106",
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
                                        "obj-105",
                                        1
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
                                        "obj-106",
                                        1
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
                                        "obj-105",
                                        2
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
                                        "obj-106",
                                        2
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
                                        "obj-105",
                                        3
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
                                        "obj-106",
                                        3
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
                                        "obj-105",
                                        4
                                    ],
                                    "destination": [
                                        "obj-61",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-106",
                                        4
                                    ],
                                    "destination": [
                                        "obj-59",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-105",
                                        5
                                    ],
                                    "destination": [
                                        "obj-72",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-106",
                                        5
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
                                        "obj-105",
                                        6
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
                                        "obj-106",
                                        6
                                    ],
                                    "destination": [
                                        "obj-81",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-105",
                                        7
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
                                        "obj-106",
                                        7
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
                                        "obj-17",
                                        0
                                    ],
                                    "destination": [
                                        "obj-20",
                                        1
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
                                        "obj-21",
                                        1
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
                                        1
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
                                        "obj-32",
                                        1
                                    ]
                                }
                            }
                        ],
                        "editing_bgcolor": [
                            0.333,
                            0.333,
                            0.333,
                            1.0
                        ]
                    },
                    "patching_rect": [
                        20,
                        780,
                        200.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "editing_bgcolor": [
                            0.333,
                            0.333,
                            0.333,
                            1.0
                        ]
                    },
                    "text": "p sends",
                    "varname": "sends"
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
                    "id": "obj-38",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        530.0,
                        13.0,
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
                    "id": "obj-39",
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
                        530.0,
                        38.0,
                        52.0,
                        22.0
                    ],
                    "text": "t b b b b b b"
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
                        530.0,
                        68.0,
                        40.0,
                        22.0
                    ],
                    "text": "128"
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
                        580.0,
                        68.0,
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
                    "id": "obj-42",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630.0,
                        68.0,
                        40.0,
                        22.0
                    ],
                    "text": "64"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-44",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        5.0,
                        70.0,
                        20.0
                    ],
                    "text": "Ch 1",
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-45",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        44.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        28.0,
                        25.0,
                        15.0
                    ],
                    "text": "Gain",
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-46",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        67.0,
                        19.0,
                        15.0
                    ],
                    "text": "Ins",
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-47",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        95.0,
                        20.0,
                        15.0
                    ],
                    "text": "+6",
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-48",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        135.63694267515922,
                        20.0,
                        15.0
                    ],
                    "text": "0",
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-49",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        174.87261146496814,
                        20.0,
                        15.0
                    ],
                    "text": "-6",
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-50",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        197.29299363057325,
                        20.0,
                        15.0
                    ],
                    "text": "-12",
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-51",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        236.52866242038218,
                        20.0,
                        15.0
                    ],
                    "text": "-24",
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-52",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        295.38216560509557,
                        20.0,
                        15.0
                    ],
                    "text": "-48",
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-53",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        330.0,
                        23.0,
                        15.0
                    ],
                    "text": "Pan",
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "id": "obj-54",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        372.0,
                        15.0,
                        15.0
                    ],
                    "text": "M",
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-55",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        681.0,
                        68.0,
                        135.0,
                        22.0
                    ],
                    "text": "set Ch #1"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-56",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        0.0,
                        0.0,
                        70.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        494.0,
                        70.0,
                        17.0
                    ],
                    "text": "Sends",
                    "textcolor": [
                        0.2,
                        0.25,
                        0.42,
                        1.0
                    ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "id": "obj-57",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        20,
                        620,
                        20,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        512.0,
                        20.0,
                        20.0
                    ],
                    "varname": "send1"
                }
            },
            {
                "box": {
                    "id": "obj-58",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        125,
                        620,
                        20,
                        20
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        534.0,
                        20.0,
                        20.0
                    ],
                    "varname": "send2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-63",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        740.0,
                        68.0,
                        29.5,
                        22.0
                    ],
                    "text": "0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-64",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        800.0,
                        68.0,
                        29.5,
                        22.0
                    ],
                    "text": "0"
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-66",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        350.0,
                        408.0,
                        65.0,
                        22.0
                    ],
                    "text": "$1 5",
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
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        350.0,
                        433.0,
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
                    "maxclass": "gain~",
                    "id": "obj-68",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        260,
                        158,
                        22,
                        130
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-69",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        20,
                        13,
                        94.0,
                        22.0
                    ],
                    "text": "receive~ #2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-70",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        20,
                        78,
                        94.0,
                        22.0
                    ],
                    "text": "receive~ #3",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-71",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        600,
                        110,
                        184.0,
                        22.0
                    ],
                    "text": "autopattr @autorestore 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-72",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        20,
                        650,
                        60,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        39.0,
                        513.0,
                        38.0,
                        18.0
                    ],
                    "varname": "tap1",
                    "fontsize": 8.0,
                    "items": [
                        "Pre",
                        ",",
                        "Post",
                        ",",
                        "Pan"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-73",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20,
                        690,
                        121.0,
                        22.0
                    ],
                    "text": "prepend level 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-74",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20,
                        715,
                        107.0,
                        22.0
                    ],
                    "text": "prepend tap 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-75",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        90,
                        620,
                        40.0,
                        20.0
                    ],
                    "text": "1",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        515.0,
                        13.0,
                        14.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-76",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        125,
                        650,
                        60,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        39.0,
                        535.0,
                        38.0,
                        18.0
                    ],
                    "varname": "tap2",
                    "fontsize": 8.0,
                    "items": [
                        "Pre",
                        ",",
                        "Post",
                        ",",
                        "Pan"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-77",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        125,
                        690,
                        121.0,
                        22.0
                    ],
                    "text": "prepend level 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-78",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        125,
                        715,
                        107.0,
                        22.0
                    ],
                    "text": "prepend tap 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-79",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        195,
                        620,
                        40.0,
                        20.0
                    ],
                    "text": "2",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        537.0,
                        13.0,
                        14.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-80",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        230,
                        620,
                        20,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        556.0,
                        20.0,
                        20.0
                    ],
                    "varname": "send3"
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-81",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        230,
                        650,
                        60,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        39.0,
                        557.0,
                        38.0,
                        18.0
                    ],
                    "varname": "tap3",
                    "fontsize": 8.0,
                    "items": [
                        "Pre",
                        ",",
                        "Post",
                        ",",
                        "Pan"
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
                        230,
                        690,
                        121.0,
                        22.0
                    ],
                    "text": "prepend level 3",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-83",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        230,
                        715,
                        107.0,
                        22.0
                    ],
                    "text": "prepend tap 3",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-84",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        300,
                        620,
                        40.0,
                        20.0
                    ],
                    "text": "3",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        559.0,
                        13.0,
                        14.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-85",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        335,
                        620,
                        20,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        578.0,
                        20.0,
                        20.0
                    ],
                    "varname": "send4"
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-86",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        335,
                        650,
                        60,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        39.0,
                        579.0,
                        38.0,
                        18.0
                    ],
                    "varname": "tap4",
                    "fontsize": 8.0,
                    "items": [
                        "Pre",
                        ",",
                        "Post",
                        ",",
                        "Pan"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-87",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        335,
                        690,
                        121.0,
                        22.0
                    ],
                    "text": "prepend level 4",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-88",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        335,
                        715,
                        107.0,
                        22.0
                    ],
                    "text": "prepend tap 4",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-89",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        405,
                        620,
                        40.0,
                        20.0
                    ],
                    "text": "4",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        581.0,
                        13.0,
                        14.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-90",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        440,
                        620,
                        20,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        600.0,
                        20.0,
                        20.0
                    ],
                    "varname": "send5"
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-91",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        440,
                        650,
                        60,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        39.0,
                        601.0,
                        38.0,
                        18.0
                    ],
                    "varname": "tap5",
                    "fontsize": 8.0,
                    "items": [
                        "Pre",
                        ",",
                        "Post",
                        ",",
                        "Pan"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-92",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        440,
                        690,
                        121.0,
                        22.0
                    ],
                    "text": "prepend level 5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-93",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        440,
                        715,
                        107.0,
                        22.0
                    ],
                    "text": "prepend tap 5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-94",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        510,
                        620,
                        40.0,
                        20.0
                    ],
                    "text": "5",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        603.0,
                        13.0,
                        14.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-95",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        545,
                        620,
                        20,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        622.0,
                        20.0,
                        20.0
                    ],
                    "varname": "send6"
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-96",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        545,
                        650,
                        60,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        39.0,
                        623.0,
                        38.0,
                        18.0
                    ],
                    "varname": "tap6",
                    "fontsize": 8.0,
                    "items": [
                        "Pre",
                        ",",
                        "Post",
                        ",",
                        "Pan"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-97",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        545,
                        690,
                        121.0,
                        22.0
                    ],
                    "text": "prepend level 6",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-98",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        545,
                        715,
                        107.0,
                        22.0
                    ],
                    "text": "prepend tap 6",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-99",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        615,
                        620,
                        40.0,
                        20.0
                    ],
                    "text": "6",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        625.0,
                        13.0,
                        14.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-100",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        650,
                        620,
                        20,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        644.0,
                        20.0,
                        20.0
                    ],
                    "varname": "send7"
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-101",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        650,
                        650,
                        60,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        39.0,
                        645.0,
                        38.0,
                        18.0
                    ],
                    "varname": "tap7",
                    "fontsize": 8.0,
                    "items": [
                        "Pre",
                        ",",
                        "Post",
                        ",",
                        "Pan"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-102",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        650,
                        690,
                        121.0,
                        22.0
                    ],
                    "text": "prepend level 7",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-103",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        650,
                        715,
                        107.0,
                        22.0
                    ],
                    "text": "prepend tap 7",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-104",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        720,
                        620,
                        40.0,
                        20.0
                    ],
                    "text": "7",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        647.0,
                        13.0,
                        14.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-105",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        755,
                        620,
                        20,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        666.0,
                        20.0,
                        20.0
                    ],
                    "varname": "send8"
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-106",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        755,
                        650,
                        60,
                        20
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        39.0,
                        667.0,
                        38.0,
                        18.0
                    ],
                    "varname": "tap8",
                    "fontsize": 8.0,
                    "items": [
                        "Pre",
                        ",",
                        "Post",
                        ",",
                        "Pan"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-107",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        755,
                        690,
                        121.0,
                        22.0
                    ],
                    "text": "prepend level 8",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-108",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        755,
                        715,
                        107.0,
                        22.0
                    ],
                    "text": "prepend tap 8",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-109",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        825,
                        620,
                        40.0,
                        20.0
                    ],
                    "text": "8",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        669.0,
                        13.0,
                        14.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-110",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        470,
                        300,
                        87.5,
                        22.0
                    ],
                    "text": "loadmess 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-111",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        470,
                        330,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        57.0,
                        370.0,
                        20.0,
                        20.0
                    ],
                    "varname": "solo"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-112",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        500,
                        330,
                        40.0,
                        20.0
                    ],
                    "text": "S",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        44.0,
                        372.0,
                        13.0,
                        15.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-113",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        470,
                        355,
                        51.0,
                        22.0
                    ],
                    "text": "t i i",
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
                        560,
                        330,
                        170.0,
                        22.0
                    ],
                    "text": "receive mixer-solo-any",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-115",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        470,
                        385,
                        113.75,
                        22.0
                    ],
                    "text": "pak 0 0 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-116",
                    "numinlets": 9,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        470,
                        410,
                        268.0,
                        22.0
                    ],
                    "text": "expr (1 - $i1) * (($i2 == 0) || $i3)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-117",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        600,
                        385,
                        121.0,
                        22.0
                    ],
                    "text": "prepend solo #1",
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
                        600,
                        410,
                        121.0,
                        22.0
                    ],
                    "text": "send mixer-solo",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        149.5,
                        45.0,
                        149.5,
                        45.0
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
                        1
                    ],
                    "midpoints": [
                        369.5,
                        90.0,
                        192.0,
                        90.0,
                        192.0,
                        48.0,
                        172.5,
                        48.0
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
                        "obj-12",
                        1
                    ],
                    "midpoints": [
                        369.5,
                        90.0,
                        264.0,
                        90.0,
                        264.0,
                        48.0,
                        242.5,
                        48.0
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
                        "obj-15",
                        1
                    ],
                    "midpoints": [
                        149.5,
                        90.0,
                        220.0,
                        90.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-11",
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
                        149.5,
                        90.0,
                        126.0,
                        90.0,
                        126.0,
                        324.0,
                        297.0,
                        324.0,
                        297.0,
                        510.0,
                        319.5,
                        510.0
                    ],
                    "order": 0,
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
                        219.5,
                        90.0,
                        290.0,
                        90.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-12",
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
                        219.5,
                        90.0,
                        378.0,
                        90.0,
                        378.0,
                        300.0,
                        414.0,
                        300.0,
                        414.0,
                        510.0,
                        379.5,
                        510.0
                    ],
                    "order": 0,
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
                        400.5,
                        129.0,
                        423.0,
                        129.0,
                        423.0,
                        99.0,
                        435.5,
                        99.0
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
                        435.5,
                        138.0,
                        126.0,
                        138.0,
                        126.0,
                        99.0,
                        149.5,
                        99.0
                    ],
                    "order": 1,
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
                        435.5,
                        126.0,
                        417.0,
                        126.0,
                        417.0,
                        87.0,
                        219.5,
                        87.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-14",
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
                        149.5,
                        144.0,
                        319.5,
                        144.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-15",
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
                        149.5,
                        300.0,
                        465.5,
                        300.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-15",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-37",
                        1
                    ],
                    "midpoints": [
                        219.5,
                        144.0,
                        501.7,
                        144.0
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        319.5,
                        300.0,
                        149.5,
                        300.0
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
                        "obj-37",
                        2
                    ],
                    "midpoints": [
                        319.5,
                        300.0,
                        537.9,
                        300.0
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
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        319.5,
                        351.0,
                        297.0,
                        351.0,
                        297.0,
                        300.0,
                        369.5,
                        300.0
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        219.5,
                        45.0,
                        219.5,
                        45.0
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
                        369.5,
                        336.0,
                        369.5,
                        336.0
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
                        386.5,
                        360.0,
                        369.5,
                        360.0
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
                        "obj-24",
                        1
                    ],
                    "midpoints": [
                        369.5,
                        360.0,
                        264.0,
                        360.0,
                        264.0,
                        333.0,
                        242.5,
                        333.0
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
                        1
                    ],
                    "midpoints": [
                        369.5,
                        387.0,
                        393.0,
                        387.0,
                        393.0,
                        360.0,
                        264.0,
                        360.0,
                        264.0,
                        324.0,
                        172.5,
                        324.0
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
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        149.5,
                        363.0,
                        149.5,
                        363.0
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
                        "obj-37",
                        4
                    ],
                    "midpoints": [
                        149.5,
                        363.0,
                        195.0,
                        363.0,
                        195.0,
                        510.0,
                        610.3,
                        510.0
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
                        "obj-28",
                        0
                    ],
                    "midpoints": [
                        219.5,
                        363.0,
                        219.5,
                        363.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-24",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-37",
                        5
                    ],
                    "midpoints": [
                        219.5,
                        363.0,
                        297.0,
                        363.0,
                        297.0,
                        510.0,
                        646.5,
                        510.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-24",
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
                        149.5,
                        408.0,
                        149.5,
                        408.0
                    ],
                    "order": 2,
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
                        149.5,
                        417.0,
                        297.0,
                        417.0,
                        297.0,
                        423.0,
                        319.5,
                        423.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-27",
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
                        149.5,
                        408.0,
                        126.0,
                        408.0,
                        126.0,
                        519.0,
                        149.5,
                        519.0
                    ],
                    "order": 1,
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
                        219.5,
                        408.0,
                        219.5,
                        408.0
                    ],
                    "order": 2,
                    "source": [
                        "obj-28",
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
                        417.0,
                        297.0,
                        417.0,
                        297.0,
                        450.0,
                        319.5,
                        450.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-28",
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
                        219.5,
                        408.0,
                        195.0,
                        408.0,
                        195.0,
                        519.0,
                        219.5,
                        519.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-28",
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
                    "midpoints": [
                        359.5,
                        90.0,
                        290.5,
                        90.0
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
                        "obj-39",
                        0
                    ],
                    "midpoints": [
                        539.5,
                        36.0,
                        539.5,
                        36.0
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
                        539.5,
                        63.0,
                        539.5,
                        63.0
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
                        550.5,
                        63.0,
                        589.5,
                        63.0
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
                        561.5,
                        63.0,
                        639.5,
                        63.0
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
                        "obj-55",
                        0
                    ],
                    "midpoints": [
                        572.5,
                        63.0,
                        690.5,
                        63.0
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
                        "obj-16",
                        2
                    ],
                    "midpoints": [
                        419.5,
                        45.0,
                        357.0,
                        45.0,
                        357.0,
                        99.0,
                        360.5,
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
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        539.5,
                        144.0,
                        319.5,
                        144.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        589.5,
                        102.0,
                        516.0,
                        102.0,
                        516.0,
                        0.0,
                        319.5,
                        0.0
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
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        639.5,
                        300.0,
                        319.5,
                        300.0
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
                        690.5,
                        93.0,
                        678.0,
                        93.0,
                        678.0,
                        0.0,
                        45.0,
                        0.0,
                        45.0,
                        -3.0,
                        9.5,
                        -3.0
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
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        319.5,
                        90.0,
                        357.0,
                        90.0,
                        357.0,
                        48.0,
                        369.5,
                        48.0
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
                        "obj-39",
                        4
                    ],
                    "destination": [
                        "obj-63",
                        0
                    ],
                    "midpoints": [
                        583.5,
                        63.0,
                        749.5,
                        63.0
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
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        749.5,
                        96.0,
                        400.5,
                        96.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-39",
                        5
                    ],
                    "destination": [
                        "obj-64",
                        0
                    ],
                    "midpoints": [
                        594.5,
                        63.0,
                        809.5,
                        63.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        809.5,
                        96.0,
                        319.5,
                        96.0,
                        319.5,
                        378.0,
                        319.5,
                        378.0
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
                        "obj-27",
                        1
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
                        "obj-28",
                        1
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
                        "obj-68",
                        0
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
                        "obj-68",
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
                        "obj-24",
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
                        "obj-37",
                        3
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
                        "obj-11",
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
                        "obj-12",
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
                        "obj-73",
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
                        "obj-74",
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
                        "obj-37",
                        6
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
                        "obj-37",
                        6
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
                        "obj-77",
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
                        "obj-78",
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
                        "obj-37",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-78",
                        0
                    ],
                    "destination": [
                        "obj-37",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-80",
                        0
                    ],
                    "destination": [
                        "obj-82",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-81",
                        0
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
                        "obj-82",
                        0
                    ],
                    "destination": [
                        "obj-37",
                        6
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
                        "obj-37",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-85",
                        0
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
                        "obj-86",
                        0
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
                        "obj-87",
                        0
                    ],
                    "destination": [
                        "obj-37",
                        6
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
                        "obj-37",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-90",
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
                        "obj-91",
                        0
                    ],
                    "destination": [
                        "obj-93",
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
                        "obj-37",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-93",
                        0
                    ],
                    "destination": [
                        "obj-37",
                        6
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
                        "obj-97",
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
                        "obj-98",
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
                        "obj-37",
                        6
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
                        "obj-37",
                        6
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
                        "obj-102",
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
                        "obj-103",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-102",
                        0
                    ],
                    "destination": [
                        "obj-37",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-103",
                        0
                    ],
                    "destination": [
                        "obj-37",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-105",
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
                        "obj-106",
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
                        "obj-107",
                        0
                    ],
                    "destination": [
                        "obj-37",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-108",
                        0
                    ],
                    "destination": [
                        "obj-37",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-110",
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
                        "obj-111",
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
                        "obj-113",
                        1
                    ],
                    "destination": [
                        "obj-115",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-113",
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
                        "obj-25",
                        0
                    ],
                    "destination": [
                        "obj-115",
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
                        "obj-115",
                        1
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
                        "obj-66",
                        0
                    ]
                }
            }
        ],
        "editing_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ]
    }
}