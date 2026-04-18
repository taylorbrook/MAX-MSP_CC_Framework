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
            5139.0,
            917.0
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
                        930.0,
                        495.0,
                        420.0,
                        320.0
                    ],
                    "text": "dada.bounce",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        72.0,
                        22.0
                    ],
                    "text": "loadbang",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "bgcolor": [
                        0.85,
                        0.92,
                        0.85,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 8,
                    "outlettype": [
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
                        165.0,
                        75.0,
                        135.0,
                        22.0
                    ],
                    "text": "t b b b b b b b b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-4",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        255.0,
                        120.0,
                        100.0,
                        22.0
                    ],
                    "text": "bouncedata 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-5",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        375.0,
                        120.0,
                        93.0,
                        22.0
                    ],
                    "text": "clear balls",
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
                        480.0,
                        120.0,
                        667.0,
                        22.0
                    ],
                    "text": "llll bounce [room [[[coord -100 80]] [[coord 0 -80]] [[coord 100 80]]] [[1 2] [2 3]]] [balls]",
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
                        1155.0,
                        120.0,
                        450.0,
                        22.0
                    ],
                    "text": "addball [coord -60 0] [speed 2.3 -1.7] [color 0.95 0.3 0.3 1.]",
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
                        1620.0,
                        120.0,
                        464.0,
                        22.0
                    ],
                    "text": "addball [coord -30 20] [speed -1.5 2.1] [color 0.3 0.85 0.95 1.]",
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
                        2100.0,
                        120.0,
                        450.0,
                        22.0
                    ],
                    "text": "addball [coord 0 -40] [speed 1.9 1.3] [color 0.95 0.85 0.3 1.]",
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
                        2565.0,
                        120.0,
                        457.0,
                        22.0
                    ],
                    "text": "addball [coord 30 20] [speed -2.1 -1.8] [color 0.4 0.95 0.4 1.]",
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
                        3045.0,
                        120.0,
                        443.0,
                        22.0
                    ],
                    "text": "addball [coord 60 0] [speed 1.7 2.2] [color 0.85 0.4 0.95 1.]",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        30.0,
                        72.0,
                        22.0
                    ],
                    "text": "loadbang",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "bgcolor": [
                        0.85,
                        0.92,
                        0.85,
                        1.0
                    ]
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
                        315.0,
                        75.0,
                        72.0,
                        22.0
                    ],
                    "text": "cpuclock",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3495.0,
                        120.0,
                        163.0,
                        22.0
                    ],
                    "text": "send v1_session_start",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3675.0,
                        120.0,
                        163.0,
                        22.0
                    ],
                    "text": "send v2_session_start",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3855.0,
                        120.0,
                        163.0,
                        22.0
                    ],
                    "text": "send v3_session_start",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4035.0,
                        120.0,
                        163.0,
                        22.0
                    ],
                    "text": "send v4_session_start",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-18",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4215.0,
                        120.0,
                        163.0,
                        22.0
                    ],
                    "text": "send v5_session_start",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        45.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-20",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        75.0,
                        58.0,
                        22.0
                    ],
                    "text": "int $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4950.0,
                        30.0,
                        93.0,
                        20.0
                    ],
                    "text": "Play / Stop",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                    "maxclass": "button",
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        105.0,
                        45.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-23",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        105.0,
                        75.0,
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
                    "id": "obj-24",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        75.0,
                        120.0,
                        93.0,
                        22.0
                    ],
                    "text": "clear balls",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        195.0,
                        120.0,
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
                    "maxclass": "comment",
                    "id": "obj-26",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4950.0,
                        75.0,
                        51.0,
                        20.0
                    ],
                    "text": "Clear",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                    "maxclass": "number",
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        120.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 1,
                    "maximum": 200
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
                        30.0,
                        150.0,
                        93.0,
                        22.0
                    ],
                    "text": "playstep $1",
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
                        405.0,
                        75.0,
                        40.0,
                        22.0
                    ],
                    "text": "20",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-30",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4950.0,
                        135.0,
                        149.0,
                        20.0
                    ],
                    "text": "Speed (playstep ms)",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                    "maxclass": "number",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        120.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 1,
                    "maximum": 50
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
                        135.0,
                        150.0,
                        93.0,
                        22.0
                    ],
                    "text": "ballsize $1",
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
                        465.0,
                        75.0,
                        40.0,
                        22.0
                    ],
                    "text": "10",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-34",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4950.0,
                        180.0,
                        79.0,
                        20.0
                    ],
                    "text": "Ball size",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                    "maxclass": "flonum",
                    "id": "obj-35",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        240.0,
                        120.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 20.0,
                    "maximum": 2000.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-36",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        885.0,
                        120.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 100.0,
                    "maximum": 16000.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-37",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        240.0,
                        150.0,
                        114.0,
                        22.0
                    ],
                    "text": "send v1_min_hz",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-38",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        885.0,
                        150.0,
                        114.0,
                        22.0
                    ],
                    "text": "send v1_max_hz",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-39",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        375.0,
                        150.0,
                        114.0,
                        22.0
                    ],
                    "text": "send v2_min_hz",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-40",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1020.0,
                        150.0,
                        114.0,
                        22.0
                    ],
                    "text": "send v2_max_hz",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-41",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        510.0,
                        150.0,
                        114.0,
                        22.0
                    ],
                    "text": "send v3_min_hz",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1155.0,
                        150.0,
                        114.0,
                        22.0
                    ],
                    "text": "send v3_max_hz",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-43",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        630.0,
                        150.0,
                        114.0,
                        22.0
                    ],
                    "text": "send v4_min_hz",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-44",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1275.0,
                        150.0,
                        114.0,
                        22.0
                    ],
                    "text": "send v4_max_hz",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-45",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        765.0,
                        150.0,
                        114.0,
                        22.0
                    ],
                    "text": "send v5_min_hz",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-46",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1410.0,
                        150.0,
                        114.0,
                        22.0
                    ],
                    "text": "send v5_max_hz",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-47",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        510.0,
                        75.0,
                        44.0,
                        22.0
                    ],
                    "text": "55.0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-48",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        570.0,
                        75.0,
                        58.0,
                        22.0
                    ],
                    "text": "4186.0",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        4950.0,
                        225.0,
                        58.0,
                        20.0
                    ],
                    "text": "Min Hz",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                        4950.0,
                        285.0,
                        58.0,
                        20.0
                    ],
                    "text": "Max Hz",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                    "id": "obj-51",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1080.0,
                        855.0,
                        121.0,
                        22.0
                    ],
                    "text": "send ball-event",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-52",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        4410.0,
                        30.0,
                        86.0,
                        22.0
                    ],
                    "text": "p voice-1",
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
                            400.0,
                            300.0
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
                                    "maxclass": "outlet",
                                    "id": "obj-1",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        600.0,
                                        660.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "ball 1 audio L"
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
                                        720.0,
                                        660.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "ball 1 audio R"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        30.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "receive ball-event",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        75.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "t l l l",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        360.0,
                                        120.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "bach.keys position",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        150.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.llll2list",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        195.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack 0. 0.",
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
                                        510.0,
                                        285.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-9",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        435.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-10",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        120.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "bach.keys speed",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-11",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        150.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.llll2list",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        195.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack 0. 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-13",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        495.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-14",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-15",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        120.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.keys ball",
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
                                        660.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-17",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        675.0,
                                        195.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "select 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-18",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "receive v1_min_hz",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-19",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        30.0,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "receive v1_max_hz",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-20",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        30.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "receive v1_session_start",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-21",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        45.0,
                                        75.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "f 55.0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-22",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        75.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "f 4186.0",
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        540.0,
                                        75.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-24",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        240.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "t b b b b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-25",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        330.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "expr ($f1 + 100.) / 200.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-26",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        360.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * pow($f2/$f1, $f3)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-27",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        405.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "cycle~ 0.",
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        450.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "cycle~ 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-29",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        405.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * 2.0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-30",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        495.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-31",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        285.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "expr sqrt($f1*$f1 + $f2*$f2)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-32",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        330.0,
                                        240.0,
                                        22.0
                                    ],
                                    "text": "expr clip($f1/8., 0., 1.) * 127.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-33",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        915.0,
                                        360.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "i 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-34",
                                    "numinlets": 5,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "signal",
                                        "signal",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        405.0,
                                        177.0,
                                        22.0
                                    ],
                                    "text": "adsr~ 12. 180. 0.6 350.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-35",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        540.0,
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
                                    "id": "obj-36",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        570.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "*~ 0.2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-37",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        360.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "expr cos($f1 * 1.5707963267949)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-38",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        360.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "expr sin($f1 * 1.5707963267949)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-39",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        615.0,
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
                                    "id": "obj-40",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        615.0,
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
                                        795.0,
                                        285.0,
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
                                    "maxclass": "newobj",
                                    "id": "obj-42",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        900.0,
                                        330.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "cpuclock",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-43",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        960.0,
                                        360.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 - $f2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-44",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1125.0,
                                        405.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "send bach_onset",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-45",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        555.0,
                                        450.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "ftom",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-46",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        495.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * 100.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-47",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        540.0,
                                        405.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "f 440.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-48",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        510.0,
                                        540.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "send bach_pitch",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        990.0,
                                        330.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "500",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        1155.0,
                                        360.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "send bach_dur",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-51",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1260.0,
                                        405.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "send bach_vel",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-52",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1095.0,
                                        360.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "i 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-53",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1035.0,
                                        330.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "send bach_bang",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
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
                                        "obj-4",
                                        2
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
                                        "obj-6",
                                        0
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
                                        "obj-7",
                                        0
                                    ],
                                    "destination": [
                                        "obj-8",
                                        1
                                    ],
                                    "midpoints": [
                                        382.0,
                                        187.0,
                                        502.0,
                                        187.0,
                                        502.0,
                                        225.0,
                                        502.0,
                                        232.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        270.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        270.0,
                                        547.0,
                                        270.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-7",
                                        1
                                    ],
                                    "destination": [
                                        "obj-9",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        1
                                    ],
                                    "destination": [
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        407.5,
                                        67.0,
                                        532.0,
                                        67.0,
                                        532.0,
                                        105.0,
                                        532.0,
                                        112.0,
                                        510.0,
                                        112.0,
                                        510.0,
                                        150.0,
                                        570.5,
                                        150.0
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
                                        "obj-11",
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
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-12",
                                        1
                                    ],
                                    "destination": [
                                        "obj-14",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        0
                                    ],
                                    "destination": [
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        382.0,
                                        67.0,
                                        532.0,
                                        67.0,
                                        532.0,
                                        105.0,
                                        532.0,
                                        112.0,
                                        510.0,
                                        112.0,
                                        510.0,
                                        150.0,
                                        510.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        702.0,
                                        150.0
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
                                        "obj-16",
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
                                        "obj-18",
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
                                        "obj-19",
                                        0
                                    ],
                                    "destination": [
                                        "obj-22",
                                        1
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
                                        "obj-23",
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
                                        "obj-24",
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
                                        "obj-25",
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
                                        "obj-26",
                                        0
                                    ],
                                    "midpoints": [
                                        74.0,
                                        67.0,
                                        172.0,
                                        67.0,
                                        172.0,
                                        105.0,
                                        172.0,
                                        105.0
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
                                        "obj-26",
                                        1
                                    ],
                                    "midpoints": [
                                        216.0,
                                        228.5,
                                        271.0,
                                        228.5
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
                                        "obj-26",
                                        2
                                    ],
                                    "midpoints": [
                                        542.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        370.0,
                                        390.0
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
                                        "obj-27",
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
                                        "obj-29",
                                        0
                                    ],
                                    "midpoints": [
                                        271.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        412.0,
                                        397.0,
                                        357.0,
                                        397.0,
                                        357.0,
                                        435.0,
                                        417.0,
                                        435.0
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
                                        "obj-28",
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
                                        "obj-30",
                                        0
                                    ],
                                    "midpoints": [
                                        309.5,
                                        397.0,
                                        352.0,
                                        397.0,
                                        352.0,
                                        435.0,
                                        367.0,
                                        435.0
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
                                        "obj-30",
                                        1
                                    ],
                                    "midpoints": [
                                        459.5,
                                        483.5,
                                        400.5,
                                        483.5
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
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        517.0,
                                        232.0,
                                        577.0,
                                        232.0,
                                        577.0,
                                        270.0,
                                        577.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        577.0,
                                        315.0
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
                                        "obj-31",
                                        1
                                    ],
                                    "midpoints": [
                                        607.0,
                                        232.0,
                                        732.0,
                                        232.0,
                                        732.0,
                                        270.0,
                                        775.0,
                                        270.0
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
                                        "obj-32",
                                        0
                                    ],
                                    "midpoints": [
                                        676.0,
                                        318.5,
                                        765.0,
                                        318.5
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
                                        "obj-33",
                                        1
                                    ],
                                    "midpoints": [
                                        765.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        945.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        3
                                    ],
                                    "destination": [
                                        "obj-33",
                                        0
                                    ],
                                    "midpoints": [
                                        717.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        277.0,
                                        787.0,
                                        277.0,
                                        787.0,
                                        315.0,
                                        787.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        922.0,
                                        390.0
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
                                    ],
                                    "midpoints": [
                                        383.75,
                                        487.0,
                                        502.0,
                                        487.0,
                                        502.0,
                                        525.0,
                                        502.0,
                                        532.0,
                                        502.0,
                                        532.0,
                                        502.0,
                                        570.0,
                                        652.0,
                                        570.0
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
                                        "obj-35",
                                        1
                                    ],
                                    "midpoints": [
                                        937.0,
                                        483.5,
                                        680.0,
                                        483.5
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
                                        "obj-36",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        2
                                    ],
                                    "destination": [
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        695.3333333333334,
                                        232.0,
                                        547.0,
                                        232.0,
                                        547.0,
                                        270.0,
                                        547.0,
                                        232.0,
                                        577.0,
                                        232.0,
                                        577.0,
                                        270.0,
                                        577.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        517.0,
                                        315.0
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
                                        "obj-37",
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
                                        "obj-38",
                                        0
                                    ],
                                    "midpoints": [
                                        542.0,
                                        322.0,
                                        637.0,
                                        322.0,
                                        637.0,
                                        360.0,
                                        637.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        776.5,
                                        390.0
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
                                        "obj-39",
                                        0
                                    ],
                                    "midpoints": [
                                        689.0,
                                        603.5,
                                        592.0,
                                        603.5
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
                                        "obj-40",
                                        0
                                    ],
                                    "midpoints": [
                                        689.0,
                                        603.5,
                                        727.0,
                                        603.5
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
                                        1
                                    ],
                                    "midpoints": [
                                        536.5,
                                        397.0,
                                        606.0,
                                        397.0,
                                        606.0,
                                        435.0,
                                        606.0,
                                        442.0,
                                        607.0,
                                        442.0,
                                        607.0,
                                        480.0,
                                        607.0,
                                        487.0,
                                        639.0,
                                        487.0,
                                        639.0,
                                        525.0,
                                        639.0,
                                        532.0,
                                        639.0,
                                        532.0,
                                        639.0,
                                        570.0,
                                        620.0,
                                        570.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        776.5,
                                        498.5,
                                        755.0,
                                        498.5
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
                                        "obj-1",
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
                                        "obj-2",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        1
                                    ],
                                    "destination": [
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        673.6666666666666,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        841.5,
                                        315.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        4
                                    ],
                                    "destination": [
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        881.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        936.0,
                                        360.0
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
                                        "obj-43",
                                        0
                                    ],
                                    "midpoints": [
                                        936.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        967.0,
                                        390.0
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
                                        "obj-43",
                                        1
                                    ],
                                    "midpoints": [
                                        562.0,
                                        112.0,
                                        639.0,
                                        112.0,
                                        639.0,
                                        150.0,
                                        639.0,
                                        112.0,
                                        767.0,
                                        112.0,
                                        767.0,
                                        150.0,
                                        767.0,
                                        142.0,
                                        632.0,
                                        142.0,
                                        632.0,
                                        180.0,
                                        632.0,
                                        142.0,
                                        754.0,
                                        142.0,
                                        754.0,
                                        180.0,
                                        754.0,
                                        187.0,
                                        634.0,
                                        187.0,
                                        634.0,
                                        225.0,
                                        634.0,
                                        187.0,
                                        755.0,
                                        187.0,
                                        755.0,
                                        225.0,
                                        755.0,
                                        232.0,
                                        637.0,
                                        232.0,
                                        637.0,
                                        270.0,
                                        637.0,
                                        232.0,
                                        732.0,
                                        232.0,
                                        732.0,
                                        270.0,
                                        732.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        562.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        277.0,
                                        787.0,
                                        277.0,
                                        787.0,
                                        315.0,
                                        787.0,
                                        322.0,
                                        642.0,
                                        322.0,
                                        642.0,
                                        360.0,
                                        642.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        907.0,
                                        352.0,
                                        907.0,
                                        390.0,
                                        907.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        661.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        1067.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        0
                                    ],
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        1017.0,
                                        352.0,
                                        1147.0,
                                        352.0,
                                        1147.0,
                                        390.0,
                                        1147.0,
                                        352.0,
                                        1087.0,
                                        352.0,
                                        1087.0,
                                        390.0,
                                        1087.0,
                                        397.0,
                                        1115.0,
                                        397.0,
                                        1115.0,
                                        435.0,
                                        1185.5,
                                        435.0
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
                                        "obj-47",
                                        1
                                    ],
                                    "midpoints": [
                                        271.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        412.0,
                                        397.0,
                                        357.0,
                                        397.0,
                                        357.0,
                                        435.0,
                                        357.0,
                                        397.0,
                                        482.0,
                                        397.0,
                                        482.0,
                                        435.0,
                                        591.0,
                                        435.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        3
                                    ],
                                    "destination": [
                                        "obj-47",
                                        0
                                    ],
                                    "midpoints": [
                                        861.25,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        562.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        322.0,
                                        642.0,
                                        322.0,
                                        642.0,
                                        360.0,
                                        642.0,
                                        322.0,
                                        637.0,
                                        322.0,
                                        637.0,
                                        360.0,
                                        637.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        661.0,
                                        352.0,
                                        652.0,
                                        352.0,
                                        652.0,
                                        390.0,
                                        547.0,
                                        390.0
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
                                        "obj-45",
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
                                        "obj-48",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        2
                                    ],
                                    "destination": [
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        841.5,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        997.0,
                                        360.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-49",
                                        0
                                    ],
                                    "destination": [
                                        "obj-50",
                                        0
                                    ],
                                    "midpoints": [
                                        1010.0,
                                        322.0,
                                        1157.0,
                                        322.0,
                                        1157.0,
                                        360.0,
                                        1157.0,
                                        352.0,
                                        1082.0,
                                        352.0,
                                        1082.0,
                                        390.0,
                                        1082.0,
                                        352.0,
                                        1087.0,
                                        352.0,
                                        1087.0,
                                        390.0,
                                        1208.5,
                                        390.0
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
                                        "obj-52",
                                        1
                                    ],
                                    "midpoints": [
                                        765.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        960.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        901.0,
                                        352.0,
                                        952.0,
                                        352.0,
                                        952.0,
                                        390.0,
                                        1125.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        1
                                    ],
                                    "destination": [
                                        "obj-52",
                                        0
                                    ],
                                    "midpoints": [
                                        821.75,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        960.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        901.0,
                                        352.0,
                                        952.0,
                                        352.0,
                                        952.0,
                                        390.0,
                                        1102.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-52",
                                        0
                                    ],
                                    "destination": [
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        1113.5,
                                        352.0,
                                        1270.0,
                                        352.0,
                                        1270.0,
                                        390.0,
                                        1270.0,
                                        397.0,
                                        1115.0,
                                        397.0,
                                        1115.0,
                                        435.0,
                                        1115.0,
                                        397.0,
                                        1254.0,
                                        397.0,
                                        1254.0,
                                        435.0,
                                        1313.5,
                                        435.0
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
                                        "obj-53",
                                        0
                                    ],
                                    "midpoints": [
                                        802.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        1092.0,
                                        360.0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0
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
                    "maxclass": "newobj",
                    "id": "obj-53",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        4515.0,
                        30.0,
                        86.0,
                        22.0
                    ],
                    "text": "p voice-2",
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
                            400.0,
                            300.0
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
                                    "maxclass": "outlet",
                                    "id": "obj-1",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        600.0,
                                        660.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "ball 2 audio L"
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
                                        720.0,
                                        660.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "ball 2 audio R"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        30.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "receive ball-event",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        75.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "t l l l",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        360.0,
                                        120.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "bach.keys position",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        150.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.llll2list",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        195.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack 0. 0.",
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
                                        510.0,
                                        285.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-9",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        435.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-10",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        120.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "bach.keys speed",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-11",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        150.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.llll2list",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        195.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack 0. 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-13",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        495.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-14",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-15",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        120.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.keys ball",
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
                                        660.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-17",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        675.0,
                                        195.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "select 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-18",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "receive v2_min_hz",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-19",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        30.0,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "receive v2_max_hz",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-20",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        30.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "receive v2_session_start",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-21",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        45.0,
                                        75.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "f 55.0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-22",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        75.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "f 4186.0",
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        540.0,
                                        75.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-24",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        240.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "t b b b b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-25",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        330.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "expr ($f1 + 100.) / 200.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-26",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        360.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * pow($f2/$f1, $f3)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-27",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        405.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "cycle~ 0.",
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        450.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "cycle~ 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-29",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        405.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * 3.0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-30",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        495.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-31",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        285.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "expr sqrt($f1*$f1 + $f2*$f2)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-32",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        330.0,
                                        240.0,
                                        22.0
                                    ],
                                    "text": "expr clip($f1/8., 0., 1.) * 127.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-33",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        915.0,
                                        360.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "i 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-34",
                                    "numinlets": 5,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "signal",
                                        "signal",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        405.0,
                                        177.0,
                                        22.0
                                    ],
                                    "text": "adsr~ 12. 180. 0.6 350.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-35",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        540.0,
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
                                    "id": "obj-36",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        570.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "*~ 0.2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-37",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        360.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "expr cos($f1 * 1.5707963267949)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-38",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        360.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "expr sin($f1 * 1.5707963267949)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-39",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        615.0,
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
                                    "id": "obj-40",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        615.0,
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
                                        795.0,
                                        285.0,
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
                                    "maxclass": "newobj",
                                    "id": "obj-42",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        900.0,
                                        330.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "cpuclock",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-43",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        960.0,
                                        360.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 - $f2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-44",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1125.0,
                                        405.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "send bach_onset",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-45",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        555.0,
                                        450.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "ftom",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-46",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        495.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * 100.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-47",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        540.0,
                                        405.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "f 440.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-48",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        510.0,
                                        540.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "send bach_pitch",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        990.0,
                                        330.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "500",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        1155.0,
                                        360.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "send bach_dur",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-51",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1260.0,
                                        405.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "send bach_vel",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-52",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1095.0,
                                        360.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "i 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-53",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1035.0,
                                        330.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "send bach_bang",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
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
                                        "obj-4",
                                        2
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
                                        "obj-6",
                                        0
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
                                        "obj-7",
                                        0
                                    ],
                                    "destination": [
                                        "obj-8",
                                        1
                                    ],
                                    "midpoints": [
                                        382.0,
                                        187.0,
                                        502.0,
                                        187.0,
                                        502.0,
                                        225.0,
                                        502.0,
                                        232.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        270.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        270.0,
                                        547.0,
                                        270.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-7",
                                        1
                                    ],
                                    "destination": [
                                        "obj-9",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        1
                                    ],
                                    "destination": [
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        407.5,
                                        67.0,
                                        532.0,
                                        67.0,
                                        532.0,
                                        105.0,
                                        532.0,
                                        112.0,
                                        510.0,
                                        112.0,
                                        510.0,
                                        150.0,
                                        570.5,
                                        150.0
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
                                        "obj-11",
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
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-12",
                                        1
                                    ],
                                    "destination": [
                                        "obj-14",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        0
                                    ],
                                    "destination": [
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        382.0,
                                        67.0,
                                        532.0,
                                        67.0,
                                        532.0,
                                        105.0,
                                        532.0,
                                        112.0,
                                        510.0,
                                        112.0,
                                        510.0,
                                        150.0,
                                        510.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        702.0,
                                        150.0
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
                                        "obj-16",
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
                                        "obj-18",
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
                                        "obj-19",
                                        0
                                    ],
                                    "destination": [
                                        "obj-22",
                                        1
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
                                        "obj-23",
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
                                        "obj-24",
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
                                        "obj-25",
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
                                        "obj-26",
                                        0
                                    ],
                                    "midpoints": [
                                        74.0,
                                        67.0,
                                        172.0,
                                        67.0,
                                        172.0,
                                        105.0,
                                        172.0,
                                        105.0
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
                                        "obj-26",
                                        1
                                    ],
                                    "midpoints": [
                                        216.0,
                                        228.5,
                                        271.0,
                                        228.5
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
                                        "obj-26",
                                        2
                                    ],
                                    "midpoints": [
                                        542.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        370.0,
                                        390.0
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
                                        "obj-27",
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
                                        "obj-29",
                                        0
                                    ],
                                    "midpoints": [
                                        271.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        412.0,
                                        397.0,
                                        357.0,
                                        397.0,
                                        357.0,
                                        435.0,
                                        417.0,
                                        435.0
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
                                        "obj-28",
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
                                        "obj-30",
                                        0
                                    ],
                                    "midpoints": [
                                        309.5,
                                        397.0,
                                        352.0,
                                        397.0,
                                        352.0,
                                        435.0,
                                        367.0,
                                        435.0
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
                                        "obj-30",
                                        1
                                    ],
                                    "midpoints": [
                                        459.5,
                                        483.5,
                                        400.5,
                                        483.5
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
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        517.0,
                                        232.0,
                                        577.0,
                                        232.0,
                                        577.0,
                                        270.0,
                                        577.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        577.0,
                                        315.0
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
                                        "obj-31",
                                        1
                                    ],
                                    "midpoints": [
                                        607.0,
                                        232.0,
                                        732.0,
                                        232.0,
                                        732.0,
                                        270.0,
                                        775.0,
                                        270.0
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
                                        "obj-32",
                                        0
                                    ],
                                    "midpoints": [
                                        676.0,
                                        318.5,
                                        765.0,
                                        318.5
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
                                        "obj-33",
                                        1
                                    ],
                                    "midpoints": [
                                        765.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        945.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        3
                                    ],
                                    "destination": [
                                        "obj-33",
                                        0
                                    ],
                                    "midpoints": [
                                        717.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        277.0,
                                        787.0,
                                        277.0,
                                        787.0,
                                        315.0,
                                        787.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        922.0,
                                        390.0
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
                                    ],
                                    "midpoints": [
                                        383.75,
                                        487.0,
                                        502.0,
                                        487.0,
                                        502.0,
                                        525.0,
                                        502.0,
                                        532.0,
                                        502.0,
                                        532.0,
                                        502.0,
                                        570.0,
                                        652.0,
                                        570.0
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
                                        "obj-35",
                                        1
                                    ],
                                    "midpoints": [
                                        937.0,
                                        483.5,
                                        680.0,
                                        483.5
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
                                        "obj-36",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        2
                                    ],
                                    "destination": [
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        695.3333333333334,
                                        232.0,
                                        547.0,
                                        232.0,
                                        547.0,
                                        270.0,
                                        547.0,
                                        232.0,
                                        577.0,
                                        232.0,
                                        577.0,
                                        270.0,
                                        577.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        517.0,
                                        315.0
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
                                        "obj-37",
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
                                        "obj-38",
                                        0
                                    ],
                                    "midpoints": [
                                        542.0,
                                        322.0,
                                        637.0,
                                        322.0,
                                        637.0,
                                        360.0,
                                        637.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        776.5,
                                        390.0
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
                                        "obj-39",
                                        0
                                    ],
                                    "midpoints": [
                                        689.0,
                                        603.5,
                                        592.0,
                                        603.5
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
                                        "obj-40",
                                        0
                                    ],
                                    "midpoints": [
                                        689.0,
                                        603.5,
                                        727.0,
                                        603.5
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
                                        1
                                    ],
                                    "midpoints": [
                                        536.5,
                                        397.0,
                                        606.0,
                                        397.0,
                                        606.0,
                                        435.0,
                                        606.0,
                                        442.0,
                                        607.0,
                                        442.0,
                                        607.0,
                                        480.0,
                                        607.0,
                                        487.0,
                                        639.0,
                                        487.0,
                                        639.0,
                                        525.0,
                                        639.0,
                                        532.0,
                                        639.0,
                                        532.0,
                                        639.0,
                                        570.0,
                                        620.0,
                                        570.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        776.5,
                                        498.5,
                                        755.0,
                                        498.5
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
                                        "obj-1",
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
                                        "obj-2",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        1
                                    ],
                                    "destination": [
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        673.6666666666666,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        841.5,
                                        315.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        4
                                    ],
                                    "destination": [
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        881.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        936.0,
                                        360.0
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
                                        "obj-43",
                                        0
                                    ],
                                    "midpoints": [
                                        936.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        967.0,
                                        390.0
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
                                        "obj-43",
                                        1
                                    ],
                                    "midpoints": [
                                        562.0,
                                        112.0,
                                        639.0,
                                        112.0,
                                        639.0,
                                        150.0,
                                        639.0,
                                        112.0,
                                        767.0,
                                        112.0,
                                        767.0,
                                        150.0,
                                        767.0,
                                        142.0,
                                        632.0,
                                        142.0,
                                        632.0,
                                        180.0,
                                        632.0,
                                        142.0,
                                        754.0,
                                        142.0,
                                        754.0,
                                        180.0,
                                        754.0,
                                        187.0,
                                        634.0,
                                        187.0,
                                        634.0,
                                        225.0,
                                        634.0,
                                        187.0,
                                        755.0,
                                        187.0,
                                        755.0,
                                        225.0,
                                        755.0,
                                        232.0,
                                        637.0,
                                        232.0,
                                        637.0,
                                        270.0,
                                        637.0,
                                        232.0,
                                        732.0,
                                        232.0,
                                        732.0,
                                        270.0,
                                        732.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        562.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        277.0,
                                        787.0,
                                        277.0,
                                        787.0,
                                        315.0,
                                        787.0,
                                        322.0,
                                        642.0,
                                        322.0,
                                        642.0,
                                        360.0,
                                        642.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        907.0,
                                        352.0,
                                        907.0,
                                        390.0,
                                        907.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        661.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        1067.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        0
                                    ],
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        1017.0,
                                        352.0,
                                        1147.0,
                                        352.0,
                                        1147.0,
                                        390.0,
                                        1147.0,
                                        352.0,
                                        1087.0,
                                        352.0,
                                        1087.0,
                                        390.0,
                                        1087.0,
                                        397.0,
                                        1115.0,
                                        397.0,
                                        1115.0,
                                        435.0,
                                        1185.5,
                                        435.0
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
                                        "obj-47",
                                        1
                                    ],
                                    "midpoints": [
                                        271.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        412.0,
                                        397.0,
                                        357.0,
                                        397.0,
                                        357.0,
                                        435.0,
                                        357.0,
                                        397.0,
                                        482.0,
                                        397.0,
                                        482.0,
                                        435.0,
                                        591.0,
                                        435.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        3
                                    ],
                                    "destination": [
                                        "obj-47",
                                        0
                                    ],
                                    "midpoints": [
                                        861.25,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        562.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        322.0,
                                        642.0,
                                        322.0,
                                        642.0,
                                        360.0,
                                        642.0,
                                        322.0,
                                        637.0,
                                        322.0,
                                        637.0,
                                        360.0,
                                        637.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        661.0,
                                        352.0,
                                        652.0,
                                        352.0,
                                        652.0,
                                        390.0,
                                        547.0,
                                        390.0
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
                                        "obj-45",
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
                                        "obj-48",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        2
                                    ],
                                    "destination": [
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        841.5,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        997.0,
                                        360.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-49",
                                        0
                                    ],
                                    "destination": [
                                        "obj-50",
                                        0
                                    ],
                                    "midpoints": [
                                        1010.0,
                                        322.0,
                                        1157.0,
                                        322.0,
                                        1157.0,
                                        360.0,
                                        1157.0,
                                        352.0,
                                        1082.0,
                                        352.0,
                                        1082.0,
                                        390.0,
                                        1082.0,
                                        352.0,
                                        1087.0,
                                        352.0,
                                        1087.0,
                                        390.0,
                                        1208.5,
                                        390.0
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
                                        "obj-52",
                                        1
                                    ],
                                    "midpoints": [
                                        765.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        960.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        901.0,
                                        352.0,
                                        952.0,
                                        352.0,
                                        952.0,
                                        390.0,
                                        1125.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        1
                                    ],
                                    "destination": [
                                        "obj-52",
                                        0
                                    ],
                                    "midpoints": [
                                        821.75,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        960.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        901.0,
                                        352.0,
                                        952.0,
                                        352.0,
                                        952.0,
                                        390.0,
                                        1102.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-52",
                                        0
                                    ],
                                    "destination": [
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        1113.5,
                                        352.0,
                                        1270.0,
                                        352.0,
                                        1270.0,
                                        390.0,
                                        1270.0,
                                        397.0,
                                        1115.0,
                                        397.0,
                                        1115.0,
                                        435.0,
                                        1115.0,
                                        397.0,
                                        1254.0,
                                        397.0,
                                        1254.0,
                                        435.0,
                                        1313.5,
                                        435.0
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
                                        "obj-53",
                                        0
                                    ],
                                    "midpoints": [
                                        802.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        1092.0,
                                        360.0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0
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
                    "maxclass": "newobj",
                    "id": "obj-54",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        4620.0,
                        30.0,
                        86.0,
                        22.0
                    ],
                    "text": "p voice-3",
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
                            400.0,
                            300.0
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
                                    "maxclass": "outlet",
                                    "id": "obj-1",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        600.0,
                                        660.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "ball 3 audio L"
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
                                        720.0,
                                        660.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "ball 3 audio R"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        30.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "receive ball-event",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        75.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "t l l l",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        360.0,
                                        120.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "bach.keys position",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        150.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.llll2list",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        195.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack 0. 0.",
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
                                        510.0,
                                        285.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-9",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        435.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-10",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        120.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "bach.keys speed",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-11",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        150.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.llll2list",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        195.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack 0. 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-13",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        495.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-14",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-15",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        120.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.keys ball",
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
                                        660.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-17",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        675.0,
                                        195.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "select 3",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-18",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "receive v3_min_hz",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-19",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        30.0,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "receive v3_max_hz",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-20",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        30.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "receive v3_session_start",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-21",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        45.0,
                                        75.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "f 55.0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-22",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        75.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "f 4186.0",
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        540.0,
                                        75.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-24",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        240.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "t b b b b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-25",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        330.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "expr ($f1 + 100.) / 200.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-26",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        360.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * pow($f2/$f1, $f3)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-27",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        405.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "cycle~ 0.",
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        450.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "cycle~ 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-29",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        405.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * 1.5",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-30",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        495.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-31",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        285.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "expr sqrt($f1*$f1 + $f2*$f2)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-32",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        330.0,
                                        240.0,
                                        22.0
                                    ],
                                    "text": "expr clip($f1/8., 0., 1.) * 127.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-33",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        915.0,
                                        360.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "i 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-34",
                                    "numinlets": 5,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "signal",
                                        "signal",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        405.0,
                                        177.0,
                                        22.0
                                    ],
                                    "text": "adsr~ 12. 180. 0.6 350.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-35",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        540.0,
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
                                    "id": "obj-36",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        570.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "*~ 0.2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-37",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        360.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "expr cos($f1 * 1.5707963267949)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-38",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        360.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "expr sin($f1 * 1.5707963267949)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-39",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        615.0,
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
                                    "id": "obj-40",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        615.0,
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
                                        795.0,
                                        285.0,
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
                                    "maxclass": "newobj",
                                    "id": "obj-42",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        900.0,
                                        330.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "cpuclock",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-43",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        960.0,
                                        360.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 - $f2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-44",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1125.0,
                                        405.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "send bach_onset",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-45",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        555.0,
                                        450.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "ftom",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-46",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        495.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * 100.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-47",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        540.0,
                                        405.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "f 440.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-48",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        510.0,
                                        540.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "send bach_pitch",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        990.0,
                                        330.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "500",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        1155.0,
                                        360.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "send bach_dur",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-51",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1260.0,
                                        405.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "send bach_vel",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-52",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1095.0,
                                        360.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "i 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-53",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1035.0,
                                        330.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "send bach_bang",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
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
                                        "obj-4",
                                        2
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
                                        "obj-6",
                                        0
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
                                        "obj-7",
                                        0
                                    ],
                                    "destination": [
                                        "obj-8",
                                        1
                                    ],
                                    "midpoints": [
                                        382.0,
                                        187.0,
                                        502.0,
                                        187.0,
                                        502.0,
                                        225.0,
                                        502.0,
                                        232.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        270.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        270.0,
                                        547.0,
                                        270.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-7",
                                        1
                                    ],
                                    "destination": [
                                        "obj-9",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        1
                                    ],
                                    "destination": [
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        407.5,
                                        67.0,
                                        532.0,
                                        67.0,
                                        532.0,
                                        105.0,
                                        532.0,
                                        112.0,
                                        510.0,
                                        112.0,
                                        510.0,
                                        150.0,
                                        570.5,
                                        150.0
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
                                        "obj-11",
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
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-12",
                                        1
                                    ],
                                    "destination": [
                                        "obj-14",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        0
                                    ],
                                    "destination": [
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        382.0,
                                        67.0,
                                        532.0,
                                        67.0,
                                        532.0,
                                        105.0,
                                        532.0,
                                        112.0,
                                        510.0,
                                        112.0,
                                        510.0,
                                        150.0,
                                        510.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        702.0,
                                        150.0
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
                                        "obj-16",
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
                                        "obj-18",
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
                                        "obj-19",
                                        0
                                    ],
                                    "destination": [
                                        "obj-22",
                                        1
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
                                        "obj-23",
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
                                        "obj-24",
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
                                        "obj-25",
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
                                        "obj-26",
                                        0
                                    ],
                                    "midpoints": [
                                        74.0,
                                        67.0,
                                        172.0,
                                        67.0,
                                        172.0,
                                        105.0,
                                        172.0,
                                        105.0
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
                                        "obj-26",
                                        1
                                    ],
                                    "midpoints": [
                                        216.0,
                                        228.5,
                                        271.0,
                                        228.5
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
                                        "obj-26",
                                        2
                                    ],
                                    "midpoints": [
                                        542.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        370.0,
                                        390.0
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
                                        "obj-27",
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
                                        "obj-29",
                                        0
                                    ],
                                    "midpoints": [
                                        271.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        412.0,
                                        397.0,
                                        357.0,
                                        397.0,
                                        357.0,
                                        435.0,
                                        417.0,
                                        435.0
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
                                        "obj-28",
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
                                        "obj-30",
                                        0
                                    ],
                                    "midpoints": [
                                        309.5,
                                        397.0,
                                        352.0,
                                        397.0,
                                        352.0,
                                        435.0,
                                        367.0,
                                        435.0
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
                                        "obj-30",
                                        1
                                    ],
                                    "midpoints": [
                                        459.5,
                                        483.5,
                                        400.5,
                                        483.5
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
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        517.0,
                                        232.0,
                                        577.0,
                                        232.0,
                                        577.0,
                                        270.0,
                                        577.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        577.0,
                                        315.0
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
                                        "obj-31",
                                        1
                                    ],
                                    "midpoints": [
                                        607.0,
                                        232.0,
                                        732.0,
                                        232.0,
                                        732.0,
                                        270.0,
                                        775.0,
                                        270.0
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
                                        "obj-32",
                                        0
                                    ],
                                    "midpoints": [
                                        676.0,
                                        318.5,
                                        765.0,
                                        318.5
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
                                        "obj-33",
                                        1
                                    ],
                                    "midpoints": [
                                        765.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        945.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        3
                                    ],
                                    "destination": [
                                        "obj-33",
                                        0
                                    ],
                                    "midpoints": [
                                        717.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        277.0,
                                        787.0,
                                        277.0,
                                        787.0,
                                        315.0,
                                        787.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        922.0,
                                        390.0
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
                                    ],
                                    "midpoints": [
                                        383.75,
                                        487.0,
                                        502.0,
                                        487.0,
                                        502.0,
                                        525.0,
                                        502.0,
                                        532.0,
                                        502.0,
                                        532.0,
                                        502.0,
                                        570.0,
                                        652.0,
                                        570.0
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
                                        "obj-35",
                                        1
                                    ],
                                    "midpoints": [
                                        937.0,
                                        483.5,
                                        680.0,
                                        483.5
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
                                        "obj-36",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        2
                                    ],
                                    "destination": [
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        695.3333333333334,
                                        232.0,
                                        547.0,
                                        232.0,
                                        547.0,
                                        270.0,
                                        547.0,
                                        232.0,
                                        577.0,
                                        232.0,
                                        577.0,
                                        270.0,
                                        577.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        517.0,
                                        315.0
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
                                        "obj-37",
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
                                        "obj-38",
                                        0
                                    ],
                                    "midpoints": [
                                        542.0,
                                        322.0,
                                        637.0,
                                        322.0,
                                        637.0,
                                        360.0,
                                        637.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        776.5,
                                        390.0
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
                                        "obj-39",
                                        0
                                    ],
                                    "midpoints": [
                                        689.0,
                                        603.5,
                                        592.0,
                                        603.5
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
                                        "obj-40",
                                        0
                                    ],
                                    "midpoints": [
                                        689.0,
                                        603.5,
                                        727.0,
                                        603.5
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
                                        1
                                    ],
                                    "midpoints": [
                                        536.5,
                                        397.0,
                                        606.0,
                                        397.0,
                                        606.0,
                                        435.0,
                                        606.0,
                                        442.0,
                                        607.0,
                                        442.0,
                                        607.0,
                                        480.0,
                                        607.0,
                                        487.0,
                                        639.0,
                                        487.0,
                                        639.0,
                                        525.0,
                                        639.0,
                                        532.0,
                                        639.0,
                                        532.0,
                                        639.0,
                                        570.0,
                                        620.0,
                                        570.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        776.5,
                                        498.5,
                                        755.0,
                                        498.5
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
                                        "obj-1",
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
                                        "obj-2",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        1
                                    ],
                                    "destination": [
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        673.6666666666666,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        841.5,
                                        315.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        4
                                    ],
                                    "destination": [
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        881.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        936.0,
                                        360.0
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
                                        "obj-43",
                                        0
                                    ],
                                    "midpoints": [
                                        936.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        967.0,
                                        390.0
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
                                        "obj-43",
                                        1
                                    ],
                                    "midpoints": [
                                        562.0,
                                        112.0,
                                        639.0,
                                        112.0,
                                        639.0,
                                        150.0,
                                        639.0,
                                        112.0,
                                        767.0,
                                        112.0,
                                        767.0,
                                        150.0,
                                        767.0,
                                        142.0,
                                        632.0,
                                        142.0,
                                        632.0,
                                        180.0,
                                        632.0,
                                        142.0,
                                        754.0,
                                        142.0,
                                        754.0,
                                        180.0,
                                        754.0,
                                        187.0,
                                        634.0,
                                        187.0,
                                        634.0,
                                        225.0,
                                        634.0,
                                        187.0,
                                        755.0,
                                        187.0,
                                        755.0,
                                        225.0,
                                        755.0,
                                        232.0,
                                        637.0,
                                        232.0,
                                        637.0,
                                        270.0,
                                        637.0,
                                        232.0,
                                        732.0,
                                        232.0,
                                        732.0,
                                        270.0,
                                        732.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        562.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        277.0,
                                        787.0,
                                        277.0,
                                        787.0,
                                        315.0,
                                        787.0,
                                        322.0,
                                        642.0,
                                        322.0,
                                        642.0,
                                        360.0,
                                        642.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        907.0,
                                        352.0,
                                        907.0,
                                        390.0,
                                        907.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        661.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        1067.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        0
                                    ],
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        1017.0,
                                        352.0,
                                        1147.0,
                                        352.0,
                                        1147.0,
                                        390.0,
                                        1147.0,
                                        352.0,
                                        1087.0,
                                        352.0,
                                        1087.0,
                                        390.0,
                                        1087.0,
                                        397.0,
                                        1115.0,
                                        397.0,
                                        1115.0,
                                        435.0,
                                        1185.5,
                                        435.0
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
                                        "obj-47",
                                        1
                                    ],
                                    "midpoints": [
                                        271.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        412.0,
                                        397.0,
                                        357.0,
                                        397.0,
                                        357.0,
                                        435.0,
                                        357.0,
                                        397.0,
                                        482.0,
                                        397.0,
                                        482.0,
                                        435.0,
                                        591.0,
                                        435.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        3
                                    ],
                                    "destination": [
                                        "obj-47",
                                        0
                                    ],
                                    "midpoints": [
                                        861.25,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        562.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        322.0,
                                        642.0,
                                        322.0,
                                        642.0,
                                        360.0,
                                        642.0,
                                        322.0,
                                        637.0,
                                        322.0,
                                        637.0,
                                        360.0,
                                        637.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        661.0,
                                        352.0,
                                        652.0,
                                        352.0,
                                        652.0,
                                        390.0,
                                        547.0,
                                        390.0
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
                                        "obj-45",
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
                                        "obj-48",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        2
                                    ],
                                    "destination": [
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        841.5,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        997.0,
                                        360.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-49",
                                        0
                                    ],
                                    "destination": [
                                        "obj-50",
                                        0
                                    ],
                                    "midpoints": [
                                        1010.0,
                                        322.0,
                                        1157.0,
                                        322.0,
                                        1157.0,
                                        360.0,
                                        1157.0,
                                        352.0,
                                        1082.0,
                                        352.0,
                                        1082.0,
                                        390.0,
                                        1082.0,
                                        352.0,
                                        1087.0,
                                        352.0,
                                        1087.0,
                                        390.0,
                                        1208.5,
                                        390.0
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
                                        "obj-52",
                                        1
                                    ],
                                    "midpoints": [
                                        765.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        960.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        901.0,
                                        352.0,
                                        952.0,
                                        352.0,
                                        952.0,
                                        390.0,
                                        1125.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        1
                                    ],
                                    "destination": [
                                        "obj-52",
                                        0
                                    ],
                                    "midpoints": [
                                        821.75,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        960.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        901.0,
                                        352.0,
                                        952.0,
                                        352.0,
                                        952.0,
                                        390.0,
                                        1102.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-52",
                                        0
                                    ],
                                    "destination": [
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        1113.5,
                                        352.0,
                                        1270.0,
                                        352.0,
                                        1270.0,
                                        390.0,
                                        1270.0,
                                        397.0,
                                        1115.0,
                                        397.0,
                                        1115.0,
                                        435.0,
                                        1115.0,
                                        397.0,
                                        1254.0,
                                        397.0,
                                        1254.0,
                                        435.0,
                                        1313.5,
                                        435.0
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
                                        "obj-53",
                                        0
                                    ],
                                    "midpoints": [
                                        802.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        1092.0,
                                        360.0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0
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
                    "maxclass": "newobj",
                    "id": "obj-55",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        4725.0,
                        30.0,
                        86.0,
                        22.0
                    ],
                    "text": "p voice-4",
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
                            400.0,
                            300.0
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
                                    "maxclass": "outlet",
                                    "id": "obj-1",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        600.0,
                                        660.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "ball 4 audio L"
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
                                        720.0,
                                        660.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "ball 4 audio R"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        30.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "receive ball-event",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        75.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "t l l l",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        360.0,
                                        120.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "bach.keys position",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        150.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.llll2list",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        195.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack 0. 0.",
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
                                        510.0,
                                        285.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-9",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        435.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-10",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        120.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "bach.keys speed",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-11",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        150.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.llll2list",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        195.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack 0. 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-13",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        495.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-14",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-15",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        120.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.keys ball",
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
                                        660.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-17",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        675.0,
                                        195.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "select 4",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-18",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "receive v4_min_hz",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-19",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        30.0,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "receive v4_max_hz",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-20",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        30.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "receive v4_session_start",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-21",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        45.0,
                                        75.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "f 55.0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-22",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        75.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "f 4186.0",
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        540.0,
                                        75.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-24",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        240.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "t b b b b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-25",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        330.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "expr ($f1 + 100.) / 200.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-26",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        360.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * pow($f2/$f1, $f3)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-27",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        405.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "cycle~ 0.",
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        450.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "cycle~ 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-29",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        405.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * 2.5",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-30",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        495.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-31",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        285.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "expr sqrt($f1*$f1 + $f2*$f2)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-32",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        330.0,
                                        240.0,
                                        22.0
                                    ],
                                    "text": "expr clip($f1/8., 0., 1.) * 127.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-33",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        915.0,
                                        360.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "i 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-34",
                                    "numinlets": 5,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "signal",
                                        "signal",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        405.0,
                                        177.0,
                                        22.0
                                    ],
                                    "text": "adsr~ 12. 180. 0.6 350.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-35",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        540.0,
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
                                    "id": "obj-36",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        570.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "*~ 0.2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-37",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        360.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "expr cos($f1 * 1.5707963267949)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-38",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        360.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "expr sin($f1 * 1.5707963267949)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-39",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        615.0,
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
                                    "id": "obj-40",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        615.0,
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
                                        795.0,
                                        285.0,
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
                                    "maxclass": "newobj",
                                    "id": "obj-42",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        900.0,
                                        330.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "cpuclock",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-43",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        960.0,
                                        360.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 - $f2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-44",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1125.0,
                                        405.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "send bach_onset",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-45",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        555.0,
                                        450.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "ftom",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-46",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        495.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * 100.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-47",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        540.0,
                                        405.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "f 440.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-48",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        510.0,
                                        540.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "send bach_pitch",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        990.0,
                                        330.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "500",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        1155.0,
                                        360.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "send bach_dur",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-51",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1260.0,
                                        405.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "send bach_vel",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-52",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1095.0,
                                        360.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "i 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-53",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1035.0,
                                        330.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "send bach_bang",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
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
                                        "obj-4",
                                        2
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
                                        "obj-6",
                                        0
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
                                        "obj-7",
                                        0
                                    ],
                                    "destination": [
                                        "obj-8",
                                        1
                                    ],
                                    "midpoints": [
                                        382.0,
                                        187.0,
                                        502.0,
                                        187.0,
                                        502.0,
                                        225.0,
                                        502.0,
                                        232.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        270.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        270.0,
                                        547.0,
                                        270.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-7",
                                        1
                                    ],
                                    "destination": [
                                        "obj-9",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        1
                                    ],
                                    "destination": [
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        407.5,
                                        67.0,
                                        532.0,
                                        67.0,
                                        532.0,
                                        105.0,
                                        532.0,
                                        112.0,
                                        510.0,
                                        112.0,
                                        510.0,
                                        150.0,
                                        570.5,
                                        150.0
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
                                        "obj-11",
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
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-12",
                                        1
                                    ],
                                    "destination": [
                                        "obj-14",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        0
                                    ],
                                    "destination": [
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        382.0,
                                        67.0,
                                        532.0,
                                        67.0,
                                        532.0,
                                        105.0,
                                        532.0,
                                        112.0,
                                        510.0,
                                        112.0,
                                        510.0,
                                        150.0,
                                        510.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        702.0,
                                        150.0
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
                                        "obj-16",
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
                                        "obj-18",
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
                                        "obj-19",
                                        0
                                    ],
                                    "destination": [
                                        "obj-22",
                                        1
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
                                        "obj-23",
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
                                        "obj-24",
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
                                        "obj-25",
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
                                        "obj-26",
                                        0
                                    ],
                                    "midpoints": [
                                        74.0,
                                        67.0,
                                        172.0,
                                        67.0,
                                        172.0,
                                        105.0,
                                        172.0,
                                        105.0
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
                                        "obj-26",
                                        1
                                    ],
                                    "midpoints": [
                                        216.0,
                                        228.5,
                                        271.0,
                                        228.5
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
                                        "obj-26",
                                        2
                                    ],
                                    "midpoints": [
                                        542.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        370.0,
                                        390.0
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
                                        "obj-27",
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
                                        "obj-29",
                                        0
                                    ],
                                    "midpoints": [
                                        271.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        412.0,
                                        397.0,
                                        357.0,
                                        397.0,
                                        357.0,
                                        435.0,
                                        417.0,
                                        435.0
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
                                        "obj-28",
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
                                        "obj-30",
                                        0
                                    ],
                                    "midpoints": [
                                        309.5,
                                        397.0,
                                        352.0,
                                        397.0,
                                        352.0,
                                        435.0,
                                        367.0,
                                        435.0
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
                                        "obj-30",
                                        1
                                    ],
                                    "midpoints": [
                                        459.5,
                                        483.5,
                                        400.5,
                                        483.5
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
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        517.0,
                                        232.0,
                                        577.0,
                                        232.0,
                                        577.0,
                                        270.0,
                                        577.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        577.0,
                                        315.0
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
                                        "obj-31",
                                        1
                                    ],
                                    "midpoints": [
                                        607.0,
                                        232.0,
                                        732.0,
                                        232.0,
                                        732.0,
                                        270.0,
                                        775.0,
                                        270.0
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
                                        "obj-32",
                                        0
                                    ],
                                    "midpoints": [
                                        676.0,
                                        318.5,
                                        765.0,
                                        318.5
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
                                        "obj-33",
                                        1
                                    ],
                                    "midpoints": [
                                        765.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        945.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        3
                                    ],
                                    "destination": [
                                        "obj-33",
                                        0
                                    ],
                                    "midpoints": [
                                        717.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        277.0,
                                        787.0,
                                        277.0,
                                        787.0,
                                        315.0,
                                        787.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        922.0,
                                        390.0
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
                                    ],
                                    "midpoints": [
                                        383.75,
                                        487.0,
                                        502.0,
                                        487.0,
                                        502.0,
                                        525.0,
                                        502.0,
                                        532.0,
                                        502.0,
                                        532.0,
                                        502.0,
                                        570.0,
                                        652.0,
                                        570.0
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
                                        "obj-35",
                                        1
                                    ],
                                    "midpoints": [
                                        937.0,
                                        483.5,
                                        680.0,
                                        483.5
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
                                        "obj-36",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        2
                                    ],
                                    "destination": [
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        695.3333333333334,
                                        232.0,
                                        547.0,
                                        232.0,
                                        547.0,
                                        270.0,
                                        547.0,
                                        232.0,
                                        577.0,
                                        232.0,
                                        577.0,
                                        270.0,
                                        577.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        517.0,
                                        315.0
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
                                        "obj-37",
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
                                        "obj-38",
                                        0
                                    ],
                                    "midpoints": [
                                        542.0,
                                        322.0,
                                        637.0,
                                        322.0,
                                        637.0,
                                        360.0,
                                        637.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        776.5,
                                        390.0
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
                                        "obj-39",
                                        0
                                    ],
                                    "midpoints": [
                                        689.0,
                                        603.5,
                                        592.0,
                                        603.5
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
                                        "obj-40",
                                        0
                                    ],
                                    "midpoints": [
                                        689.0,
                                        603.5,
                                        727.0,
                                        603.5
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
                                        1
                                    ],
                                    "midpoints": [
                                        536.5,
                                        397.0,
                                        606.0,
                                        397.0,
                                        606.0,
                                        435.0,
                                        606.0,
                                        442.0,
                                        607.0,
                                        442.0,
                                        607.0,
                                        480.0,
                                        607.0,
                                        487.0,
                                        639.0,
                                        487.0,
                                        639.0,
                                        525.0,
                                        639.0,
                                        532.0,
                                        639.0,
                                        532.0,
                                        639.0,
                                        570.0,
                                        620.0,
                                        570.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        776.5,
                                        498.5,
                                        755.0,
                                        498.5
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
                                        "obj-1",
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
                                        "obj-2",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        1
                                    ],
                                    "destination": [
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        673.6666666666666,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        841.5,
                                        315.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        4
                                    ],
                                    "destination": [
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        881.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        936.0,
                                        360.0
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
                                        "obj-43",
                                        0
                                    ],
                                    "midpoints": [
                                        936.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        967.0,
                                        390.0
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
                                        "obj-43",
                                        1
                                    ],
                                    "midpoints": [
                                        562.0,
                                        112.0,
                                        639.0,
                                        112.0,
                                        639.0,
                                        150.0,
                                        639.0,
                                        112.0,
                                        767.0,
                                        112.0,
                                        767.0,
                                        150.0,
                                        767.0,
                                        142.0,
                                        632.0,
                                        142.0,
                                        632.0,
                                        180.0,
                                        632.0,
                                        142.0,
                                        754.0,
                                        142.0,
                                        754.0,
                                        180.0,
                                        754.0,
                                        187.0,
                                        634.0,
                                        187.0,
                                        634.0,
                                        225.0,
                                        634.0,
                                        187.0,
                                        755.0,
                                        187.0,
                                        755.0,
                                        225.0,
                                        755.0,
                                        232.0,
                                        637.0,
                                        232.0,
                                        637.0,
                                        270.0,
                                        637.0,
                                        232.0,
                                        732.0,
                                        232.0,
                                        732.0,
                                        270.0,
                                        732.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        562.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        277.0,
                                        787.0,
                                        277.0,
                                        787.0,
                                        315.0,
                                        787.0,
                                        322.0,
                                        642.0,
                                        322.0,
                                        642.0,
                                        360.0,
                                        642.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        907.0,
                                        352.0,
                                        907.0,
                                        390.0,
                                        907.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        661.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        1067.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        0
                                    ],
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        1017.0,
                                        352.0,
                                        1147.0,
                                        352.0,
                                        1147.0,
                                        390.0,
                                        1147.0,
                                        352.0,
                                        1087.0,
                                        352.0,
                                        1087.0,
                                        390.0,
                                        1087.0,
                                        397.0,
                                        1115.0,
                                        397.0,
                                        1115.0,
                                        435.0,
                                        1185.5,
                                        435.0
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
                                        "obj-47",
                                        1
                                    ],
                                    "midpoints": [
                                        271.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        412.0,
                                        397.0,
                                        357.0,
                                        397.0,
                                        357.0,
                                        435.0,
                                        357.0,
                                        397.0,
                                        482.0,
                                        397.0,
                                        482.0,
                                        435.0,
                                        591.0,
                                        435.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        3
                                    ],
                                    "destination": [
                                        "obj-47",
                                        0
                                    ],
                                    "midpoints": [
                                        861.25,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        562.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        322.0,
                                        642.0,
                                        322.0,
                                        642.0,
                                        360.0,
                                        642.0,
                                        322.0,
                                        637.0,
                                        322.0,
                                        637.0,
                                        360.0,
                                        637.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        661.0,
                                        352.0,
                                        652.0,
                                        352.0,
                                        652.0,
                                        390.0,
                                        547.0,
                                        390.0
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
                                        "obj-45",
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
                                        "obj-48",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        2
                                    ],
                                    "destination": [
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        841.5,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        997.0,
                                        360.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-49",
                                        0
                                    ],
                                    "destination": [
                                        "obj-50",
                                        0
                                    ],
                                    "midpoints": [
                                        1010.0,
                                        322.0,
                                        1157.0,
                                        322.0,
                                        1157.0,
                                        360.0,
                                        1157.0,
                                        352.0,
                                        1082.0,
                                        352.0,
                                        1082.0,
                                        390.0,
                                        1082.0,
                                        352.0,
                                        1087.0,
                                        352.0,
                                        1087.0,
                                        390.0,
                                        1208.5,
                                        390.0
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
                                        "obj-52",
                                        1
                                    ],
                                    "midpoints": [
                                        765.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        960.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        901.0,
                                        352.0,
                                        952.0,
                                        352.0,
                                        952.0,
                                        390.0,
                                        1125.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        1
                                    ],
                                    "destination": [
                                        "obj-52",
                                        0
                                    ],
                                    "midpoints": [
                                        821.75,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        960.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        901.0,
                                        352.0,
                                        952.0,
                                        352.0,
                                        952.0,
                                        390.0,
                                        1102.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-52",
                                        0
                                    ],
                                    "destination": [
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        1113.5,
                                        352.0,
                                        1270.0,
                                        352.0,
                                        1270.0,
                                        390.0,
                                        1270.0,
                                        397.0,
                                        1115.0,
                                        397.0,
                                        1115.0,
                                        435.0,
                                        1115.0,
                                        397.0,
                                        1254.0,
                                        397.0,
                                        1254.0,
                                        435.0,
                                        1313.5,
                                        435.0
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
                                        "obj-53",
                                        0
                                    ],
                                    "midpoints": [
                                        802.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        1092.0,
                                        360.0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0
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
                    "maxclass": "newobj",
                    "id": "obj-56",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        4815.0,
                        30.0,
                        86.0,
                        22.0
                    ],
                    "text": "p voice-5",
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
                            400.0,
                            300.0
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
                                    "maxclass": "outlet",
                                    "id": "obj-1",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        600.0,
                                        660.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "ball 5 audio L"
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
                                        720.0,
                                        660.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "ball 5 audio R"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        30.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "receive ball-event",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        75.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "t l l l",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        360.0,
                                        120.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "bach.keys position",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        150.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.llll2list",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        195.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack 0. 0.",
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
                                        510.0,
                                        285.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-9",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        435.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-10",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        120.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "bach.keys speed",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-11",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        150.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.llll2list",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        195.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack 0. 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-13",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        495.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-14",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        240.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-15",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        120.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "bach.keys ball",
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
                                        660.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-17",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        675.0,
                                        195.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "select 5",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-18",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "receive v5_min_hz",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-19",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        30.0,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "receive v5_max_hz",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-20",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        30.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "receive v5_session_start",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-21",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        45.0,
                                        75.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "f 55.0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-22",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        75.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "f 4186.0",
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        540.0,
                                        75.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "f 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-24",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        240.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "t b b b b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-25",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        330.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "expr ($f1 + 100.) / 200.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-26",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        360.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * pow($f2/$f1, $f3)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-27",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        405.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "cycle~ 0.",
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        450.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "cycle~ 0.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-29",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        405.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * 4.0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-30",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        495.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-31",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        570.0,
                                        285.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "expr sqrt($f1*$f1 + $f2*$f2)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-32",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        330.0,
                                        240.0,
                                        22.0
                                    ],
                                    "text": "expr clip($f1/8., 0., 1.) * 127.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-33",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        915.0,
                                        360.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "i 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-34",
                                    "numinlets": 5,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "signal",
                                        "signal",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        405.0,
                                        177.0,
                                        22.0
                                    ],
                                    "text": "adsr~ 12. 180. 0.6 350.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-35",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        645.0,
                                        540.0,
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
                                    "id": "obj-36",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        570.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "*~ 0.2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-37",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        420.0,
                                        360.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "expr cos($f1 * 1.5707963267949)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-38",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        360.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "expr sin($f1 * 1.5707963267949)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-39",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        615.0,
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
                                    "id": "obj-40",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        615.0,
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
                                        795.0,
                                        285.0,
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
                                    "maxclass": "newobj",
                                    "id": "obj-42",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        900.0,
                                        330.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "cpuclock",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-43",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        960.0,
                                        360.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 - $f2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-44",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1125.0,
                                        405.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "send bach_onset",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-45",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        555.0,
                                        450.0,
                                        44.0,
                                        22.0
                                    ],
                                    "text": "ftom",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-46",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        495.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "expr $f1 * 100.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-47",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        540.0,
                                        405.0,
                                        58.0,
                                        22.0
                                    ],
                                    "text": "f 440.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-48",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        510.0,
                                        540.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "send bach_pitch",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        990.0,
                                        330.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "500",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        1155.0,
                                        360.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "send bach_dur",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-51",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1260.0,
                                        405.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "send bach_vel",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-52",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1095.0,
                                        360.0,
                                        37.0,
                                        22.0
                                    ],
                                    "text": "i 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-53",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1035.0,
                                        330.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "send bach_bang",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
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
                                        "obj-4",
                                        2
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
                                        "obj-6",
                                        0
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
                                        "obj-7",
                                        0
                                    ],
                                    "destination": [
                                        "obj-8",
                                        1
                                    ],
                                    "midpoints": [
                                        382.0,
                                        187.0,
                                        502.0,
                                        187.0,
                                        502.0,
                                        225.0,
                                        502.0,
                                        232.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        270.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        232.0,
                                        487.0,
                                        270.0,
                                        547.0,
                                        270.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-7",
                                        1
                                    ],
                                    "destination": [
                                        "obj-9",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        1
                                    ],
                                    "destination": [
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        407.5,
                                        67.0,
                                        532.0,
                                        67.0,
                                        532.0,
                                        105.0,
                                        532.0,
                                        112.0,
                                        510.0,
                                        112.0,
                                        510.0,
                                        150.0,
                                        570.5,
                                        150.0
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
                                        "obj-11",
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
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-12",
                                        1
                                    ],
                                    "destination": [
                                        "obj-14",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        0
                                    ],
                                    "destination": [
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        382.0,
                                        67.0,
                                        532.0,
                                        67.0,
                                        532.0,
                                        105.0,
                                        532.0,
                                        112.0,
                                        510.0,
                                        112.0,
                                        510.0,
                                        150.0,
                                        510.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        702.0,
                                        150.0
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
                                        "obj-16",
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
                                        "obj-18",
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
                                        "obj-19",
                                        0
                                    ],
                                    "destination": [
                                        "obj-22",
                                        1
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
                                        "obj-23",
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
                                        "obj-24",
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
                                        "obj-25",
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
                                        "obj-26",
                                        0
                                    ],
                                    "midpoints": [
                                        74.0,
                                        67.0,
                                        172.0,
                                        67.0,
                                        172.0,
                                        105.0,
                                        172.0,
                                        105.0
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
                                        "obj-26",
                                        1
                                    ],
                                    "midpoints": [
                                        216.0,
                                        228.5,
                                        271.0,
                                        228.5
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
                                        "obj-26",
                                        2
                                    ],
                                    "midpoints": [
                                        542.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        370.0,
                                        390.0
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
                                        "obj-27",
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
                                        "obj-29",
                                        0
                                    ],
                                    "midpoints": [
                                        271.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        412.0,
                                        397.0,
                                        357.0,
                                        397.0,
                                        357.0,
                                        435.0,
                                        417.0,
                                        435.0
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
                                        "obj-28",
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
                                        "obj-30",
                                        0
                                    ],
                                    "midpoints": [
                                        309.5,
                                        397.0,
                                        352.0,
                                        397.0,
                                        352.0,
                                        435.0,
                                        367.0,
                                        435.0
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
                                        "obj-30",
                                        1
                                    ],
                                    "midpoints": [
                                        459.5,
                                        483.5,
                                        400.5,
                                        483.5
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
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        517.0,
                                        232.0,
                                        577.0,
                                        232.0,
                                        577.0,
                                        270.0,
                                        577.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        577.0,
                                        315.0
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
                                        "obj-31",
                                        1
                                    ],
                                    "midpoints": [
                                        607.0,
                                        232.0,
                                        732.0,
                                        232.0,
                                        732.0,
                                        270.0,
                                        775.0,
                                        270.0
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
                                        "obj-32",
                                        0
                                    ],
                                    "midpoints": [
                                        676.0,
                                        318.5,
                                        765.0,
                                        318.5
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
                                        "obj-33",
                                        1
                                    ],
                                    "midpoints": [
                                        765.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        945.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        3
                                    ],
                                    "destination": [
                                        "obj-33",
                                        0
                                    ],
                                    "midpoints": [
                                        717.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        277.0,
                                        787.0,
                                        277.0,
                                        787.0,
                                        315.0,
                                        787.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        922.0,
                                        390.0
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
                                    ],
                                    "midpoints": [
                                        383.75,
                                        487.0,
                                        502.0,
                                        487.0,
                                        502.0,
                                        525.0,
                                        502.0,
                                        532.0,
                                        502.0,
                                        532.0,
                                        502.0,
                                        570.0,
                                        652.0,
                                        570.0
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
                                        "obj-35",
                                        1
                                    ],
                                    "midpoints": [
                                        937.0,
                                        483.5,
                                        680.0,
                                        483.5
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
                                        "obj-36",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        2
                                    ],
                                    "destination": [
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        695.3333333333334,
                                        232.0,
                                        547.0,
                                        232.0,
                                        547.0,
                                        270.0,
                                        547.0,
                                        232.0,
                                        577.0,
                                        232.0,
                                        577.0,
                                        270.0,
                                        577.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        517.0,
                                        315.0
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
                                        "obj-37",
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
                                        "obj-38",
                                        0
                                    ],
                                    "midpoints": [
                                        542.0,
                                        322.0,
                                        637.0,
                                        322.0,
                                        637.0,
                                        360.0,
                                        637.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        776.5,
                                        390.0
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
                                        "obj-39",
                                        0
                                    ],
                                    "midpoints": [
                                        689.0,
                                        603.5,
                                        592.0,
                                        603.5
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
                                        "obj-40",
                                        0
                                    ],
                                    "midpoints": [
                                        689.0,
                                        603.5,
                                        727.0,
                                        603.5
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
                                        1
                                    ],
                                    "midpoints": [
                                        536.5,
                                        397.0,
                                        606.0,
                                        397.0,
                                        606.0,
                                        435.0,
                                        606.0,
                                        442.0,
                                        607.0,
                                        442.0,
                                        607.0,
                                        480.0,
                                        607.0,
                                        487.0,
                                        639.0,
                                        487.0,
                                        639.0,
                                        525.0,
                                        639.0,
                                        532.0,
                                        639.0,
                                        532.0,
                                        639.0,
                                        570.0,
                                        620.0,
                                        570.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        776.5,
                                        498.5,
                                        755.0,
                                        498.5
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
                                        "obj-1",
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
                                        "obj-2",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        1
                                    ],
                                    "destination": [
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        673.6666666666666,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        841.5,
                                        315.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        4
                                    ],
                                    "destination": [
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        881.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        936.0,
                                        360.0
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
                                        "obj-43",
                                        0
                                    ],
                                    "midpoints": [
                                        936.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        967.0,
                                        390.0
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
                                        "obj-43",
                                        1
                                    ],
                                    "midpoints": [
                                        562.0,
                                        112.0,
                                        639.0,
                                        112.0,
                                        639.0,
                                        150.0,
                                        639.0,
                                        112.0,
                                        767.0,
                                        112.0,
                                        767.0,
                                        150.0,
                                        767.0,
                                        142.0,
                                        632.0,
                                        142.0,
                                        632.0,
                                        180.0,
                                        632.0,
                                        142.0,
                                        754.0,
                                        142.0,
                                        754.0,
                                        180.0,
                                        754.0,
                                        187.0,
                                        634.0,
                                        187.0,
                                        634.0,
                                        225.0,
                                        634.0,
                                        187.0,
                                        755.0,
                                        187.0,
                                        755.0,
                                        225.0,
                                        755.0,
                                        232.0,
                                        637.0,
                                        232.0,
                                        637.0,
                                        270.0,
                                        637.0,
                                        232.0,
                                        732.0,
                                        232.0,
                                        732.0,
                                        270.0,
                                        732.0,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        562.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        277.0,
                                        787.0,
                                        277.0,
                                        787.0,
                                        315.0,
                                        787.0,
                                        322.0,
                                        642.0,
                                        322.0,
                                        642.0,
                                        360.0,
                                        642.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        892.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        907.0,
                                        352.0,
                                        907.0,
                                        390.0,
                                        907.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        661.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        1067.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        0
                                    ],
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        1017.0,
                                        352.0,
                                        1147.0,
                                        352.0,
                                        1147.0,
                                        390.0,
                                        1147.0,
                                        352.0,
                                        1087.0,
                                        352.0,
                                        1087.0,
                                        390.0,
                                        1087.0,
                                        397.0,
                                        1115.0,
                                        397.0,
                                        1115.0,
                                        435.0,
                                        1185.5,
                                        435.0
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
                                        "obj-47",
                                        1
                                    ],
                                    "midpoints": [
                                        271.0,
                                        352.0,
                                        412.0,
                                        352.0,
                                        412.0,
                                        390.0,
                                        412.0,
                                        397.0,
                                        357.0,
                                        397.0,
                                        357.0,
                                        435.0,
                                        357.0,
                                        397.0,
                                        482.0,
                                        397.0,
                                        482.0,
                                        435.0,
                                        591.0,
                                        435.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        3
                                    ],
                                    "destination": [
                                        "obj-47",
                                        0
                                    ],
                                    "midpoints": [
                                        861.25,
                                        277.0,
                                        562.0,
                                        277.0,
                                        562.0,
                                        315.0,
                                        562.0,
                                        277.0,
                                        790.0,
                                        277.0,
                                        790.0,
                                        315.0,
                                        790.0,
                                        322.0,
                                        642.0,
                                        322.0,
                                        642.0,
                                        360.0,
                                        642.0,
                                        322.0,
                                        637.0,
                                        322.0,
                                        637.0,
                                        360.0,
                                        637.0,
                                        352.0,
                                        661.0,
                                        352.0,
                                        661.0,
                                        390.0,
                                        661.0,
                                        352.0,
                                        652.0,
                                        352.0,
                                        652.0,
                                        390.0,
                                        547.0,
                                        390.0
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
                                        "obj-45",
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
                                        "obj-48",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        2
                                    ],
                                    "destination": [
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        841.5,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        892.0,
                                        322.0,
                                        892.0,
                                        360.0,
                                        997.0,
                                        360.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-49",
                                        0
                                    ],
                                    "destination": [
                                        "obj-50",
                                        0
                                    ],
                                    "midpoints": [
                                        1010.0,
                                        322.0,
                                        1157.0,
                                        322.0,
                                        1157.0,
                                        360.0,
                                        1157.0,
                                        352.0,
                                        1082.0,
                                        352.0,
                                        1082.0,
                                        390.0,
                                        1082.0,
                                        352.0,
                                        1087.0,
                                        352.0,
                                        1087.0,
                                        390.0,
                                        1208.5,
                                        390.0
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
                                        "obj-52",
                                        1
                                    ],
                                    "midpoints": [
                                        765.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        960.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        901.0,
                                        352.0,
                                        952.0,
                                        352.0,
                                        952.0,
                                        390.0,
                                        1125.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-41",
                                        1
                                    ],
                                    "destination": [
                                        "obj-52",
                                        0
                                    ],
                                    "midpoints": [
                                        821.75,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        982.0,
                                        322.0,
                                        1027.0,
                                        322.0,
                                        1027.0,
                                        360.0,
                                        1027.0,
                                        352.0,
                                        960.0,
                                        352.0,
                                        960.0,
                                        390.0,
                                        960.0,
                                        352.0,
                                        901.0,
                                        352.0,
                                        901.0,
                                        390.0,
                                        901.0,
                                        352.0,
                                        952.0,
                                        352.0,
                                        952.0,
                                        390.0,
                                        1102.0,
                                        390.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-52",
                                        0
                                    ],
                                    "destination": [
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        1113.5,
                                        352.0,
                                        1270.0,
                                        352.0,
                                        1270.0,
                                        390.0,
                                        1270.0,
                                        397.0,
                                        1115.0,
                                        397.0,
                                        1115.0,
                                        435.0,
                                        1115.0,
                                        397.0,
                                        1254.0,
                                        397.0,
                                        1254.0,
                                        435.0,
                                        1313.5,
                                        435.0
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
                                        "obj-53",
                                        0
                                    ],
                                    "midpoints": [
                                        802.0,
                                        322.0,
                                        893.0,
                                        322.0,
                                        893.0,
                                        360.0,
                                        893.0,
                                        322.0,
                                        980.0,
                                        322.0,
                                        980.0,
                                        360.0,
                                        980.0,
                                        322.0,
                                        982.0,
                                        322.0,
                                        982.0,
                                        360.0,
                                        1092.0,
                                        360.0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0
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
                    "maxclass": "newobj",
                    "id": "obj-57",
                    "numinlets": 6,
                    "numoutlets": 8,
                    "outlettype": [
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
                        1530.0,
                        150.0,
                        600.0,
                        300.0
                    ],
                    "text": "bach.roll",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-58",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        495.0,
                        30.0,
                        142.0,
                        22.0
                    ],
                    "text": "receive bach_onset",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-59",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        660.0,
                        30.0,
                        142.0,
                        22.0
                    ],
                    "text": "receive bach_pitch",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-60",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        810.0,
                        30.0,
                        128.0,
                        22.0
                    ],
                    "text": "receive bach_dur",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-61",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210.0,
                        30.0,
                        128.0,
                        22.0
                    ],
                    "text": "receive bach_vel",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-62",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        345.0,
                        30.0,
                        135.0,
                        22.0
                    ],
                    "text": "receive bach_bang",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-63",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4455.0,
                        75.0,
                        47.5,
                        22.0
                    ],
                    "text": "+~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-64",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4530.0,
                        120.0,
                        47.5,
                        22.0
                    ],
                    "text": "+~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-65",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4620.0,
                        150.0,
                        47.5,
                        22.0
                    ],
                    "text": "+~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-66",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4710.0,
                        195.0,
                        47.5,
                        22.0
                    ],
                    "text": "+~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-67",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4515.0,
                        75.0,
                        47.5,
                        22.0
                    ],
                    "text": "+~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-68",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4590.0,
                        120.0,
                        47.5,
                        22.0
                    ],
                    "text": "+~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-69",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4680.0,
                        150.0,
                        47.5,
                        22.0
                    ],
                    "text": "+~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-70",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4785.0,
                        195.0,
                        47.5,
                        22.0
                    ],
                    "text": "+~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-72",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4725.0,
                        405.0,
                        65.0,
                        22.0
                    ],
                    "text": "limi~ 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-73",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4725.0,
                        450.0,
                        72.0,
                        22.0
                    ],
                    "text": "dac~ 1 2",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "gain~",
                    "id": "obj-74",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        4725.0,
                        240.0,
                        22.0,
                        140.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "gain~",
                    "id": "obj-75",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        4785.0,
                        240.0,
                        22.0,
                        140.0
                    ],
                    "parameter_enable": 0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "obj-2",
                        0
                    ],
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        66.0,
                        22.0,
                        112.0,
                        22.0,
                        112.0,
                        60.0,
                        112.0,
                        22.0,
                        202.0,
                        22.0,
                        202.0,
                        60.0,
                        202.0,
                        37.0,
                        137.0,
                        37.0,
                        137.0,
                        77.0,
                        137.0,
                        67.0,
                        96.0,
                        67.0,
                        96.0,
                        105.0,
                        96.0,
                        67.0,
                        164.0,
                        67.0,
                        164.0,
                        105.0,
                        232.5,
                        105.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        7
                    ],
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        293.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        262.0,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-4",
                        0
                    ],
                    "destination": [
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        305.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        472.0,
                        112.0,
                        877.0,
                        112.0,
                        877.0,
                        150.0,
                        877.0,
                        142.0,
                        362.0,
                        142.0,
                        362.0,
                        180.0,
                        362.0,
                        142.0,
                        877.0,
                        142.0,
                        877.0,
                        180.0,
                        877.0,
                        142.0,
                        497.0,
                        142.0,
                        497.0,
                        180.0,
                        497.0,
                        142.0,
                        1012.0,
                        142.0,
                        1012.0,
                        180.0,
                        1012.0,
                        142.0,
                        632.0,
                        142.0,
                        632.0,
                        180.0,
                        632.0,
                        142.0,
                        752.0,
                        142.0,
                        752.0,
                        180.0,
                        752.0,
                        142.0,
                        757.0,
                        142.0,
                        757.0,
                        180.0,
                        1140.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        6
                    ],
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        275.7142857142857,
                        67.0,
                        307.0,
                        67.0,
                        307.0,
                        105.0,
                        307.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        382.0,
                        150.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        421.5,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        472.0,
                        112.0,
                        877.0,
                        112.0,
                        877.0,
                        150.0,
                        877.0,
                        142.0,
                        877.0,
                        142.0,
                        877.0,
                        180.0,
                        877.0,
                        142.0,
                        497.0,
                        142.0,
                        497.0,
                        180.0,
                        497.0,
                        142.0,
                        1012.0,
                        142.0,
                        1012.0,
                        180.0,
                        1012.0,
                        142.0,
                        632.0,
                        142.0,
                        632.0,
                        180.0,
                        632.0,
                        142.0,
                        752.0,
                        142.0,
                        752.0,
                        180.0,
                        752.0,
                        142.0,
                        757.0,
                        142.0,
                        757.0,
                        180.0,
                        1140.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        5
                    ],
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        258.42857142857144,
                        67.0,
                        395.0,
                        67.0,
                        395.0,
                        105.0,
                        395.0,
                        67.0,
                        397.0,
                        67.0,
                        397.0,
                        105.0,
                        397.0,
                        67.0,
                        457.0,
                        67.0,
                        457.0,
                        105.0,
                        457.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        367.0,
                        112.0,
                        367.0,
                        150.0,
                        367.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        487.0,
                        150.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        813.5,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        943.0,
                        142.0,
                        1007.0,
                        142.0,
                        1007.0,
                        180.0,
                        1007.0,
                        142.0,
                        1012.0,
                        142.0,
                        1012.0,
                        180.0,
                        1012.0,
                        142.0,
                        887.0,
                        142.0,
                        887.0,
                        180.0,
                        1140.0,
                        180.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        241.14285714285714,
                        67.0,
                        395.0,
                        67.0,
                        395.0,
                        105.0,
                        395.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        472.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        298.0,
                        112.0,
                        877.0,
                        112.0,
                        877.0,
                        150.0,
                        1162.0,
                        150.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        1380.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        142.0,
                        1142.0,
                        142.0,
                        1142.0,
                        180.0,
                        1142.0,
                        142.0,
                        1277.0,
                        142.0,
                        1277.0,
                        180.0,
                        1277.0,
                        142.0,
                        1267.0,
                        142.0,
                        1267.0,
                        180.0,
                        1140.0,
                        180.0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        223.85714285714286,
                        67.0,
                        395.0,
                        67.0,
                        395.0,
                        105.0,
                        395.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1147.0,
                        112.0,
                        1147.0,
                        150.0,
                        1147.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        298.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        1627.0,
                        150.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        1852.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1613.0,
                        112.0,
                        1613.0,
                        150.0,
                        1613.0,
                        142.0,
                        1142.0,
                        142.0,
                        1142.0,
                        180.0,
                        1142.0,
                        142.0,
                        1277.0,
                        142.0,
                        1277.0,
                        180.0,
                        1277.0,
                        142.0,
                        1397.0,
                        142.0,
                        1397.0,
                        180.0,
                        1397.0,
                        142.0,
                        1532.0,
                        142.0,
                        1532.0,
                        180.0,
                        1532.0,
                        142.0,
                        1522.0,
                        142.0,
                        1522.0,
                        458.0,
                        1140.0,
                        458.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        206.57142857142856,
                        67.0,
                        395.0,
                        67.0,
                        395.0,
                        105.0,
                        395.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1147.0,
                        112.0,
                        1147.0,
                        150.0,
                        1147.0,
                        112.0,
                        1612.0,
                        112.0,
                        1612.0,
                        150.0,
                        1612.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        298.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        2107.0,
                        150.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        2325.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1613.0,
                        112.0,
                        1613.0,
                        150.0,
                        1613.0,
                        112.0,
                        1612.0,
                        112.0,
                        1612.0,
                        150.0,
                        1612.0,
                        142.0,
                        1142.0,
                        142.0,
                        1142.0,
                        180.0,
                        1142.0,
                        142.0,
                        1277.0,
                        142.0,
                        1277.0,
                        180.0,
                        1277.0,
                        142.0,
                        1397.0,
                        142.0,
                        1397.0,
                        180.0,
                        1397.0,
                        142.0,
                        1532.0,
                        142.0,
                        1532.0,
                        180.0,
                        1532.0,
                        142.0,
                        1522.0,
                        142.0,
                        1522.0,
                        458.0,
                        1140.0,
                        458.0
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
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        189.28571428571428,
                        67.0,
                        395.0,
                        67.0,
                        395.0,
                        105.0,
                        395.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1613.0,
                        112.0,
                        1613.0,
                        150.0,
                        1613.0,
                        112.0,
                        1612.0,
                        112.0,
                        1612.0,
                        150.0,
                        1612.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        112.0,
                        193.0,
                        112.0,
                        193.0,
                        150.0,
                        193.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        298.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        2572.0,
                        150.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        2793.5,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1613.0,
                        112.0,
                        1613.0,
                        150.0,
                        1613.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        142.0,
                        1142.0,
                        142.0,
                        1142.0,
                        180.0,
                        1142.0,
                        142.0,
                        1277.0,
                        142.0,
                        1277.0,
                        180.0,
                        1277.0,
                        142.0,
                        1397.0,
                        142.0,
                        1397.0,
                        180.0,
                        1397.0,
                        142.0,
                        1532.0,
                        142.0,
                        1532.0,
                        180.0,
                        1532.0,
                        142.0,
                        2138.0,
                        142.0,
                        2138.0,
                        458.0,
                        1140.0,
                        458.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        172.0,
                        67.0,
                        395.0,
                        67.0,
                        395.0,
                        105.0,
                        395.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1613.0,
                        112.0,
                        1613.0,
                        150.0,
                        1613.0,
                        112.0,
                        1612.0,
                        112.0,
                        1612.0,
                        150.0,
                        1612.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2557.0,
                        112.0,
                        2557.0,
                        150.0,
                        2557.0,
                        112.0,
                        176.0,
                        112.0,
                        176.0,
                        150.0,
                        176.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        112.0,
                        193.0,
                        112.0,
                        193.0,
                        150.0,
                        193.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        298.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        3052.0,
                        150.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        3266.5,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1613.0,
                        112.0,
                        1613.0,
                        150.0,
                        1613.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2557.0,
                        112.0,
                        2557.0,
                        150.0,
                        2557.0,
                        142.0,
                        1142.0,
                        142.0,
                        1142.0,
                        180.0,
                        1142.0,
                        142.0,
                        1277.0,
                        142.0,
                        1277.0,
                        180.0,
                        1277.0,
                        142.0,
                        1397.0,
                        142.0,
                        1397.0,
                        180.0,
                        1397.0,
                        142.0,
                        1532.0,
                        142.0,
                        1532.0,
                        180.0,
                        1532.0,
                        142.0,
                        2138.0,
                        142.0,
                        2138.0,
                        458.0,
                        1140.0,
                        458.0
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
                    ],
                    "midpoints": [
                        156.0,
                        22.0,
                        202.0,
                        22.0,
                        202.0,
                        60.0,
                        202.0,
                        22.0,
                        337.0,
                        22.0,
                        337.0,
                        60.0,
                        337.0,
                        67.0,
                        308.0,
                        67.0,
                        308.0,
                        105.0,
                        308.0,
                        67.0,
                        164.0,
                        67.0,
                        164.0,
                        105.0,
                        351.0,
                        105.0
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
                        "obj-14",
                        0
                    ],
                    "midpoints": [
                        351.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1613.0,
                        112.0,
                        1613.0,
                        150.0,
                        1613.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2557.0,
                        112.0,
                        2557.0,
                        150.0,
                        2557.0,
                        112.0,
                        3037.0,
                        112.0,
                        3037.0,
                        150.0,
                        3037.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        3576.5,
                        150.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        351.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1613.0,
                        112.0,
                        1613.0,
                        150.0,
                        1613.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2557.0,
                        112.0,
                        2557.0,
                        150.0,
                        2557.0,
                        112.0,
                        3037.0,
                        112.0,
                        3037.0,
                        150.0,
                        3037.0,
                        112.0,
                        3487.0,
                        112.0,
                        3487.0,
                        150.0,
                        3487.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        3756.5,
                        150.0
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
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        351.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1613.0,
                        112.0,
                        1613.0,
                        150.0,
                        1613.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2557.0,
                        112.0,
                        2557.0,
                        150.0,
                        2557.0,
                        112.0,
                        3037.0,
                        112.0,
                        3037.0,
                        150.0,
                        3037.0,
                        112.0,
                        3487.0,
                        112.0,
                        3487.0,
                        150.0,
                        3487.0,
                        112.0,
                        3667.0,
                        112.0,
                        3667.0,
                        150.0,
                        3667.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        3936.5,
                        150.0
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
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        351.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1613.0,
                        112.0,
                        1613.0,
                        150.0,
                        1613.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2557.0,
                        112.0,
                        2557.0,
                        150.0,
                        2557.0,
                        112.0,
                        3037.0,
                        112.0,
                        3037.0,
                        150.0,
                        3037.0,
                        112.0,
                        3487.0,
                        112.0,
                        3487.0,
                        150.0,
                        3487.0,
                        112.0,
                        3667.0,
                        112.0,
                        3667.0,
                        150.0,
                        3667.0,
                        112.0,
                        3847.0,
                        112.0,
                        3847.0,
                        150.0,
                        3847.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        4116.5,
                        150.0
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
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        351.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1613.0,
                        112.0,
                        1613.0,
                        150.0,
                        1613.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2557.0,
                        112.0,
                        2557.0,
                        150.0,
                        2557.0,
                        112.0,
                        3037.0,
                        112.0,
                        3037.0,
                        150.0,
                        3037.0,
                        112.0,
                        3487.0,
                        112.0,
                        3487.0,
                        150.0,
                        3487.0,
                        112.0,
                        3667.0,
                        112.0,
                        3667.0,
                        150.0,
                        3667.0,
                        112.0,
                        3847.0,
                        112.0,
                        3847.0,
                        150.0,
                        3847.0,
                        112.0,
                        4027.0,
                        112.0,
                        4027.0,
                        150.0,
                        4027.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        4296.5,
                        150.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        59.0,
                        67.0,
                        308.0,
                        67.0,
                        308.0,
                        105.0,
                        308.0,
                        67.0,
                        395.0,
                        67.0,
                        395.0,
                        105.0,
                        395.0,
                        67.0,
                        164.0,
                        67.0,
                        164.0,
                        105.0,
                        164.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        472.0,
                        112.0,
                        176.0,
                        112.0,
                        176.0,
                        150.0,
                        176.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        112.0,
                        88.0,
                        112.0,
                        88.0,
                        150.0,
                        88.0,
                        112.0,
                        193.0,
                        112.0,
                        193.0,
                        150.0,
                        193.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        298.0,
                        112.0,
                        877.0,
                        112.0,
                        877.0,
                        150.0,
                        877.0,
                        142.0,
                        131.0,
                        142.0,
                        131.0,
                        180.0,
                        131.0,
                        142.0,
                        236.0,
                        142.0,
                        236.0,
                        180.0,
                        236.0,
                        142.0,
                        362.0,
                        142.0,
                        362.0,
                        180.0,
                        362.0,
                        142.0,
                        877.0,
                        142.0,
                        877.0,
                        180.0,
                        877.0,
                        142.0,
                        497.0,
                        142.0,
                        497.0,
                        180.0,
                        497.0,
                        142.0,
                        1012.0,
                        142.0,
                        1012.0,
                        180.0,
                        1012.0,
                        142.0,
                        632.0,
                        142.0,
                        632.0,
                        180.0,
                        632.0,
                        142.0,
                        622.0,
                        142.0,
                        622.0,
                        180.0,
                        622.0,
                        142.0,
                        757.0,
                        142.0,
                        757.0,
                        180.0,
                        1140.0,
                        180.0
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
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-23",
                        1
                    ],
                    "destination": [
                        "obj-24",
                        0
                    ],
                    "midpoints": [
                        149.0,
                        67.0,
                        96.0,
                        67.0,
                        96.0,
                        105.0,
                        96.0,
                        112.0,
                        88.0,
                        112.0,
                        88.0,
                        150.0,
                        88.0,
                        112.0,
                        127.0,
                        112.0,
                        127.0,
                        150.0,
                        82.0,
                        150.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        112.0,
                        67.0,
                        157.0,
                        67.0,
                        157.0,
                        105.0,
                        157.0,
                        112.0,
                        176.0,
                        112.0,
                        176.0,
                        150.0,
                        176.0,
                        112.0,
                        127.0,
                        112.0,
                        127.0,
                        150.0,
                        202.0,
                        150.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        121.5,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        472.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        112.0,
                        193.0,
                        112.0,
                        193.0,
                        150.0,
                        193.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        298.0,
                        112.0,
                        877.0,
                        112.0,
                        877.0,
                        150.0,
                        877.0,
                        142.0,
                        131.0,
                        142.0,
                        131.0,
                        180.0,
                        131.0,
                        142.0,
                        236.0,
                        142.0,
                        236.0,
                        180.0,
                        236.0,
                        142.0,
                        362.0,
                        142.0,
                        362.0,
                        180.0,
                        362.0,
                        142.0,
                        877.0,
                        142.0,
                        877.0,
                        180.0,
                        877.0,
                        142.0,
                        497.0,
                        142.0,
                        497.0,
                        180.0,
                        497.0,
                        142.0,
                        1012.0,
                        142.0,
                        1012.0,
                        180.0,
                        1012.0,
                        142.0,
                        632.0,
                        142.0,
                        632.0,
                        180.0,
                        632.0,
                        142.0,
                        622.0,
                        142.0,
                        622.0,
                        180.0,
                        622.0,
                        142.0,
                        757.0,
                        142.0,
                        757.0,
                        180.0,
                        1140.0,
                        180.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        76.5,
                        142.0,
                        236.0,
                        142.0,
                        236.0,
                        180.0,
                        236.0,
                        142.0,
                        362.0,
                        142.0,
                        362.0,
                        180.0,
                        362.0,
                        142.0,
                        877.0,
                        142.0,
                        877.0,
                        180.0,
                        877.0,
                        142.0,
                        497.0,
                        142.0,
                        497.0,
                        180.0,
                        497.0,
                        142.0,
                        1012.0,
                        142.0,
                        1012.0,
                        180.0,
                        1012.0,
                        142.0,
                        632.0,
                        142.0,
                        632.0,
                        180.0,
                        632.0,
                        142.0,
                        622.0,
                        142.0,
                        622.0,
                        180.0,
                        622.0,
                        142.0,
                        757.0,
                        142.0,
                        757.0,
                        180.0,
                        1140.0,
                        180.0
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
                        "obj-29",
                        0
                    ],
                    "midpoints": [
                        156.0,
                        22.0,
                        346.0,
                        22.0,
                        346.0,
                        60.0,
                        346.0,
                        22.0,
                        337.0,
                        22.0,
                        337.0,
                        60.0,
                        337.0,
                        67.0,
                        308.0,
                        67.0,
                        308.0,
                        105.0,
                        308.0,
                        67.0,
                        307.0,
                        67.0,
                        307.0,
                        105.0,
                        307.0,
                        67.0,
                        164.0,
                        67.0,
                        164.0,
                        105.0,
                        412.0,
                        105.0
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
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        425.0,
                        67.0,
                        308.0,
                        67.0,
                        308.0,
                        105.0,
                        308.0,
                        67.0,
                        307.0,
                        67.0,
                        307.0,
                        105.0,
                        307.0,
                        67.0,
                        96.0,
                        67.0,
                        96.0,
                        105.0,
                        96.0,
                        67.0,
                        164.0,
                        67.0,
                        164.0,
                        105.0,
                        164.0,
                        112.0,
                        247.0,
                        112.0,
                        247.0,
                        150.0,
                        247.0,
                        112.0,
                        367.0,
                        112.0,
                        367.0,
                        150.0,
                        367.0,
                        112.0,
                        176.0,
                        112.0,
                        176.0,
                        150.0,
                        176.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        112.0,
                        193.0,
                        112.0,
                        193.0,
                        150.0,
                        193.0,
                        112.0,
                        232.0,
                        112.0,
                        232.0,
                        150.0,
                        55.0,
                        150.0
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
                        "obj-32",
                        0
                    ],
                    "midpoints": [
                        142.0,
                        112.0,
                        176.0,
                        112.0,
                        176.0,
                        150.0,
                        142.0,
                        150.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        181.5,
                        142.0,
                        362.0,
                        142.0,
                        362.0,
                        180.0,
                        362.0,
                        142.0,
                        877.0,
                        142.0,
                        877.0,
                        180.0,
                        877.0,
                        142.0,
                        497.0,
                        142.0,
                        497.0,
                        180.0,
                        497.0,
                        142.0,
                        1012.0,
                        142.0,
                        1012.0,
                        180.0,
                        1012.0,
                        142.0,
                        632.0,
                        142.0,
                        632.0,
                        180.0,
                        632.0,
                        142.0,
                        622.0,
                        142.0,
                        622.0,
                        180.0,
                        622.0,
                        142.0,
                        757.0,
                        142.0,
                        757.0,
                        180.0,
                        1140.0,
                        180.0
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
                        "obj-33",
                        0
                    ],
                    "midpoints": [
                        156.0,
                        22.0,
                        346.0,
                        22.0,
                        346.0,
                        60.0,
                        346.0,
                        22.0,
                        337.0,
                        22.0,
                        337.0,
                        60.0,
                        337.0,
                        67.0,
                        308.0,
                        67.0,
                        308.0,
                        105.0,
                        308.0,
                        67.0,
                        307.0,
                        67.0,
                        307.0,
                        105.0,
                        307.0,
                        67.0,
                        164.0,
                        67.0,
                        164.0,
                        105.0,
                        164.0,
                        67.0,
                        397.0,
                        67.0,
                        397.0,
                        105.0,
                        472.0,
                        105.0
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
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        485.0,
                        67.0,
                        308.0,
                        67.0,
                        308.0,
                        105.0,
                        308.0,
                        67.0,
                        307.0,
                        67.0,
                        307.0,
                        105.0,
                        307.0,
                        67.0,
                        164.0,
                        67.0,
                        164.0,
                        105.0,
                        164.0,
                        67.0,
                        397.0,
                        67.0,
                        397.0,
                        105.0,
                        397.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        367.0,
                        112.0,
                        367.0,
                        150.0,
                        367.0,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        472.0,
                        112.0,
                        176.0,
                        112.0,
                        176.0,
                        150.0,
                        176.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        160.0,
                        150.0
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
                        "obj-37",
                        0
                    ],
                    "midpoints": [
                        247.0,
                        112.0,
                        247.0,
                        112.0,
                        247.0,
                        150.0,
                        247.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        297.0,
                        150.0
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
                    ],
                    "midpoints": [
                        892.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        942.0,
                        150.0
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
                    ],
                    "midpoints": [
                        247.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        367.0,
                        112.0,
                        367.0,
                        150.0,
                        367.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        142.0,
                        362.0,
                        142.0,
                        362.0,
                        180.0,
                        432.0,
                        180.0
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
                        "obj-40",
                        0
                    ],
                    "midpoints": [
                        892.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        142.0,
                        1007.0,
                        142.0,
                        1007.0,
                        180.0,
                        1077.0,
                        180.0
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
                        "obj-41",
                        0
                    ],
                    "midpoints": [
                        247.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        367.0,
                        112.0,
                        367.0,
                        150.0,
                        367.0,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        472.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        142.0,
                        362.0,
                        142.0,
                        362.0,
                        180.0,
                        362.0,
                        142.0,
                        367.0,
                        142.0,
                        367.0,
                        180.0,
                        567.0,
                        180.0
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
                        "obj-42",
                        0
                    ],
                    "midpoints": [
                        892.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1147.0,
                        112.0,
                        1147.0,
                        150.0,
                        1147.0,
                        142.0,
                        1007.0,
                        142.0,
                        1007.0,
                        180.0,
                        1007.0,
                        142.0,
                        1012.0,
                        142.0,
                        1012.0,
                        180.0,
                        1212.0,
                        180.0
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
                        "obj-43",
                        0
                    ],
                    "midpoints": [
                        247.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        472.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        142.0,
                        362.0,
                        142.0,
                        362.0,
                        180.0,
                        362.0,
                        142.0,
                        497.0,
                        142.0,
                        497.0,
                        180.0,
                        497.0,
                        142.0,
                        502.0,
                        142.0,
                        502.0,
                        180.0,
                        687.0,
                        180.0
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
                        "obj-44",
                        0
                    ],
                    "midpoints": [
                        892.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1147.0,
                        112.0,
                        1147.0,
                        150.0,
                        1147.0,
                        142.0,
                        1007.0,
                        142.0,
                        1007.0,
                        180.0,
                        1007.0,
                        142.0,
                        1142.0,
                        142.0,
                        1142.0,
                        180.0,
                        1142.0,
                        142.0,
                        1147.0,
                        142.0,
                        1147.0,
                        180.0,
                        1332.0,
                        180.0
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
                        "obj-45",
                        0
                    ],
                    "midpoints": [
                        247.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        472.0,
                        112.0,
                        254.0,
                        112.0,
                        254.0,
                        150.0,
                        254.0,
                        142.0,
                        362.0,
                        142.0,
                        362.0,
                        180.0,
                        362.0,
                        142.0,
                        497.0,
                        142.0,
                        497.0,
                        180.0,
                        497.0,
                        142.0,
                        502.0,
                        142.0,
                        502.0,
                        180.0,
                        502.0,
                        142.0,
                        622.0,
                        142.0,
                        622.0,
                        180.0,
                        822.0,
                        180.0
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
                        "obj-46",
                        0
                    ],
                    "midpoints": [
                        892.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1147.0,
                        112.0,
                        1147.0,
                        150.0,
                        1147.0,
                        142.0,
                        1007.0,
                        142.0,
                        1007.0,
                        180.0,
                        1007.0,
                        142.0,
                        1142.0,
                        142.0,
                        1142.0,
                        180.0,
                        1142.0,
                        142.0,
                        1147.0,
                        142.0,
                        1147.0,
                        180.0,
                        1147.0,
                        142.0,
                        1267.0,
                        142.0,
                        1267.0,
                        180.0,
                        1467.0,
                        180.0
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
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        156.0,
                        22.0,
                        487.0,
                        22.0,
                        487.0,
                        60.0,
                        487.0,
                        22.0,
                        346.0,
                        22.0,
                        346.0,
                        60.0,
                        346.0,
                        22.0,
                        337.0,
                        22.0,
                        337.0,
                        60.0,
                        337.0,
                        67.0,
                        308.0,
                        67.0,
                        308.0,
                        105.0,
                        308.0,
                        67.0,
                        307.0,
                        67.0,
                        307.0,
                        105.0,
                        307.0,
                        67.0,
                        164.0,
                        67.0,
                        164.0,
                        105.0,
                        164.0,
                        67.0,
                        397.0,
                        67.0,
                        397.0,
                        105.0,
                        397.0,
                        67.0,
                        457.0,
                        67.0,
                        457.0,
                        105.0,
                        517.0,
                        105.0
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
                        "obj-48",
                        0
                    ],
                    "midpoints": [
                        156.0,
                        22.0,
                        487.0,
                        22.0,
                        487.0,
                        60.0,
                        487.0,
                        22.0,
                        346.0,
                        22.0,
                        346.0,
                        60.0,
                        346.0,
                        22.0,
                        337.0,
                        22.0,
                        337.0,
                        60.0,
                        337.0,
                        67.0,
                        308.0,
                        67.0,
                        308.0,
                        105.0,
                        308.0,
                        67.0,
                        395.0,
                        67.0,
                        395.0,
                        105.0,
                        395.0,
                        67.0,
                        164.0,
                        67.0,
                        164.0,
                        105.0,
                        164.0,
                        67.0,
                        397.0,
                        67.0,
                        397.0,
                        105.0,
                        397.0,
                        67.0,
                        457.0,
                        67.0,
                        457.0,
                        105.0,
                        457.0,
                        67.0,
                        502.0,
                        67.0,
                        502.0,
                        105.0,
                        577.0,
                        105.0
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
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        532.0,
                        67.0,
                        308.0,
                        67.0,
                        308.0,
                        105.0,
                        308.0,
                        67.0,
                        395.0,
                        67.0,
                        395.0,
                        105.0,
                        395.0,
                        67.0,
                        397.0,
                        67.0,
                        397.0,
                        105.0,
                        397.0,
                        67.0,
                        457.0,
                        67.0,
                        457.0,
                        105.0,
                        457.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        367.0,
                        112.0,
                        367.0,
                        150.0,
                        367.0,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        265.0,
                        150.0
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
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        599.0,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        910.0,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-1",
                        2
                    ],
                    "destination": [
                        "obj-51",
                        0
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
                        "obj-57",
                        1
                    ],
                    "midpoints": [
                        566.0,
                        22.0,
                        810.0,
                        22.0,
                        810.0,
                        60.0,
                        810.0,
                        22.0,
                        946.0,
                        22.0,
                        946.0,
                        60.0,
                        946.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1147.0,
                        112.0,
                        1147.0,
                        150.0,
                        1147.0,
                        112.0,
                        1612.0,
                        112.0,
                        1612.0,
                        150.0,
                        1612.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        943.0,
                        142.0,
                        1007.0,
                        142.0,
                        1007.0,
                        180.0,
                        1007.0,
                        142.0,
                        1142.0,
                        142.0,
                        1142.0,
                        180.0,
                        1142.0,
                        142.0,
                        632.0,
                        142.0,
                        632.0,
                        180.0,
                        632.0,
                        142.0,
                        1147.0,
                        142.0,
                        1147.0,
                        180.0,
                        1147.0,
                        142.0,
                        752.0,
                        142.0,
                        752.0,
                        180.0,
                        752.0,
                        142.0,
                        1267.0,
                        142.0,
                        1267.0,
                        180.0,
                        1267.0,
                        142.0,
                        887.0,
                        142.0,
                        887.0,
                        180.0,
                        887.0,
                        142.0,
                        1402.0,
                        142.0,
                        1402.0,
                        180.0,
                        1654.2,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-59",
                        0
                    ],
                    "destination": [
                        "obj-57",
                        2
                    ],
                    "midpoints": [
                        731.0,
                        22.0,
                        946.0,
                        22.0,
                        946.0,
                        60.0,
                        946.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1147.0,
                        112.0,
                        1147.0,
                        150.0,
                        1147.0,
                        112.0,
                        1612.0,
                        112.0,
                        1612.0,
                        150.0,
                        1612.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        943.0,
                        142.0,
                        1007.0,
                        142.0,
                        1007.0,
                        180.0,
                        1007.0,
                        142.0,
                        1142.0,
                        142.0,
                        1142.0,
                        180.0,
                        1142.0,
                        142.0,
                        1277.0,
                        142.0,
                        1277.0,
                        180.0,
                        1277.0,
                        142.0,
                        752.0,
                        142.0,
                        752.0,
                        180.0,
                        752.0,
                        142.0,
                        1267.0,
                        142.0,
                        1267.0,
                        180.0,
                        1267.0,
                        142.0,
                        887.0,
                        142.0,
                        887.0,
                        180.0,
                        887.0,
                        142.0,
                        1402.0,
                        142.0,
                        1402.0,
                        180.0,
                        1771.4,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-60",
                        0
                    ],
                    "destination": [
                        "obj-57",
                        3
                    ],
                    "midpoints": [
                        874.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1613.0,
                        112.0,
                        1613.0,
                        150.0,
                        1613.0,
                        112.0,
                        1612.0,
                        112.0,
                        1612.0,
                        150.0,
                        1612.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        943.0,
                        142.0,
                        1007.0,
                        142.0,
                        1007.0,
                        180.0,
                        1007.0,
                        142.0,
                        1142.0,
                        142.0,
                        1142.0,
                        180.0,
                        1142.0,
                        142.0,
                        1277.0,
                        142.0,
                        1277.0,
                        180.0,
                        1277.0,
                        142.0,
                        1397.0,
                        142.0,
                        1397.0,
                        180.0,
                        1397.0,
                        142.0,
                        887.0,
                        142.0,
                        887.0,
                        180.0,
                        887.0,
                        142.0,
                        1402.0,
                        142.0,
                        1402.0,
                        180.0,
                        1888.6,
                        180.0
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
                        "obj-57",
                        4
                    ],
                    "midpoints": [
                        274.0,
                        22.0,
                        645.0,
                        22.0,
                        645.0,
                        60.0,
                        645.0,
                        22.0,
                        810.0,
                        22.0,
                        810.0,
                        60.0,
                        810.0,
                        22.0,
                        946.0,
                        22.0,
                        946.0,
                        60.0,
                        946.0,
                        22.0,
                        488.0,
                        22.0,
                        488.0,
                        60.0,
                        488.0,
                        67.0,
                        308.0,
                        67.0,
                        308.0,
                        105.0,
                        308.0,
                        67.0,
                        395.0,
                        67.0,
                        395.0,
                        105.0,
                        395.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1147.0,
                        112.0,
                        1147.0,
                        150.0,
                        1147.0,
                        112.0,
                        1612.0,
                        112.0,
                        1612.0,
                        150.0,
                        1612.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        298.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        943.0,
                        142.0,
                        362.0,
                        142.0,
                        362.0,
                        180.0,
                        362.0,
                        142.0,
                        1007.0,
                        142.0,
                        1007.0,
                        180.0,
                        1007.0,
                        142.0,
                        497.0,
                        142.0,
                        497.0,
                        180.0,
                        497.0,
                        142.0,
                        1142.0,
                        142.0,
                        1142.0,
                        180.0,
                        1142.0,
                        142.0,
                        632.0,
                        142.0,
                        632.0,
                        180.0,
                        632.0,
                        142.0,
                        1147.0,
                        142.0,
                        1147.0,
                        180.0,
                        1147.0,
                        142.0,
                        752.0,
                        142.0,
                        752.0,
                        180.0,
                        752.0,
                        142.0,
                        1267.0,
                        142.0,
                        1267.0,
                        180.0,
                        1267.0,
                        142.0,
                        887.0,
                        142.0,
                        887.0,
                        180.0,
                        887.0,
                        142.0,
                        1402.0,
                        142.0,
                        1402.0,
                        180.0,
                        2005.8,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-62",
                        0
                    ],
                    "destination": [
                        "obj-57",
                        0
                    ],
                    "midpoints": [
                        412.5,
                        22.0,
                        645.0,
                        22.0,
                        645.0,
                        60.0,
                        645.0,
                        22.0,
                        810.0,
                        22.0,
                        810.0,
                        60.0,
                        810.0,
                        22.0,
                        946.0,
                        22.0,
                        946.0,
                        60.0,
                        946.0,
                        67.0,
                        453.0,
                        67.0,
                        453.0,
                        105.0,
                        453.0,
                        67.0,
                        513.0,
                        67.0,
                        513.0,
                        105.0,
                        513.0,
                        67.0,
                        562.0,
                        67.0,
                        562.0,
                        105.0,
                        562.0,
                        67.0,
                        636.0,
                        67.0,
                        636.0,
                        105.0,
                        636.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1147.0,
                        112.0,
                        1147.0,
                        150.0,
                        1147.0,
                        112.0,
                        943.0,
                        112.0,
                        943.0,
                        150.0,
                        943.0,
                        142.0,
                        1007.0,
                        142.0,
                        1007.0,
                        180.0,
                        1007.0,
                        142.0,
                        497.0,
                        142.0,
                        497.0,
                        180.0,
                        497.0,
                        142.0,
                        1012.0,
                        142.0,
                        1012.0,
                        180.0,
                        1012.0,
                        142.0,
                        632.0,
                        142.0,
                        632.0,
                        180.0,
                        632.0,
                        142.0,
                        1147.0,
                        142.0,
                        1147.0,
                        180.0,
                        1147.0,
                        142.0,
                        752.0,
                        142.0,
                        752.0,
                        180.0,
                        752.0,
                        142.0,
                        1267.0,
                        142.0,
                        1267.0,
                        180.0,
                        1267.0,
                        142.0,
                        887.0,
                        142.0,
                        887.0,
                        180.0,
                        887.0,
                        142.0,
                        1402.0,
                        142.0,
                        1402.0,
                        180.0,
                        1537.0,
                        180.0
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
                        "obj-57",
                        0
                    ],
                    "midpoints": [
                        220.5,
                        112.0,
                        363.0,
                        112.0,
                        363.0,
                        150.0,
                        363.0,
                        112.0,
                        476.0,
                        112.0,
                        476.0,
                        150.0,
                        476.0,
                        112.0,
                        1155.0,
                        112.0,
                        1155.0,
                        150.0,
                        1155.0,
                        112.0,
                        1147.0,
                        112.0,
                        1147.0,
                        150.0,
                        1147.0,
                        112.0,
                        298.0,
                        112.0,
                        298.0,
                        150.0,
                        298.0,
                        112.0,
                        877.0,
                        112.0,
                        877.0,
                        150.0,
                        877.0,
                        142.0,
                        236.0,
                        142.0,
                        236.0,
                        180.0,
                        236.0,
                        142.0,
                        362.0,
                        142.0,
                        362.0,
                        180.0,
                        362.0,
                        142.0,
                        877.0,
                        142.0,
                        877.0,
                        180.0,
                        877.0,
                        142.0,
                        497.0,
                        142.0,
                        497.0,
                        180.0,
                        497.0,
                        142.0,
                        1012.0,
                        142.0,
                        1012.0,
                        180.0,
                        1012.0,
                        142.0,
                        632.0,
                        142.0,
                        632.0,
                        180.0,
                        632.0,
                        142.0,
                        1147.0,
                        142.0,
                        1147.0,
                        180.0,
                        1147.0,
                        142.0,
                        752.0,
                        142.0,
                        752.0,
                        180.0,
                        752.0,
                        142.0,
                        1267.0,
                        142.0,
                        1267.0,
                        180.0,
                        1267.0,
                        142.0,
                        887.0,
                        142.0,
                        887.0,
                        180.0,
                        887.0,
                        142.0,
                        1402.0,
                        142.0,
                        1402.0,
                        180.0,
                        1537.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-52",
                        0
                    ],
                    "destination": [
                        "obj-63",
                        0
                    ],
                    "midpoints": [
                        4417.0,
                        63.5,
                        4462.0,
                        63.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-53",
                        0
                    ],
                    "destination": [
                        "obj-63",
                        1
                    ],
                    "midpoints": [
                        4522.0,
                        22.0,
                        4504.0,
                        22.0,
                        4504.0,
                        60.0,
                        4504.0,
                        67.0,
                        4507.0,
                        67.0,
                        4507.0,
                        105.0,
                        4495.5,
                        105.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-52",
                        1
                    ],
                    "destination": [
                        "obj-67",
                        0
                    ],
                    "midpoints": [
                        4489.0,
                        22.0,
                        4507.0,
                        22.0,
                        4507.0,
                        60.0,
                        4507.0,
                        67.0,
                        4510.5,
                        67.0,
                        4510.5,
                        105.0,
                        4522.0,
                        105.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-53",
                        1
                    ],
                    "destination": [
                        "obj-67",
                        1
                    ],
                    "midpoints": [
                        4594.0,
                        63.5,
                        4555.5,
                        63.5
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
                        "obj-64",
                        0
                    ],
                    "midpoints": [
                        4478.75,
                        67.0,
                        4507.0,
                        67.0,
                        4507.0,
                        105.0,
                        4537.0,
                        105.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-54",
                        0
                    ],
                    "destination": [
                        "obj-64",
                        1
                    ],
                    "midpoints": [
                        4627.0,
                        22.0,
                        4609.0,
                        22.0,
                        4609.0,
                        60.0,
                        4609.0,
                        67.0,
                        4570.5,
                        67.0,
                        4570.5,
                        105.0,
                        4570.5,
                        112.0,
                        4582.0,
                        112.0,
                        4582.0,
                        150.0,
                        4570.5,
                        150.0
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
                        "obj-68",
                        0
                    ],
                    "midpoints": [
                        4538.75,
                        112.0,
                        4585.5,
                        112.0,
                        4585.5,
                        150.0,
                        4597.0,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-54",
                        1
                    ],
                    "destination": [
                        "obj-68",
                        1
                    ],
                    "midpoints": [
                        4699.0,
                        86.0,
                        4630.5,
                        86.0
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
                        "obj-65",
                        0
                    ],
                    "midpoints": [
                        4553.75,
                        112.0,
                        4582.0,
                        112.0,
                        4582.0,
                        150.0,
                        4627.0,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-55",
                        0
                    ],
                    "destination": [
                        "obj-65",
                        1
                    ],
                    "midpoints": [
                        4732.0,
                        22.0,
                        4714.0,
                        22.0,
                        4714.0,
                        60.0,
                        4714.0,
                        142.0,
                        4672.0,
                        142.0,
                        4672.0,
                        180.0,
                        4660.5,
                        180.0
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
                        "obj-69",
                        0
                    ],
                    "midpoints": [
                        4613.75,
                        142.0,
                        4675.5,
                        142.0,
                        4675.5,
                        180.0,
                        4687.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-55",
                        1
                    ],
                    "destination": [
                        "obj-69",
                        1
                    ],
                    "midpoints": [
                        4804.0,
                        101.0,
                        4720.5,
                        101.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-65",
                        0
                    ],
                    "destination": [
                        "obj-66",
                        0
                    ],
                    "midpoints": [
                        4643.75,
                        142.0,
                        4672.0,
                        142.0,
                        4672.0,
                        180.0,
                        4717.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-56",
                        0
                    ],
                    "destination": [
                        "obj-66",
                        1
                    ],
                    "midpoints": [
                        4822.0,
                        22.0,
                        4819.0,
                        22.0,
                        4819.0,
                        60.0,
                        4819.0,
                        187.0,
                        4777.0,
                        187.0,
                        4777.0,
                        225.0,
                        4750.5,
                        225.0
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
                    ],
                    "midpoints": [
                        4703.75,
                        187.0,
                        4765.5,
                        187.0,
                        4765.5,
                        225.0,
                        4792.0,
                        225.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-56",
                        1
                    ],
                    "destination": [
                        "obj-70",
                        1
                    ],
                    "midpoints": [
                        4894.0,
                        123.5,
                        4825.5,
                        123.5
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
                        "obj-74",
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
                        "obj-75",
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
                        "obj-72",
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
                        "obj-72",
                        1
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
                        "obj-73",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-72",
                        1
                    ],
                    "destination": [
                        "obj-73",
                        1
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0,
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
    }
}