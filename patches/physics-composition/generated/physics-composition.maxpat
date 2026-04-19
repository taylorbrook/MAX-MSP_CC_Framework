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
            5049.0,
            962.0
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
                        1485.0,
                        540.0,
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
                        870.0,
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
                        3495.0,
                        120.0,
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
                    "numoutlets": 5,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        3495.0,
                        150.0,
                        93.0,
                        22.0
                    ],
                    "text": "t f f f f f",
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
                        3420.0,
                        495.0,
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
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3600.0,
                        495.0,
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
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3765.0,
                        495.0,
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
                    "id": "obj-18",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3945.0,
                        495.0,
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
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4125.0,
                        495.0,
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
                    "id": "obj-20",
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
                    "id": "obj-21",
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
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4860.0,
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
                    "id": "obj-23",
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
                    "id": "obj-24",
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
                    "id": "obj-25",
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
                    "id": "obj-26",
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
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4860.0,
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
                    "id": "obj-28",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        465.0,
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
                    "id": "obj-29",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        495.0,
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
                    "id": "obj-30",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3585.0,
                        120.0,
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
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4860.0,
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
                    "id": "obj-32",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        465.0,
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
                    "id": "obj-33",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        495.0,
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
                    "id": "obj-34",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3645.0,
                        120.0,
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
                    "id": "obj-35",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4860.0,
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
                    "id": "obj-36",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        240.0,
                        465.0,
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
                    "id": "obj-37",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        360.0,
                        465.0,
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
                    "id": "obj-38",
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
                        240.0,
                        495.0,
                        93.0,
                        22.0
                    ],
                    "text": "t f f f f f",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-39",
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
                        360.0,
                        495.0,
                        93.0,
                        22.0
                    ],
                    "text": "t f f f f f",
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
                        195.0,
                        540.0,
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
                    "id": "obj-41",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        840.0,
                        540.0,
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
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        330.0,
                        540.0,
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
                    "id": "obj-43",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        975.0,
                        540.0,
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
                    "id": "obj-44",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        450.0,
                        540.0,
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
                    "id": "obj-45",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1095.0,
                        540.0,
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
                    "id": "obj-46",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        585.0,
                        540.0,
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
                    "id": "obj-47",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1230.0,
                        540.0,
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
                    "id": "obj-48",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        705.0,
                        540.0,
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
                    "id": "obj-49",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1350.0,
                        540.0,
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
                    "id": "obj-50",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3690.0,
                        120.0,
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
                    "id": "obj-51",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3750.0,
                        120.0,
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
                    "maxclass": "newobj",
                    "id": "obj-52",
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
                        855.0,
                        75.0,
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
                    "maxclass": "comment",
                    "id": "obj-53",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4860.0,
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
                    "id": "obj-54",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4860.0,
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
                    "id": "obj-55",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1635.0,
                        900.0,
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
                    "id": "obj-56",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4335.0,
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
                                        1080.0,
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
                                        1200.0,
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
                                        390.0,
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
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 2",
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
                                        810.0,
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
                                        495.0,
                                        195.0,
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
                                        585.0,
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
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 2",
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
                                        585.0,
                                        195.0,
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
                                        690.0,
                                        195.0,
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
                                        780.0,
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
                                        795.0,
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
                                        780.0,
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
                                        870.0,
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
                                        315.0,
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
                                        405.0,
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
                                        555.0,
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
                                        510.0,
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
                                        495.0,
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
                                        555.0,
                                        240.0,
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
                                        525.0,
                                        285.0,
                                        268.0,
                                        22.0
                                    ],
                                    "text": "expr min(max($f1/8., 0.), 1.) * 127.",
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
                                        720.0,
                                        330.0,
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
                                        1530.0,
                                        360.0,
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        870.0,
                                        285.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "pipe 400",
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
                                        1065.0,
                                        330.0,
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
                                    "id": "obj-37",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1005.0,
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
                                    "id": "obj-38",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1020.0,
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
                                    "id": "obj-39",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1035.0,
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
                                    "id": "obj-40",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1275.0,
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
                                    "id": "obj-41",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1080.0,
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
                                    "id": "obj-42",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1200.0,
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
                                    "id": "obj-43",
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
                                        975.0,
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
                                    "id": "obj-44",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1125.0,
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
                                    "id": "obj-45",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        900.0,
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
                                    "id": "obj-46",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        900.0,
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
                                    "id": "obj-47",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        705.0,
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
                                    "id": "obj-48",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
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
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
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
                                    "id": "obj-50",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        660.0,
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
                                    "id": "obj-51",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1200.0,
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
                                    "id": "obj-52",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1710.0,
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
                                    "id": "obj-53",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        780.0,
                                        360.0,
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
                                    "id": "obj-54",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        330.0,
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
                                    "id": "obj-55",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1260.0,
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
                                        "obj-5",
                                        0
                                    ],
                                    "destination": [
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        431.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        502.0,
                                        142.0,
                                        484.0,
                                        142.0,
                                        484.0,
                                        180.0,
                                        523.0,
                                        180.0
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
                                        "obj-8",
                                        1
                                    ],
                                    "midpoints": [
                                        433.0,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        679.0,
                                        142.0,
                                        682.0,
                                        142.0,
                                        682.0,
                                        180.0,
                                        682.0,
                                        142.0,
                                        772.0,
                                        142.0,
                                        772.0,
                                        180.0,
                                        772.0,
                                        187.0,
                                        547.0,
                                        187.0,
                                        547.0,
                                        225.0,
                                        547.0,
                                        187.0,
                                        637.0,
                                        187.0,
                                        637.0,
                                        225.0,
                                        637.0,
                                        187.0,
                                        682.0,
                                        187.0,
                                        682.0,
                                        225.0,
                                        682.0,
                                        187.0,
                                        787.0,
                                        187.0,
                                        787.0,
                                        225.0,
                                        787.0,
                                        232.0,
                                        772.0,
                                        232.0,
                                        772.0,
                                        270.0,
                                        772.0,
                                        232.0,
                                        547.0,
                                        232.0,
                                        547.0,
                                        270.0,
                                        547.0,
                                        277.0,
                                        517.0,
                                        277.0,
                                        517.0,
                                        315.0,
                                        847.0,
                                        315.0
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
                                    ],
                                    "midpoints": [
                                        570.5,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        628.0,
                                        180.0
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
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        570.5,
                                        112.0,
                                        637.0,
                                        112.0,
                                        637.0,
                                        150.0,
                                        637.0,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        733.0,
                                        180.0
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
                                        "obj-13",
                                        1
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
                                    ],
                                    "midpoints": [
                                        702.0,
                                        142.0,
                                        784.0,
                                        142.0,
                                        784.0,
                                        180.0,
                                        823.0,
                                        180.0
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
                                    ],
                                    "midpoints": [
                                        832.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        962.0,
                                        360.0
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
                                        322.0,
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
                                        67.0,
                                        367.0,
                                        67.0,
                                        367.0,
                                        105.0,
                                        367.0,
                                        112.0,
                                        352.0,
                                        112.0,
                                        352.0,
                                        150.0,
                                        352.0,
                                        142.0,
                                        382.0,
                                        142.0,
                                        382.0,
                                        180.0,
                                        421.0,
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
                                        "obj-26",
                                        2
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        802.0,
                                        352.0,
                                        892.0,
                                        352.0,
                                        892.0,
                                        390.0,
                                        892.0,
                                        352.0,
                                        772.0,
                                        352.0,
                                        772.0,
                                        390.0,
                                        520.0,
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
                                        421.0,
                                        397.0,
                                        492.0,
                                        397.0,
                                        492.0,
                                        435.0,
                                        567.0,
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
                                        444.5,
                                        397.0,
                                        502.0,
                                        397.0,
                                        502.0,
                                        435.0,
                                        502.0,
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
                                        594.5,
                                        483.5,
                                        535.5,
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
                                        607.0,
                                        228.5,
                                        562.0,
                                        228.5
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
                                        712.0,
                                        228.5,
                                        760.0,
                                        228.5
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
                                        659.0,
                                        318.5,
                                        750.0,
                                        318.5
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
                                        852.0,
                                        232.0,
                                        775.0,
                                        232.0,
                                        775.0,
                                        270.0,
                                        775.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        727.0,
                                        360.0
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
                                    ],
                                    "midpoints": [
                                        738.5,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1192.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        855.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        1027.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1267.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1022.0,
                                        352.0,
                                        895.0,
                                        352.0,
                                        895.0,
                                        390.0,
                                        1537.0,
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
                                        "obj-35",
                                        0
                                    ],
                                    "midpoints": [
                                        852.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        877.0,
                                        315.0
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
                                    ],
                                    "midpoints": [
                                        911.5,
                                        277.0,
                                        967.0,
                                        277.0,
                                        967.0,
                                        315.0,
                                        967.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1072.0,
                                        360.0
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
                                        "obj-34",
                                        0
                                    ],
                                    "midpoints": [
                                        1085.0,
                                        322.0,
                                        1205.0,
                                        322.0,
                                        1205.0,
                                        360.0,
                                        1205.0,
                                        322.0,
                                        1248.0,
                                        322.0,
                                        1248.0,
                                        360.0,
                                        1248.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1537.0,
                                        390.0
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
                                        "obj-37",
                                        0
                                    ],
                                    "midpoints": [
                                        518.75,
                                        487.0,
                                        789.0,
                                        487.0,
                                        789.0,
                                        525.0,
                                        789.0,
                                        532.0,
                                        789.0,
                                        532.0,
                                        789.0,
                                        570.0,
                                        1012.0,
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
                                        "obj-37",
                                        1
                                    ],
                                    "midpoints": [
                                        1537.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1040.0,
                                        390.0
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
                                        "obj-38",
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
                                        "obj-39",
                                        0
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        1057.0,
                                        322.0,
                                        1057.0,
                                        360.0,
                                        1057.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1151.5,
                                        390.0
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
                                        "obj-40",
                                        0
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1205.0,
                                        322.0,
                                        1205.0,
                                        360.0,
                                        1205.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1192.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1391.5,
                                        390.0
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
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        1049.0,
                                        603.5,
                                        1087.0,
                                        603.5
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
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        1049.0,
                                        607.0,
                                        1130.0,
                                        607.0,
                                        1130.0,
                                        645.0,
                                        1207.0,
                                        645.0
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
                                        "obj-41",
                                        1
                                    ],
                                    "midpoints": [
                                        1151.5,
                                        498.5,
                                        1115.0,
                                        498.5
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
                                        "obj-42",
                                        1
                                    ],
                                    "midpoints": [
                                        1391.5,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1235.0,
                                        390.0
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
                                        "obj-1",
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
                                        "obj-43",
                                        0
                                    ],
                                    "midpoints": [
                                        808.6666666666666,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        961.0,
                                        277.0,
                                        961.0,
                                        315.0,
                                        1021.5,
                                        315.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        4
                                    ],
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        1061.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1161.0,
                                        360.0
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
                                        "obj-45",
                                        0
                                    ],
                                    "midpoints": [
                                        1161.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1057.0,
                                        322.0,
                                        1057.0,
                                        360.0,
                                        1057.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        907.0,
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
                                        "obj-45",
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
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        679.0,
                                        142.0,
                                        784.0,
                                        142.0,
                                        784.0,
                                        180.0,
                                        784.0,
                                        142.0,
                                        772.0,
                                        142.0,
                                        772.0,
                                        180.0,
                                        772.0,
                                        187.0,
                                        637.0,
                                        187.0,
                                        637.0,
                                        225.0,
                                        637.0,
                                        187.0,
                                        742.0,
                                        187.0,
                                        742.0,
                                        225.0,
                                        742.0,
                                        187.0,
                                        787.0,
                                        187.0,
                                        787.0,
                                        225.0,
                                        787.0,
                                        232.0,
                                        772.0,
                                        232.0,
                                        772.0,
                                        270.0,
                                        772.0,
                                        232.0,
                                        775.0,
                                        232.0,
                                        775.0,
                                        270.0,
                                        775.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        967.0,
                                        277.0,
                                        967.0,
                                        315.0,
                                        967.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        862.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        802.0,
                                        352.0,
                                        772.0,
                                        352.0,
                                        772.0,
                                        390.0,
                                        1007.0,
                                        390.0
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
                                        "obj-26",
                                        0
                                    ],
                                    "destination": [
                                        "obj-49",
                                        1
                                    ],
                                    "midpoints": [
                                        421.0,
                                        397.0,
                                        492.0,
                                        397.0,
                                        492.0,
                                        435.0,
                                        492.0,
                                        397.0,
                                        632.0,
                                        397.0,
                                        632.0,
                                        435.0,
                                        741.0,
                                        435.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        3
                                    ],
                                    "destination": [
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        1041.25,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        862.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        855.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        1027.0,
                                        352.0,
                                        892.0,
                                        352.0,
                                        892.0,
                                        390.0,
                                        892.0,
                                        352.0,
                                        895.0,
                                        352.0,
                                        895.0,
                                        390.0,
                                        895.0,
                                        397.0,
                                        892.0,
                                        397.0,
                                        892.0,
                                        435.0,
                                        697.0,
                                        435.0
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
                                        "obj-48",
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
                                        "obj-50",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        2
                                    ],
                                    "destination": [
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        1021.5,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1207.0,
                                        360.0
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
                                        "obj-52",
                                        0
                                    ],
                                    "midpoints": [
                                        1220.0,
                                        322.0,
                                        1382.0,
                                        322.0,
                                        1382.0,
                                        360.0,
                                        1382.0,
                                        352.0,
                                        1522.0,
                                        352.0,
                                        1522.0,
                                        390.0,
                                        1522.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1516.0,
                                        352.0,
                                        1516.0,
                                        390.0,
                                        1763.5,
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
                                        "obj-54",
                                        1
                                    ],
                                    "midpoints": [
                                        659.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        840.0,
                                        360.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        1
                                    ],
                                    "destination": [
                                        "obj-54",
                                        0
                                    ],
                                    "midpoints": [
                                        1001.75,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        817.0,
                                        360.0
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
                                        "obj-53",
                                        0
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
                                        "obj-55",
                                        0
                                    ],
                                    "midpoints": [
                                        982.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1317.0,
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
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4425.0,
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
                                        1080.0,
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
                                        1200.0,
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
                                        390.0,
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
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 2",
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
                                        810.0,
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
                                        495.0,
                                        195.0,
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
                                        585.0,
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
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 2",
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
                                        585.0,
                                        195.0,
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
                                        690.0,
                                        195.0,
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
                                        780.0,
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
                                        795.0,
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
                                        780.0,
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
                                        870.0,
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
                                        315.0,
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
                                        405.0,
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
                                        555.0,
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
                                        510.0,
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
                                        495.0,
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
                                        555.0,
                                        240.0,
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
                                        525.0,
                                        285.0,
                                        268.0,
                                        22.0
                                    ],
                                    "text": "expr min(max($f1/8., 0.), 1.) * 127.",
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
                                        720.0,
                                        330.0,
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
                                        1530.0,
                                        360.0,
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        870.0,
                                        285.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "pipe 400",
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
                                        1065.0,
                                        330.0,
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
                                    "id": "obj-37",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1005.0,
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
                                    "id": "obj-38",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1020.0,
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
                                    "id": "obj-39",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1035.0,
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
                                    "id": "obj-40",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1275.0,
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
                                    "id": "obj-41",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1080.0,
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
                                    "id": "obj-42",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1200.0,
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
                                    "id": "obj-43",
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
                                        975.0,
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
                                    "id": "obj-44",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1125.0,
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
                                    "id": "obj-45",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        900.0,
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
                                    "id": "obj-46",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        900.0,
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
                                    "id": "obj-47",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        705.0,
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
                                    "id": "obj-48",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
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
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
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
                                    "id": "obj-50",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        660.0,
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
                                    "id": "obj-51",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1200.0,
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
                                    "id": "obj-52",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1710.0,
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
                                    "id": "obj-53",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        780.0,
                                        360.0,
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
                                    "id": "obj-54",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        330.0,
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
                                    "id": "obj-55",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1260.0,
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
                                        "obj-5",
                                        0
                                    ],
                                    "destination": [
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        431.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        502.0,
                                        142.0,
                                        484.0,
                                        142.0,
                                        484.0,
                                        180.0,
                                        523.0,
                                        180.0
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
                                        "obj-8",
                                        1
                                    ],
                                    "midpoints": [
                                        433.0,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        679.0,
                                        142.0,
                                        682.0,
                                        142.0,
                                        682.0,
                                        180.0,
                                        682.0,
                                        142.0,
                                        772.0,
                                        142.0,
                                        772.0,
                                        180.0,
                                        772.0,
                                        187.0,
                                        547.0,
                                        187.0,
                                        547.0,
                                        225.0,
                                        547.0,
                                        187.0,
                                        637.0,
                                        187.0,
                                        637.0,
                                        225.0,
                                        637.0,
                                        187.0,
                                        682.0,
                                        187.0,
                                        682.0,
                                        225.0,
                                        682.0,
                                        187.0,
                                        787.0,
                                        187.0,
                                        787.0,
                                        225.0,
                                        787.0,
                                        232.0,
                                        772.0,
                                        232.0,
                                        772.0,
                                        270.0,
                                        772.0,
                                        232.0,
                                        547.0,
                                        232.0,
                                        547.0,
                                        270.0,
                                        547.0,
                                        277.0,
                                        517.0,
                                        277.0,
                                        517.0,
                                        315.0,
                                        847.0,
                                        315.0
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
                                    ],
                                    "midpoints": [
                                        570.5,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        628.0,
                                        180.0
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
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        570.5,
                                        112.0,
                                        637.0,
                                        112.0,
                                        637.0,
                                        150.0,
                                        637.0,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        733.0,
                                        180.0
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
                                        "obj-13",
                                        1
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
                                    ],
                                    "midpoints": [
                                        702.0,
                                        142.0,
                                        784.0,
                                        142.0,
                                        784.0,
                                        180.0,
                                        823.0,
                                        180.0
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
                                    ],
                                    "midpoints": [
                                        832.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        962.0,
                                        360.0
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
                                        322.0,
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
                                        67.0,
                                        367.0,
                                        67.0,
                                        367.0,
                                        105.0,
                                        367.0,
                                        112.0,
                                        352.0,
                                        112.0,
                                        352.0,
                                        150.0,
                                        352.0,
                                        142.0,
                                        382.0,
                                        142.0,
                                        382.0,
                                        180.0,
                                        421.0,
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
                                        "obj-26",
                                        2
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        802.0,
                                        352.0,
                                        892.0,
                                        352.0,
                                        892.0,
                                        390.0,
                                        892.0,
                                        352.0,
                                        772.0,
                                        352.0,
                                        772.0,
                                        390.0,
                                        520.0,
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
                                        421.0,
                                        397.0,
                                        492.0,
                                        397.0,
                                        492.0,
                                        435.0,
                                        567.0,
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
                                        444.5,
                                        397.0,
                                        502.0,
                                        397.0,
                                        502.0,
                                        435.0,
                                        502.0,
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
                                        594.5,
                                        483.5,
                                        535.5,
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
                                        607.0,
                                        228.5,
                                        562.0,
                                        228.5
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
                                        712.0,
                                        228.5,
                                        760.0,
                                        228.5
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
                                        659.0,
                                        318.5,
                                        750.0,
                                        318.5
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
                                        852.0,
                                        232.0,
                                        775.0,
                                        232.0,
                                        775.0,
                                        270.0,
                                        775.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        727.0,
                                        360.0
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
                                    ],
                                    "midpoints": [
                                        738.5,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1192.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        855.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        1027.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1267.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1022.0,
                                        352.0,
                                        895.0,
                                        352.0,
                                        895.0,
                                        390.0,
                                        1537.0,
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
                                        "obj-35",
                                        0
                                    ],
                                    "midpoints": [
                                        852.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        877.0,
                                        315.0
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
                                    ],
                                    "midpoints": [
                                        911.5,
                                        277.0,
                                        967.0,
                                        277.0,
                                        967.0,
                                        315.0,
                                        967.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1072.0,
                                        360.0
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
                                        "obj-34",
                                        0
                                    ],
                                    "midpoints": [
                                        1085.0,
                                        322.0,
                                        1205.0,
                                        322.0,
                                        1205.0,
                                        360.0,
                                        1205.0,
                                        322.0,
                                        1248.0,
                                        322.0,
                                        1248.0,
                                        360.0,
                                        1248.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1537.0,
                                        390.0
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
                                        "obj-37",
                                        0
                                    ],
                                    "midpoints": [
                                        518.75,
                                        487.0,
                                        789.0,
                                        487.0,
                                        789.0,
                                        525.0,
                                        789.0,
                                        532.0,
                                        789.0,
                                        532.0,
                                        789.0,
                                        570.0,
                                        1012.0,
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
                                        "obj-37",
                                        1
                                    ],
                                    "midpoints": [
                                        1537.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1040.0,
                                        390.0
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
                                        "obj-38",
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
                                        "obj-39",
                                        0
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        1057.0,
                                        322.0,
                                        1057.0,
                                        360.0,
                                        1057.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1151.5,
                                        390.0
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
                                        "obj-40",
                                        0
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1205.0,
                                        322.0,
                                        1205.0,
                                        360.0,
                                        1205.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1192.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1391.5,
                                        390.0
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
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        1049.0,
                                        603.5,
                                        1087.0,
                                        603.5
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
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        1049.0,
                                        607.0,
                                        1130.0,
                                        607.0,
                                        1130.0,
                                        645.0,
                                        1207.0,
                                        645.0
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
                                        "obj-41",
                                        1
                                    ],
                                    "midpoints": [
                                        1151.5,
                                        498.5,
                                        1115.0,
                                        498.5
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
                                        "obj-42",
                                        1
                                    ],
                                    "midpoints": [
                                        1391.5,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1235.0,
                                        390.0
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
                                        "obj-1",
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
                                        "obj-43",
                                        0
                                    ],
                                    "midpoints": [
                                        808.6666666666666,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        961.0,
                                        277.0,
                                        961.0,
                                        315.0,
                                        1021.5,
                                        315.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        4
                                    ],
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        1061.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1161.0,
                                        360.0
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
                                        "obj-45",
                                        0
                                    ],
                                    "midpoints": [
                                        1161.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1057.0,
                                        322.0,
                                        1057.0,
                                        360.0,
                                        1057.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        907.0,
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
                                        "obj-45",
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
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        679.0,
                                        142.0,
                                        784.0,
                                        142.0,
                                        784.0,
                                        180.0,
                                        784.0,
                                        142.0,
                                        772.0,
                                        142.0,
                                        772.0,
                                        180.0,
                                        772.0,
                                        187.0,
                                        637.0,
                                        187.0,
                                        637.0,
                                        225.0,
                                        637.0,
                                        187.0,
                                        742.0,
                                        187.0,
                                        742.0,
                                        225.0,
                                        742.0,
                                        187.0,
                                        787.0,
                                        187.0,
                                        787.0,
                                        225.0,
                                        787.0,
                                        232.0,
                                        772.0,
                                        232.0,
                                        772.0,
                                        270.0,
                                        772.0,
                                        232.0,
                                        775.0,
                                        232.0,
                                        775.0,
                                        270.0,
                                        775.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        967.0,
                                        277.0,
                                        967.0,
                                        315.0,
                                        967.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        862.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        802.0,
                                        352.0,
                                        772.0,
                                        352.0,
                                        772.0,
                                        390.0,
                                        1007.0,
                                        390.0
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
                                        "obj-26",
                                        0
                                    ],
                                    "destination": [
                                        "obj-49",
                                        1
                                    ],
                                    "midpoints": [
                                        421.0,
                                        397.0,
                                        492.0,
                                        397.0,
                                        492.0,
                                        435.0,
                                        492.0,
                                        397.0,
                                        632.0,
                                        397.0,
                                        632.0,
                                        435.0,
                                        741.0,
                                        435.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        3
                                    ],
                                    "destination": [
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        1041.25,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        862.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        855.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        1027.0,
                                        352.0,
                                        892.0,
                                        352.0,
                                        892.0,
                                        390.0,
                                        892.0,
                                        352.0,
                                        895.0,
                                        352.0,
                                        895.0,
                                        390.0,
                                        895.0,
                                        397.0,
                                        892.0,
                                        397.0,
                                        892.0,
                                        435.0,
                                        697.0,
                                        435.0
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
                                        "obj-48",
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
                                        "obj-50",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        2
                                    ],
                                    "destination": [
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        1021.5,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1207.0,
                                        360.0
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
                                        "obj-52",
                                        0
                                    ],
                                    "midpoints": [
                                        1220.0,
                                        322.0,
                                        1382.0,
                                        322.0,
                                        1382.0,
                                        360.0,
                                        1382.0,
                                        352.0,
                                        1522.0,
                                        352.0,
                                        1522.0,
                                        390.0,
                                        1522.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1516.0,
                                        352.0,
                                        1516.0,
                                        390.0,
                                        1763.5,
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
                                        "obj-54",
                                        1
                                    ],
                                    "midpoints": [
                                        659.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        840.0,
                                        360.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        1
                                    ],
                                    "destination": [
                                        "obj-54",
                                        0
                                    ],
                                    "midpoints": [
                                        1001.75,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        817.0,
                                        360.0
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
                                        "obj-53",
                                        0
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
                                        "obj-55",
                                        0
                                    ],
                                    "midpoints": [
                                        982.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1317.0,
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
                    "id": "obj-58",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4530.0,
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
                                        1080.0,
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
                                        1200.0,
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
                                        390.0,
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
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 2",
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
                                        810.0,
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
                                        495.0,
                                        195.0,
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
                                        585.0,
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
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 2",
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
                                        585.0,
                                        195.0,
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
                                        690.0,
                                        195.0,
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
                                        780.0,
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
                                        795.0,
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
                                        780.0,
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
                                        870.0,
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
                                        315.0,
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
                                        405.0,
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
                                        555.0,
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
                                        510.0,
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
                                        495.0,
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
                                        555.0,
                                        240.0,
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
                                        525.0,
                                        285.0,
                                        268.0,
                                        22.0
                                    ],
                                    "text": "expr min(max($f1/8., 0.), 1.) * 127.",
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
                                        720.0,
                                        330.0,
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
                                        1530.0,
                                        360.0,
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        870.0,
                                        285.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "pipe 400",
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
                                        1065.0,
                                        330.0,
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
                                    "id": "obj-37",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1005.0,
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
                                    "id": "obj-38",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1020.0,
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
                                    "id": "obj-39",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1035.0,
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
                                    "id": "obj-40",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1275.0,
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
                                    "id": "obj-41",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1080.0,
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
                                    "id": "obj-42",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1200.0,
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
                                    "id": "obj-43",
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
                                        975.0,
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
                                    "id": "obj-44",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1125.0,
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
                                    "id": "obj-45",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        900.0,
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
                                    "id": "obj-46",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        900.0,
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
                                    "id": "obj-47",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        705.0,
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
                                    "id": "obj-48",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
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
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
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
                                    "id": "obj-50",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        660.0,
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
                                    "id": "obj-51",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1200.0,
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
                                    "id": "obj-52",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1710.0,
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
                                    "id": "obj-53",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        780.0,
                                        360.0,
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
                                    "id": "obj-54",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        330.0,
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
                                    "id": "obj-55",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1260.0,
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
                                        "obj-5",
                                        0
                                    ],
                                    "destination": [
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        431.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        502.0,
                                        142.0,
                                        484.0,
                                        142.0,
                                        484.0,
                                        180.0,
                                        523.0,
                                        180.0
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
                                        "obj-8",
                                        1
                                    ],
                                    "midpoints": [
                                        433.0,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        679.0,
                                        142.0,
                                        682.0,
                                        142.0,
                                        682.0,
                                        180.0,
                                        682.0,
                                        142.0,
                                        772.0,
                                        142.0,
                                        772.0,
                                        180.0,
                                        772.0,
                                        187.0,
                                        547.0,
                                        187.0,
                                        547.0,
                                        225.0,
                                        547.0,
                                        187.0,
                                        637.0,
                                        187.0,
                                        637.0,
                                        225.0,
                                        637.0,
                                        187.0,
                                        682.0,
                                        187.0,
                                        682.0,
                                        225.0,
                                        682.0,
                                        187.0,
                                        787.0,
                                        187.0,
                                        787.0,
                                        225.0,
                                        787.0,
                                        232.0,
                                        772.0,
                                        232.0,
                                        772.0,
                                        270.0,
                                        772.0,
                                        232.0,
                                        547.0,
                                        232.0,
                                        547.0,
                                        270.0,
                                        547.0,
                                        277.0,
                                        517.0,
                                        277.0,
                                        517.0,
                                        315.0,
                                        847.0,
                                        315.0
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
                                    ],
                                    "midpoints": [
                                        570.5,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        628.0,
                                        180.0
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
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        570.5,
                                        112.0,
                                        637.0,
                                        112.0,
                                        637.0,
                                        150.0,
                                        637.0,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        733.0,
                                        180.0
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
                                        "obj-13",
                                        1
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
                                    ],
                                    "midpoints": [
                                        702.0,
                                        142.0,
                                        784.0,
                                        142.0,
                                        784.0,
                                        180.0,
                                        823.0,
                                        180.0
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
                                    ],
                                    "midpoints": [
                                        832.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        962.0,
                                        360.0
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
                                        322.0,
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
                                        67.0,
                                        367.0,
                                        67.0,
                                        367.0,
                                        105.0,
                                        367.0,
                                        112.0,
                                        352.0,
                                        112.0,
                                        352.0,
                                        150.0,
                                        352.0,
                                        142.0,
                                        382.0,
                                        142.0,
                                        382.0,
                                        180.0,
                                        421.0,
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
                                        "obj-26",
                                        2
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        802.0,
                                        352.0,
                                        892.0,
                                        352.0,
                                        892.0,
                                        390.0,
                                        892.0,
                                        352.0,
                                        772.0,
                                        352.0,
                                        772.0,
                                        390.0,
                                        520.0,
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
                                        421.0,
                                        397.0,
                                        492.0,
                                        397.0,
                                        492.0,
                                        435.0,
                                        567.0,
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
                                        444.5,
                                        397.0,
                                        502.0,
                                        397.0,
                                        502.0,
                                        435.0,
                                        502.0,
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
                                        594.5,
                                        483.5,
                                        535.5,
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
                                        607.0,
                                        228.5,
                                        562.0,
                                        228.5
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
                                        712.0,
                                        228.5,
                                        760.0,
                                        228.5
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
                                        659.0,
                                        318.5,
                                        750.0,
                                        318.5
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
                                        852.0,
                                        232.0,
                                        775.0,
                                        232.0,
                                        775.0,
                                        270.0,
                                        775.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        727.0,
                                        360.0
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
                                    ],
                                    "midpoints": [
                                        738.5,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1192.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        855.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        1027.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1267.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1022.0,
                                        352.0,
                                        895.0,
                                        352.0,
                                        895.0,
                                        390.0,
                                        1537.0,
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
                                        "obj-35",
                                        0
                                    ],
                                    "midpoints": [
                                        852.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        877.0,
                                        315.0
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
                                    ],
                                    "midpoints": [
                                        911.5,
                                        277.0,
                                        967.0,
                                        277.0,
                                        967.0,
                                        315.0,
                                        967.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1072.0,
                                        360.0
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
                                        "obj-34",
                                        0
                                    ],
                                    "midpoints": [
                                        1085.0,
                                        322.0,
                                        1205.0,
                                        322.0,
                                        1205.0,
                                        360.0,
                                        1205.0,
                                        322.0,
                                        1248.0,
                                        322.0,
                                        1248.0,
                                        360.0,
                                        1248.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1537.0,
                                        390.0
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
                                        "obj-37",
                                        0
                                    ],
                                    "midpoints": [
                                        518.75,
                                        487.0,
                                        789.0,
                                        487.0,
                                        789.0,
                                        525.0,
                                        789.0,
                                        532.0,
                                        789.0,
                                        532.0,
                                        789.0,
                                        570.0,
                                        1012.0,
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
                                        "obj-37",
                                        1
                                    ],
                                    "midpoints": [
                                        1537.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1040.0,
                                        390.0
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
                                        "obj-38",
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
                                        "obj-39",
                                        0
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        1057.0,
                                        322.0,
                                        1057.0,
                                        360.0,
                                        1057.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1151.5,
                                        390.0
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
                                        "obj-40",
                                        0
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1205.0,
                                        322.0,
                                        1205.0,
                                        360.0,
                                        1205.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1192.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1391.5,
                                        390.0
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
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        1049.0,
                                        603.5,
                                        1087.0,
                                        603.5
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
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        1049.0,
                                        607.0,
                                        1130.0,
                                        607.0,
                                        1130.0,
                                        645.0,
                                        1207.0,
                                        645.0
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
                                        "obj-41",
                                        1
                                    ],
                                    "midpoints": [
                                        1151.5,
                                        498.5,
                                        1115.0,
                                        498.5
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
                                        "obj-42",
                                        1
                                    ],
                                    "midpoints": [
                                        1391.5,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1235.0,
                                        390.0
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
                                        "obj-1",
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
                                        "obj-43",
                                        0
                                    ],
                                    "midpoints": [
                                        808.6666666666666,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        961.0,
                                        277.0,
                                        961.0,
                                        315.0,
                                        1021.5,
                                        315.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        4
                                    ],
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        1061.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1161.0,
                                        360.0
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
                                        "obj-45",
                                        0
                                    ],
                                    "midpoints": [
                                        1161.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1057.0,
                                        322.0,
                                        1057.0,
                                        360.0,
                                        1057.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        907.0,
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
                                        "obj-45",
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
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        679.0,
                                        142.0,
                                        784.0,
                                        142.0,
                                        784.0,
                                        180.0,
                                        784.0,
                                        142.0,
                                        772.0,
                                        142.0,
                                        772.0,
                                        180.0,
                                        772.0,
                                        187.0,
                                        637.0,
                                        187.0,
                                        637.0,
                                        225.0,
                                        637.0,
                                        187.0,
                                        742.0,
                                        187.0,
                                        742.0,
                                        225.0,
                                        742.0,
                                        187.0,
                                        787.0,
                                        187.0,
                                        787.0,
                                        225.0,
                                        787.0,
                                        232.0,
                                        772.0,
                                        232.0,
                                        772.0,
                                        270.0,
                                        772.0,
                                        232.0,
                                        775.0,
                                        232.0,
                                        775.0,
                                        270.0,
                                        775.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        967.0,
                                        277.0,
                                        967.0,
                                        315.0,
                                        967.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        862.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        802.0,
                                        352.0,
                                        772.0,
                                        352.0,
                                        772.0,
                                        390.0,
                                        1007.0,
                                        390.0
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
                                        "obj-26",
                                        0
                                    ],
                                    "destination": [
                                        "obj-49",
                                        1
                                    ],
                                    "midpoints": [
                                        421.0,
                                        397.0,
                                        492.0,
                                        397.0,
                                        492.0,
                                        435.0,
                                        492.0,
                                        397.0,
                                        632.0,
                                        397.0,
                                        632.0,
                                        435.0,
                                        741.0,
                                        435.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        3
                                    ],
                                    "destination": [
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        1041.25,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        862.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        855.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        1027.0,
                                        352.0,
                                        892.0,
                                        352.0,
                                        892.0,
                                        390.0,
                                        892.0,
                                        352.0,
                                        895.0,
                                        352.0,
                                        895.0,
                                        390.0,
                                        895.0,
                                        397.0,
                                        892.0,
                                        397.0,
                                        892.0,
                                        435.0,
                                        697.0,
                                        435.0
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
                                        "obj-48",
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
                                        "obj-50",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        2
                                    ],
                                    "destination": [
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        1021.5,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1207.0,
                                        360.0
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
                                        "obj-52",
                                        0
                                    ],
                                    "midpoints": [
                                        1220.0,
                                        322.0,
                                        1382.0,
                                        322.0,
                                        1382.0,
                                        360.0,
                                        1382.0,
                                        352.0,
                                        1522.0,
                                        352.0,
                                        1522.0,
                                        390.0,
                                        1522.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1516.0,
                                        352.0,
                                        1516.0,
                                        390.0,
                                        1763.5,
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
                                        "obj-54",
                                        1
                                    ],
                                    "midpoints": [
                                        659.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        840.0,
                                        360.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        1
                                    ],
                                    "destination": [
                                        "obj-54",
                                        0
                                    ],
                                    "midpoints": [
                                        1001.75,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        817.0,
                                        360.0
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
                                        "obj-53",
                                        0
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
                                        "obj-55",
                                        0
                                    ],
                                    "midpoints": [
                                        982.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1317.0,
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
                    "id": "obj-59",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4635.0,
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
                                        1080.0,
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
                                        1200.0,
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
                                        390.0,
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
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 2",
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
                                        810.0,
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
                                        495.0,
                                        195.0,
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
                                        585.0,
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
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 2",
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
                                        585.0,
                                        195.0,
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
                                        690.0,
                                        195.0,
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
                                        780.0,
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
                                        795.0,
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
                                        780.0,
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
                                        870.0,
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
                                        315.0,
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
                                        405.0,
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
                                        555.0,
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
                                        510.0,
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
                                        495.0,
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
                                        555.0,
                                        240.0,
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
                                        525.0,
                                        285.0,
                                        268.0,
                                        22.0
                                    ],
                                    "text": "expr min(max($f1/8., 0.), 1.) * 127.",
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
                                        720.0,
                                        330.0,
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
                                        1530.0,
                                        360.0,
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        870.0,
                                        285.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "pipe 400",
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
                                        1065.0,
                                        330.0,
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
                                    "id": "obj-37",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1005.0,
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
                                    "id": "obj-38",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1020.0,
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
                                    "id": "obj-39",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1035.0,
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
                                    "id": "obj-40",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1275.0,
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
                                    "id": "obj-41",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1080.0,
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
                                    "id": "obj-42",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1200.0,
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
                                    "id": "obj-43",
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
                                        975.0,
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
                                    "id": "obj-44",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1125.0,
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
                                    "id": "obj-45",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        900.0,
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
                                    "id": "obj-46",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        900.0,
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
                                    "id": "obj-47",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        705.0,
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
                                    "id": "obj-48",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
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
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
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
                                    "id": "obj-50",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        660.0,
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
                                    "id": "obj-51",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1200.0,
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
                                    "id": "obj-52",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1710.0,
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
                                    "id": "obj-53",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        780.0,
                                        360.0,
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
                                    "id": "obj-54",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        330.0,
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
                                    "id": "obj-55",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1260.0,
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
                                        "obj-5",
                                        0
                                    ],
                                    "destination": [
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        431.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        502.0,
                                        142.0,
                                        484.0,
                                        142.0,
                                        484.0,
                                        180.0,
                                        523.0,
                                        180.0
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
                                        "obj-8",
                                        1
                                    ],
                                    "midpoints": [
                                        433.0,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        679.0,
                                        142.0,
                                        682.0,
                                        142.0,
                                        682.0,
                                        180.0,
                                        682.0,
                                        142.0,
                                        772.0,
                                        142.0,
                                        772.0,
                                        180.0,
                                        772.0,
                                        187.0,
                                        547.0,
                                        187.0,
                                        547.0,
                                        225.0,
                                        547.0,
                                        187.0,
                                        637.0,
                                        187.0,
                                        637.0,
                                        225.0,
                                        637.0,
                                        187.0,
                                        682.0,
                                        187.0,
                                        682.0,
                                        225.0,
                                        682.0,
                                        187.0,
                                        787.0,
                                        187.0,
                                        787.0,
                                        225.0,
                                        787.0,
                                        232.0,
                                        772.0,
                                        232.0,
                                        772.0,
                                        270.0,
                                        772.0,
                                        232.0,
                                        547.0,
                                        232.0,
                                        547.0,
                                        270.0,
                                        547.0,
                                        277.0,
                                        517.0,
                                        277.0,
                                        517.0,
                                        315.0,
                                        847.0,
                                        315.0
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
                                    ],
                                    "midpoints": [
                                        570.5,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        628.0,
                                        180.0
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
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        570.5,
                                        112.0,
                                        637.0,
                                        112.0,
                                        637.0,
                                        150.0,
                                        637.0,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        733.0,
                                        180.0
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
                                        "obj-13",
                                        1
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
                                    ],
                                    "midpoints": [
                                        702.0,
                                        142.0,
                                        784.0,
                                        142.0,
                                        784.0,
                                        180.0,
                                        823.0,
                                        180.0
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
                                    ],
                                    "midpoints": [
                                        832.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        962.0,
                                        360.0
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
                                        322.0,
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
                                        67.0,
                                        367.0,
                                        67.0,
                                        367.0,
                                        105.0,
                                        367.0,
                                        112.0,
                                        352.0,
                                        112.0,
                                        352.0,
                                        150.0,
                                        352.0,
                                        142.0,
                                        382.0,
                                        142.0,
                                        382.0,
                                        180.0,
                                        421.0,
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
                                        "obj-26",
                                        2
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        802.0,
                                        352.0,
                                        892.0,
                                        352.0,
                                        892.0,
                                        390.0,
                                        892.0,
                                        352.0,
                                        772.0,
                                        352.0,
                                        772.0,
                                        390.0,
                                        520.0,
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
                                        421.0,
                                        397.0,
                                        492.0,
                                        397.0,
                                        492.0,
                                        435.0,
                                        567.0,
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
                                        444.5,
                                        397.0,
                                        502.0,
                                        397.0,
                                        502.0,
                                        435.0,
                                        502.0,
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
                                        594.5,
                                        483.5,
                                        535.5,
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
                                        607.0,
                                        228.5,
                                        562.0,
                                        228.5
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
                                        712.0,
                                        228.5,
                                        760.0,
                                        228.5
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
                                        659.0,
                                        318.5,
                                        750.0,
                                        318.5
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
                                        852.0,
                                        232.0,
                                        775.0,
                                        232.0,
                                        775.0,
                                        270.0,
                                        775.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        727.0,
                                        360.0
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
                                    ],
                                    "midpoints": [
                                        738.5,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1192.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        855.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        1027.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1267.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1022.0,
                                        352.0,
                                        895.0,
                                        352.0,
                                        895.0,
                                        390.0,
                                        1537.0,
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
                                        "obj-35",
                                        0
                                    ],
                                    "midpoints": [
                                        852.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        877.0,
                                        315.0
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
                                    ],
                                    "midpoints": [
                                        911.5,
                                        277.0,
                                        967.0,
                                        277.0,
                                        967.0,
                                        315.0,
                                        967.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1072.0,
                                        360.0
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
                                        "obj-34",
                                        0
                                    ],
                                    "midpoints": [
                                        1085.0,
                                        322.0,
                                        1205.0,
                                        322.0,
                                        1205.0,
                                        360.0,
                                        1205.0,
                                        322.0,
                                        1248.0,
                                        322.0,
                                        1248.0,
                                        360.0,
                                        1248.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1537.0,
                                        390.0
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
                                        "obj-37",
                                        0
                                    ],
                                    "midpoints": [
                                        518.75,
                                        487.0,
                                        789.0,
                                        487.0,
                                        789.0,
                                        525.0,
                                        789.0,
                                        532.0,
                                        789.0,
                                        532.0,
                                        789.0,
                                        570.0,
                                        1012.0,
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
                                        "obj-37",
                                        1
                                    ],
                                    "midpoints": [
                                        1537.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1040.0,
                                        390.0
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
                                        "obj-38",
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
                                        "obj-39",
                                        0
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        1057.0,
                                        322.0,
                                        1057.0,
                                        360.0,
                                        1057.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1151.5,
                                        390.0
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
                                        "obj-40",
                                        0
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1205.0,
                                        322.0,
                                        1205.0,
                                        360.0,
                                        1205.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1192.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1391.5,
                                        390.0
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
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        1049.0,
                                        603.5,
                                        1087.0,
                                        603.5
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
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        1049.0,
                                        607.0,
                                        1130.0,
                                        607.0,
                                        1130.0,
                                        645.0,
                                        1207.0,
                                        645.0
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
                                        "obj-41",
                                        1
                                    ],
                                    "midpoints": [
                                        1151.5,
                                        498.5,
                                        1115.0,
                                        498.5
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
                                        "obj-42",
                                        1
                                    ],
                                    "midpoints": [
                                        1391.5,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1235.0,
                                        390.0
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
                                        "obj-1",
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
                                        "obj-43",
                                        0
                                    ],
                                    "midpoints": [
                                        808.6666666666666,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        961.0,
                                        277.0,
                                        961.0,
                                        315.0,
                                        1021.5,
                                        315.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        4
                                    ],
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        1061.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1161.0,
                                        360.0
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
                                        "obj-45",
                                        0
                                    ],
                                    "midpoints": [
                                        1161.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1057.0,
                                        322.0,
                                        1057.0,
                                        360.0,
                                        1057.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        907.0,
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
                                        "obj-45",
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
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        679.0,
                                        142.0,
                                        784.0,
                                        142.0,
                                        784.0,
                                        180.0,
                                        784.0,
                                        142.0,
                                        772.0,
                                        142.0,
                                        772.0,
                                        180.0,
                                        772.0,
                                        187.0,
                                        637.0,
                                        187.0,
                                        637.0,
                                        225.0,
                                        637.0,
                                        187.0,
                                        742.0,
                                        187.0,
                                        742.0,
                                        225.0,
                                        742.0,
                                        187.0,
                                        787.0,
                                        187.0,
                                        787.0,
                                        225.0,
                                        787.0,
                                        232.0,
                                        772.0,
                                        232.0,
                                        772.0,
                                        270.0,
                                        772.0,
                                        232.0,
                                        775.0,
                                        232.0,
                                        775.0,
                                        270.0,
                                        775.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        967.0,
                                        277.0,
                                        967.0,
                                        315.0,
                                        967.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        862.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        802.0,
                                        352.0,
                                        772.0,
                                        352.0,
                                        772.0,
                                        390.0,
                                        1007.0,
                                        390.0
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
                                        "obj-26",
                                        0
                                    ],
                                    "destination": [
                                        "obj-49",
                                        1
                                    ],
                                    "midpoints": [
                                        421.0,
                                        397.0,
                                        492.0,
                                        397.0,
                                        492.0,
                                        435.0,
                                        492.0,
                                        397.0,
                                        632.0,
                                        397.0,
                                        632.0,
                                        435.0,
                                        741.0,
                                        435.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        3
                                    ],
                                    "destination": [
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        1041.25,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        862.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        855.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        1027.0,
                                        352.0,
                                        892.0,
                                        352.0,
                                        892.0,
                                        390.0,
                                        892.0,
                                        352.0,
                                        895.0,
                                        352.0,
                                        895.0,
                                        390.0,
                                        895.0,
                                        397.0,
                                        892.0,
                                        397.0,
                                        892.0,
                                        435.0,
                                        697.0,
                                        435.0
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
                                        "obj-48",
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
                                        "obj-50",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        2
                                    ],
                                    "destination": [
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        1021.5,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1207.0,
                                        360.0
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
                                        "obj-52",
                                        0
                                    ],
                                    "midpoints": [
                                        1220.0,
                                        322.0,
                                        1382.0,
                                        322.0,
                                        1382.0,
                                        360.0,
                                        1382.0,
                                        352.0,
                                        1522.0,
                                        352.0,
                                        1522.0,
                                        390.0,
                                        1522.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1516.0,
                                        352.0,
                                        1516.0,
                                        390.0,
                                        1763.5,
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
                                        "obj-54",
                                        1
                                    ],
                                    "midpoints": [
                                        659.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        840.0,
                                        360.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        1
                                    ],
                                    "destination": [
                                        "obj-54",
                                        0
                                    ],
                                    "midpoints": [
                                        1001.75,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        817.0,
                                        360.0
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
                                        "obj-53",
                                        0
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
                                        "obj-55",
                                        0
                                    ],
                                    "midpoints": [
                                        982.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1317.0,
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
                    "id": "obj-60",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4740.0,
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
                                        1080.0,
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
                                        1200.0,
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
                                        390.0,
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
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 2",
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
                                        810.0,
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
                                        495.0,
                                        195.0,
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
                                        585.0,
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
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
                                        150.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "bach.nth 2",
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
                                        585.0,
                                        195.0,
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
                                        690.0,
                                        195.0,
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
                                        780.0,
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
                                        795.0,
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
                                        780.0,
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
                                        870.0,
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
                                        315.0,
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
                                        405.0,
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
                                        555.0,
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
                                        510.0,
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
                                        495.0,
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
                                        555.0,
                                        240.0,
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
                                        525.0,
                                        285.0,
                                        268.0,
                                        22.0
                                    ],
                                    "text": "expr min(max($f1/8., 0.), 1.) * 127.",
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
                                        720.0,
                                        330.0,
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
                                        1530.0,
                                        360.0,
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        870.0,
                                        285.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "pipe 400",
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
                                        1065.0,
                                        330.0,
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
                                    "id": "obj-37",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1005.0,
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
                                    "id": "obj-38",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1020.0,
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
                                    "id": "obj-39",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1035.0,
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
                                    "id": "obj-40",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1275.0,
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
                                    "id": "obj-41",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1080.0,
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
                                    "id": "obj-42",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        1200.0,
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
                                    "id": "obj-43",
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
                                        975.0,
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
                                    "id": "obj-44",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1125.0,
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
                                    "id": "obj-45",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        900.0,
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
                                    "id": "obj-46",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        900.0,
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
                                    "id": "obj-47",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        705.0,
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
                                    "id": "obj-48",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
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
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
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
                                    "id": "obj-50",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        660.0,
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
                                    "id": "obj-51",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1200.0,
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
                                    "id": "obj-52",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1710.0,
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
                                    "id": "obj-53",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        780.0,
                                        360.0,
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
                                    "id": "obj-54",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        330.0,
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
                                    "id": "obj-55",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1260.0,
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
                                        "obj-5",
                                        0
                                    ],
                                    "destination": [
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        431.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        502.0,
                                        142.0,
                                        484.0,
                                        142.0,
                                        484.0,
                                        180.0,
                                        523.0,
                                        180.0
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
                                        "obj-8",
                                        1
                                    ],
                                    "midpoints": [
                                        433.0,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        679.0,
                                        142.0,
                                        682.0,
                                        142.0,
                                        682.0,
                                        180.0,
                                        682.0,
                                        142.0,
                                        772.0,
                                        142.0,
                                        772.0,
                                        180.0,
                                        772.0,
                                        187.0,
                                        547.0,
                                        187.0,
                                        547.0,
                                        225.0,
                                        547.0,
                                        187.0,
                                        637.0,
                                        187.0,
                                        637.0,
                                        225.0,
                                        637.0,
                                        187.0,
                                        682.0,
                                        187.0,
                                        682.0,
                                        225.0,
                                        682.0,
                                        187.0,
                                        787.0,
                                        187.0,
                                        787.0,
                                        225.0,
                                        787.0,
                                        232.0,
                                        772.0,
                                        232.0,
                                        772.0,
                                        270.0,
                                        772.0,
                                        232.0,
                                        547.0,
                                        232.0,
                                        547.0,
                                        270.0,
                                        547.0,
                                        277.0,
                                        517.0,
                                        277.0,
                                        517.0,
                                        315.0,
                                        847.0,
                                        315.0
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
                                    ],
                                    "midpoints": [
                                        570.5,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        628.0,
                                        180.0
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
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        570.5,
                                        112.0,
                                        637.0,
                                        112.0,
                                        637.0,
                                        150.0,
                                        637.0,
                                        142.0,
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        733.0,
                                        180.0
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
                                        "obj-13",
                                        1
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
                                    ],
                                    "midpoints": [
                                        702.0,
                                        142.0,
                                        784.0,
                                        142.0,
                                        784.0,
                                        180.0,
                                        823.0,
                                        180.0
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
                                    ],
                                    "midpoints": [
                                        832.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        962.0,
                                        360.0
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
                                        322.0,
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
                                        67.0,
                                        367.0,
                                        67.0,
                                        367.0,
                                        105.0,
                                        367.0,
                                        112.0,
                                        352.0,
                                        112.0,
                                        352.0,
                                        150.0,
                                        352.0,
                                        142.0,
                                        382.0,
                                        142.0,
                                        382.0,
                                        180.0,
                                        421.0,
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
                                        "obj-26",
                                        2
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        802.0,
                                        352.0,
                                        892.0,
                                        352.0,
                                        892.0,
                                        390.0,
                                        892.0,
                                        352.0,
                                        772.0,
                                        352.0,
                                        772.0,
                                        390.0,
                                        520.0,
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
                                        421.0,
                                        397.0,
                                        492.0,
                                        397.0,
                                        492.0,
                                        435.0,
                                        567.0,
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
                                        444.5,
                                        397.0,
                                        502.0,
                                        397.0,
                                        502.0,
                                        435.0,
                                        502.0,
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
                                        594.5,
                                        483.5,
                                        535.5,
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
                                        607.0,
                                        228.5,
                                        562.0,
                                        228.5
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
                                        712.0,
                                        228.5,
                                        760.0,
                                        228.5
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
                                        659.0,
                                        318.5,
                                        750.0,
                                        318.5
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
                                        852.0,
                                        232.0,
                                        775.0,
                                        232.0,
                                        775.0,
                                        270.0,
                                        775.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        727.0,
                                        360.0
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
                                    ],
                                    "midpoints": [
                                        738.5,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1192.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        855.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        1027.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1267.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1022.0,
                                        352.0,
                                        895.0,
                                        352.0,
                                        895.0,
                                        390.0,
                                        1537.0,
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
                                        "obj-35",
                                        0
                                    ],
                                    "midpoints": [
                                        852.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        877.0,
                                        315.0
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
                                    ],
                                    "midpoints": [
                                        911.5,
                                        277.0,
                                        967.0,
                                        277.0,
                                        967.0,
                                        315.0,
                                        967.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1072.0,
                                        360.0
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
                                        "obj-34",
                                        0
                                    ],
                                    "midpoints": [
                                        1085.0,
                                        322.0,
                                        1205.0,
                                        322.0,
                                        1205.0,
                                        360.0,
                                        1205.0,
                                        322.0,
                                        1248.0,
                                        322.0,
                                        1248.0,
                                        360.0,
                                        1248.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1537.0,
                                        390.0
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
                                        "obj-37",
                                        0
                                    ],
                                    "midpoints": [
                                        518.75,
                                        487.0,
                                        789.0,
                                        487.0,
                                        789.0,
                                        525.0,
                                        789.0,
                                        532.0,
                                        789.0,
                                        532.0,
                                        789.0,
                                        570.0,
                                        1012.0,
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
                                        "obj-37",
                                        1
                                    ],
                                    "midpoints": [
                                        1537.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1267.0,
                                        352.0,
                                        1267.0,
                                        390.0,
                                        1040.0,
                                        390.0
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
                                        "obj-38",
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
                                        "obj-39",
                                        0
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        1057.0,
                                        322.0,
                                        1057.0,
                                        360.0,
                                        1057.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1151.5,
                                        390.0
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
                                        "obj-40",
                                        0
                                    ],
                                    "midpoints": [
                                        962.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1205.0,
                                        322.0,
                                        1205.0,
                                        360.0,
                                        1205.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1192.0,
                                        322.0,
                                        1252.0,
                                        322.0,
                                        1252.0,
                                        360.0,
                                        1252.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1022.0,
                                        352.0,
                                        1022.0,
                                        390.0,
                                        1391.5,
                                        390.0
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
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        1049.0,
                                        603.5,
                                        1087.0,
                                        603.5
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
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        1049.0,
                                        607.0,
                                        1130.0,
                                        607.0,
                                        1130.0,
                                        645.0,
                                        1207.0,
                                        645.0
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
                                        "obj-41",
                                        1
                                    ],
                                    "midpoints": [
                                        1151.5,
                                        498.5,
                                        1115.0,
                                        498.5
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
                                        "obj-42",
                                        1
                                    ],
                                    "midpoints": [
                                        1391.5,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1235.0,
                                        390.0
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
                                        "obj-1",
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
                                        "obj-43",
                                        0
                                    ],
                                    "midpoints": [
                                        808.6666666666666,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        961.0,
                                        277.0,
                                        961.0,
                                        315.0,
                                        1021.5,
                                        315.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        4
                                    ],
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        1061.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1161.0,
                                        360.0
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
                                        "obj-45",
                                        0
                                    ],
                                    "midpoints": [
                                        1161.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1057.0,
                                        322.0,
                                        1057.0,
                                        360.0,
                                        1057.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        907.0,
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
                                        "obj-45",
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
                                        574.0,
                                        142.0,
                                        574.0,
                                        180.0,
                                        574.0,
                                        142.0,
                                        679.0,
                                        142.0,
                                        679.0,
                                        180.0,
                                        679.0,
                                        142.0,
                                        784.0,
                                        142.0,
                                        784.0,
                                        180.0,
                                        784.0,
                                        142.0,
                                        772.0,
                                        142.0,
                                        772.0,
                                        180.0,
                                        772.0,
                                        187.0,
                                        637.0,
                                        187.0,
                                        637.0,
                                        225.0,
                                        637.0,
                                        187.0,
                                        742.0,
                                        187.0,
                                        742.0,
                                        225.0,
                                        742.0,
                                        187.0,
                                        787.0,
                                        187.0,
                                        787.0,
                                        225.0,
                                        787.0,
                                        232.0,
                                        772.0,
                                        232.0,
                                        772.0,
                                        270.0,
                                        772.0,
                                        232.0,
                                        775.0,
                                        232.0,
                                        775.0,
                                        270.0,
                                        775.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        967.0,
                                        277.0,
                                        967.0,
                                        315.0,
                                        967.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        862.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        802.0,
                                        322.0,
                                        802.0,
                                        360.0,
                                        802.0,
                                        352.0,
                                        772.0,
                                        352.0,
                                        772.0,
                                        390.0,
                                        1007.0,
                                        390.0
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
                                        "obj-26",
                                        0
                                    ],
                                    "destination": [
                                        "obj-49",
                                        1
                                    ],
                                    "midpoints": [
                                        421.0,
                                        397.0,
                                        492.0,
                                        397.0,
                                        492.0,
                                        435.0,
                                        492.0,
                                        397.0,
                                        632.0,
                                        397.0,
                                        632.0,
                                        435.0,
                                        741.0,
                                        435.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        3
                                    ],
                                    "destination": [
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        1041.25,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        801.0,
                                        277.0,
                                        801.0,
                                        315.0,
                                        801.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        862.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        765.0,
                                        322.0,
                                        855.0,
                                        322.0,
                                        855.0,
                                        360.0,
                                        855.0,
                                        352.0,
                                        1027.0,
                                        352.0,
                                        1027.0,
                                        390.0,
                                        1027.0,
                                        352.0,
                                        892.0,
                                        352.0,
                                        892.0,
                                        390.0,
                                        892.0,
                                        352.0,
                                        895.0,
                                        352.0,
                                        895.0,
                                        390.0,
                                        895.0,
                                        397.0,
                                        892.0,
                                        397.0,
                                        892.0,
                                        435.0,
                                        697.0,
                                        435.0
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
                                        "obj-48",
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
                                        "obj-50",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        2
                                    ],
                                    "destination": [
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        1021.5,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1207.0,
                                        360.0
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
                                        "obj-52",
                                        0
                                    ],
                                    "midpoints": [
                                        1220.0,
                                        322.0,
                                        1382.0,
                                        322.0,
                                        1382.0,
                                        360.0,
                                        1382.0,
                                        352.0,
                                        1522.0,
                                        352.0,
                                        1522.0,
                                        390.0,
                                        1522.0,
                                        352.0,
                                        1276.0,
                                        352.0,
                                        1276.0,
                                        390.0,
                                        1276.0,
                                        352.0,
                                        1516.0,
                                        352.0,
                                        1516.0,
                                        390.0,
                                        1763.5,
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
                                        "obj-54",
                                        1
                                    ],
                                    "midpoints": [
                                        659.0,
                                        277.0,
                                        802.0,
                                        277.0,
                                        802.0,
                                        315.0,
                                        802.0,
                                        322.0,
                                        765.0,
                                        322.0,
                                        765.0,
                                        360.0,
                                        840.0,
                                        360.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-43",
                                        1
                                    ],
                                    "destination": [
                                        "obj-54",
                                        0
                                    ],
                                    "midpoints": [
                                        1001.75,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        277.0,
                                        862.0,
                                        315.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        322.0,
                                        862.0,
                                        360.0,
                                        817.0,
                                        360.0
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
                                        "obj-53",
                                        0
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
                                        "obj-55",
                                        0
                                    ],
                                    "midpoints": [
                                        982.0,
                                        322.0,
                                        1062.0,
                                        322.0,
                                        1062.0,
                                        360.0,
                                        1062.0,
                                        322.0,
                                        1113.0,
                                        322.0,
                                        1113.0,
                                        360.0,
                                        1113.0,
                                        322.0,
                                        1117.0,
                                        322.0,
                                        1117.0,
                                        360.0,
                                        1117.0,
                                        322.0,
                                        1192.0,
                                        322.0,
                                        1192.0,
                                        360.0,
                                        1317.0,
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
                    "id": "obj-61",
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
                        240.0,
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
                    "id": "obj-62",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        405.0,
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
                    "id": "obj-63",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        705.0,
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
                    "id": "obj-64",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        570.0,
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
                    "id": "obj-65",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        270.0,
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
                    "id": "obj-66",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        120.0,
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
                    "id": "obj-67",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4365.0,
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
                        4440.0,
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
                        4530.0,
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
                        4620.0,
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
                    "id": "obj-71",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4440.0,
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
                    "id": "obj-72",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4515.0,
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
                    "id": "obj-73",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4605.0,
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
                    "id": "obj-74",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4695.0,
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
                    "id": "obj-76",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4650.0,
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
                    "id": "obj-77",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4635.0,
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
                    "id": "obj-78",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        4635.0,
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
                    "id": "obj-79",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        4710.0,
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
                        108.5,
                        262.0,
                        108.5
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
                        142.0,
                        848.0,
                        142.0,
                        848.0,
                        458.0,
                        848.0,
                        457.0,
                        418.0,
                        457.0,
                        418.0,
                        495.0,
                        418.0,
                        487.0,
                        341.0,
                        487.0,
                        341.0,
                        525.0,
                        341.0,
                        487.0,
                        461.0,
                        487.0,
                        461.0,
                        525.0,
                        461.0,
                        532.0,
                        317.0,
                        532.0,
                        317.0,
                        570.0,
                        317.0,
                        532.0,
                        962.0,
                        532.0,
                        962.0,
                        570.0,
                        962.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        967.0,
                        532.0,
                        967.0,
                        570.0,
                        967.0,
                        532.0,
                        572.0,
                        532.0,
                        572.0,
                        570.0,
                        572.0,
                        532.0,
                        1087.0,
                        532.0,
                        1087.0,
                        570.0,
                        1087.0,
                        532.0,
                        707.0,
                        532.0,
                        707.0,
                        570.0,
                        707.0,
                        532.0,
                        1222.0,
                        532.0,
                        1222.0,
                        570.0,
                        1222.0,
                        532.0,
                        827.0,
                        532.0,
                        827.0,
                        570.0,
                        827.0,
                        532.0,
                        1342.0,
                        532.0,
                        1342.0,
                        570.0,
                        1695.0,
                        570.0
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
                        112.0,
                        363.0,
                        112.0,
                        363.0,
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
                        142.0,
                        848.0,
                        142.0,
                        848.0,
                        458.0,
                        848.0,
                        487.0,
                        461.0,
                        487.0,
                        461.0,
                        525.0,
                        461.0,
                        532.0,
                        962.0,
                        532.0,
                        962.0,
                        570.0,
                        962.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        1097.0,
                        532.0,
                        1097.0,
                        570.0,
                        1097.0,
                        532.0,
                        572.0,
                        532.0,
                        572.0,
                        570.0,
                        572.0,
                        532.0,
                        1087.0,
                        532.0,
                        1087.0,
                        570.0,
                        1087.0,
                        532.0,
                        707.0,
                        532.0,
                        707.0,
                        570.0,
                        707.0,
                        532.0,
                        1222.0,
                        532.0,
                        1222.0,
                        570.0,
                        1222.0,
                        532.0,
                        827.0,
                        532.0,
                        827.0,
                        570.0,
                        827.0,
                        532.0,
                        1342.0,
                        532.0,
                        1342.0,
                        570.0,
                        1695.0,
                        570.0
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
                        142.0,
                        848.0,
                        142.0,
                        848.0,
                        458.0,
                        848.0,
                        532.0,
                        962.0,
                        532.0,
                        962.0,
                        570.0,
                        962.0,
                        532.0,
                        1097.0,
                        532.0,
                        1097.0,
                        570.0,
                        1097.0,
                        532.0,
                        1217.0,
                        532.0,
                        1217.0,
                        570.0,
                        1217.0,
                        532.0,
                        1222.0,
                        532.0,
                        1222.0,
                        570.0,
                        1222.0,
                        532.0,
                        827.0,
                        532.0,
                        827.0,
                        570.0,
                        827.0,
                        532.0,
                        1342.0,
                        532.0,
                        1342.0,
                        570.0,
                        1695.0,
                        570.0
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
                        847.0,
                        67.0,
                        847.0,
                        105.0,
                        847.0,
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
                        1612.0,
                        112.0,
                        1612.0,
                        150.0,
                        1612.0,
                        532.0,
                        1472.0,
                        532.0,
                        1472.0,
                        570.0,
                        1695.0,
                        570.0
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
                        956.0,
                        67.0,
                        956.0,
                        105.0,
                        956.0,
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
                        341.0,
                        1695.0,
                        341.0
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
                        956.0,
                        67.0,
                        956.0,
                        105.0,
                        956.0,
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
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        1695.0,
                        150.0
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
                        956.0,
                        67.0,
                        956.0,
                        105.0,
                        956.0,
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
                        1695.0,
                        150.0
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
                        956.0,
                        67.0,
                        956.0,
                        105.0,
                        956.0,
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
                        2092.0,
                        112.0,
                        2092.0,
                        150.0,
                        2092.0,
                        112.0,
                        2558.0,
                        112.0,
                        2558.0,
                        150.0,
                        2558.0,
                        112.0,
                        2557.0,
                        112.0,
                        2557.0,
                        150.0,
                        1695.0,
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
                        "obj-14",
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
                        "obj-15",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-14",
                        1
                    ],
                    "destination": [
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        3521.75,
                        487.0,
                        3591.0,
                        487.0,
                        3591.0,
                        525.0,
                        3681.5,
                        525.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-14",
                        2
                    ],
                    "destination": [
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        3541.5,
                        487.0,
                        3591.0,
                        487.0,
                        3591.0,
                        525.0,
                        3591.0,
                        487.0,
                        3771.0,
                        487.0,
                        3771.0,
                        525.0,
                        3846.5,
                        525.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-14",
                        3
                    ],
                    "destination": [
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        3561.25,
                        487.0,
                        3591.0,
                        487.0,
                        3591.0,
                        525.0,
                        3591.0,
                        487.0,
                        3771.0,
                        487.0,
                        3771.0,
                        525.0,
                        3771.0,
                        487.0,
                        3757.0,
                        487.0,
                        3757.0,
                        525.0,
                        4026.5,
                        525.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-14",
                        4
                    ],
                    "destination": [
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        3581.0,
                        487.0,
                        3591.0,
                        487.0,
                        3591.0,
                        525.0,
                        3591.0,
                        487.0,
                        3771.0,
                        487.0,
                        3771.0,
                        525.0,
                        3771.0,
                        487.0,
                        3936.0,
                        487.0,
                        3936.0,
                        525.0,
                        3936.0,
                        487.0,
                        3937.0,
                        487.0,
                        3937.0,
                        525.0,
                        4206.5,
                        525.0
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
                        "obj-21",
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
                        164.0,
                        67.0,
                        164.0,
                        105.0,
                        164.0,
                        67.0,
                        847.0,
                        67.0,
                        847.0,
                        105.0,
                        847.0,
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
                        142.0,
                        848.0,
                        142.0,
                        848.0,
                        458.0,
                        848.0,
                        457.0,
                        88.0,
                        457.0,
                        88.0,
                        495.0,
                        88.0,
                        457.0,
                        193.0,
                        457.0,
                        193.0,
                        495.0,
                        193.0,
                        457.0,
                        298.0,
                        457.0,
                        298.0,
                        495.0,
                        298.0,
                        457.0,
                        418.0,
                        457.0,
                        418.0,
                        495.0,
                        418.0,
                        487.0,
                        131.0,
                        487.0,
                        131.0,
                        525.0,
                        131.0,
                        487.0,
                        236.0,
                        487.0,
                        236.0,
                        525.0,
                        236.0,
                        487.0,
                        341.0,
                        487.0,
                        341.0,
                        525.0,
                        341.0,
                        487.0,
                        461.0,
                        487.0,
                        461.0,
                        525.0,
                        461.0,
                        532.0,
                        317.0,
                        532.0,
                        317.0,
                        570.0,
                        317.0,
                        532.0,
                        832.0,
                        532.0,
                        832.0,
                        570.0,
                        832.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        967.0,
                        532.0,
                        967.0,
                        570.0,
                        967.0,
                        532.0,
                        572.0,
                        532.0,
                        572.0,
                        570.0,
                        572.0,
                        532.0,
                        1087.0,
                        532.0,
                        1087.0,
                        570.0,
                        1087.0,
                        532.0,
                        707.0,
                        532.0,
                        707.0,
                        570.0,
                        707.0,
                        532.0,
                        1222.0,
                        532.0,
                        1222.0,
                        570.0,
                        1222.0,
                        532.0,
                        827.0,
                        532.0,
                        827.0,
                        570.0,
                        827.0,
                        532.0,
                        1342.0,
                        532.0,
                        1342.0,
                        570.0,
                        1695.0,
                        570.0
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
                        1
                    ],
                    "destination": [
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        149.0,
                        67.0,
                        96.0,
                        67.0,
                        96.0,
                        105.0,
                        82.0,
                        105.0
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
                        "obj-26",
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
                        202.0,
                        150.0
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
                        142.0,
                        848.0,
                        142.0,
                        848.0,
                        458.0,
                        848.0,
                        457.0,
                        193.0,
                        457.0,
                        193.0,
                        495.0,
                        193.0,
                        457.0,
                        298.0,
                        457.0,
                        298.0,
                        495.0,
                        298.0,
                        457.0,
                        418.0,
                        457.0,
                        418.0,
                        495.0,
                        418.0,
                        487.0,
                        131.0,
                        487.0,
                        131.0,
                        525.0,
                        131.0,
                        487.0,
                        236.0,
                        487.0,
                        236.0,
                        525.0,
                        236.0,
                        487.0,
                        341.0,
                        487.0,
                        341.0,
                        525.0,
                        341.0,
                        487.0,
                        461.0,
                        487.0,
                        461.0,
                        525.0,
                        461.0,
                        532.0,
                        317.0,
                        532.0,
                        317.0,
                        570.0,
                        317.0,
                        532.0,
                        962.0,
                        532.0,
                        962.0,
                        570.0,
                        962.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        967.0,
                        532.0,
                        967.0,
                        570.0,
                        967.0,
                        532.0,
                        572.0,
                        532.0,
                        572.0,
                        570.0,
                        572.0,
                        532.0,
                        1087.0,
                        532.0,
                        1087.0,
                        570.0,
                        1087.0,
                        532.0,
                        707.0,
                        532.0,
                        707.0,
                        570.0,
                        707.0,
                        532.0,
                        1222.0,
                        532.0,
                        1222.0,
                        570.0,
                        1222.0,
                        532.0,
                        827.0,
                        532.0,
                        827.0,
                        570.0,
                        827.0,
                        532.0,
                        1342.0,
                        532.0,
                        1342.0,
                        570.0,
                        1695.0,
                        570.0
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
                        "obj-29",
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        76.5,
                        487.0,
                        236.0,
                        487.0,
                        236.0,
                        525.0,
                        236.0,
                        487.0,
                        341.0,
                        487.0,
                        341.0,
                        525.0,
                        341.0,
                        487.0,
                        461.0,
                        487.0,
                        461.0,
                        525.0,
                        461.0,
                        532.0,
                        317.0,
                        532.0,
                        317.0,
                        570.0,
                        317.0,
                        532.0,
                        832.0,
                        532.0,
                        832.0,
                        570.0,
                        832.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        967.0,
                        532.0,
                        967.0,
                        570.0,
                        967.0,
                        532.0,
                        572.0,
                        532.0,
                        572.0,
                        570.0,
                        572.0,
                        532.0,
                        1087.0,
                        532.0,
                        1087.0,
                        570.0,
                        1087.0,
                        532.0,
                        707.0,
                        532.0,
                        707.0,
                        570.0,
                        707.0,
                        532.0,
                        1222.0,
                        532.0,
                        1222.0,
                        570.0,
                        1222.0,
                        532.0,
                        827.0,
                        532.0,
                        827.0,
                        570.0,
                        827.0,
                        532.0,
                        1342.0,
                        532.0,
                        1342.0,
                        570.0,
                        1695.0,
                        570.0
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
                        "obj-28",
                        0
                    ],
                    "midpoints": [
                        3605.0,
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
                        142.0,
                        3487.0,
                        142.0,
                        3487.0,
                        180.0,
                        3487.0,
                        142.0,
                        848.0,
                        142.0,
                        848.0,
                        458.0,
                        848.0,
                        457.0,
                        193.0,
                        457.0,
                        193.0,
                        495.0,
                        193.0,
                        457.0,
                        298.0,
                        457.0,
                        298.0,
                        495.0,
                        298.0,
                        457.0,
                        418.0,
                        457.0,
                        418.0,
                        495.0,
                        55.0,
                        495.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        181.5,
                        487.0,
                        341.0,
                        487.0,
                        341.0,
                        525.0,
                        341.0,
                        487.0,
                        461.0,
                        487.0,
                        461.0,
                        525.0,
                        461.0,
                        532.0,
                        317.0,
                        532.0,
                        317.0,
                        570.0,
                        317.0,
                        532.0,
                        962.0,
                        532.0,
                        962.0,
                        570.0,
                        962.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        967.0,
                        532.0,
                        967.0,
                        570.0,
                        967.0,
                        532.0,
                        572.0,
                        532.0,
                        572.0,
                        570.0,
                        572.0,
                        532.0,
                        1087.0,
                        532.0,
                        1087.0,
                        570.0,
                        1087.0,
                        532.0,
                        707.0,
                        532.0,
                        707.0,
                        570.0,
                        707.0,
                        532.0,
                        1222.0,
                        532.0,
                        1222.0,
                        570.0,
                        1222.0,
                        532.0,
                        827.0,
                        532.0,
                        827.0,
                        570.0,
                        827.0,
                        532.0,
                        1342.0,
                        532.0,
                        1342.0,
                        570.0,
                        1695.0,
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
                        "obj-32",
                        0
                    ],
                    "midpoints": [
                        3665.0,
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
                        3577.0,
                        112.0,
                        3577.0,
                        150.0,
                        3577.0,
                        142.0,
                        3487.0,
                        142.0,
                        3487.0,
                        180.0,
                        3487.0,
                        142.0,
                        848.0,
                        142.0,
                        848.0,
                        458.0,
                        848.0,
                        457.0,
                        298.0,
                        457.0,
                        298.0,
                        495.0,
                        298.0,
                        457.0,
                        418.0,
                        457.0,
                        418.0,
                        495.0,
                        160.0,
                        495.0
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
                        247.0,
                        491.0,
                        286.5,
                        491.0
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
                    ],
                    "midpoints": [
                        367.0,
                        491.0,
                        406.5,
                        491.0
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
                        "obj-41",
                        0
                    ],
                    "midpoints": [
                        367.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        572.0,
                        532.0,
                        572.0,
                        570.0,
                        572.0,
                        532.0,
                        577.0,
                        532.0,
                        577.0,
                        570.0,
                        577.0,
                        532.0,
                        697.0,
                        532.0,
                        697.0,
                        570.0,
                        897.0,
                        570.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-38",
                        1
                    ],
                    "destination": [
                        "obj-42",
                        0
                    ],
                    "midpoints": [
                        266.75,
                        487.0,
                        352.0,
                        487.0,
                        352.0,
                        525.0,
                        352.0,
                        532.0,
                        317.0,
                        532.0,
                        317.0,
                        570.0,
                        387.0,
                        570.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-39",
                        1
                    ],
                    "destination": [
                        "obj-43",
                        0
                    ],
                    "midpoints": [
                        386.75,
                        532.0,
                        832.0,
                        532.0,
                        832.0,
                        570.0,
                        832.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        572.0,
                        532.0,
                        572.0,
                        570.0,
                        572.0,
                        532.0,
                        707.0,
                        532.0,
                        707.0,
                        570.0,
                        707.0,
                        532.0,
                        697.0,
                        532.0,
                        697.0,
                        570.0,
                        1032.0,
                        570.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-38",
                        2
                    ],
                    "destination": [
                        "obj-44",
                        0
                    ],
                    "midpoints": [
                        286.5,
                        487.0,
                        352.0,
                        487.0,
                        352.0,
                        525.0,
                        352.0,
                        532.0,
                        317.0,
                        532.0,
                        317.0,
                        570.0,
                        317.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        507.0,
                        570.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-39",
                        2
                    ],
                    "destination": [
                        "obj-45",
                        0
                    ],
                    "midpoints": [
                        406.5,
                        532.0,
                        832.0,
                        532.0,
                        832.0,
                        570.0,
                        832.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        967.0,
                        532.0,
                        967.0,
                        570.0,
                        967.0,
                        532.0,
                        572.0,
                        532.0,
                        572.0,
                        570.0,
                        572.0,
                        532.0,
                        707.0,
                        532.0,
                        707.0,
                        570.0,
                        707.0,
                        532.0,
                        827.0,
                        532.0,
                        827.0,
                        570.0,
                        1152.0,
                        570.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-38",
                        3
                    ],
                    "destination": [
                        "obj-46",
                        0
                    ],
                    "midpoints": [
                        306.25,
                        487.0,
                        461.0,
                        487.0,
                        461.0,
                        525.0,
                        461.0,
                        532.0,
                        317.0,
                        532.0,
                        317.0,
                        570.0,
                        317.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        442.0,
                        532.0,
                        442.0,
                        570.0,
                        642.0,
                        570.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-39",
                        3
                    ],
                    "destination": [
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        426.25,
                        532.0,
                        832.0,
                        532.0,
                        832.0,
                        570.0,
                        832.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        967.0,
                        532.0,
                        967.0,
                        570.0,
                        967.0,
                        532.0,
                        572.0,
                        532.0,
                        572.0,
                        570.0,
                        572.0,
                        532.0,
                        1087.0,
                        532.0,
                        1087.0,
                        570.0,
                        1087.0,
                        532.0,
                        707.0,
                        532.0,
                        707.0,
                        570.0,
                        707.0,
                        532.0,
                        827.0,
                        532.0,
                        827.0,
                        570.0,
                        1287.0,
                        570.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-38",
                        4
                    ],
                    "destination": [
                        "obj-48",
                        0
                    ],
                    "midpoints": [
                        326.0,
                        487.0,
                        461.0,
                        487.0,
                        461.0,
                        525.0,
                        461.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        572.0,
                        532.0,
                        572.0,
                        570.0,
                        572.0,
                        532.0,
                        577.0,
                        532.0,
                        577.0,
                        570.0,
                        762.0,
                        570.0
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
                        "obj-49",
                        0
                    ],
                    "midpoints": [
                        446.0,
                        532.0,
                        962.0,
                        532.0,
                        962.0,
                        570.0,
                        962.0,
                        532.0,
                        452.0,
                        532.0,
                        452.0,
                        570.0,
                        452.0,
                        532.0,
                        967.0,
                        532.0,
                        967.0,
                        570.0,
                        967.0,
                        532.0,
                        572.0,
                        532.0,
                        572.0,
                        570.0,
                        572.0,
                        532.0,
                        1087.0,
                        532.0,
                        1087.0,
                        570.0,
                        1087.0,
                        532.0,
                        707.0,
                        532.0,
                        707.0,
                        570.0,
                        707.0,
                        532.0,
                        1222.0,
                        532.0,
                        1222.0,
                        570.0,
                        1222.0,
                        532.0,
                        827.0,
                        532.0,
                        827.0,
                        570.0,
                        1407.0,
                        570.0
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
                        "obj-52",
                        0
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
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        862.0,
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
                        3531.0,
                        150.0
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
                        "obj-30",
                        0
                    ],
                    "midpoints": [
                        881.75,
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
                        3592.0,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-52",
                        2
                    ],
                    "destination": [
                        "obj-34",
                        0
                    ],
                    "midpoints": [
                        901.5,
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
                        3577.0,
                        112.0,
                        3577.0,
                        150.0,
                        3652.0,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-52",
                        3
                    ],
                    "destination": [
                        "obj-50",
                        0
                    ],
                    "midpoints": [
                        921.25,
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
                        3577.0,
                        112.0,
                        3577.0,
                        150.0,
                        3577.0,
                        112.0,
                        3637.0,
                        112.0,
                        3637.0,
                        150.0,
                        3697.0,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-52",
                        4
                    ],
                    "destination": [
                        "obj-51",
                        0
                    ],
                    "midpoints": [
                        941.0,
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
                        2558.0,
                        112.0,
                        2558.0,
                        150.0,
                        2558.0,
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
                        3577.0,
                        112.0,
                        3577.0,
                        150.0,
                        3577.0,
                        112.0,
                        3637.0,
                        112.0,
                        3637.0,
                        150.0,
                        3637.0,
                        112.0,
                        3682.0,
                        112.0,
                        3682.0,
                        150.0,
                        3757.0,
                        150.0
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
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        3712.0,
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
                        3577.0,
                        112.0,
                        3577.0,
                        150.0,
                        3577.0,
                        112.0,
                        3637.0,
                        112.0,
                        3637.0,
                        150.0,
                        3637.0,
                        142.0,
                        3487.0,
                        142.0,
                        3487.0,
                        180.0,
                        3487.0,
                        142.0,
                        848.0,
                        142.0,
                        848.0,
                        458.0,
                        848.0,
                        457.0,
                        418.0,
                        457.0,
                        418.0,
                        495.0,
                        265.0,
                        495.0
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
                        "obj-37",
                        0
                    ],
                    "midpoints": [
                        3779.0,
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
                        3577.0,
                        112.0,
                        3577.0,
                        150.0,
                        3577.0,
                        112.0,
                        3637.0,
                        112.0,
                        3637.0,
                        150.0,
                        3637.0,
                        112.0,
                        3682.0,
                        112.0,
                        3682.0,
                        150.0,
                        3682.0,
                        142.0,
                        3487.0,
                        142.0,
                        3487.0,
                        180.0,
                        3487.0,
                        142.0,
                        848.0,
                        142.0,
                        848.0,
                        458.0,
                        385.0,
                        458.0
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
                        "obj-55",
                        0
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
                        "obj-61",
                        1
                    ],
                    "midpoints": [
                        476.0,
                        22.0,
                        406.0,
                        22.0,
                        406.0,
                        60.0,
                        406.0,
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
                        364.2,
                        150.0
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
                        "obj-61",
                        2
                    ],
                    "midpoints": [
                        776.0,
                        22.0,
                        555.0,
                        22.0,
                        555.0,
                        60.0,
                        555.0,
                        22.0,
                        562.0,
                        22.0,
                        562.0,
                        60.0,
                        562.0,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        481.4,
                        150.0
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
                        "obj-61",
                        3
                    ],
                    "midpoints": [
                        634.0,
                        112.0,
                        472.0,
                        112.0,
                        472.0,
                        150.0,
                        598.6,
                        150.0
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
                        "obj-61",
                        4
                    ],
                    "midpoints": [
                        334.0,
                        22.0,
                        555.0,
                        22.0,
                        555.0,
                        60.0,
                        555.0,
                        22.0,
                        697.0,
                        22.0,
                        697.0,
                        60.0,
                        697.0,
                        22.0,
                        562.0,
                        22.0,
                        562.0,
                        60.0,
                        562.0,
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
                        715.8,
                        150.0
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
                        "obj-61",
                        0
                    ],
                    "midpoints": [
                        187.5,
                        67.0,
                        157.0,
                        67.0,
                        157.0,
                        105.0,
                        157.0,
                        112.0,
                        247.0,
                        112.0,
                        247.0,
                        150.0,
                        247.0,
                        112.0,
                        187.0,
                        112.0,
                        187.0,
                        150.0,
                        247.0,
                        150.0
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
                        "obj-61",
                        0
                    ],
                    "midpoints": [
                        220.5,
                        112.0,
                        247.0,
                        112.0,
                        247.0,
                        150.0,
                        247.0,
                        150.0
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
                        "obj-67",
                        0
                    ],
                    "midpoints": [
                        4342.0,
                        63.5,
                        4372.0,
                        63.5
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
                        "obj-67",
                        1
                    ],
                    "midpoints": [
                        4432.0,
                        22.0,
                        4429.0,
                        22.0,
                        4429.0,
                        60.0,
                        4429.0,
                        67.0,
                        4432.0,
                        67.0,
                        4432.0,
                        105.0,
                        4405.5,
                        105.0
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
                        "obj-71",
                        0
                    ],
                    "midpoints": [
                        4414.0,
                        22.0,
                        4417.0,
                        22.0,
                        4417.0,
                        60.0,
                        4417.0,
                        67.0,
                        4420.5,
                        67.0,
                        4420.5,
                        105.0,
                        4447.0,
                        105.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-57",
                        1
                    ],
                    "destination": [
                        "obj-71",
                        1
                    ],
                    "midpoints": [
                        4504.0,
                        63.5,
                        4480.5,
                        63.5
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
                        4388.75,
                        67.0,
                        4432.0,
                        67.0,
                        4432.0,
                        105.0,
                        4447.0,
                        105.0
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
                        "obj-68",
                        1
                    ],
                    "midpoints": [
                        4537.0,
                        22.0,
                        4519.0,
                        22.0,
                        4519.0,
                        60.0,
                        4519.0,
                        67.0,
                        4495.5,
                        67.0,
                        4495.5,
                        105.0,
                        4495.5,
                        112.0,
                        4507.0,
                        112.0,
                        4507.0,
                        150.0,
                        4480.5,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-71",
                        0
                    ],
                    "destination": [
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        4463.75,
                        112.0,
                        4495.5,
                        112.0,
                        4495.5,
                        150.0,
                        4522.0,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-58",
                        1
                    ],
                    "destination": [
                        "obj-72",
                        1
                    ],
                    "midpoints": [
                        4609.0,
                        86.0,
                        4555.5,
                        86.0
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
                        4463.75,
                        112.0,
                        4507.0,
                        112.0,
                        4507.0,
                        150.0,
                        4537.0,
                        150.0
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
                        "obj-69",
                        1
                    ],
                    "midpoints": [
                        4642.0,
                        22.0,
                        4624.0,
                        22.0,
                        4624.0,
                        60.0,
                        4624.0,
                        112.0,
                        4570.5,
                        112.0,
                        4570.5,
                        150.0,
                        4570.5,
                        142.0,
                        4597.0,
                        142.0,
                        4597.0,
                        180.0,
                        4570.5,
                        180.0
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
                    ],
                    "midpoints": [
                        4538.75,
                        142.0,
                        4585.5,
                        142.0,
                        4585.5,
                        180.0,
                        4612.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-59",
                        1
                    ],
                    "destination": [
                        "obj-73",
                        1
                    ],
                    "midpoints": [
                        4714.0,
                        101.0,
                        4645.5,
                        101.0
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
                        4553.75,
                        142.0,
                        4597.0,
                        142.0,
                        4597.0,
                        180.0,
                        4627.0,
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
                        "obj-70",
                        1
                    ],
                    "midpoints": [
                        4747.0,
                        22.0,
                        4729.0,
                        22.0,
                        4729.0,
                        60.0,
                        4729.0,
                        142.0,
                        4660.5,
                        142.0,
                        4660.5,
                        180.0,
                        4660.5,
                        187.0,
                        4687.0,
                        187.0,
                        4687.0,
                        225.0,
                        4660.5,
                        225.0
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
                        "obj-74",
                        0
                    ],
                    "midpoints": [
                        4628.75,
                        187.0,
                        4675.5,
                        187.0,
                        4675.5,
                        225.0,
                        4702.0,
                        225.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-60",
                        1
                    ],
                    "destination": [
                        "obj-74",
                        1
                    ],
                    "midpoints": [
                        4819.0,
                        123.5,
                        4735.5,
                        123.5
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
                        "obj-78",
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
                        "obj-79",
                        0
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
                        "obj-76",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-79",
                        0
                    ],
                    "destination": [
                        "obj-76",
                        1
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
                        "obj-77",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-76",
                        1
                    ],
                    "destination": [
                        "obj-77",
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