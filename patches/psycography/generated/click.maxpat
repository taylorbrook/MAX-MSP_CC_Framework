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
            85.0,
            104.0,
            640.0,
            480.0
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
                    "maxclass": "inlet",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        470,
                        30,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "control: seek <n> / clickmute 0|1 / subdiv 0|1 / resync / reset"
                }
            },
            {
                "box": {
                    "maxclass": "outlet",
                    "id": "obj-2",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        380,
                        790,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "click audio (signal) -> dedicated ch 10 in main patch"
                }
            },
            {
                "box": {
                    "maxclass": "outlet",
                    "id": "obj-3",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        600,
                        790,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "status from scheduler (armed/done/count)"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        40,
                        40,
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
                    "maxclass": "newobj",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 5,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        40,
                        90,
                        93.0,
                        22.0
                    ],
                    "text": "t b b b b b",
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
                        40,
                        140,
                        205.0,
                        22.0
                    ],
                    "text": "read psycography_clicks.txt",
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
                        300,
                        140,
                        51.0,
                        22.0
                    ],
                    "text": "clear",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-8",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        140,
                        79.0,
                        22.0
                    ],
                    "text": "delay 300",
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
                        210,
                        190,
                        44.0,
                        22.0
                    ],
                    "text": "dump",
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
                        470,
                        250,
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
                    "id": "obj-11",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        560,
                        250,
                        40.0,
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
                    "id": "obj-12",
                    "numinlets": 2,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        40,
                        240,
                        177.0,
                        22.0
                    ],
                    "text": "coll psycography_clicks",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        40,
                        300,
                        97.0,
                        22.0
                    ],
                    "text": "prepend add",
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
                        40,
                        340,
                        548.0,
                        20.0
                    ],
                    "text": "loader: read clicks coll -> dump (delay 300 for read latency) -> add into js",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 6,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        470,
                        90,
                        296.0,
                        22.0
                    ],
                    "text": "route seek clickmute subdiv resync reset",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        470,
                        150,
                        100.0,
                        22.0
                    ],
                    "text": "prepend seek",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-17",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        590,
                        150,
                        44.0,
                        22.0
                    ],
                    "text": "== 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-18",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        820,
                        150,
                        51.0,
                        22.0
                    ],
                    "text": "reset",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-19",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        700,
                        200,
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
                    "maxclass": "comment",
                    "id": "obj-20",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        470,
                        320,
                        527.0,
                        20.0
                    ],
                    "text": "resync = snapshot master -> seek (re-sync pointer after a transport seek)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        40,
                        400,
                        121.0,
                        22.0
                    ],
                    "text": "receive~ master",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        210,
                        400,
                        128.0,
                        22.0
                    ],
                    "text": "sig~ 1000000000.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-23",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        40,
                        460,
                        40.0,
                        22.0
                    ],
                    "text": ">=~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-24",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        40,
                        520,
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
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        40,
                        580,
                        149.0,
                        22.0
                    ],
                    "text": "js clicks_engine.js",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-26",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        40,
                        640,
                        653.0,
                        20.0
                    ],
                    "text": "crossing: receive~ master >=~ sig~<next> -> edge~ -> js fire (emit type, advance, arm next)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        380,
                        380,
                        79.0,
                        22.0
                    ],
                    "text": "sel 0 1 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-28",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        560,
                        420,
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
                    "id": "obj-29",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        380,
                        440,
                        51.0,
                        22.0
                    ],
                    "text": "t b b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-30",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        460,
                        440,
                        51.0,
                        22.0
                    ],
                    "text": "t b b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        560,
                        480,
                        51.0,
                        22.0
                    ],
                    "text": "t b b",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        380,
                        490,
                        44.0,
                        22.0
                    ],
                    "text": "1000",
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
                        380,
                        530,
                        93.0,
                        22.0
                    ],
                    "text": "0.6 0 0. 40",
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
                        460,
                        490,
                        44.0,
                        22.0
                    ],
                    "text": "1500",
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
                        460,
                        530,
                        86.0,
                        22.0
                    ],
                    "text": "1. 0 0. 40",
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
                        560,
                        530,
                        40.0,
                        22.0
                    ],
                    "text": "800",
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
                        560,
                        570,
                        93.0,
                        22.0
                    ],
                    "text": "0.4 0 0. 40",
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
                        "signal"
                    ],
                    "patching_rect": [
                        380,
                        610,
                        93.0,
                        22.0
                    ],
                    "text": "cycle~ 1000",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-39",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        520,
                        610,
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
                    "id": "obj-40",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        380,
                        670,
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
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        380,
                        730,
                        51.0,
                        22.0
                    ],
                    "text": "*~ 1.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        560,
                        730,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0
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
                        380,
                        350,
                        569.0,
                        20.0
                    ],
                    "text": "accent=1500Hz/1.0  beat=1000Hz/0.6  subdiv=800Hz/0.4 (gated). 40ms decay burst.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "button",
                    "id": "obj-44",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        780,
                        440,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "button",
                    "id": "obj-45",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        830,
                        440,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "button",
                    "id": "obj-46",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        880,
                        440,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-47",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        780,
                        520,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-48",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        780,
                        560,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
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
                        780,
                        415,
                        275.0,
                        20.0
                    ],
                    "text": "TEST: audition accent / beat / subdiv",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        810,
                        524,
                        107.0,
                        20.0
                    ],
                    "text": "subdiv on/off",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-51",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        810,
                        564,
                        100.0,
                        20.0
                    ],
                    "text": "click on/off",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "obj-4",
                        0
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
                        "obj-5",
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
                        "obj-5",
                        1
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
                        "obj-5",
                        2
                    ],
                    "destination": [
                        "obj-8",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-5",
                        3
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
                        "obj-5",
                        4
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
                        "obj-6",
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
                        "obj-8",
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
                        "obj-9",
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
                        0
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
                        "obj-1",
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
                        "obj-15",
                        0
                    ],
                    "destination": [
                        "obj-16",
                        0
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
                        "obj-17",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-15",
                        3
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
                        "obj-15",
                        4
                    ],
                    "destination": [
                        "obj-18",
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
                        "obj-16",
                        0
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
                        "obj-23",
                        0
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
                        "obj-19",
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
                        "obj-23",
                        1
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
                        "obj-25",
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
                        "obj-25",
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
                        "obj-25",
                        0
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
                        "obj-25",
                        0
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
                        "obj-25",
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
                        "obj-22",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-25",
                        2
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
                        "obj-25",
                        1
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
                        "obj-29",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-27",
                        1
                    ],
                    "destination": [
                        "obj-30",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-27",
                        2
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
                        "obj-28",
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
                        1
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
                        "obj-29",
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
                        "obj-30",
                        1
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
                        "obj-30",
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
                        "obj-31",
                        1
                    ],
                    "destination": [
                        "obj-36",
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
                        "obj-37",
                        0
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
                        "obj-38",
                        0
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
                        "obj-38",
                        0
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
                        "obj-38",
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
                        "obj-39",
                        0
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
                        "obj-39",
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
                        "obj-41",
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
                        "obj-17",
                        0
                    ],
                    "destination": [
                        "obj-41",
                        1
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
                        "obj-41",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-15",
                        2
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
                        "obj-11",
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
                        "obj-45",
                        0
                    ],
                    "destination": [
                        "obj-29",
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
                        "obj-30",
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
                        "obj-31",
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
                        "obj-28",
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
                        "obj-41",
                        1
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0
    }
}