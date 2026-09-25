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
                    "background": 1,
                    "id": "obj-43",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1420.0,
                        120.0,
                        80.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        0.0,
                        80.0,
                        694
                    ],
                    "rounded": 7,
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
                    },
                    "border": 0,
                    "ignoreclick": 1
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
                        30.0,
                        35.0,
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
                        300.0,
                        35.0,
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
                        450.0,
                        35.0,
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
                        540.0,
                        35.0,
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
                        30.0,
                        12.0,
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
                        300.0,
                        12.0,
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
                        450.0,
                        12.0,
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
                        540.0,
                        12.0,
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
                        700.0,
                        120.0,
                        36.0,
                        36.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        36.0,
                        26.0,
                        36.0,
                        36.0
                    ],
                    "varname": "trim",
                    "size": 129
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
                        700.0,
                        170.0,
                        111.0,
                        22.0
                    ],
                    "text": "scale 0 128 -20. 20."
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
                        30.0,
                        300.0,
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
                        300.0,
                        300.0,
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
                        700.0,
                        300.0,
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
                        700.0,
                        334.0,
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
                        30.0,
                        420.0,
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
                    "id": "obj-16",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        300.0,
                        420.0,
                        80.0,
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
                        30.0,
                        460.0,
                        36.0,
                        60.0
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
                        1130.0,
                        460.0,
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
                    "varname": "pan",
                    "size": 129
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
                        1130.0,
                        510.0,
                        40.5,
                        22.0
                    ],
                    "text": "/ 128."
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
                        1130.0,
                        540.0,
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
                    "id": "obj-23",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        30.0,
                        730.0,
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
                        300.0,
                        730.0,
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
                        700.0,
                        460.0,
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
                        30.0,
                        680.0,
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
                        300.0,
                        680.0,
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
                        72.0,
                        780.0,
                        24.0,
                        60.0
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
                        342.0,
                        780.0,
                        24.0,
                        60.0
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
                        104.0,
                        780.0,
                        92.0,
                        22.0
                    ],
                    "text": "send~ master-L",
                    "varname": "tomasterL"
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
                        374.0,
                        780.0,
                        94.0,
                        22.0
                    ],
                    "text": "send~ master-R",
                    "varname": "tomasterR"
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
                        30.0,
                        780.0,
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
                        300.0,
                        780.0,
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
                        470.0,
                        420.0,
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
                        560.0,
                        420.0,
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
                                        50.0,
                                        40.0,
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
                                        50.0,
                                        16.0,
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
                                        140.0,
                                        40.0,
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
                                        140.0,
                                        16.0,
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
                                        230.0,
                                        40.0,
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
                                        230.0,
                                        16.0,
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
                                        320.0,
                                        40.0,
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
                                        320.0,
                                        16.0,
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
                                        410.0,
                                        40.0,
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
                                        410.0,
                                        16.0,
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
                                        500.0,
                                        40.0,
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
                                        500.0,
                                        16.0,
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
                                        40.0,
                                        225.0,
                                        46.0,
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
                                        90.0,
                                        250.0,
                                        28.0,
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
                                        30.0,
                                        250.0,
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
                                        90.0,
                                        350.0,
                                        96.0,
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
                                        190.0,
                                        350.0,
                                        96.0,
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
                                        90.0,
                                        400.0,
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
                                        190.0,
                                        400.0,
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
                                        90.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-1-L",
                                    "varname": "bus1L"
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
                                        190.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-1-R",
                                    "varname": "bus1R"
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
                                        310.0,
                                        225.0,
                                        46.0,
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
                                        360.0,
                                        250.0,
                                        28.0,
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
                                        300.0,
                                        250.0,
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
                                        360.0,
                                        350.0,
                                        96.0,
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
                                        460.0,
                                        350.0,
                                        96.0,
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
                                        360.0,
                                        400.0,
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
                                        460.0,
                                        400.0,
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
                                        360.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-2-L",
                                    "varname": "bus2L"
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
                                        460.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-2-R",
                                    "varname": "bus2R"
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
                                        580.0,
                                        225.0,
                                        46.0,
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
                                        630.0,
                                        250.0,
                                        28.0,
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
                                        570.0,
                                        250.0,
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
                                        630.0,
                                        350.0,
                                        96.0,
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
                                        730.0,
                                        350.0,
                                        96.0,
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
                                        630.0,
                                        400.0,
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
                                        730.0,
                                        400.0,
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
                                        630.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-3-L",
                                    "varname": "bus3L"
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
                                        730.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-3-R",
                                    "varname": "bus3R"
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
                                        850.0,
                                        225.0,
                                        46.0,
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
                                        900.0,
                                        250.0,
                                        28.0,
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
                                        840.0,
                                        250.0,
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
                                        900.0,
                                        350.0,
                                        96.0,
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
                                        1000.0,
                                        350.0,
                                        96.0,
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
                                        900.0,
                                        400.0,
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
                                        1000.0,
                                        400.0,
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
                                        900.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-4-L",
                                    "varname": "bus4L"
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
                                        1000.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-4-R",
                                    "varname": "bus4R"
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
                                        1120.0,
                                        225.0,
                                        46.0,
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
                                        1170.0,
                                        250.0,
                                        28.0,
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
                                        1110.0,
                                        250.0,
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
                                        1170.0,
                                        350.0,
                                        96.0,
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
                                        1270.0,
                                        350.0,
                                        96.0,
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
                                        1170.0,
                                        400.0,
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
                                        1270.0,
                                        400.0,
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
                                        1170.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-5-L",
                                    "varname": "bus5L"
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
                                        1270.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-5-R",
                                    "varname": "bus5R"
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
                                        1390.0,
                                        225.0,
                                        46.0,
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
                                        1440.0,
                                        250.0,
                                        28.0,
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
                                        1380.0,
                                        250.0,
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
                                        1440.0,
                                        350.0,
                                        96.0,
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
                                        1540.0,
                                        350.0,
                                        96.0,
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
                                        1440.0,
                                        400.0,
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
                                        1540.0,
                                        400.0,
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
                                        1440.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-6-L",
                                    "varname": "bus6L"
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
                                        1540.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-6-R",
                                    "varname": "bus6R"
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
                                        1660.0,
                                        225.0,
                                        46.0,
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
                                        1710.0,
                                        250.0,
                                        28.0,
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
                                        1650.0,
                                        250.0,
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
                                        1710.0,
                                        350.0,
                                        96.0,
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
                                        1810.0,
                                        350.0,
                                        96.0,
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
                                        1710.0,
                                        400.0,
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
                                        1810.0,
                                        400.0,
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
                                        1710.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-7-L",
                                    "varname": "bus7L"
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
                                        1810.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-7-R",
                                    "varname": "bus7R"
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
                                        1930.0,
                                        225.0,
                                        46.0,
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
                                        1980.0,
                                        250.0,
                                        28.0,
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
                                        1920.0,
                                        250.0,
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
                                        1980.0,
                                        350.0,
                                        96.0,
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
                                        2080.0,
                                        350.0,
                                        96.0,
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
                                        1980.0,
                                        400.0,
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
                                        2080.0,
                                        400.0,
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
                                        1980.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-8-L",
                                    "varname": "bus8L"
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
                                        2080.0,
                                        440.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ bus-8-R",
                                    "varname": "bus8R"
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
                                        600.0,
                                        40.0,
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
                                        600.0,
                                        80.0,
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
                                        600.0,
                                        115.0,
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
                                        800.0,
                                        115.0,
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
                                    "maxclass": "message",
                                    "id": "obj-107",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        280.0,
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
                                    "id": "obj-108",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        310.0,
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
                                    "maxclass": "message",
                                    "id": "obj-109",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        300.0,
                                        280.0,
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
                                    "id": "obj-110",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        300.0,
                                        310.0,
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
                                    "maxclass": "message",
                                    "id": "obj-111",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        280.0,
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
                                    "id": "obj-112",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        310.0,
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
                                    "maxclass": "message",
                                    "id": "obj-113",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        840.0,
                                        280.0,
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
                                    "id": "obj-114",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        840.0,
                                        310.0,
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
                                    "maxclass": "message",
                                    "id": "obj-115",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1110.0,
                                        280.0,
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
                                    "id": "obj-116",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1110.0,
                                        310.0,
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
                                    "maxclass": "message",
                                    "id": "obj-117",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1380.0,
                                        280.0,
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
                                    "id": "obj-118",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1380.0,
                                        310.0,
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
                                    "maxclass": "message",
                                    "id": "obj-119",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1650.0,
                                        280.0,
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
                                    "id": "obj-120",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1650.0,
                                        310.0,
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
                                    "maxclass": "message",
                                    "id": "obj-121",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1920.0,
                                        280.0,
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
                                    "id": "obj-122",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1920.0,
                                        310.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "line~",
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
                                        54.0,
                                        175.0,
                                        123.33333333333333,
                                        175.0
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
                                        54.0,
                                        175.0,
                                        393.3333333333333,
                                        175.0
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
                                        54.0,
                                        175.0,
                                        663.3333333333334,
                                        175.0
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
                                        54.0,
                                        175.0,
                                        933.3333333333334,
                                        175.0
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
                                        54.0,
                                        175.0,
                                        1203.3333333333333,
                                        175.0
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
                                        54.0,
                                        175.0,
                                        1473.3333333333333,
                                        175.0
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
                                        54.0,
                                        175.0,
                                        1743.3333333333333,
                                        175.0
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
                                        54.0,
                                        175.0,
                                        2013.3333333333333,
                                        175.0
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
                                        504.0,
                                        215.0,
                                        282.0,
                                        215.0
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
                                        504.0,
                                        215.0,
                                        552.0,
                                        215.0
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
                                        504.0,
                                        215.0,
                                        822.0,
                                        215.0
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
                                        504.0,
                                        215.0,
                                        1092.0,
                                        215.0
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
                                        504.0,
                                        215.0,
                                        1362.0,
                                        215.0
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
                                        504.0,
                                        215.0,
                                        1632.0,
                                        215.0
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
                                        504.0,
                                        215.0,
                                        1902.0,
                                        215.0
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
                                        504.0,
                                        215.0,
                                        2172.0,
                                        215.0
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
                                        94.0,
                                        346.0,
                                        194.0,
                                        346.0
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
                                        364.0,
                                        346.0,
                                        464.0,
                                        346.0
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
                                        144.0,
                                        183.0,
                                        223.33333333333334,
                                        183.0
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
                                        144.0,
                                        183.0,
                                        493.3333333333333,
                                        183.0
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
                                        144.0,
                                        183.0,
                                        763.3333333333334,
                                        183.0
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
                                        144.0,
                                        183.0,
                                        1033.3333333333333,
                                        183.0
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
                                        144.0,
                                        183.0,
                                        1303.3333333333333,
                                        183.0
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
                                        144.0,
                                        183.0,
                                        1573.3333333333333,
                                        183.0
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
                                        144.0,
                                        183.0,
                                        1843.3333333333333,
                                        183.0
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
                                        144.0,
                                        183.0,
                                        2113.3333333333335,
                                        183.0
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
                                        634.0,
                                        346.0,
                                        734.0,
                                        346.0
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
                                        "obj-43",
                                        0
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
                                        904.0,
                                        346.0,
                                        1004.0,
                                        346.0
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
                                        234.0,
                                        191.0,
                                        152.66666666666666,
                                        191.0
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
                                        234.0,
                                        191.0,
                                        422.6666666666667,
                                        191.0
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
                                    ],
                                    "midpoints": [
                                        234.0,
                                        191.0,
                                        692.6666666666666,
                                        191.0
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
                                        234.0,
                                        191.0,
                                        962.6666666666666,
                                        191.0
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
                                        234.0,
                                        191.0,
                                        1232.6666666666667,
                                        191.0
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
                                        234.0,
                                        191.0,
                                        1502.6666666666667,
                                        191.0
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
                                        234.0,
                                        191.0,
                                        1772.6666666666667,
                                        191.0
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
                                        234.0,
                                        191.0,
                                        2042.6666666666667,
                                        191.0
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
                                        0
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
                                        1174.0,
                                        346.0,
                                        1274.0,
                                        346.0
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
                                        0
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
                                        324.0,
                                        199.0,
                                        252.66666666666666,
                                        199.0
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
                                        324.0,
                                        199.0,
                                        522.6666666666666,
                                        199.0
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
                                        324.0,
                                        199.0,
                                        792.6666666666666,
                                        199.0
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
                                    ],
                                    "midpoints": [
                                        324.0,
                                        199.0,
                                        1062.6666666666667,
                                        199.0
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
                                        324.0,
                                        199.0,
                                        1332.6666666666667,
                                        199.0
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
                                        324.0,
                                        199.0,
                                        1602.6666666666667,
                                        199.0
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
                                        324.0,
                                        199.0,
                                        1872.6666666666667,
                                        199.0
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
                                        324.0,
                                        199.0,
                                        2142.6666666666665,
                                        199.0
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
                                        1444.0,
                                        346.0,
                                        1544.0,
                                        346.0
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
                                        0
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
                                        1714.0,
                                        346.0,
                                        1814.0,
                                        346.0
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
                                        0
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
                                        414.0,
                                        207.0,
                                        182.0,
                                        207.0
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
                                        414.0,
                                        207.0,
                                        452.0,
                                        207.0
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
                                        414.0,
                                        207.0,
                                        722.0,
                                        207.0
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
                                        414.0,
                                        207.0,
                                        992.0,
                                        207.0
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
                                        414.0,
                                        207.0,
                                        1262.0,
                                        207.0
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
                                        414.0,
                                        207.0,
                                        1532.0,
                                        207.0
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
                                        414.0,
                                        207.0,
                                        1802.0,
                                        207.0
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
                                        414.0,
                                        207.0,
                                        2072.0,
                                        207.0
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
                                        1984.0,
                                        346.0,
                                        2084.0,
                                        346.0
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
                                        0
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
                                    ],
                                    "midpoints": [
                                        660.5,
                                        106.0,
                                        804.0,
                                        106.0
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
                                    ],
                                    "midpoints": [
                                        604.0,
                                        145.0,
                                        34.0,
                                        145.0
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
                                    ],
                                    "midpoints": [
                                        804.0,
                                        221.0,
                                        94.0,
                                        221.0
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
                                    ],
                                    "midpoints": [
                                        623.4,
                                        169.0,
                                        304.0,
                                        169.0
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
                                    ],
                                    "midpoints": [
                                        823.4,
                                        151.0,
                                        364.0,
                                        151.0
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
                                    ],
                                    "midpoints": [
                                        642.8,
                                        221.0,
                                        574.0,
                                        221.0
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
                                    ],
                                    "midpoints": [
                                        842.8,
                                        163.0,
                                        634.0,
                                        163.0
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
                                    ],
                                    "midpoints": [
                                        662.1,
                                        169.0,
                                        844.0,
                                        169.0
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
                                    ],
                                    "midpoints": [
                                        862.1,
                                        221.0,
                                        904.0,
                                        221.0
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
                                    ],
                                    "midpoints": [
                                        681.5,
                                        157.0,
                                        1114.0,
                                        157.0
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
                                    ],
                                    "midpoints": [
                                        881.5,
                                        169.0,
                                        1174.0,
                                        169.0
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
                                    ],
                                    "midpoints": [
                                        700.9,
                                        145.0,
                                        1384.0,
                                        145.0
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
                                    ],
                                    "midpoints": [
                                        900.9,
                                        151.0,
                                        1444.0,
                                        151.0
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
                                    ],
                                    "midpoints": [
                                        720.2,
                                        221.0,
                                        1654.0,
                                        221.0
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
                                    ],
                                    "midpoints": [
                                        920.2,
                                        163.0,
                                        1714.0,
                                        163.0
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
                                    ],
                                    "midpoints": [
                                        739.6,
                                        169.0,
                                        1924.0,
                                        169.0
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
                                    ],
                                    "midpoints": [
                                        939.6,
                                        157.0,
                                        1984.0,
                                        157.0
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
                                        "obj-107",
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
                                        "obj-108",
                                        0
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
                                        "obj-20",
                                        1
                                    ],
                                    "midpoints": [
                                        34.0,
                                        388.0,
                                        128.0,
                                        388.0
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
                                        "obj-21",
                                        1
                                    ],
                                    "midpoints": [
                                        34.0,
                                        388.0,
                                        228.0,
                                        388.0
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
                                        "obj-109",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-109",
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
                                        "obj-110",
                                        0
                                    ],
                                    "destination": [
                                        "obj-31",
                                        1
                                    ],
                                    "midpoints": [
                                        304.0,
                                        388.0,
                                        398.0,
                                        388.0
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
                                        "obj-32",
                                        1
                                    ],
                                    "midpoints": [
                                        304.0,
                                        388.0,
                                        498.0,
                                        388.0
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
                                        "obj-111",
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
                                        "obj-112",
                                        0
                                    ],
                                    "destination": [
                                        "obj-42",
                                        1
                                    ],
                                    "midpoints": [
                                        574.0,
                                        388.0,
                                        668.0,
                                        388.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-112",
                                        0
                                    ],
                                    "destination": [
                                        "obj-43",
                                        1
                                    ],
                                    "midpoints": [
                                        574.0,
                                        388.0,
                                        768.0,
                                        388.0
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
                                        "obj-113",
                                        0
                                    ],
                                    "destination": [
                                        "obj-114",
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
                                        "obj-53",
                                        1
                                    ],
                                    "midpoints": [
                                        844.0,
                                        388.0,
                                        938.0,
                                        388.0
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
                                        "obj-54",
                                        1
                                    ],
                                    "midpoints": [
                                        844.0,
                                        388.0,
                                        1038.0,
                                        388.0
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
                                        "obj-115",
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
                                        "obj-64",
                                        1
                                    ],
                                    "midpoints": [
                                        1114.0,
                                        388.0,
                                        1208.0,
                                        388.0
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
                                        "obj-65",
                                        1
                                    ],
                                    "midpoints": [
                                        1114.0,
                                        388.0,
                                        1308.0,
                                        388.0
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
                                        "obj-118",
                                        0
                                    ],
                                    "destination": [
                                        "obj-75",
                                        1
                                    ],
                                    "midpoints": [
                                        1384.0,
                                        388.0,
                                        1478.0,
                                        388.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-118",
                                        0
                                    ],
                                    "destination": [
                                        "obj-76",
                                        1
                                    ],
                                    "midpoints": [
                                        1384.0,
                                        388.0,
                                        1578.0,
                                        388.0
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
                                        "obj-119",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-119",
                                        0
                                    ],
                                    "destination": [
                                        "obj-120",
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
                                        "obj-86",
                                        1
                                    ],
                                    "midpoints": [
                                        1654.0,
                                        388.0,
                                        1748.0,
                                        388.0
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
                                        "obj-87",
                                        1
                                    ],
                                    "midpoints": [
                                        1654.0,
                                        388.0,
                                        1848.0,
                                        388.0
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
                                        "obj-121",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-121",
                                        0
                                    ],
                                    "destination": [
                                        "obj-122",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-122",
                                        0
                                    ],
                                    "destination": [
                                        "obj-97",
                                        1
                                    ],
                                    "midpoints": [
                                        1924.0,
                                        388.0,
                                        2018.0,
                                        388.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-122",
                                        0
                                    ],
                                    "destination": [
                                        "obj-98",
                                        1
                                    ],
                                    "midpoints": [
                                        1924.0,
                                        388.0,
                                        2118.0,
                                        388.0
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
                        30.0,
                        1340.0,
                        890.0,
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
                        700.0,
                        12.0,
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
                        700.0,
                        42.0,
                        360.0,
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
                        700.0,
                        80.0,
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
                        770.0,
                        80.0,
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
                        840.0,
                        80.0,
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
                        1320.0,
                        120.0,
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
                    "fontsize": 9.0,
                    "id": "obj-45",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        740.0,
                        128.0,
                        44.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        4.0,
                        28,
                        31.0,
                        16.0
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
                    "fontsize": 9.0,
                    "id": "obj-46",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        730.0,
                        304.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        4.0,
                        66,
                        25.0,
                        16.0
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
                    "fontsize": 9.0,
                    "id": "obj-47",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1320.0,
                        150.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        122,
                        22.0,
                        16.0
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
                    "fontsize": 9.0,
                    "id": "obj-48",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1320.0,
                        170.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        136,
                        22.0,
                        16.0
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
                    "fontsize": 9.0,
                    "id": "obj-49",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1320.0,
                        190.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        148,
                        22.0,
                        16.0
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
                    "fontsize": 9.0,
                    "id": "obj-50",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1320.0,
                        210.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        162,
                        22.0,
                        16.0
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
                    "fontsize": 9.0,
                    "id": "obj-51",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1320.0,
                        230.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        190,
                        22.0,
                        16.0
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
                    "fontsize": 9.0,
                    "id": "obj-52",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1320.0,
                        250.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        244,
                        22.0,
                        16.0
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
                    "fontsize": 9.0,
                    "id": "obj-53",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1170.0,
                        468.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        4.0,
                        330,
                        31.0,
                        16.0
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
                    "fontsize": 9.0,
                    "id": "obj-54",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        728.0,
                        464.0,
                        40.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        372,
                        15.0,
                        16.0
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
                        911.0,
                        80.0,
                        62.0,
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
                        700.0,
                        730.0,
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
                        700.0,
                        760.0,
                        20.0,
                        20.0
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
                        700.0,
                        830.0,
                        20.0,
                        20.0
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
                        981.0,
                        80.0,
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
                        1052.0,
                        80.0,
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
                        700.0,
                        610.0,
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
                        700.0,
                        640.0,
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
                        300.0,
                        535.0,
                        22.0,
                        60.0
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
                        70.0,
                        75.0,
                        94.0,
                        22.0
                    ],
                    "text": "receive~ #2",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "varname": "inL"
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
                        340.0,
                        75.0,
                        94.0,
                        22.0
                    ],
                    "text": "receive~ #3",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "varname": "inR"
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
                        1160.0,
                        12.0,
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
                        810.0,
                        760.0,
                        60.0,
                        20.0
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
                        700.0,
                        790.0,
                        100.0,
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
                        810.0,
                        790.0,
                        100.0,
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
                        726.0,
                        760.0,
                        30.0,
                        20.0
                    ],
                    "text": "1",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        514,
                        13.0,
                        16.0
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
                        810.0,
                        830.0,
                        60.0,
                        20.0
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
                        700.0,
                        860.0,
                        100.0,
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
                        810.0,
                        860.0,
                        100.0,
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
                        726.0,
                        830.0,
                        30.0,
                        20.0
                    ],
                    "text": "2",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        536,
                        13.0,
                        16.0
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
                        700.0,
                        900.0,
                        20.0,
                        20.0
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
                        810.0,
                        900.0,
                        60.0,
                        20.0
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
                        700.0,
                        930.0,
                        100.0,
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
                        810.0,
                        930.0,
                        100.0,
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
                        726.0,
                        900.0,
                        30.0,
                        20.0
                    ],
                    "text": "3",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        558,
                        13.0,
                        16.0
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
                        700.0,
                        970.0,
                        20.0,
                        20.0
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
                        810.0,
                        970.0,
                        60.0,
                        20.0
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
                        700.0,
                        1000.0,
                        100.0,
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
                        810.0,
                        1000.0,
                        100.0,
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
                        726.0,
                        970.0,
                        30.0,
                        20.0
                    ],
                    "text": "4",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        580,
                        13.0,
                        16.0
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
                        700.0,
                        1040.0,
                        20.0,
                        20.0
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
                        810.0,
                        1040.0,
                        60.0,
                        20.0
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
                        700.0,
                        1070.0,
                        100.0,
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
                        810.0,
                        1070.0,
                        100.0,
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
                        726.0,
                        1040.0,
                        30.0,
                        20.0
                    ],
                    "text": "5",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        602,
                        13.0,
                        16.0
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
                        700.0,
                        1110.0,
                        20.0,
                        20.0
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
                        810.0,
                        1110.0,
                        60.0,
                        20.0
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
                        700.0,
                        1140.0,
                        100.0,
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
                        810.0,
                        1140.0,
                        100.0,
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
                        726.0,
                        1110.0,
                        30.0,
                        20.0
                    ],
                    "text": "6",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        624,
                        13.0,
                        16.0
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
                        700.0,
                        1180.0,
                        20.0,
                        20.0
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
                        810.0,
                        1180.0,
                        60.0,
                        20.0
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
                        700.0,
                        1210.0,
                        100.0,
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
                        810.0,
                        1210.0,
                        100.0,
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
                        726.0,
                        1180.0,
                        30.0,
                        20.0
                    ],
                    "text": "7",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        646,
                        13.0,
                        16.0
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
                        700.0,
                        1250.0,
                        20.0,
                        20.0
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
                        810.0,
                        1250.0,
                        60.0,
                        20.0
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
                        700.0,
                        1280.0,
                        100.0,
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
                        810.0,
                        1280.0,
                        100.0,
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
                        726.0,
                        1250.0,
                        30.0,
                        20.0
                    ],
                    "text": "8",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [
                        2.0,
                        668,
                        13.0,
                        16.0
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
                        900.0,
                        430.0,
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
                        900.0,
                        460.0,
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
                        928.0,
                        464.0,
                        40.0,
                        20.0
                    ],
                    "text": "S",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [
                        44.0,
                        372,
                        13.0,
                        16.0
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
                        900.0,
                        495.0,
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
                        740.0,
                        495.0,
                        140.0,
                        22.0
                    ],
                    "text": "receive mixer-solo-any",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "varname": "soloany"
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
                        700.0,
                        535.0,
                        230.0,
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
                        700.0,
                        575.0,
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
                        960.0,
                        535.0,
                        104.0,
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
                    "id": "obj-119",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        200.0,
                        51.0,
                        22.0
                    ],
                    "text": "dbtoa",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-120",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        230.0,
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
                    "id": "obj-121",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        260.0,
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
                    "id": "obj-122",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1130.0,
                        575.0,
                        170.0,
                        22.0
                    ],
                    "text": "expr cos($f1*1.570796)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-123",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1310.0,
                        575.0,
                        170.0,
                        22.0
                    ],
                    "text": "expr sin($f1*1.570796)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-124",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1130.0,
                        610.0,
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
                    "id": "obj-125",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        1130.0,
                        640.0,
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
                    "maxclass": "message",
                    "id": "obj-126",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1310.0,
                        610.0,
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
                    "id": "obj-127",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        1310.0,
                        640.0,
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
                    "id": "obj-128",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        980.0,
                        570.0,
                        65.0,
                        22.0
                    ],
                    "text": "forward",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "varname": "solofwd"
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
                        "obj-1",
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
                        34.0,
                        408.0,
                        70.0,
                        408.0
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
                        34.0,
                        396.0,
                        474.0,
                        396.0
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
                        304.0,
                        408.0,
                        340.0,
                        408.0
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
                        304.0,
                        412.0,
                        564.0,
                        412.0
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
                        704.0,
                        362.0,
                        26.0,
                        362.0,
                        26.0,
                        412.0,
                        34.0,
                        412.0
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
                        704.0,
                        362.0,
                        298.0,
                        362.0,
                        298.0,
                        412.0,
                        304.0,
                        412.0
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
                        34.0,
                        456.0,
                        26.0,
                        456.0,
                        26.0,
                        1332.0,
                        34.0,
                        1332.0
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
                        304.0,
                        456.0,
                        202.0,
                        456.0,
                        202.0,
                        1332.0,
                        181.0,
                        1332.0
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
                        "obj-12",
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
                        "obj-37",
                        4
                    ],
                    "midpoints": [
                        34.0,
                        766.0,
                        66.0,
                        766.0,
                        66.0,
                        1324.0,
                        622.0,
                        1324.0
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
                        "obj-37",
                        5
                    ],
                    "midpoints": [
                        304.0,
                        766.0,
                        334.0,
                        766.0,
                        334.0,
                        1332.0,
                        769.0,
                        1332.0
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
                        "obj-15",
                        2
                    ],
                    "midpoints": [
                        454.0,
                        401.0,
                        106.0,
                        401.0
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
                        544.0,
                        407.0,
                        376.0,
                        407.0
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
                        704.0,
                        108.0,
                        114.0,
                        108.0,
                        114.0,
                        452.0,
                        34.0,
                        452.0
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
                        774.0,
                        108.0,
                        704.0,
                        108.0
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
                        844.0,
                        426.0,
                        1134.0,
                        426.0
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
                        915.0,
                        108.0,
                        1324.0,
                        108.0
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
                        985.0,
                        288.0,
                        704.0,
                        288.0
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
                        1056.0,
                        420.0,
                        704.0,
                        420.0
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
                    ],
                    "midpoints": [
                        704.0,
                        668.0,
                        68.0,
                        668.0
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
                    ],
                    "midpoints": [
                        704.0,
                        668.0,
                        338.0,
                        668.0
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
                    ],
                    "midpoints": [
                        62.0,
                        524.0,
                        304.0,
                        524.0
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
                    ],
                    "midpoints": [
                        74.0,
                        101.0,
                        34.0,
                        101.0
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
                    ],
                    "midpoints": [
                        344.0,
                        101.0,
                        304.0,
                        101.0
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
                    ],
                    "midpoints": [
                        704.0,
                        826.0,
                        916.0,
                        826.0
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
                    ],
                    "midpoints": [
                        814.0,
                        826.0,
                        916.0,
                        826.0
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
                    ],
                    "midpoints": [
                        704.0,
                        886.0,
                        916.0,
                        886.0
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
                    ],
                    "midpoints": [
                        814.0,
                        886.0,
                        916.0,
                        886.0
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
                    ],
                    "midpoints": [
                        704.0,
                        956.0,
                        916.0,
                        956.0
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
                    ],
                    "midpoints": [
                        814.0,
                        956.0,
                        916.0,
                        956.0
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
                    ],
                    "midpoints": [
                        704.0,
                        1026.0,
                        916.0,
                        1026.0
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
                    ],
                    "midpoints": [
                        814.0,
                        1026.0,
                        916.0,
                        1026.0
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
                    ],
                    "midpoints": [
                        704.0,
                        1096.0,
                        916.0,
                        1096.0
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
                    ],
                    "midpoints": [
                        814.0,
                        1096.0,
                        916.0,
                        1096.0
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
                    ],
                    "midpoints": [
                        704.0,
                        1166.0,
                        916.0,
                        1166.0
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
                    ],
                    "midpoints": [
                        814.0,
                        1166.0,
                        916.0,
                        1166.0
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
                    ],
                    "midpoints": [
                        704.0,
                        1236.0,
                        916.0,
                        1236.0
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
                    ],
                    "midpoints": [
                        814.0,
                        1236.0,
                        916.0,
                        1236.0
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
                    ],
                    "midpoints": [
                        704.0,
                        1306.0,
                        916.0,
                        1306.0
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
                    ],
                    "midpoints": [
                        814.0,
                        1306.0,
                        916.0,
                        1306.0
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
                    ],
                    "midpoints": [
                        947.0,
                        523.0,
                        926.0,
                        523.0
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
                    ],
                    "midpoints": [
                        904.0,
                        529.0,
                        964.0,
                        529.0
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
                    ],
                    "midpoints": [
                        744.0,
                        523.0,
                        815.0,
                        523.0
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
            },
            {
                "patchline": {
                    "source": [
                        "obj-10",
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
                        "obj-119",
                        0
                    ],
                    "destination": [
                        "obj-120",
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
                        "obj-121",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-121",
                        0
                    ],
                    "destination": [
                        "obj-11",
                        1
                    ],
                    "midpoints": [
                        704.0,
                        288.0,
                        68.0,
                        288.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-121",
                        0
                    ],
                    "destination": [
                        "obj-12",
                        1
                    ],
                    "midpoints": [
                        704.0,
                        288.0,
                        338.0,
                        288.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-21",
                        1
                    ],
                    "destination": [
                        "obj-122",
                        0
                    ],
                    "midpoints": [
                        1162.0,
                        566.0,
                        1134.0,
                        566.0
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
                        "obj-123",
                        0
                    ],
                    "midpoints": [
                        1134.0,
                        566.0,
                        1314.0,
                        566.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-122",
                        0
                    ],
                    "destination": [
                        "obj-124",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-124",
                        0
                    ],
                    "destination": [
                        "obj-125",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-125",
                        0
                    ],
                    "destination": [
                        "obj-23",
                        1
                    ],
                    "midpoints": [
                        1134.0,
                        710.0,
                        68.0,
                        710.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-123",
                        0
                    ],
                    "destination": [
                        "obj-126",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-126",
                        0
                    ],
                    "destination": [
                        "obj-127",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-127",
                        0
                    ],
                    "destination": [
                        "obj-24",
                        1
                    ],
                    "midpoints": [
                        1314.0,
                        718.0,
                        338.0,
                        718.0
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
                        "obj-27",
                        0
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
                        "obj-23",
                        0
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
                        "obj-37",
                        2
                    ],
                    "midpoints": [
                        34.0,
                        716.0,
                        210.0,
                        716.0,
                        210.0,
                        1332.0,
                        328.0,
                        1332.0
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
                        "obj-24",
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
                        "obj-37",
                        3
                    ],
                    "midpoints": [
                        304.0,
                        726.0,
                        475.0,
                        726.0
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
                        "obj-29",
                        0
                    ],
                    "midpoints": [
                        34.0,
                        776.0,
                        76.0,
                        776.0
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
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        34.0,
                        776.0,
                        108.0,
                        776.0
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
                        "obj-33",
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
                        "obj-30",
                        0
                    ],
                    "midpoints": [
                        304.0,
                        776.0,
                        346.0,
                        776.0
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
                        "obj-32",
                        0
                    ],
                    "midpoints": [
                        304.0,
                        776.0,
                        378.0,
                        776.0
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
                        "obj-34",
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
                        "obj-128",
                        0
                    ],
                    "midpoints": [
                        964.0,
                        561.0,
                        984.0,
                        561.0
                    ]
                }
            }
        ],
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