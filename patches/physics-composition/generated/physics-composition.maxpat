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
            6229.0,
            662.0
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
                        240.0,
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
                        6075.0,
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
                        105.0,
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
                    "maxclass": "newobj",
                    "id": "obj-4",
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
                    "text": "receive init-bang",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        6075.0,
                        75.0,
                        114.0,
                        22.0
                    ],
                    "text": "send init-bang",
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
                        120.0,
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
                    "id": "obj-7",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        240.0,
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
                    "id": "obj-8",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        345.0,
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
                    "id": "obj-9",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1020.0,
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
                    "id": "obj-10",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1485.0,
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
                    "id": "obj-11",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1965.0,
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
                    "id": "obj-12",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2430.0,
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
                    "id": "obj-13",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2910.0,
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
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        180.0,
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
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3360.0,
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
                    "id": "obj-16",
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
                        3360.0,
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
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3285.0,
                        195.0,
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
                    "id": "obj-18",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3450.0,
                        195.0,
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
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3630.0,
                        195.0,
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
                    "id": "obj-20",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3810.0,
                        195.0,
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
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3990.0,
                        195.0,
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
                    "id": "obj-22",
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
                    "id": "obj-23",
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
                    "id": "obj-24",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        60.0,
                        45.0,
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
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5655.0,
                        0.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-26",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5655.0,
                        30.0,
                        114.0,
                        22.0
                    ],
                    "text": "send init-bang",
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
                        5790.0,
                        30.0,
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
                    "id": "obj-28",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5745.0,
                        75.0,
                        121.0,
                        22.0
                    ],
                    "text": "send roll-clear",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-29",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5685.0,
                        0.0,
                        247.0,
                        20.0
                    ],
                    "text": "Reset (re-add balls + clear roll)",
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
                    "id": "obj-30",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5910.0,
                        0.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-31",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5910.0,
                        30.0,
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
                    "id": "obj-32",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5910.0,
                        75.0,
                        121.0,
                        22.0
                    ],
                    "text": "send roll-clear",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-33",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        5940.0,
                        0.0,
                        114.0,
                        20.0
                    ],
                    "text": "Clear notation",
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
                    "id": "obj-34",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        165.0,
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
                    "id": "obj-35",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        195.0,
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
                    "id": "obj-36",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3450.0,
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
                    "id": "obj-37",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        90.0,
                        165.0,
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
                    "id": "obj-38",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        165.0,
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
                    "id": "obj-39",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        195.0,
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
                    "id": "obj-40",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3510.0,
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
                    "id": "obj-41",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        195.0,
                        165.0,
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
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        240.0,
                        165.0,
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
                    "id": "obj-43",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        360.0,
                        165.0,
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
                    "id": "obj-44",
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
                        195.0,
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
                    "id": "obj-45",
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
                        195.0,
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
                    "id": "obj-46",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        195.0,
                        240.0,
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
                    "id": "obj-47",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        840.0,
                        240.0,
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
                    "id": "obj-48",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        330.0,
                        240.0,
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
                    "id": "obj-49",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        975.0,
                        240.0,
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
                    "id": "obj-50",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        450.0,
                        240.0,
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
                    "id": "obj-51",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1095.0,
                        240.0,
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
                    "id": "obj-52",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        585.0,
                        240.0,
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
                    "id": "obj-53",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1230.0,
                        240.0,
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
                    "id": "obj-54",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        705.0,
                        240.0,
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
                    "id": "obj-55",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1350.0,
                        240.0,
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
                    "id": "obj-56",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3555.0,
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
                    "id": "obj-57",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        3615.0,
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
                    "id": "obj-58",
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
                        255.0,
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
                    "id": "obj-59",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        300.0,
                        165.0,
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
                    "id": "obj-60",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        420.0,
                        165.0,
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
                    "id": "obj-61",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1635.0,
                        600.0,
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
                    "id": "obj-62",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4200.0,
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
                    "id": "obj-63",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4290.0,
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
                    "id": "obj-64",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4395.0,
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
                    "id": "obj-65",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4500.0,
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
                    "id": "obj-66",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4605.0,
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
                    "id": "obj-67",
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
                        4980.0,
                        75.0,
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
                    "id": "obj-68",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5190.0,
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
                    "id": "obj-69",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5025.0,
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
                    "id": "obj-70",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5490.0,
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
                    "id": "obj-71",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        5340.0,
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
                    "id": "obj-72",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4725.0,
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
                    "id": "obj-73",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        4875.0,
                        30.0,
                        142.0,
                        22.0
                    ],
                    "text": "receive roll-clear",
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
                        4230.0,
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
                    "id": "obj-75",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4305.0,
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
                    "id": "obj-76",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4395.0,
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
                    "id": "obj-77",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4485.0,
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
                    "id": "obj-78",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4305.0,
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
                    "id": "obj-79",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4380.0,
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
                    "id": "obj-80",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4470.0,
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
                    "id": "obj-81",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        4560.0,
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
                    "id": "obj-83",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        4515.0,
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
                    "id": "obj-84",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        4500.0,
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
                    "id": "obj-85",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        4500.0,
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
                    "id": "obj-86",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        4575.0,
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
                        "obj-4",
                        0
                    ],
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        97.5,
                        22.0,
                        172.0,
                        22.0,
                        172.0,
                        60.0,
                        172.0,
                        37.0,
                        161.0,
                        37.0,
                        161.0,
                        73.0,
                        161.0,
                        67.0,
                        96.0,
                        67.0,
                        96.0,
                        105.0,
                        172.5,
                        105.0
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        6111.0,
                        63.5,
                        6132.0,
                        63.5
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
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        233.0,
                        112.0,
                        232.0,
                        112.0,
                        232.0,
                        150.0,
                        127.0,
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
                        170.0,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1012.0,
                        112.0,
                        1012.0,
                        150.0,
                        1012.0,
                        112.0,
                        1477.0,
                        112.0,
                        1477.0,
                        150.0,
                        1477.0,
                        157.0,
                        247.0,
                        157.0,
                        247.0,
                        193.0,
                        247.0,
                        157.0,
                        193.0,
                        157.0,
                        193.0,
                        195.0,
                        193.0,
                        157.0,
                        282.0,
                        157.0,
                        282.0,
                        193.0,
                        282.0,
                        157.0,
                        298.0,
                        157.0,
                        298.0,
                        195.0,
                        298.0,
                        157.0,
                        418.0,
                        157.0,
                        418.0,
                        195.0,
                        418.0,
                        157.0,
                        366.0,
                        157.0,
                        366.0,
                        193.0,
                        366.0,
                        157.0,
                        486.0,
                        157.0,
                        486.0,
                        193.0,
                        486.0,
                        187.0,
                        236.0,
                        187.0,
                        236.0,
                        225.0,
                        236.0,
                        187.0,
                        341.0,
                        187.0,
                        341.0,
                        225.0,
                        341.0,
                        187.0,
                        461.0,
                        187.0,
                        461.0,
                        225.0,
                        461.0,
                        232.0,
                        317.0,
                        232.0,
                        317.0,
                        270.0,
                        317.0,
                        232.0,
                        962.0,
                        232.0,
                        962.0,
                        270.0,
                        962.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        452.0,
                        232.0,
                        967.0,
                        232.0,
                        967.0,
                        270.0,
                        967.0,
                        232.0,
                        572.0,
                        232.0,
                        572.0,
                        270.0,
                        572.0,
                        232.0,
                        1087.0,
                        232.0,
                        1087.0,
                        270.0,
                        1087.0,
                        232.0,
                        707.0,
                        232.0,
                        707.0,
                        270.0,
                        707.0,
                        232.0,
                        1222.0,
                        232.0,
                        1222.0,
                        270.0,
                        1222.0,
                        232.0,
                        827.0,
                        232.0,
                        827.0,
                        270.0,
                        827.0,
                        232.0,
                        1342.0,
                        232.0,
                        1342.0,
                        270.0,
                        1695.0,
                        270.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        215.71428571428572,
                        67.0,
                        247.0,
                        67.0,
                        247.0,
                        105.0,
                        247.0,
                        112.0,
                        228.0,
                        112.0,
                        228.0,
                        150.0,
                        247.0,
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
                        286.5,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1012.0,
                        112.0,
                        1012.0,
                        150.0,
                        1012.0,
                        112.0,
                        1477.0,
                        112.0,
                        1477.0,
                        150.0,
                        1477.0,
                        157.0,
                        298.0,
                        157.0,
                        298.0,
                        195.0,
                        298.0,
                        157.0,
                        418.0,
                        157.0,
                        418.0,
                        195.0,
                        418.0,
                        157.0,
                        366.0,
                        157.0,
                        366.0,
                        193.0,
                        366.0,
                        157.0,
                        486.0,
                        157.0,
                        486.0,
                        193.0,
                        486.0,
                        187.0,
                        341.0,
                        187.0,
                        341.0,
                        225.0,
                        341.0,
                        187.0,
                        461.0,
                        187.0,
                        461.0,
                        225.0,
                        461.0,
                        232.0,
                        317.0,
                        232.0,
                        317.0,
                        270.0,
                        317.0,
                        232.0,
                        962.0,
                        232.0,
                        962.0,
                        270.0,
                        962.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        452.0,
                        232.0,
                        967.0,
                        232.0,
                        967.0,
                        270.0,
                        967.0,
                        232.0,
                        572.0,
                        232.0,
                        572.0,
                        270.0,
                        572.0,
                        232.0,
                        1087.0,
                        232.0,
                        1087.0,
                        270.0,
                        1087.0,
                        232.0,
                        707.0,
                        232.0,
                        707.0,
                        270.0,
                        707.0,
                        232.0,
                        1222.0,
                        232.0,
                        1222.0,
                        270.0,
                        1222.0,
                        232.0,
                        827.0,
                        232.0,
                        827.0,
                        270.0,
                        827.0,
                        232.0,
                        1342.0,
                        232.0,
                        1342.0,
                        270.0,
                        1695.0,
                        270.0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        198.42857142857142,
                        67.0,
                        247.0,
                        67.0,
                        247.0,
                        105.0,
                        247.0,
                        112.0,
                        228.0,
                        112.0,
                        228.0,
                        150.0,
                        228.0,
                        112.0,
                        232.0,
                        112.0,
                        232.0,
                        150.0,
                        352.0,
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
                        678.5,
                        112.0,
                        1012.0,
                        112.0,
                        1012.0,
                        150.0,
                        1012.0,
                        112.0,
                        1477.0,
                        112.0,
                        1477.0,
                        150.0,
                        1477.0,
                        232.0,
                        962.0,
                        232.0,
                        962.0,
                        270.0,
                        962.0,
                        232.0,
                        1097.0,
                        232.0,
                        1097.0,
                        270.0,
                        1097.0,
                        232.0,
                        1217.0,
                        232.0,
                        1217.0,
                        270.0,
                        1217.0,
                        232.0,
                        707.0,
                        232.0,
                        707.0,
                        270.0,
                        707.0,
                        232.0,
                        1222.0,
                        232.0,
                        1222.0,
                        270.0,
                        1222.0,
                        232.0,
                        827.0,
                        232.0,
                        827.0,
                        270.0,
                        827.0,
                        232.0,
                        1342.0,
                        232.0,
                        1342.0,
                        270.0,
                        1695.0,
                        270.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        181.14285714285714,
                        67.0,
                        356.0,
                        67.0,
                        356.0,
                        105.0,
                        356.0,
                        112.0,
                        228.0,
                        112.0,
                        228.0,
                        150.0,
                        228.0,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        337.0,
                        112.0,
                        337.0,
                        150.0,
                        1027.0,
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
                        1245.0,
                        112.0,
                        1477.0,
                        112.0,
                        1477.0,
                        150.0,
                        1477.0,
                        232.0,
                        1352.0,
                        232.0,
                        1352.0,
                        270.0,
                        1352.0,
                        232.0,
                        1472.0,
                        232.0,
                        1472.0,
                        270.0,
                        1695.0,
                        270.0
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
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        163.85714285714286,
                        67.0,
                        356.0,
                        67.0,
                        356.0,
                        105.0,
                        356.0,
                        112.0,
                        228.0,
                        112.0,
                        228.0,
                        150.0,
                        228.0,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1012.0,
                        112.0,
                        1012.0,
                        150.0,
                        1492.0,
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
                        1717.0,
                        191.0,
                        1695.0,
                        191.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        146.57142857142856,
                        67.0,
                        356.0,
                        67.0,
                        356.0,
                        105.0,
                        356.0,
                        112.0,
                        228.0,
                        112.0,
                        228.0,
                        150.0,
                        228.0,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1012.0,
                        112.0,
                        1012.0,
                        150.0,
                        1012.0,
                        112.0,
                        1477.0,
                        112.0,
                        1477.0,
                        150.0,
                        1972.0,
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
                        2190.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        129.28571428571428,
                        67.0,
                        356.0,
                        67.0,
                        356.0,
                        105.0,
                        356.0,
                        112.0,
                        228.0,
                        112.0,
                        228.0,
                        150.0,
                        228.0,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1478.0,
                        112.0,
                        1478.0,
                        150.0,
                        1478.0,
                        112.0,
                        1477.0,
                        112.0,
                        1477.0,
                        150.0,
                        1477.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        2437.0,
                        150.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        2658.5,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
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
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        112.0,
                        67.0,
                        356.0,
                        67.0,
                        356.0,
                        105.0,
                        356.0,
                        112.0,
                        228.0,
                        112.0,
                        228.0,
                        150.0,
                        228.0,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1478.0,
                        112.0,
                        1478.0,
                        150.0,
                        1478.0,
                        112.0,
                        1477.0,
                        112.0,
                        1477.0,
                        150.0,
                        1477.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        2422.0,
                        112.0,
                        2422.0,
                        150.0,
                        2917.0,
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        3131.5,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        2423.0,
                        112.0,
                        2423.0,
                        150.0,
                        2423.0,
                        112.0,
                        2422.0,
                        112.0,
                        2422.0,
                        150.0,
                        1695.0,
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
                        "obj-16",
                        1
                    ],
                    "destination": [
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        3386.75,
                        187.0,
                        3456.0,
                        187.0,
                        3456.0,
                        225.0,
                        3531.5,
                        225.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-16",
                        2
                    ],
                    "destination": [
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        3406.5,
                        187.0,
                        3456.0,
                        187.0,
                        3456.0,
                        225.0,
                        3456.0,
                        187.0,
                        3621.0,
                        187.0,
                        3621.0,
                        225.0,
                        3711.5,
                        225.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-16",
                        3
                    ],
                    "destination": [
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        3426.25,
                        187.0,
                        3456.0,
                        187.0,
                        3456.0,
                        225.0,
                        3456.0,
                        187.0,
                        3621.0,
                        187.0,
                        3621.0,
                        225.0,
                        3621.0,
                        187.0,
                        3622.0,
                        187.0,
                        3622.0,
                        225.0,
                        3891.5,
                        225.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-16",
                        4
                    ],
                    "destination": [
                        "obj-21",
                        0
                    ],
                    "midpoints": [
                        3446.0,
                        187.0,
                        3456.0,
                        187.0,
                        3456.0,
                        225.0,
                        3456.0,
                        187.0,
                        3621.0,
                        187.0,
                        3621.0,
                        225.0,
                        3621.0,
                        187.0,
                        3801.0,
                        187.0,
                        3801.0,
                        225.0,
                        3801.0,
                        187.0,
                        3802.0,
                        187.0,
                        3802.0,
                        225.0,
                        4071.5,
                        225.0
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
                        0
                    ],
                    "destination": [
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        59.0,
                        67.0,
                        248.0,
                        67.0,
                        248.0,
                        105.0,
                        248.0,
                        67.0,
                        356.0,
                        67.0,
                        356.0,
                        105.0,
                        356.0,
                        112.0,
                        228.0,
                        112.0,
                        228.0,
                        150.0,
                        228.0,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1012.0,
                        112.0,
                        1012.0,
                        150.0,
                        1012.0,
                        112.0,
                        1477.0,
                        112.0,
                        1477.0,
                        150.0,
                        1477.0,
                        157.0,
                        88.0,
                        157.0,
                        88.0,
                        195.0,
                        88.0,
                        157.0,
                        247.0,
                        157.0,
                        247.0,
                        193.0,
                        247.0,
                        157.0,
                        193.0,
                        157.0,
                        193.0,
                        195.0,
                        193.0,
                        157.0,
                        282.0,
                        157.0,
                        282.0,
                        193.0,
                        282.0,
                        157.0,
                        298.0,
                        157.0,
                        298.0,
                        195.0,
                        298.0,
                        157.0,
                        418.0,
                        157.0,
                        418.0,
                        195.0,
                        418.0,
                        157.0,
                        366.0,
                        157.0,
                        366.0,
                        193.0,
                        366.0,
                        157.0,
                        486.0,
                        157.0,
                        486.0,
                        193.0,
                        486.0,
                        187.0,
                        131.0,
                        187.0,
                        131.0,
                        225.0,
                        131.0,
                        187.0,
                        236.0,
                        187.0,
                        236.0,
                        225.0,
                        236.0,
                        187.0,
                        341.0,
                        187.0,
                        341.0,
                        225.0,
                        341.0,
                        187.0,
                        461.0,
                        187.0,
                        461.0,
                        225.0,
                        461.0,
                        232.0,
                        317.0,
                        232.0,
                        317.0,
                        270.0,
                        317.0,
                        232.0,
                        832.0,
                        232.0,
                        832.0,
                        270.0,
                        832.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        452.0,
                        232.0,
                        967.0,
                        232.0,
                        967.0,
                        270.0,
                        967.0,
                        232.0,
                        572.0,
                        232.0,
                        572.0,
                        270.0,
                        572.0,
                        232.0,
                        1087.0,
                        232.0,
                        1087.0,
                        270.0,
                        1087.0,
                        232.0,
                        707.0,
                        232.0,
                        707.0,
                        270.0,
                        707.0,
                        232.0,
                        1222.0,
                        232.0,
                        1222.0,
                        270.0,
                        1222.0,
                        232.0,
                        827.0,
                        232.0,
                        827.0,
                        270.0,
                        827.0,
                        232.0,
                        1342.0,
                        232.0,
                        1342.0,
                        270.0,
                        1695.0,
                        270.0
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
                        0
                    ],
                    "midpoints": [
                        5667.0,
                        -8.0,
                        5677.0,
                        -8.0,
                        5677.0,
                        28.0,
                        5712.0,
                        28.0
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
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        5667.0,
                        -8.0,
                        5677.0,
                        -8.0,
                        5677.0,
                        28.0,
                        5677.0,
                        22.0,
                        5777.0,
                        22.0,
                        5777.0,
                        60.0,
                        5797.0,
                        60.0
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
                        "obj-30",
                        0
                    ],
                    "destination": [
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        5922.0,
                        -8.0,
                        5940.0,
                        -8.0,
                        5940.0,
                        28.0,
                        5917.0,
                        28.0
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
                        5935.5,
                        63.5,
                        5970.5,
                        63.5
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        76.5,
                        187.0,
                        236.0,
                        187.0,
                        236.0,
                        225.0,
                        236.0,
                        187.0,
                        341.0,
                        187.0,
                        341.0,
                        225.0,
                        341.0,
                        187.0,
                        461.0,
                        187.0,
                        461.0,
                        225.0,
                        461.0,
                        232.0,
                        317.0,
                        232.0,
                        317.0,
                        270.0,
                        317.0,
                        232.0,
                        832.0,
                        232.0,
                        832.0,
                        270.0,
                        832.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        452.0,
                        232.0,
                        967.0,
                        232.0,
                        967.0,
                        270.0,
                        967.0,
                        232.0,
                        572.0,
                        232.0,
                        572.0,
                        270.0,
                        572.0,
                        232.0,
                        1087.0,
                        232.0,
                        1087.0,
                        270.0,
                        1087.0,
                        232.0,
                        707.0,
                        232.0,
                        707.0,
                        270.0,
                        707.0,
                        232.0,
                        1222.0,
                        232.0,
                        1222.0,
                        270.0,
                        1222.0,
                        232.0,
                        827.0,
                        232.0,
                        827.0,
                        270.0,
                        827.0,
                        232.0,
                        1342.0,
                        232.0,
                        1342.0,
                        270.0,
                        1695.0,
                        270.0
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
                        3470.0,
                        112.0,
                        228.0,
                        112.0,
                        228.0,
                        150.0,
                        228.0,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1478.0,
                        112.0,
                        1478.0,
                        150.0,
                        1478.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        2422.0,
                        112.0,
                        2422.0,
                        150.0,
                        2422.0,
                        112.0,
                        2902.0,
                        112.0,
                        2902.0,
                        150.0,
                        2902.0,
                        112.0,
                        3352.0,
                        112.0,
                        3352.0,
                        150.0,
                        3352.0,
                        142.0,
                        3352.0,
                        142.0,
                        3352.0,
                        180.0,
                        3352.0,
                        157.0,
                        247.0,
                        157.0,
                        247.0,
                        193.0,
                        247.0,
                        157.0,
                        193.0,
                        157.0,
                        193.0,
                        195.0,
                        193.0,
                        157.0,
                        282.0,
                        157.0,
                        282.0,
                        193.0,
                        282.0,
                        157.0,
                        298.0,
                        157.0,
                        298.0,
                        195.0,
                        298.0,
                        157.0,
                        418.0,
                        157.0,
                        418.0,
                        195.0,
                        418.0,
                        157.0,
                        366.0,
                        157.0,
                        366.0,
                        193.0,
                        366.0,
                        157.0,
                        486.0,
                        157.0,
                        486.0,
                        193.0,
                        55.0,
                        193.0
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
                        "obj-39",
                        0
                    ],
                    "midpoints": [
                        142.0,
                        157.0,
                        82.0,
                        157.0,
                        82.0,
                        193.0,
                        142.0,
                        193.0
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
                    ],
                    "midpoints": [
                        181.5,
                        187.0,
                        341.0,
                        187.0,
                        341.0,
                        225.0,
                        341.0,
                        187.0,
                        461.0,
                        187.0,
                        461.0,
                        225.0,
                        461.0,
                        232.0,
                        317.0,
                        232.0,
                        317.0,
                        270.0,
                        317.0,
                        232.0,
                        962.0,
                        232.0,
                        962.0,
                        270.0,
                        962.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        452.0,
                        232.0,
                        967.0,
                        232.0,
                        967.0,
                        270.0,
                        967.0,
                        232.0,
                        572.0,
                        232.0,
                        572.0,
                        270.0,
                        572.0,
                        232.0,
                        1087.0,
                        232.0,
                        1087.0,
                        270.0,
                        1087.0,
                        232.0,
                        707.0,
                        232.0,
                        707.0,
                        270.0,
                        707.0,
                        232.0,
                        1222.0,
                        232.0,
                        1222.0,
                        270.0,
                        1222.0,
                        232.0,
                        827.0,
                        232.0,
                        827.0,
                        270.0,
                        827.0,
                        232.0,
                        1342.0,
                        232.0,
                        1342.0,
                        270.0,
                        1695.0,
                        270.0
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        3530.0,
                        112.0,
                        228.0,
                        112.0,
                        228.0,
                        150.0,
                        228.0,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1478.0,
                        112.0,
                        1478.0,
                        150.0,
                        1478.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        2422.0,
                        112.0,
                        2422.0,
                        150.0,
                        2422.0,
                        112.0,
                        2902.0,
                        112.0,
                        2902.0,
                        150.0,
                        2902.0,
                        112.0,
                        3352.0,
                        112.0,
                        3352.0,
                        150.0,
                        3352.0,
                        112.0,
                        3442.0,
                        112.0,
                        3442.0,
                        150.0,
                        3442.0,
                        142.0,
                        3352.0,
                        142.0,
                        3352.0,
                        180.0,
                        3352.0,
                        157.0,
                        247.0,
                        157.0,
                        247.0,
                        193.0,
                        247.0,
                        157.0,
                        282.0,
                        157.0,
                        282.0,
                        193.0,
                        282.0,
                        157.0,
                        298.0,
                        157.0,
                        298.0,
                        195.0,
                        298.0,
                        157.0,
                        418.0,
                        157.0,
                        418.0,
                        195.0,
                        418.0,
                        157.0,
                        366.0,
                        157.0,
                        366.0,
                        193.0,
                        366.0,
                        157.0,
                        486.0,
                        157.0,
                        486.0,
                        193.0,
                        160.0,
                        193.0
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
                        "obj-44",
                        0
                    ],
                    "midpoints": [
                        247.0,
                        157.0,
                        247.0,
                        157.0,
                        247.0,
                        193.0,
                        247.0,
                        157.0,
                        282.0,
                        157.0,
                        282.0,
                        193.0,
                        286.5,
                        193.0
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
                        "obj-45",
                        0
                    ],
                    "midpoints": [
                        367.0,
                        157.0,
                        366.0,
                        157.0,
                        366.0,
                        193.0,
                        406.5,
                        193.0
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
                        "obj-46",
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
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        367.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        452.0,
                        232.0,
                        572.0,
                        232.0,
                        572.0,
                        270.0,
                        572.0,
                        232.0,
                        577.0,
                        232.0,
                        577.0,
                        270.0,
                        577.0,
                        232.0,
                        697.0,
                        232.0,
                        697.0,
                        270.0,
                        897.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-44",
                        1
                    ],
                    "destination": [
                        "obj-48",
                        0
                    ],
                    "midpoints": [
                        266.75,
                        187.0,
                        352.0,
                        187.0,
                        352.0,
                        225.0,
                        352.0,
                        232.0,
                        317.0,
                        232.0,
                        317.0,
                        270.0,
                        387.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        1
                    ],
                    "destination": [
                        "obj-49",
                        0
                    ],
                    "midpoints": [
                        386.75,
                        232.0,
                        832.0,
                        232.0,
                        832.0,
                        270.0,
                        832.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        452.0,
                        232.0,
                        572.0,
                        232.0,
                        572.0,
                        270.0,
                        572.0,
                        232.0,
                        707.0,
                        232.0,
                        707.0,
                        270.0,
                        707.0,
                        232.0,
                        697.0,
                        232.0,
                        697.0,
                        270.0,
                        1032.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-44",
                        2
                    ],
                    "destination": [
                        "obj-50",
                        0
                    ],
                    "midpoints": [
                        286.5,
                        187.0,
                        352.0,
                        187.0,
                        352.0,
                        225.0,
                        352.0,
                        232.0,
                        317.0,
                        232.0,
                        317.0,
                        270.0,
                        317.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        507.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        2
                    ],
                    "destination": [
                        "obj-51",
                        0
                    ],
                    "midpoints": [
                        406.5,
                        232.0,
                        832.0,
                        232.0,
                        832.0,
                        270.0,
                        832.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        452.0,
                        232.0,
                        967.0,
                        232.0,
                        967.0,
                        270.0,
                        967.0,
                        232.0,
                        572.0,
                        232.0,
                        572.0,
                        270.0,
                        572.0,
                        232.0,
                        707.0,
                        232.0,
                        707.0,
                        270.0,
                        707.0,
                        232.0,
                        827.0,
                        232.0,
                        827.0,
                        270.0,
                        1152.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-44",
                        3
                    ],
                    "destination": [
                        "obj-52",
                        0
                    ],
                    "midpoints": [
                        306.25,
                        187.0,
                        461.0,
                        187.0,
                        461.0,
                        225.0,
                        461.0,
                        232.0,
                        317.0,
                        232.0,
                        317.0,
                        270.0,
                        317.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        452.0,
                        232.0,
                        442.0,
                        232.0,
                        442.0,
                        270.0,
                        642.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        3
                    ],
                    "destination": [
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        426.25,
                        232.0,
                        832.0,
                        232.0,
                        832.0,
                        270.0,
                        832.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        452.0,
                        232.0,
                        967.0,
                        232.0,
                        967.0,
                        270.0,
                        967.0,
                        232.0,
                        572.0,
                        232.0,
                        572.0,
                        270.0,
                        572.0,
                        232.0,
                        1087.0,
                        232.0,
                        1087.0,
                        270.0,
                        1087.0,
                        232.0,
                        707.0,
                        232.0,
                        707.0,
                        270.0,
                        707.0,
                        232.0,
                        827.0,
                        232.0,
                        827.0,
                        270.0,
                        1287.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-44",
                        4
                    ],
                    "destination": [
                        "obj-54",
                        0
                    ],
                    "midpoints": [
                        326.0,
                        187.0,
                        461.0,
                        187.0,
                        461.0,
                        225.0,
                        461.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        452.0,
                        232.0,
                        572.0,
                        232.0,
                        572.0,
                        270.0,
                        572.0,
                        232.0,
                        577.0,
                        232.0,
                        577.0,
                        270.0,
                        762.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        4
                    ],
                    "destination": [
                        "obj-55",
                        0
                    ],
                    "midpoints": [
                        446.0,
                        232.0,
                        962.0,
                        232.0,
                        962.0,
                        270.0,
                        962.0,
                        232.0,
                        452.0,
                        232.0,
                        452.0,
                        270.0,
                        452.0,
                        232.0,
                        967.0,
                        232.0,
                        967.0,
                        270.0,
                        967.0,
                        232.0,
                        572.0,
                        232.0,
                        572.0,
                        270.0,
                        572.0,
                        232.0,
                        1087.0,
                        232.0,
                        1087.0,
                        270.0,
                        1087.0,
                        232.0,
                        707.0,
                        232.0,
                        707.0,
                        270.0,
                        707.0,
                        232.0,
                        1222.0,
                        232.0,
                        1222.0,
                        270.0,
                        1222.0,
                        232.0,
                        827.0,
                        232.0,
                        827.0,
                        270.0,
                        1407.0,
                        270.0
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
                        "obj-58",
                        0
                    ],
                    "midpoints": [
                        216.0,
                        67.0,
                        248.0,
                        67.0,
                        248.0,
                        105.0,
                        301.5,
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        262.0,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1478.0,
                        112.0,
                        1478.0,
                        150.0,
                        1478.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        2422.0,
                        112.0,
                        2422.0,
                        150.0,
                        2422.0,
                        112.0,
                        2902.0,
                        112.0,
                        2902.0,
                        150.0,
                        3396.0,
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
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        281.75,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1478.0,
                        112.0,
                        1478.0,
                        150.0,
                        1478.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        2422.0,
                        112.0,
                        2422.0,
                        150.0,
                        2422.0,
                        112.0,
                        2902.0,
                        112.0,
                        2902.0,
                        150.0,
                        2902.0,
                        112.0,
                        3352.0,
                        112.0,
                        3352.0,
                        150.0,
                        3457.0,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-58",
                        2
                    ],
                    "destination": [
                        "obj-40",
                        0
                    ],
                    "midpoints": [
                        301.5,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1478.0,
                        112.0,
                        1478.0,
                        150.0,
                        1478.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        2422.0,
                        112.0,
                        2422.0,
                        150.0,
                        2422.0,
                        112.0,
                        2902.0,
                        112.0,
                        2902.0,
                        150.0,
                        2902.0,
                        112.0,
                        3352.0,
                        112.0,
                        3352.0,
                        150.0,
                        3352.0,
                        112.0,
                        3442.0,
                        112.0,
                        3442.0,
                        150.0,
                        3517.0,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-58",
                        3
                    ],
                    "destination": [
                        "obj-56",
                        0
                    ],
                    "midpoints": [
                        321.25,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1478.0,
                        112.0,
                        1478.0,
                        150.0,
                        1478.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        2422.0,
                        112.0,
                        2422.0,
                        150.0,
                        2422.0,
                        112.0,
                        2902.0,
                        112.0,
                        2902.0,
                        150.0,
                        2902.0,
                        112.0,
                        3352.0,
                        112.0,
                        3352.0,
                        150.0,
                        3352.0,
                        112.0,
                        3442.0,
                        112.0,
                        3442.0,
                        150.0,
                        3442.0,
                        112.0,
                        3502.0,
                        112.0,
                        3502.0,
                        150.0,
                        3562.0,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-58",
                        4
                    ],
                    "destination": [
                        "obj-57",
                        0
                    ],
                    "midpoints": [
                        341.0,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1478.0,
                        112.0,
                        1478.0,
                        150.0,
                        1478.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        2422.0,
                        112.0,
                        2422.0,
                        150.0,
                        2422.0,
                        112.0,
                        2902.0,
                        112.0,
                        2902.0,
                        150.0,
                        2902.0,
                        112.0,
                        3352.0,
                        112.0,
                        3352.0,
                        150.0,
                        3352.0,
                        112.0,
                        3442.0,
                        112.0,
                        3442.0,
                        150.0,
                        3442.0,
                        112.0,
                        3502.0,
                        112.0,
                        3502.0,
                        150.0,
                        3502.0,
                        112.0,
                        3547.0,
                        112.0,
                        3547.0,
                        150.0,
                        3622.0,
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
                        "obj-42",
                        0
                    ],
                    "midpoints": [
                        3577.0,
                        112.0,
                        341.0,
                        112.0,
                        341.0,
                        150.0,
                        341.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1478.0,
                        112.0,
                        1478.0,
                        150.0,
                        1478.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        2422.0,
                        112.0,
                        2422.0,
                        150.0,
                        2422.0,
                        112.0,
                        2902.0,
                        112.0,
                        2902.0,
                        150.0,
                        2902.0,
                        112.0,
                        3352.0,
                        112.0,
                        3352.0,
                        150.0,
                        3352.0,
                        112.0,
                        3442.0,
                        112.0,
                        3442.0,
                        150.0,
                        3442.0,
                        112.0,
                        3502.0,
                        112.0,
                        3502.0,
                        150.0,
                        3502.0,
                        142.0,
                        3352.0,
                        142.0,
                        3352.0,
                        180.0,
                        3352.0,
                        157.0,
                        282.0,
                        157.0,
                        282.0,
                        193.0,
                        282.0,
                        157.0,
                        418.0,
                        157.0,
                        418.0,
                        195.0,
                        418.0,
                        157.0,
                        366.0,
                        157.0,
                        366.0,
                        193.0,
                        366.0,
                        157.0,
                        486.0,
                        157.0,
                        486.0,
                        193.0,
                        265.0,
                        193.0
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
                        "obj-43",
                        0
                    ],
                    "midpoints": [
                        3644.0,
                        112.0,
                        1020.0,
                        112.0,
                        1020.0,
                        150.0,
                        1020.0,
                        112.0,
                        1478.0,
                        112.0,
                        1478.0,
                        150.0,
                        1478.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        1957.0,
                        112.0,
                        1957.0,
                        150.0,
                        1957.0,
                        112.0,
                        2422.0,
                        112.0,
                        2422.0,
                        150.0,
                        2422.0,
                        112.0,
                        2902.0,
                        112.0,
                        2902.0,
                        150.0,
                        2902.0,
                        112.0,
                        3352.0,
                        112.0,
                        3352.0,
                        150.0,
                        3352.0,
                        112.0,
                        3442.0,
                        112.0,
                        3442.0,
                        150.0,
                        3442.0,
                        112.0,
                        3502.0,
                        112.0,
                        3502.0,
                        150.0,
                        3502.0,
                        112.0,
                        3547.0,
                        112.0,
                        3547.0,
                        150.0,
                        3547.0,
                        142.0,
                        3352.0,
                        142.0,
                        3352.0,
                        180.0,
                        3352.0,
                        157.0,
                        486.0,
                        157.0,
                        486.0,
                        193.0,
                        385.0,
                        193.0
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
                        "obj-61",
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
                        "obj-67",
                        1
                    ],
                    "midpoints": [
                        5261.0,
                        22.0,
                        5175.0,
                        22.0,
                        5175.0,
                        60.0,
                        5104.2,
                        60.0
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
                        "obj-67",
                        2
                    ],
                    "midpoints": [
                        5096.0,
                        22.0,
                        5182.0,
                        22.0,
                        5182.0,
                        60.0,
                        5221.4,
                        60.0
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
                        "obj-67",
                        3
                    ],
                    "midpoints": [
                        5554.0,
                        22.0,
                        5340.0,
                        22.0,
                        5340.0,
                        60.0,
                        5340.0,
                        22.0,
                        5476.0,
                        22.0,
                        5476.0,
                        60.0,
                        5338.6,
                        60.0
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
                        "obj-67",
                        4
                    ],
                    "midpoints": [
                        5404.0,
                        63.5,
                        5455.8,
                        63.5
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
                        "obj-67",
                        0
                    ],
                    "midpoints": [
                        4792.5,
                        22.0,
                        4867.0,
                        22.0,
                        4867.0,
                        60.0,
                        4987.0,
                        60.0
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
                        "obj-67",
                        0
                    ],
                    "midpoints": [
                        4946.0,
                        63.5,
                        4987.0,
                        63.5
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
                        "obj-74",
                        0
                    ],
                    "midpoints": [
                        4207.0,
                        63.5,
                        4237.0,
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
                        "obj-74",
                        1
                    ],
                    "midpoints": [
                        4297.0,
                        22.0,
                        4294.0,
                        22.0,
                        4294.0,
                        60.0,
                        4294.0,
                        67.0,
                        4297.0,
                        67.0,
                        4297.0,
                        105.0,
                        4270.5,
                        105.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-62",
                        1
                    ],
                    "destination": [
                        "obj-78",
                        0
                    ],
                    "midpoints": [
                        4279.0,
                        22.0,
                        4282.0,
                        22.0,
                        4282.0,
                        60.0,
                        4282.0,
                        67.0,
                        4285.5,
                        67.0,
                        4285.5,
                        105.0,
                        4312.0,
                        105.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-63",
                        1
                    ],
                    "destination": [
                        "obj-78",
                        1
                    ],
                    "midpoints": [
                        4369.0,
                        63.5,
                        4345.5,
                        63.5
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
                        "obj-75",
                        0
                    ],
                    "midpoints": [
                        4253.75,
                        67.0,
                        4297.0,
                        67.0,
                        4297.0,
                        105.0,
                        4312.0,
                        105.0
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
                        "obj-75",
                        1
                    ],
                    "midpoints": [
                        4402.0,
                        22.0,
                        4384.0,
                        22.0,
                        4384.0,
                        60.0,
                        4384.0,
                        67.0,
                        4360.5,
                        67.0,
                        4360.5,
                        105.0,
                        4360.5,
                        112.0,
                        4372.0,
                        112.0,
                        4372.0,
                        150.0,
                        4345.5,
                        150.0
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
                        "obj-79",
                        0
                    ],
                    "midpoints": [
                        4328.75,
                        112.0,
                        4360.5,
                        112.0,
                        4360.5,
                        150.0,
                        4387.0,
                        150.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-64",
                        1
                    ],
                    "destination": [
                        "obj-79",
                        1
                    ],
                    "midpoints": [
                        4474.0,
                        86.0,
                        4420.5,
                        86.0
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
                        "obj-76",
                        0
                    ],
                    "midpoints": [
                        4328.75,
                        112.0,
                        4372.0,
                        112.0,
                        4372.0,
                        150.0,
                        4402.0,
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
                        "obj-76",
                        1
                    ],
                    "midpoints": [
                        4507.0,
                        22.0,
                        4489.0,
                        22.0,
                        4489.0,
                        60.0,
                        4489.0,
                        112.0,
                        4435.5,
                        112.0,
                        4435.5,
                        150.0,
                        4435.5,
                        142.0,
                        4462.0,
                        142.0,
                        4462.0,
                        180.0,
                        4435.5,
                        180.0
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
                        "obj-80",
                        0
                    ],
                    "midpoints": [
                        4403.75,
                        142.0,
                        4450.5,
                        142.0,
                        4450.5,
                        180.0,
                        4477.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-65",
                        1
                    ],
                    "destination": [
                        "obj-80",
                        1
                    ],
                    "midpoints": [
                        4579.0,
                        101.0,
                        4510.5,
                        101.0
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
                    ],
                    "midpoints": [
                        4418.75,
                        142.0,
                        4462.0,
                        142.0,
                        4462.0,
                        180.0,
                        4492.0,
                        180.0
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
                        "obj-77",
                        1
                    ],
                    "midpoints": [
                        4612.0,
                        22.0,
                        4594.0,
                        22.0,
                        4594.0,
                        60.0,
                        4594.0,
                        142.0,
                        4525.5,
                        142.0,
                        4525.5,
                        180.0,
                        4525.5,
                        187.0,
                        4552.0,
                        187.0,
                        4552.0,
                        225.0,
                        4525.5,
                        225.0
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
                        "obj-81",
                        0
                    ],
                    "midpoints": [
                        4493.75,
                        187.0,
                        4540.5,
                        187.0,
                        4540.5,
                        225.0,
                        4567.0,
                        225.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-66",
                        1
                    ],
                    "destination": [
                        "obj-81",
                        1
                    ],
                    "midpoints": [
                        4684.0,
                        123.5,
                        4600.5,
                        123.5
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
                        "obj-85",
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
                        "obj-86",
                        0
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
                        "obj-83",
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
                        "obj-83",
                        1
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
                        "obj-84",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-83",
                        1
                    ],
                    "destination": [
                        "obj-84",
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