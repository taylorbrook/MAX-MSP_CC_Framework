{
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
            60.0,
            60.0,
            1240.0,
            980.0
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
                    "maxclass": "panel",
                    "id": "obj-55",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        710,
                        392,
                        510,
                        500
                    ],
                    "parameter_enable": 0,
                    "background": 1,
                    "ignoreclick": 1,
                    "border": 0,
                    "rounded": 6,
                    "mode": 0,
                    "bgcolor": [
                        0.19,
                        0.19,
                        0.22,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "panel",
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        510,
                        48,
                        710,
                        330
                    ],
                    "parameter_enable": 0,
                    "background": 1,
                    "ignoreclick": 1,
                    "border": 0,
                    "rounded": 6,
                    "mode": 0,
                    "bgcolor": [
                        0.19,
                        0.19,
                        0.22,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "panel",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        20,
                        48,
                        480,
                        156
                    ],
                    "parameter_enable": 0,
                    "background": 1,
                    "ignoreclick": 1,
                    "border": 0,
                    "rounded": 6,
                    "mode": 0,
                    "bgcolor": [
                        0.19,
                        0.19,
                        0.22,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30.0,
                        10.0,
                        420.0,
                        24.0
                    ],
                    "text": "BARNETT DBAP   control messages demo",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ],
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
                        460.0,
                        8.0,
                        750.0,
                        33.0
                    ],
                    "text": "A message '<control name> <value>' into a module's control inlet sets that control: the dial moves, the engine follows, scenes store it.  Turn DSP on (bottom left), pick an input in the source, then click any message box.",
                    "fontname": "Arial",
                    "fontsize": 11.0,
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
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30.0,
                        54.0,
                        400.0,
                        20.0
                    ],
                    "text": "1  MOTION MODULE   messages into its only inlet",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        178.0,
                        40.0,
                        22.0
                    ],
                    "text": "t l",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-6",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        44.0,
                        84.0,
                        44.0,
                        22.0
                    ],
                    "text": "on 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-7",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        44.0,
                        112.0,
                        44.0,
                        22.0
                    ],
                    "text": "on 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-8",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        44.0,
                        140.0,
                        37.0,
                        22.0
                    ],
                    "text": "cue",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-9",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        84.0,
                        58.0,
                        22.0
                    ],
                    "text": "path 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-10",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        112.0,
                        58.0,
                        22.0
                    ],
                    "text": "path 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-11",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        140.0,
                        58.0,
                        22.0
                    ],
                    "text": "path 6",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-12",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        256.0,
                        84.0,
                        72.0,
                        22.0
                    ],
                    "text": "rate 0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-13",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        256.0,
                        112.0,
                        65.0,
                        22.0
                    ],
                    "text": "size 4.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-14",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        256.0,
                        140.0,
                        86.0,
                        22.0
                    ],
                    "text": "wander 1.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-15",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        378.0,
                        84.0,
                        58.0,
                        22.0
                    ],
                    "text": "loop 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-16",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        378.0,
                        112.0,
                        58.0,
                        22.0
                    ],
                    "text": "loop 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-17",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        378.0,
                        140.0,
                        58.0,
                        22.0
                    ],
                    "text": "loop 2",
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
                        150.0,
                        178.0,
                        340.0,
                        20.0
                    ],
                    "text": "path 6 = recorded   loop 1 = palindrome, 2 = one-shot",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        0.62,
                        0.64,
                        0.68,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        212,
                        460,
                        150
                    ],
                    "args": [
                        "Dm"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "lockeddragscroll": 0,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "viewvisibility": 1,
                    "name": "dbap-motion.maxpat",
                    "lockedsize": 0,
                    "varname": "demo_motion"
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-20",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "multichannelsignal",
                        ""
                    ],
                    "patching_rect": [
                        30,
                        392,
                        660,
                        500
                    ],
                    "args": [
                        "D",
                        1
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "lockeddragscroll": 0,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "viewvisibility": 1,
                    "name": "dbap-source.maxpat",
                    "lockedsize": 0,
                    "varname": "demo_source"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        520.0,
                        54.0,
                        690.0,
                        20.0
                    ],
                    "text": "2  SOURCE MODULE   messages into its THIRD inlet (the one the motion module also feeds)",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ],
                    "fontface": 1
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
                        671.0,
                        348.0,
                        40.0,
                        22.0
                    ],
                    "text": "t l",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-24",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        534.0,
                        78.0,
                        130.0,
                        19.0
                    ],
                    "text": "set a control",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        0.62,
                        0.64,
                        0.68,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-25",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        534.0,
                        98.0,
                        72.0,
                        22.0
                    ],
                    "text": "width 3.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-26",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        534.0,
                        126.0,
                        72.0,
                        22.0
                    ],
                    "text": "width 0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-27",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        534.0,
                        154.0,
                        65.0,
                        22.0
                    ],
                    "text": "air 0.8",
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
                        534.0,
                        182.0,
                        86.0,
                        22.0
                    ],
                    "text": "rolloff 6.",
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
                        534.0,
                        210.0,
                        93.0,
                        22.0
                    ],
                    "text": "master -12.",
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
                        534.0,
                        238.0,
                        72.0,
                        22.0
                    ],
                    "text": "srcz 1.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        730.0,
                        78.0,
                        260.0,
                        19.0
                    ],
                    "text": "lists of 8, and position in metres",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        0.62,
                        0.64,
                        0.68,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-32",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        730.0,
                        98.0,
                        233.0,
                        22.0
                    ],
                    "text": "weights 1. 1. 1. 1. 0. 0. 0. 0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-33",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        730.0,
                        126.0,
                        233.0,
                        22.0
                    ],
                    "text": "weights 1. 1. 1. 1. 1. 1. 1. 1.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-34",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        730.0,
                        154.0,
                        233.0,
                        22.0
                    ],
                    "text": "trims 0. 0. -6. -6. 0. 0. 0. 0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-35",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        730.0,
                        182.0,
                        219.0,
                        22.0
                    ],
                    "text": "trims 0. 0. 0. 0. 0. 0. 0. 0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-36",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        730.0,
                        210.0,
                        128.0,
                        22.0
                    ],
                    "text": "setanchor 6. 7.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-37",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        730.0,
                        238.0,
                        128.0,
                        22.0
                    ],
                    "text": "setanchor 2.5 3.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-38",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1020.0,
                        78.0,
                        200.0,
                        19.0
                    ],
                    "text": "live values: any number + prepend",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        0.62,
                        0.64,
                        0.68,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "slider",
                    "id": "obj-39",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1020.0,
                        98.0,
                        150.0,
                        20.0
                    ],
                    "parameter_enable": 0,
                    "floatoutput": 1,
                    "size": 1.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-40",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1020.0,
                        126.0,
                        80.0,
                        22.0
                    ],
                    "text": "prepend air",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-41",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1020.0,
                        166.0,
                        56.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0.0,
                    "maximum": 12.0
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
                        1020.0,
                        196.0,
                        93.0,
                        22.0
                    ],
                    "text": "prepend width",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-43",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1108.0,
                        128.0,
                        100.0,
                        19.0
                    ],
                    "text": "0..1 -> air",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        0.62,
                        0.64,
                        0.68,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-44",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1120.0,
                        198.0,
                        100.0,
                        19.0
                    ],
                    "text": "metres -> width",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        0.62,
                        0.64,
                        0.68,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-45",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1020.0,
                        236.0,
                        51.0,
                        22.0
                    ],
                    "text": "ctlin 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-46",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1020.0,
                        264.0,
                        121.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-47",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1020.0,
                        292.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend decorr",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-48",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1078.0,
                        238.0,
                        128.0,
                        19.0
                    ],
                    "text": "MIDI CC 1 -> decorr",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        0.62,
                        0.64,
                        0.68,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-49",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        720.0,
                        350.0,
                        300.0,
                        19.0
                    ],
                    "text": "t l = one cord into the inlet",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        0.62,
                        0.64,
                        0.68,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-50",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30.0,
                        922.0,
                        177.0,
                        22.0
                    ],
                    "text": "mc.dac~ 1 2 3 4 5 6 7 8",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-51",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        230.0,
                        920.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-52",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        262.0,
                        923.0,
                        520.0,
                        19.0
                    ],
                    "text": "DSP on / off.   8 speaker feeds. The demo skips the host's alignment delays (mc.delay~).",
                    "fontname": "Arial",
                    "fontsize": 11.0,
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
                    "maxclass": "newobj",
                    "id": "obj-53",
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
                        800.0,
                        922.0,
                        149.0,
                        22.0
                    ],
                    "text": "dict venue @embed 1",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "data": {
                        "name": "Roy Barnett Recital Hall (O-Octagon OQ4 traced layout, not measured)",
                        "units": "metres",
                        "speakers": {
                            "s1": {
                                "x": 0.5,
                                "y": 4.5,
                                "z": 4.5,
                                "delayMs": 0.0
                            },
                            "s2": {
                                "x": 12.5,
                                "y": 4.5,
                                "z": 4.5,
                                "delayMs": 0.0
                            },
                            "s3": {
                                "x": 12.5,
                                "y": 9.85,
                                "z": 4.7,
                                "delayMs": 0.0
                            },
                            "s4": {
                                "x": 12.5,
                                "y": 16.0,
                                "z": 5.1,
                                "delayMs": 0.0
                            },
                            "s5": {
                                "x": 9.8,
                                "y": 19.5,
                                "z": 5.4,
                                "delayMs": 0.0
                            },
                            "s6": {
                                "x": 3.2,
                                "y": 19.5,
                                "z": 5.4,
                                "delayMs": 0.0
                            },
                            "s7": {
                                "x": 0.5,
                                "y": 16.0,
                                "z": 5.1,
                                "delayMs": 0.0
                            },
                            "s8": {
                                "x": 0.5,
                                "y": 9.85,
                                "z": 4.7,
                                "delayMs": 0.0
                            }
                        },
                        "rake": {
                            "front": 1.1,
                            "rear": 3.2
                        }
                    },
                    "saved_object_attributes": {
                        "embed": 1,
                        "legacy": 1,
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    }
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
                        956.0,
                        923.0,
                        200.0,
                        19.0
                    ],
                    "text": "venue (copy of the host's)",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        0.62,
                        0.64,
                        0.68,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-56",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        724.0,
                        400.0,
                        300.0,
                        20.0
                    ],
                    "text": "HOW IT WORKS",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-57",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        724.0,
                        424.0,
                        484.0,
                        72.0
                    ],
                    "text": "Both modules end their control inlet at their own scene storage (pattrstorage). A message whose FIRST WORD is the name of a control sets that control. The control then drives the engine exactly as if you had turned it, so the face, the sound and the stored scenes always agree. Unknown words do nothing.",
                    "fontname": "Arial",
                    "fontsize": 11.0,
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
                    "id": "obj-58",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        724.0,
                        504.0,
                        300.0,
                        19.0
                    ],
                    "text": "SOURCE, third inlet",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-59",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        724.0,
                        524.0,
                        484.0,
                        112.0
                    ],
                    "text": "rolloff 3..12   blur 0..1   srcz -3..15 m   width 0..12 m   decorr 0..1   air 0..1   hull 0..3   master -70..0 dB\nweights (8 floats 0..1)   trims (8 floats, dB)\nsetanchor x y : puck position in metres\nInside, 'p ctlsplit' lets motion / trace / setanchor / recstate through to the engine and sends every other message to the scene storage.",
                    "fontname": "Arial",
                    "fontsize": 11.0,
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
                    "id": "obj-60",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        724.0,
                        644.0,
                        300.0,
                        19.0
                    ],
                    "text": "MOTION, its only inlet",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-61",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        724.0,
                        664.0,
                        484.0,
                        84.0
                    ],
                    "text": "on 0/1   path 0..6   rate 0.01..10 Hz   size 0..24 m   ratio 0..1   angle 0..360   height 0..8 m   phase 0..360   seed 1..64   wander 0..12 m   loop 0..2\ncue : play a one-shot, or restart a loop\nstore N / recall N : its scenes",
                    "fontname": "Arial",
                    "fontsize": 11.0,
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
                    "id": "obj-62",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        724.0,
                        756.0,
                        400.0,
                        19.0
                    ],
                    "text": "THE TWO CORDS BETWEEN THE MODULES",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-63",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        724.0,
                        776.0,
                        484.0,
                        80.0
                    ],
                    "text": "motion outlet -> source third inlet : the moving offset, the trace, and the anchor after a recording.\nsource right outlet -> motion inlet (the cord up the left edge) : scene store / recall and the mouse position for the gesture recorder. Your own messages simply join these cords.",
                    "fontname": "Arial",
                    "fontsize": 11.0,
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
                    "id": "obj-64",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        724.0,
                        858.0,
                        484.0,
                        33.0
                    ],
                    "text": "Keep store / recall / clear / read / write / delete away from an external controller: those words act on the scenes.",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [
                        0.62,
                        0.64,
                        0.68,
                        1.0
                    ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "obj-6",
                        0
                    ],
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        53.5,
                        110.0,
                        36,
                        110.0,
                        36,
                        172,
                        39.5,
                        172
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        53.5,
                        138.0,
                        36,
                        138.0,
                        36,
                        172,
                        39.5,
                        172
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        53.5,
                        166.0,
                        36,
                        166.0,
                        36,
                        172,
                        39.5,
                        172
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-9",
                        0
                    ],
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        159.5,
                        110.0,
                        142,
                        110.0,
                        142,
                        172,
                        39.5,
                        172
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        159.5,
                        138.0,
                        142,
                        138.0,
                        142,
                        172,
                        39.5,
                        172
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        159.5,
                        166.0,
                        142,
                        166.0,
                        142,
                        172,
                        39.5,
                        172
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        265.5,
                        110.0,
                        248,
                        110.0,
                        248,
                        172,
                        39.5,
                        172
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        265.5,
                        138.0,
                        248,
                        138.0,
                        248,
                        172,
                        39.5,
                        172
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        265.5,
                        166.0,
                        248,
                        166.0,
                        248,
                        172,
                        39.5,
                        172
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        387.5,
                        110.0,
                        370,
                        110.0,
                        370,
                        172,
                        39.5,
                        172
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        387.5,
                        138.0,
                        370,
                        138.0,
                        370,
                        172,
                        39.5,
                        172
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        387.5,
                        166.0,
                        370,
                        166.0,
                        370,
                        172,
                        39.5,
                        172
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
                        "obj-19",
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        543.5,
                        124.0,
                        526,
                        124.0,
                        526,
                        342,
                        680.5,
                        342
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        543.5,
                        152.0,
                        526,
                        152.0,
                        526,
                        342,
                        680.5,
                        342
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
                    ],
                    "midpoints": [
                        543.5,
                        180.0,
                        526,
                        180.0,
                        526,
                        342,
                        680.5,
                        342
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        543.5,
                        208.0,
                        526,
                        208.0,
                        526,
                        342,
                        680.5,
                        342
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        543.5,
                        236.0,
                        526,
                        236.0,
                        526,
                        342,
                        680.5,
                        342
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
                        543.5,
                        264.0,
                        526,
                        264.0,
                        526,
                        342,
                        680.5,
                        342
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        739.5,
                        124.0,
                        722,
                        124.0,
                        722,
                        342,
                        680.5,
                        342
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        739.5,
                        152.0,
                        722,
                        152.0,
                        722,
                        342,
                        680.5,
                        342
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        739.5,
                        180.0,
                        722,
                        180.0,
                        722,
                        342,
                        680.5,
                        342
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        739.5,
                        208.0,
                        722,
                        208.0,
                        722,
                        342,
                        680.5,
                        342
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        739.5,
                        236.0,
                        722,
                        236.0,
                        722,
                        342,
                        680.5,
                        342
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        739.5,
                        264.0,
                        722,
                        264.0,
                        722,
                        342,
                        680.5,
                        342
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        1029.5,
                        152.0,
                        1012.0,
                        152.0,
                        1012.0,
                        342,
                        680.5,
                        342
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
                        "obj-42",
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        1029.5,
                        222.0,
                        1012.0,
                        222.0,
                        1012.0,
                        342,
                        680.5,
                        342
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        1029.5,
                        318.0,
                        1012.0,
                        318.0,
                        1012.0,
                        342,
                        680.5,
                        342
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
                        "obj-20",
                        2
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
                        "obj-20",
                        2
                    ],
                    "midpoints": [
                        39.5,
                        378.0,
                        680.5,
                        378.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-20",
                        1
                    ],
                    "destination": [
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        680.5,
                        902.0,
                        12.0,
                        902.0,
                        12.0,
                        206.0,
                        39.5,
                        206.0
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
                        "obj-50",
                        0
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
                        "obj-50",
                        0
                    ],
                    "midpoints": [
                        241.5,
                        948.0,
                        218.0,
                        948.0,
                        218.0,
                        914.0,
                        39.5,
                        914.0
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0,
        "bgcolor": [
            0.13,
            0.13,
            0.15,
            1.0
        ],
        "editing_bgcolor": [
            0.13,
            0.13,
            0.15,
            1.0
        ],
        "locked_bgcolor": [
            0.13,
            0.13,
            0.15,
            1.0
        ]
    }
}